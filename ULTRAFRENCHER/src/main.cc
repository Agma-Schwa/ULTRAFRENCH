#include <algorithm>
#include <base/Assert.hh>
#include <base/Macros.hh>
#include <clopts.hh>
#include <print>
#include <ranges>
#include <string>
#include <unicode/schriter.h>
#include <unicode/stringoptions.h>
#include <unicode/translit.h>
#include <unicode/unistr.h>
#include <variant>
#include <vector>

import base;
import base.text;
using namespace base;

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

namespace dictionary {
static icu::Transliterator* normaliser;

struct entry {
    // Headword.
    std::u32string word;

    // Headword in NFKD for sorting.
    icu::UnicodeString nfkd;

    // Data.
    std::variant<std::u32string, std::vector<std::u32string>> data;

    // Part indices.
    enum : size_t {
        POSPart = 0,
        EtymPart = 1,
        BodyPart = 2,
        FormsPart = 3,
    };

    entry(std::u32string word, std::u32string data)
        : word{std::move(word)}
        , data{std::move(data)} { init(); }
    entry(std::u32string word, std::vector<std::u32string> data)
        : word{std::move(word)}
        , data{std::move(data)} { init(); }

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

    void print() const {
        auto s = text::ToUTF8(word);
        if (std::holds_alternative<std::u32string>(data)) {
            std::print("\\refentry{{{}}}{{{}}}\n", s, text::ToUTF8(std::get<std::u32string>(data)));
        } else {
            auto& parts = std::get<std::vector<std::u32string>>(data);
            usz i = 0;
            std::print("\\entry{{{}}}", s);
            for (; i < parts.size(); i++) {
                static constexpr std::u32string_view SenseMacro = U"\\\\";
                auto EmitField = [&] (bool full_stop = false) {
                    if (full_stop) std::print("{{{}}}", FullStopDelimited(parts[i]));
                    else std::print("{{{}}}", text::ToUTF8(parts[i]));
                };
                switch (i) {
                    // If this is a single word, and the field contains no backslashes,
                    // wrap it with '\pf{}'. That takes care of this field for most words
                    // (conversely, more complex etymologies often don’t start w/ a PF word).
                    case EtymPart: {
                        if (parts[i].empty()) {
                            EmitField();
                            break;
                        }

                        std::u32string_view etym{parts[i]};

                        // If the etymology contains no spaces, insert \pf, and
                        // make the word italic.
                        if (not etym.contains(U' ') and not etym.contains(U'\\'))
                            std::print("{{\\pf{{{}}}}}", text::ToUTF8(etym));

                        // Otherwise, pass it along as-is.
                        else { std::print("{{{}}}", text::ToUTF8(etym)); }
                    } break;

                    // If the body contains senses, delimit each one with a dot. We
                    // do this here because there isn’t really a good way to do that
                    // in LaTeX.
                    case BodyPart: {
                        if (not parts[i].contains(SenseMacro)) {
                            EmitField(true);
                            break;
                        }

                        u32stream body = parts[i];
                        std::print("{{");

                        // Emit everything before the first sense.
                        auto text = body.take_until(SenseMacro);
                        std::print("{}", FullStopDelimited(text));

                        // Split by senses.
                        //
                        // The first element is everything before the sense macro, which
                        // is always going to be empty, so we drop it.
                        for (auto sense : body.split(SenseMacro) | vws::drop(1)) std::print(
                            "{}{}",
                            SenseMacro,
                            FullStopDelimited(sense)
                        );
                        std::print("}}");
                    } break;

                    default: EmitField();
                }
            }
            for (; i < 5; i++) std::print("{{}}");
            std::print("\n");
        }
    }

private:
    void init() {
        nfkd = icu::UnicodeString::fromUTF32(reinterpret_cast<const UChar32*>(word.data()), i32(word.size()));
        normaliser->transliterate(nfkd);
    }
};

// Emit errors as LaTeX macros.
//
// This is so the error gets printed at the end of LaTeX compilation;
// if we print it when the ULTRAFRENCHER runs, it’s likely to get missed,
// so we do this instead.
template <typename ...Args>
void EmitError(std::format_string<Args...> fmt, Args&& ...args) {
    std::print("\\ULTRAFRENCHERERROR{{  ERROR: ");
    std::print(fmt, std::forward<Args>(args)...);
    std::print("}}");
}

void generate(std::string_view input_text) {
    static constexpr std::u32string_view ws = U" \t\v\f\n\r";
    std::print(stderr, "[ULTRAFRENCHER] Generating dictionary...\n");

    UErrorCode err{U_ZERO_ERROR};
    normaliser = icu::Transliterator::createInstance(
        "NFKD; [:M:] Remove; NFC; Lower;",
        UTRANS_FORWARD,
        err
    );
    Assert(not U_FAILURE(err), "Failed to get NFKD normalizer: {}", u_errorName(err));

    // Convert text to u32.
    std::u32string text = text::ToUTF32(input_text);

    // Convert a line into an entry.
    std::u32string logical_line;
    std::vector<entry> entries;
    auto ShipoutLine = [&] {
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
                    std::u32string{target}
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
            entries.emplace_back(std::move(word), std::move(line_parts));
        }
    };

    // Process the text.
    for (auto [i, line] : u32stream(text).lines() | vws::enumerate) {
        line = line.take_until(U'#');

        // Warn about non-typographic quotes, after comment deletion
        // because it’s technically fine to have them in comments.
        if (line.contains(U'\'')) EmitError(
            "Non-typographic quote in line {}! "
            "Please use ‘’ (and “” for nested quotes) instead!",
            i
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
        ShipoutLine();
        logical_line = line.text();
    }

    // Ship out the last line.
    ShipoutLine();

    // Sort the entries.
    rgs::stable_sort(entries, [](const auto& a, const auto& b) {
        return a.nfkd == b.nfkd ? a.word < b.word : a.nfkd < b.nfkd;
    });

    // Emit it.
    std::print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n");
    std::print("%%            This file was generated from DICTIONARY.txt             %%\n");
    std::print("%%                                                                    %%\n");
    std::print("%%                         DO NOT EDIT                                %%\n");
    std::print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n");
    std::print("\n");
    for (auto&& entry : entries) entry.print();
}
} // namespace dictionary

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

void translate(std::string_view text, bool show_unsupported) {
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
    [[maybe_unused]] char32_t prev{};
    u32stream s{input};

    // Helper to handle apostrophe-h combinations. Some letters
    // may be followed by '’h', which turns them into fricatives;
    // if the apostrophe is not followed by a 'h', then it is simply
    // discarded. This handles that case.
    const auto HandleApostropheH = [&](char32_t base, char32_t fricative) {
        if (s.consume_any(apos) and s.consume(U'h')) ipa += fricative;
        else ipa += base;
    };

    for (; not s.empty(); prev = c) {
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
        help<>
    >; // clang-format on

    auto opts = options::parse(argc, argv);
    const bool show_unsupp = opts.get<"--show-unsupported">();
    if (auto d = opts.get<"--dict">()) dictionary::generate(d->contents);
    else if (auto i = opts.get<"-i">()) ipa::translate(*i, show_unsupp);
    else if (auto f = opts.get<"-f">()) ipa::translate(f->contents, show_unsupp);
    else std::print("{} {}", argv[0], options::help());
}
