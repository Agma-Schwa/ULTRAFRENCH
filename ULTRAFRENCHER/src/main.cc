#include <algorithm>
#include <base/Assert.hh>
#include <base/Base.hh>
#include <base/Macros.hh>
#include <base/Text.hh>
#include <clopts.hh>
#include <nlohmann/json.hpp>
#include <print>
#include <ranges>
#include <string>
#include <unicode/schriter.h>
#include <unicode/stringoptions.h>
#include <unicode/translit.h>
#include <unicode/unistr.h>
#include <variant>
#include <vector>

using namespace base;
using nlohmann::json;

static constexpr std::u32string_view apos = U"'`’";

auto ICUToUTF32(const icu::UnicodeString& us) -> std::u32string {
    std::u32string text;
    UErrorCode err{U_ZERO_ERROR};
    text.resize(usz(us.length()));
    auto sz = us.toUTF32(reinterpret_cast<UChar32*>(text.data()), i32(text.size()), err);
    Assert(not U_FAILURE(err), "Failed to convert text to UTF-32: {}", u_errorName(err));
    text.resize(usz(sz));
    return text;
}

namespace dict {
static constexpr std::u32string_view SenseMacroU32 = U"\\\\";
static icu::Transliterator* Normaliser;

using RefEntry = std::string;
struct FullEntry {
    struct Sense {
        std::string def;
        std::vector<std::string> examples;
    };

    /// Part of speech.
    std::string pos;

    /// Etymology; may be empty.
    std::string etym;

    /// Primary definition, before any sense. This is also used
    /// if there is only one sense.
    std::string primary_definition;

    /// Senses after the primary definition. If there are multiple
    /// senses, the primary definition is everything before the
    /// first slash and thus often empty.
    std::vector<Sense> senses;

    /// Forms. Mainly used for verbs.
    std::string forms;
};

struct Backend {
protected:
    Backend() = default;

public:
    i64 line = 0;

    // Backend-specific error processing.
    template <typename... Args>
    void error(std::format_string<Args...> fmt, Args&&... args) {
        emit_error(std::format("In Line {}: {}", line, std::format(fmt, std::forward<Args>(args)...)));
    }

    virtual ~Backend() = default;
    virtual void emit_error(std::string error) = 0;
    virtual void emit(std::string_view word, const RefEntry& data) = 0;
    virtual void emit(std::string_view word, const FullEntry& data) = 0;
    virtual void print() = 0;
};

struct JsonBackend final : Backend {
    json out;
    std::string errors;
    std::string current_word = "<error: \\this undefined>";

    JsonBackend() {
        out = json::object();
        refs() = json::array();
        entries() = json::array();
    }

    void emit_error(std::string error) override {
        errors += error;
        if (not errors.ends_with('\n')) errors += "\n";
    }

    void emit(std::string_view word, const FullEntry& data) override {
        json& e = entries().emplace_back();
        e["word"] = current_word = TeXToHtml(word);
        e["pos"] = TeXToHtml(data.pos);
        if (not data.etym.empty()) e["etym"] = TeXToHtml(data.etym);
        if (not data.primary_definition.empty()) e["def"] = TeXToHtml(data.primary_definition);
        if (not data.forms.empty()) e["forms"] = TeXToHtml(data.forms);
        if (not data.senses.empty()) {
            json& senses = e["senses"] = json::array();
            for (auto& sense : data.senses) {
                auto& s = senses.emplace_back();
                s["def"] = TeXToHtml(sense.def);
                if (not sense.examples.empty()) {
                    auto& ex = s["examples"] = json::array();
                    for (auto& example : sense.examples)
                        ex.push_back(TeXToHtml(example));
                }
            }
        }
    }

    void emit(std::string_view word, const RefEntry& data) override {
        json& e = refs().emplace_back();
        e["from"] = current_word = TeXToHtml(word);
        e["to"] = TeXToHtml(data);
    }

    void print() override {
        if (not errors.empty()) std::println("{}", errors);
        else std::println("{}", out.dump(4));
    }

private:
    auto refs() -> json& { return out["refs"]; }
    auto entries() -> json& { return out["entries"]; }

    auto TeXToHtml(stream input) -> std::string {
        std::string out;

        // Process macros.
        for (;;) {
            out += input.take_until("\\$");
            if (input.empty()) break;

            // TODO: Render maths.
            if (input.consume('$')) {
                out += "$";
                out += input.take_until('$');
                out += '$';
                continue;
            }

            // Yeet '\'.
            input.drop();
            if (input.empty()) {
                error("Invalid macro escape sequence");
                break;
            }

            ProcessMacro(out, input);
        }

        // We need to escape some more chars for HTML.
        utils::ReplaceAll(out, "<", "&lt;");
        utils::ReplaceAll(out, ">", "&gt;");
        utils::ReplaceAll(out, "~", "&nbsp;");
        utils::ReplaceAll(out, "§", "grammar"); // FIXME: Make section references work somehow.
        return out;
    }

    void ProcessMacro(std::string& out, stream& input) {
        // Found a macro; first, handle single-character macros.
        if (text::IsPunct(*input.front())) {
            switch (auto c = input.take()[0]) {
                // Discretionary hyphen.
                case '-': out += "&shy;"; return;

                // Escaped characters.
                case '&': out += "&amp;"; return;
                case '%': out += "%"; return;
                case '#': out += "#"; return;

                // These should no longer exist at this point.
                case '\\': error("'\\\\' is not supported in this field"); return;

                // Unknown.
                default: error("Unsupported macro. Please add support for '\\{}' to the ULTRAFRENCHER", c); return;
            }
        }

        // Drop a brace-delimited argument after a macro.
        auto DropArg = [&] {
            if (input.trim_front().starts_with('{')) input.drop_until('}');
        };

        auto DropArgAndAppend = [&] (std::string_view text) {
            DropArg();
            out += text;
        };

        // Handle regular macros. We use custom tags for some of these to
        // separate the formatting from data.
        auto macro = input.take_while_any("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@");
        if (macro == "pf") SingleArgumentMacroToTag(out, input, "uf-pf");
        else if (macro == "s") SingleArgumentMacroToTag(out, input, "uf-s");
        else if (macro == "w") SingleArgumentMacroToTag(out, input, "uf-w");
        else if (macro == "textit") SingleArgumentMacroToTag(out, input, "em");
        else if (macro == "textbf") SingleArgumentMacroToTag(out, input, "strong");
        else if (macro == "textnf") SingleArgumentMacroToTag(out, input, "uf-nf");
        else if (macro == "senseref") SingleArgumentMacroToTag(out, input, "uf-sense");
        else if (macro == "L") DropArgAndAppend("<uf-mut>L</uf-mut>");
        else if (macro == "N") DropArgAndAppend("<uf-mut>N</uf-mut>");
        else if (macro == "ref" or macro == "label") DropArg();
        else if (macro == "ldots") DropArgAndAppend("&hellip;");
        else if (macro == "this") out += current_word;
        else if (macro == "ex") error("'\\ex' is only supported in the definition field of an entry, after a sense"); // Already handled.
        else error("Unsupported macro '\\{}'. Please add support for it to the ULTRAFRENCHER", macro);
    }

    void SingleArgumentMacroToTag(std::string& out, stream& input, std::string_view tag_name) {
        // Drop everything until the argument brace. We’re not a LaTeX tokeniser, so we don’t
        // support stuff like `\fract1 2`, as much as I like to write it.
        if (not stream{input.take_until('{')}.trim().empty())
            error("Sorry, macro arguments must be enclosed in braces");

        // Drop the opening brace.
        input.drop();

        // Everything until the next closing brace is our argument, but we also need to handle
        // nested macros properly.
        out += std::format("<{}>", tag_name);
        while (not input.empty()) {
            auto arg = input.take_until_any("$\\}");
            out += arg;

            // TODO: Render maths.
            if (input.consume('$')) {
                out += "$";
                out += input.take_until('$');
                out += '$';
                continue;
            }

            if (input.consume('}')) {
                out += std::format("</{}>", tag_name);
                return;
            }

            ProcessMacro(out, input.drop());
        }
    }
};

struct TeXBackend final : Backend {
    TeXBackend() {
        std::println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        std::println("%%            This file was generated from DICTIONARY.txt             %%");
        std::println("%%                                                                    %%");
        std::println("%%                         DO NOT EDIT                                %%");
        std::println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        std::println();
    }

    // Emit errors as LaTeX macros.
    //
    //  This is so the error gets printed at the end of LaTeX compilation;
    //  if we print it when the ULTRAFRENCHER runs, it’s likely to get missed,
    //  so we do this instead.
    void emit_error(std::string error) override {
        std::print("\\ULTRAFRENCHERERROR{{ ERROR: {} }}", error);
    }

    void emit(std::string_view word, const FullEntry& data) override { // clang-format off
        std::println(
            "\\entry{{{}}}{{{}}}{{{}}}{{{}{}}}{{{}}}{{}}",
            word,
            data.pos,
            data.etym,
            data.primary_definition,
            data.senses.empty() ? ""s : "\\\\"s + utils::join(
                data.senses,
                "\\\\",
                "{}",
                [&](const FullEntry::Sense& s) {
                    return s.def + (s.examples.empty() ? ""s : "\\ex " + utils::join(s.examples, "\\ex "));
                }
            ),
            data.forms
        ); // clang-format on
    }

    void emit(std::string_view word, const RefEntry& data) override {
        std::println("\\refentry{{{}}}{{{}}}", word, data);
    }

    void print() override {} // No-op.
};

struct Entry {
    /// Headword.
    std::u32string word;

    /// Line this entry starts on.
    i64 line = 0;

    /// Headword in NFKD for sorting.
    icu::UnicodeString nfkd;

    /// Data.
    Variant<RefEntry, FullEntry> data;

    /// Build a reference entry.
    Entry(std::u32string word, Backend& backend, RefEntry data)
        : word{std::move(word)}
        , line{backend.line}
        , data{std::move(data)} { init(); }

    /// Build a full entry.
    Entry(std::u32string word, Backend& backend, std::vector<std::u32string> parts)
        : word{std::move(word)}
        , line{backend.line}
        , data{FullEntry{}} {
        init();
        auto& full = data.get<FullEntry>();

        // Entry parts. note that the headword has already been removed from
        // this, so the ‘first part’ here is the part of speech (which is the
        // second field in the raw file) etc.
        enum : usz {
            POSPart = 0,
            EtymPart = 1,
            DefPart = 2,
            FormsPart = 3,
        };

        // Process the entry. This inserts things that are difficult to do in LaTeX, such as
        // full stops between senses, only if there isn’t already a full stop there. Of course,
        // this means we need to convert that to HTML for the JSON output, but we need to do
        // that anyway since the input is already LaTeX.
        //
        // FIXME: Why is this still a loop...?
        for (auto [i, part] : parts | vws::enumerate) {
            switch (i) {
                case POSPart: full.pos = text::ToUTF8(part); break;

                // If this is a single word, and the field contains no backslashes,
                // wrap it with '\pf{}'. That takes care of this field for most words
                // (conversely, more complex etymologies often don’t start w/ a PF word).
                case EtymPart: {
                    // Etymology is empty; don’t do anything here.
                    if (part.empty()) break;

                    // If the etymology contains no spaces or macros, it is likely just
                    // a single French word, so insert \pf.
                    if (not part.contains(U' ') and not part.contains(U'\\'))
                        full.etym = "\\pf{" + text::ToUTF8(part) + "}"; // No Utf32 std::format :(
                    else
                        full.etym = text::ToUTF8(part);
                } break;

                // If the definition contains senses, delimit each one with a dot. We
                // do this here because there isn’t really a good way to do that
                // in LaTeX.
                case DefPart: {
                    u32stream def = part;
                    full.primary_definition = FullStopDelimited(def.take_until(SenseMacroU32));
                    if (def.empty()) break;

                    // Split by senses.
                    //
                    // The first element is everything before the sense macro, which
                    // is always going to be empty (because we just dropped everything
                    // up to the first occurrence of the macro), so we drop it here.
                    //
                    // Lastly, a sense may contain examples; move them out of the sense.
                    for (auto sense : def.split(SenseMacroU32) | vws::drop(1)) {
                        if (not sense.contains(U"\\ex")) {
                            full.senses.emplace_back(FullStopDelimited(sense));
                        } else {
                            auto sense_def = sense.take_until(U"\\ex");
                            auto examples = sense.split(U"\\ex") | vws::drop(1) | vws::transform(FullStopDelimited) | rgs::to<std::vector>();
                            full.senses.emplace_back(FullStopDelimited(sense_def), std::move(examples));
                        }
                    }
                } break;

                // FIXME: The dot should be added here instead of by LaTeX.
                case FormsPart: full.forms = text::ToUTF8(part); break;

                // Shouldn’t happen.
                default: backend.error("Too many fields in entry: {}", i); break;
            }
        }
    }

    static auto FullStopDelimited(u32stream text) -> std::string {
        text.trim();
        if (text.empty()) return "";
        auto str = text::ToUTF8(text.text());

        // Skip past quotes so we don’t turn e.g. ⟨...’⟩ into ⟨...’.⟩.
        while (text.ends_with_any(apos)) text.drop_back();

        // Recognise common punctuation marks.
        if (not text.ends_with_any(U"?!.") and not text.ends_with(U"\\ldots")) str += ".";
        return str;
    }

    void emit(Backend& backend) const { // clang-format off
        backend.line = line;
        auto s = text::ToUTF8(word);
        data.visit(utils::Overloaded{
            [&](const RefEntry& ref) { backend.emit(s, ref); },
            [&](const FullEntry& f)  { backend.emit(s, f); },
        });
    } // clang-format on

private:
    void init() {
        nfkd = icu::UnicodeString::fromUTF32(reinterpret_cast<const UChar32*>(word.data()), i32(word.size()));
        Normaliser->transliterate(nfkd);
    }
};

void Generate(std::string_view input_text, Backend&& backend) {
    static constexpr std::u32string_view ws = U" \t\v\f\n\r";
    std::print(stderr, "[ULTRAFRENCHER] Generating dictionary...\n");

    UErrorCode err{U_ZERO_ERROR};
    Normaliser = icu::Transliterator::createInstance(
        "NFKD; [:M:] Remove; NFC; Lower;",
        UTRANS_FORWARD,
        err
    );
    Assert(not U_FAILURE(err), "Failed to get NFKD normalizer: {}", u_errorName(err));

    // Convert text to u32.
    std::u32string text = text::ToUTF32(input_text);

    // Convert a line into an entry.
    std::u32string logical_line;
    std::vector<Entry> entries;
    auto ShipOutLine = [&] {
        if (logical_line.empty()) return;
        defer { logical_line.clear(); };

        // Collapse whitespace into single spaces.
        for (usz pos = 0;;) {
            pos = logical_line.find_first_of(ws, pos);
            if (pos == std::u32string::npos) break;
            if (auto end = logical_line.find_first_not_of(ws, pos); end != std::u32string::npos) {
                logical_line.replace(pos, end - pos, U" ");
                pos = end;
            } else {
                logical_line.erase(pos);
                break;
            }
        }

        u32stream line{logical_line};
        line.trim();

        // If the line contains no '|' characters and a `>`,
        // it is a reference. Split by '>'. The lhs is a
        // comma-separated list of references, the rhs is the
        // actual definition.
        if (not line.contains(U'|')) {
            auto from = u32stream(line.take_until(U'>')).trim();
            auto target = line.drop().trim().text();
            for (auto entry : from.split(U",")) {
                entries.emplace_back(
                    std::u32string{entry.trim().text()},
                    backend,
                    RefEntry{text::ToUTF8(target)}
                );
            }
        }

        // Otherwise, the line is an entry. Split by '|' and emit
        // a single entry for the line.
        else {
            bool first = true;
            std::u32string word;
            std::vector<std::u32string> line_parts;
            for (auto part : line.split(U"|")) {
                if (first) {
                    first = false;
                    word = std::u32string{part.trim().text()};
                } else {
                    line_parts.emplace_back(part.trim().text());
                }
            }
            entries.emplace_back(std::move(word), backend, std::move(line_parts));
        }
    };

    // Process the text.
    for (auto [i, line] : u32stream(text).lines() | vws::enumerate) {
        line = line.take_until(U'#');
        backend.line = i;

        // Warn about non-typographic quotes, after comment deletion
        // because it’s technically fine to have them in comments.
        if (line.contains(U'\'')) backend.error(
            "Non-typographic quote! Please use ‘’ (and “” for nested quotes) instead!"
        );

        // Skip empty lines.
        if (line.empty()) continue;

        // Perform line continuation.
        if (line.starts_with_any(U" \t")) {
            logical_line += ' ';
            logical_line += line.trim().text();
            continue;
        }

        // This line starts a new entry, so ship out the last
        // one and start a new one.
        ShipOutLine();
        logical_line = line.text();
    }

    // Ship out the last line.
    ShipOutLine();

    // Sort the entries.
    rgs::stable_sort(entries, [](const auto& a, const auto& b) {
        return a.nfkd == b.nfkd ? a.word < b.word : a.nfkd < b.nfkd;
    });

    // Emit each entry.
    for (auto& entry : entries) entry.emit(backend);
    backend.print();
}
} // namespace dict

namespace ipa {
static constexpr char32_t Acute = U'́';
static constexpr char32_t Grave = U'̀';
static constexpr char32_t Circumflex = U'̂';
static constexpr char32_t Tilde = U'̃';
static constexpr char32_t VoicelessBelow = U'̥';
[[maybe_unused]] static constexpr char32_t VoicelessAbove = U'̊';
static constexpr char32_t Diaeresis = U'̈';
static constexpr char32_t DotBelow = U'̣';
static constexpr std::u32string_view WSOrPipe = U" \t\v\f\n\r|";

// Convert a sound to its nasal equivalent (but without
// any diacritics)
constexpr char32_t
Nasal(char32_t c) {
    switch (c) {
        case U'e': return U'ɛ';
        case U'i': return U'i';
        case U'o': return U'ɔ';
        case U'u': return U'u';
        case U'y': return U'ʏ';

        case U'a':
        case U'ɐ':
            return U'ɑ';

        default: return c;
    }
}

void Translate(std::string_view text, bool show_unsupported) {
    // Normalise the text before IPA conversion so we have
    // to deal with fewer cases. Also convert to lowercase
    // and convert ASCII apostrophes to '’'.
    UErrorCode err{U_ZERO_ERROR};
    auto normaliser = icu::Transliterator::createInstance(
        u"NFD; Lower;",
        UTRANS_FORWARD,
        err
    );
    Assert(not U_FAILURE(err), "Failed to get Transliterator: {}", u_errorName(err));
    auto us = icu::UnicodeString::fromUTF8(text);
    normaliser->transliterate(us);

    // Convert it to a u32 string.
    // Map the text to IPA.
    std::u32string ipa, input = ICUToUTF32(us);
    char32_t c{};
    u32stream s{input};

    // Helper to handle apostrophe-h combinations. Some letters
    // may be followed by '’h', which turns them into fricatives;
    // if the apostrophe is not followed by a 'h', then it is simply
    // discarded. This handles that case.
    const auto HandleApostropheH = [&](char32_t base, char32_t fricative) {
        if (s.consume_any(apos) and s.consume(U'h')) ipa += fricative;
        else ipa += base;
    };

    while (not s.empty()) {
        switch (c = s.take()[0]) {
            // Skip most punctuation marks.
            case U'.':
            case U',':
            case U':':
            case U';':
            case U'-':
            case U'–':
            case U'—':
            case U'/':
            case U'\\':
                break;

            // Skip these in the middle of words.
            case U'\'':
            case U'`':
            case U'’':
                break;

            // Skip letters that are not part of the language.
            case U'g':
            case U'm':
            case U'k':
            case U'p':
            case U'q':
            case U'x':
                break;

            // Collapse whitespace and convert '|' to a space as well
            // since we use it to separate words in glosses.
            case U' ':
            case U'\t':
            case U'\v':
            case U'\f':
            case U'\n':
            case U'\r':
            case U'|':
                while (s.consume_any(WSOrPipe));
                ipa += U' ';
                break;

            // Simple vowels.
            case U'i':
            case U'o':
            case U'u':
            simple_vowel: {
                switch (s.front().value_or(0)) {
                    case Grave:
                        s.drop();
                        ipa += c;
                        ipa += VoicelessBelow;
                        break;

                    case Acute:
                        s.drop();
                        ipa += Nasal(c);
                        ipa += Tilde;
                        break;

                    case Circumflex:
                        s.drop();
                        ipa += Nasal(c);
                        ipa += Tilde;
                        ipa += Tilde;
                        break;

                    default:
                        ipa += c;
                        break;
                }
            } break;

            // 'a' could be followed by 'u', optionally with
            // a diacritic on the 'u' (except a diaeresis), in
            // which case it is actually 'o'.
            case U'a': {
                if (s.consume(U'u')) {
                    if (s.consume(Diaeresis)) {
                        ipa += U'ɐ';
                        c = U'u';
                    } else {
                        c = 'o';
                    }
                } else {
                    c = U'ɐ';
                }

                goto simple_vowel;
            }

            // 'e' is complicated because it has two nasal variants,
            // and because it can also be a schwa. Fortunately, NFC
            // puts the dot below first, so we can get that out of the
            // way early.
            case U'e': {
                const bool dot = s.consume(DotBelow);
                switch (s.front().value_or(0)) {
                    // E-grave is oral 'ɛ'.
                    case Grave:
                        s.drop();
                        ipa += U'ɛ';
                        break;

                    case Acute:
                        s.drop();
                        ipa += dot ? U'e' : U'ɛ';
                        ipa += Tilde;
                        break;

                    case Circumflex:
                        s.drop();
                        ipa += dot ? U'e' : U'ɛ';
                        ipa += Tilde;
                        ipa += Tilde;
                        break;

                    default:
                        // E-dot w/ no nasal diacritic is a schwa.
                        ipa += dot ? U'ə' : U'e';

                        // Word-finally, E-dot is voiceless.
                        if (dot and s.starts_with_any(WSOrPipe)) ipa += VoicelessBelow;
                        break;
                }
            } break;

            // 'y' can be a vowel or a consonant if followed by '’'. Note
            // that there may be an acute before the apostrophe.
            case 'y': {
                switch (s.front().value_or(0)) {
                    case Acute:
                        s.drop();
                        if (s.consume_any(apos)) ipa += U"ɥ̃";
                        else {
                            ipa += Nasal(c);
                            ipa += Tilde;
                        }
                        break;

                    default:
                        if (s.consume_any(apos)) ipa += U"ɥ";
                        else goto simple_vowel;
                }
            } break;

            // 'b' can be followed by a dot, 'h', or an apostrophe.
            case U'b': {
                switch (s.front().value_or(0)) {
                    case U'h':
                        s.drop();
                        ipa += U"bʱ";
                        break;

                    // If followed by '’h', then this is a fricative. Otherwise,
                    // just skip the apostrophe.
                    case U'’':
                    case U'\'':
                    case U'`':
                        s.drop();
                        if (s.consume(U'h')) ipa += U"β";
                        else ipa += U"b";
                        break;

                    // Dot below doesn’t change the pronunciation.
                    default:
                        (void) s.consume(DotBelow);
                        ipa += U'b';
                        break;
                }
            } break;

            case U'c':
                if (s.consume(Acute)) ipa += U"ɕʶ";
                else if (s.consume(DotBelow)) ipa += U"ȷ̊";
                else HandleApostropheH(U'ɕ', U'x');
                break;

            // 'd' can be followed by a dot, or '’h’.
            case U'd':
                if (s.consume(DotBelow)) ipa += 'd';
                else HandleApostropheH(U'd', U'ð');
                break;

            case U'f':
                ipa += U'ɸ';
                break;

            case U'h':
                ipa += U'h';
                break;

            // We sometimes use dotless ‘j’ so we don’t end up
            // with a dot *and* an acute.
            case U'ȷ':
            case U'j':
                ipa += U'ʑ';
                if (s.consume(Acute)) ipa += U'ʶ';
                break;

            // Also handle `ll`.
            case U'l':
                if (s.consume(DotBelow)) {
                    ipa += U"ʎ̝̃";
                    while (s.consume(U"ḷ")) ipa += U'ː';
                } else {
                    ipa += U"ɮ̃";
                    while (s.starts_with(U'l') and not s.starts_with(U"ḷ")) {
                        s.drop();
                        ipa += U'ː';
                    }
                }
                break;

            case U'ł':
                ipa += U"ɮ̃ʶ";
                while (s.consume(U'ł')) ipa += U'ː';
                break;

            case U'n':
                ipa += U"n";
                break;

            case U'r':
                if (s.consume(U'r')) ipa += U'ʀ';
                else ipa += U"ɰ";
                break;

            case U's':
                if (s.consume(Acute)) {
                    ipa += U"sʶ";
                    while (s.consume(U"ś")) ipa += U'ː';
                } else {
                    ipa += U's';
                    while (s.starts_with(U's') and not s.starts_with(U"ś")) {
                        s.drop();
                        ipa += U'ː';
                    }
                }
                break;

            // 't' is /t/ on its own (archaic spelling), and 't’h' otherwise.
            case U't':
                if (s.consume_any(apos) and s.consume(U'h')) ipa += U'θ';
                else ipa += U't';
                break;

            case U'v':
                if (s.consume(Acute)) ipa += U"βʶ";
                else {
                    ipa += U"ʋ̃";
                    while (s.starts_with(U'v') and not s.starts_with(U"v́")) {
                        s.drop();
                        ipa += U'ː';
                    }
                }
                break;

            case U'w':
                ipa += U"ɰ̃";
                break;

            case U'z':
                ipa += U'z';
                if (s.consume(Acute)) ipa += U'ʶ';
                break;

            default: {
                std::print(
                    stderr,
                    "[ULTRAFRENCHER] Warning: unsupported character U+{:04X}: {}\n",
                    u32(c),
                    text::ToUTF8(c)
                );

                if (show_unsupported) ipa += text::ToUTF32(std::format("\033[33m<U+{:04X}>\033[m", u32(c)));
            } break;
        }
    }

    std::print(stdout, "{}\n", text::ToUTF8(ipa));
}
} // namespace ipa

int main(int argc, char** argv) {
    using namespace command_line_options;
    using options = clopts< // clang-format off
        option<"--dict", "The file to process", file<>>,
        option<"-i", "Convert text to IPA">,
        option<"-f", "Convert a text file to IPA", file<>>,
        flag<"--show-unsupported", "Print <U+XXXX> for unsupported characters">,
        flag<"--json", "Output the dictionary as JSON">,
        help<>
    >; // clang-format on

    auto opts = options::parse(argc, argv);
    const bool show_unsupp = opts.get<"--show-unsupported">();
    if (auto d = opts.get<"--dict">()) {
        if (opts.get<"--json">()) dict::Generate(d->contents, dict::JsonBackend());
        else dict::Generate(d->contents, dict::TeXBackend());
    } else if (auto i = opts.get<"-i">()) ipa::Translate(*i, show_unsupp);
    else if (auto f = opts.get<"-f">()) ipa::Translate(f->contents, show_unsupp);
    else std::print("{} {}", argv[0], options::help());
}
