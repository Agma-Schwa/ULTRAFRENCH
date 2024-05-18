#include <algorithm>
#include <clopts.hh>
#include <fmt/format.h>
#include <fmt/xchar.h>
#include <ranges>
#include <string>
#include <unicode/schriter.h>
#include <unicode/stringoptions.h>
#include <unicode/translit.h>
#include <unicode/unistr.h>
#include <variant>
#include <vector>

namespace rgs = std::ranges;
namespace vws = std::ranges::views;

using u8 = uint8_t;
using u16 = uint16_t;
using u32 = uint32_t;
using u64 = uint64_t;
using usz = size_t;
using uptr = uintptr_t;

using i8 = int8_t;
using i16 = int16_t;
using i32 = int32_t;
using i64 = int64_t;
using isz = ptrdiff_t;
using iptr = intptr_t;

#define STR_(X) #X
#define STR(X)  STR_(X)

#define CAT_(X, Y) X##Y
#define CAT(X, Y)  CAT_(X, Y)

template <typename... arguments>
[[noreturn]] void die(fmt::format_string<arguments...> fmt, arguments&&... args) {
    fmt::print(stderr, fmt, std::forward<arguments>(args)...);
    fmt::print(stderr, "\n");
    std::exit(1);
}

constexpr bool isspace(char32_t c) {
    return c == ' ' or c == '\t' or c == '\n' or c == '\r' or c == '\f' or c == '\v';
}

void trim(std::u32string& s) {
    while (s.back() == ' ') { s.pop_back(); }
    auto it = s.begin();
    while (it != s.end() and isspace(*it)) it++;
    s.erase(s.begin(), it);
}

[[nodiscard]] auto trim(std::u32string_view s) -> std::u32string_view {
    while (s.back() == ' ') { s.remove_suffix(1); }
    auto it = s.begin();
    while (it != s.end() and isspace(*it)) it++;
    return s.substr(usz(it - s.begin()));
}

template <typename Callback>
void split(std::u32string_view text, std::u32string_view sep, Callback cb) {
    usz pos = 0;
    for (;;) {
        auto next = text.find(sep, pos);
        if (next == std::u32string::npos) {
            cb(text.substr(pos));
            break;
        } else {
            cb(text.substr(pos, next - pos));
            pos = next + sep.size();
        }
    }
}

auto to_utf8(std::u32string_view sv) -> std::string {
    auto s = icu::UnicodeString::fromUTF32(reinterpret_cast<const UChar32*>(sv.data()), i32(sv.size()));
    std::string result;
    s.toUTF8String(result);
    return result;
}

auto to_utf32(const icu::UnicodeString& us) -> std::u32string {
    std::u32string text;
    UErrorCode err{U_ZERO_ERROR};
    text.resize(usz(us.length()));
    auto sz = us.toUTF32(reinterpret_cast<UChar32*>(text.data()), i32(text.size()), err);
    if (U_FAILURE(err)) die("Failed to convert text to UTF-32: {}", u_errorName(err));
    text.resize(usz(sz));
    return text;
}

auto utf8(char32_t c) -> std::string {
    std::u32string_view sv{&c, 1};
    return to_utf8(sv);
}

namespace dictionary {
static icu::Transliterator* normaliser;

struct entry {
    /// Headword.
    std::u32string word;

    /// Headword in NFKD for sorting.
    icu::UnicodeString nfkd;

    /// Data.
    std::variant<std::u32string, std::vector<std::u32string>> data;

    entry(std::u32string word, std::u32string data)
        : word{std::move(word)}
        , data{std::move(data)} { init(); }
    entry(std::u32string word, std::vector<std::u32string> data)
        : word{std::move(word)}
        , data{std::move(data)} { init(); }

    void print() const {
        auto s = to_utf8(word);
        if (std::holds_alternative<std::u32string>(data)) {
            fmt::print("\\refentry{{{}}}{{{}}}\n", s, to_utf8(std::get<std::u32string>(data)));
        } else {
            auto& parts = std::get<std::vector<std::u32string>>(data);
            usz i = 0;
            fmt::print("\\entry{{{}}}", s);
            for (; i < parts.size(); i++) {
                /// If the first part contains no spaces and is not empty, insert \pfabbr.
                if (i == 1 and not parts[i].empty() and not parts[i].contains(U' ')) {
                    fmt::print("{{\\pfabbr {}}}", to_utf8(parts[i]));
                } else {
                    fmt::print("{{{}}}", to_utf8(parts[i]));
                }
            }
            for (; i < 5; i++) fmt::print("{{}}");
            fmt::print("\n");
        }
    }

private:
    void init() {
        nfkd = icu::UnicodeString::fromUTF32(reinterpret_cast<const UChar32*>(word.data()), i32(word.size()));
        normaliser->transliterate(nfkd);
    }
};

class line_buffer {
    std::u32string_view text;
    usz pos;

public:
    line_buffer(std::u32string_view text)
        : text{text}
        , pos{0} {}
    void operator()(std::u32string& line) {
        /// Return empty line if we’re at the end.
        if (pos == std::u32string::npos) return;

        /// Find next line break. If there is none, return the rest.
        auto line_break = text.find('\n', pos);
        if (line_break == std::u32string::npos) {
            line += text.substr(pos);
            pos = std::u32string::npos;
        }

        /// Otherwise, return the line and advance the position.
        else {
            line += text.substr(pos, line_break - pos);
            pos = line_break + 1;
        }
    }

    explicit operator bool() const { return pos != std::u32string::npos; }
};

void generate(std::string_view input_text) {
    fmt::print(stderr, "[ULTRAFRENCHER] Generating dictionary...\n");

    UErrorCode err{U_ZERO_ERROR};
    normaliser = icu::Transliterator::createInstance(
        "NFKD; [:M:] Remove; NFC; Lower;",
        UTRANS_FORWARD,
        err
    );
    if (U_FAILURE(err)) die("Failed to get NFKD normalizer: {}", u_errorName(err));

    /// Convert text to u32.
    std::u32string text = to_utf32(icu::UnicodeString::fromUTF8(input_text));

    /// Process the text.
    line_buffer buf{text};
    std::u32string line;
    std::vector<entry> entries;
    while (buf) {
        line.clear();
        buf(line);

        /// Delete comments.
        if (auto comment_start = line.find(U'#'); comment_start != std::u32string::npos)
            line.erase(comment_start);

        /// Perform line continuation.
        while (trim(line), line.back() == U'\\' and buf) {
            line.pop_back();
            buf(line);
        }

        /// Skip empty lines.
        if (line.empty()) continue;

        /// Collapse whitespace into single spaces.
        for (usz pos = 0;;) {
            static constexpr std::u32string_view ws = U" \t\v\f\n\r";
            pos = line.find_first_of(ws, pos);
            if (pos == std::u32string::npos) break;
            if (auto end = line.find_first_not_of(ws, pos); end != std::u32string::npos) {
                line.replace(pos, end - pos, U" ");
                pos = end;
            } else {
                line.erase(pos);
                break;
            }
        }

        /// If the line contains no '|' characters and a `>`,
        /// it is a reference. Split by '>'. The lhs is a
        /// comma-separated list of references, the rhs is the
        /// actual definition.
        if (auto gt = line.find(U'>'); gt != std::u32string::npos and not line.contains('|')) {
            auto word = trim(std::u32string_view{line}.substr(gt + 1));
            split(std::u32string_view{line}.substr(0, gt), U",", [&](std::u32string_view ref) {
                entries.emplace_back(std::u32string{trim(ref)}, std::u32string{word});
            });
        }

        /// Otherwise, the line is an entry. Split by '|' and emit
        /// a single entry for the line.
        else {
            bool first = true;
            std::u32string word;
            std::vector<std::u32string> line_parts;
            split(line, U"|", [&](std::u32string_view part) {
                if (first) {
                    first = false;
                    word = std::u32string{part};
                } else {
                    line_parts.emplace_back(trim(part));
                }
            });
            entries.emplace_back(std::move(word), std::move(line_parts));
        }
    }

    /// Sort the entries.
    rgs::sort(entries, [](const auto& a, const auto& b) {
        return a.nfkd == b.nfkd ? a.word < b.word : a.nfkd < b.nfkd;
    });
    for (auto&& entry : entries) entry.print();
}
} // namespace dictionary

namespace ipa {
static constexpr char32_t Acute = U'́';
static constexpr char32_t Grave = U'̀';
static constexpr char32_t Circumflex = U'̂';
static constexpr char32_t Tilde = U'̃';
static constexpr char32_t VoicelessBelow = U'̥';
static constexpr char32_t VoicelessAbove = U'̊';
static constexpr char32_t Diaeresis = U'̈';
static constexpr char32_t DotBelow = U'̣';

static constexpr std::u32string_view apos = U"'`’";
static constexpr std::u32string_view ws = U" \t\v\f\n\r|";

class iterator {
    const char32_t* it;
    const char32_t* end;

public:
    iterator(const std::u32string& sv)
        : it{sv.data()}
        , end{sv.data() + sv.size()} {}

    bool consume(char32_t c) {
        if (is(c)) {
            it++;
            return true;
        } else {
            return false;
        }
    }

    bool consume_any(std::u32string_view sv) {
        if (is_any(sv)) {
            it++;
            return true;
        } else {
            return false;
        }
    }

    bool is(std::same_as<char32_t> auto... cs) {
        auto c = **this;
        return ((c == cs) or ...);
    }

    bool is_any(std::u32string_view sv) {
        return rgs::contains(sv, **this);
    }

    bool matches(std::u32string_view sv) {
        return std::u32string_view{it, usz(end - it)}.starts_with(sv);
    }

    char32_t operator*() const {
        if (it == end) return 0;
        return *it;
    }

    auto operator++() -> char32_t {
        if (it == end) return 0;
        return *++it;
    }

    auto operator++(int) -> char32_t {
        if (it == end) return 0;
        return *it++;
    }

    explicit operator bool() const { return it != end; }
};

/// Convert a sound to its nasal equivalent (but without
/// any diacritics)
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
    /// Normalise the text before IPA conversion so we have
    /// to deal with fewer cases. Also convert to lowercase
    /// and convert ASCII apostrophes to '’'.
    UErrorCode err{U_ZERO_ERROR};
    auto normaliser = icu::Transliterator::createInstance(
        u"NFD; Lower;",
        UTRANS_FORWARD,
        err
    );
    if (U_FAILURE(err)) die("Failed to get Transliterator: {}", u_errorName(err));
    auto us = icu::UnicodeString::fromUTF8(text);
    normaliser->transliterate(us);

    /// Convert it to a u32 string.
    /// Map the text to IPA.
    std::u32string ipa, input = to_utf32(us);
    char32_t c{};
    [[maybe_unused]] char32_t prev{};
    iterator it{input};

    /// Helper to handle apostrophe-h combinations. Some letters
    /// may be followed by '’h', which turns them into fricatives;
    /// if the apostrophe is not followed by a 'h', then it is simply
    /// discarded. This handles that case.
    const auto HandleApostropheH = [&](char32_t base, char32_t fricative) {
        if (it.consume_any(apos)) {
            if (it.consume(U'h')) {
                ipa += fricative;
                return;
            }
        }

        ipa += base;
    };

    for (; it; prev = c) {
        switch (c = it++) {
            /// Skip most punctuation marks.
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

            /// Skip these in the middle of words.
            case U'\'':
            case U'`':
            case U'’':
                break;

            /// Skip letters that are not part of the language.
            case U'g':
            case U'm':
            case U'k':
            case U'p':
            case U'q':
            case U'x':
                break;

            /// Collapse whitespace and convert '|' to a space as well
            /// since we use it to separate words in glosses.
            case U' ':
            case U'\t':
            case U'\v':
            case U'\f':
            case U'\n':
            case U'\r':
            case U'|':
                while (it.is_any(ws)) it++;
                ipa += U' ';
                break;

            /// Simple vowels.
            case U'i':
            case U'o':
            case U'u':
            simple_vowel: {
                switch (*it) {
                    case Grave:
                        it++;
                        ipa += c;
                        ipa += VoicelessBelow;
                        break;

                    case Acute:
                        it++;
                        ipa += Nasal(c);
                        ipa += Tilde;
                        break;

                    case Circumflex:
                        it++;
                        ipa += Nasal(c);
                        ipa += Tilde;
                        ipa += Tilde;
                        break;

                    default:
                        ipa += c;
                        break;
                }
            } break;

            /// 'a' could be followed by 'u', optionally with
            /// a diacritic on the 'u' (except a diaeresis), in
            /// which case it is actually 'o'.
            case U'a': {
                if (it.consume(U'u')) {
                    if (it.consume(Diaeresis)) {
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

            /// 'e' is complicated because it has two nasal variants,
            /// and because it can also be a schwa. Fortunately, NFC
            /// puts the dot below first, so we can get that out of the
            /// way early.
            case U'e': {
                const bool dot = it.consume(DotBelow);
                switch (*it) {
                    /// E-grave is oral 'ɛ'.
                    case Grave:
                        it++;
                        ipa += U'ɛ';
                        break;

                    case Acute:
                        it++;
                        ipa += dot ? U'e' : U'ɛ';
                        ipa += Tilde;
                        break;

                    case Circumflex:
                        it++;
                        ipa += dot ? U'e' : U'ɛ';
                        ipa += Tilde;
                        ipa += Tilde;
                        break;

                    default:
                        /// E-dot w/ no nasal diacritic is a schwa.
                        ipa += dot ? U'ə' : U'e';

                        /// Word-finally, E-dot is voiceless.
                        if (dot and (not it or it.is_any(ws))) ipa += VoicelessBelow;
                        break;
                }
            } break;

            /// 'y' can be a vowel or a consonant if followed by '’'. Note
            /// that there may be an acute before the apostrophe.
            case 'y': {
                switch (*it) {
                    case Acute:
                        it++;
                        if (it.consume_any(apos)) ipa += U"ɥ̃";
                        else {
                            ipa += Nasal(c);
                            ipa += Tilde;
                        }
                        break;

                    default:
                        if (it.consume_any(apos)) ipa += U"ɥ";
                        else goto simple_vowel;
                }
            } break;

            /// 'b' can be followed by a dot, 'h', or an apostrophe.
            case U'b': {
                switch (*it) {
                    case U'h':
                        it++;
                        ipa += U"bʱ";
                        break;

                    /// If followed by '’h', then this is a fricative. Otherwise,
                    /// just skip the apostrophe.
                    case U'’':
                    case U'\'':
                    case U'`':
                        it++;
                        if (it.consume(U'h')) ipa += U"β";
                        else ipa += U"b";
                        break;

                    /// Dot below doesn’t change the pronunciation.
                    default:
                        it.consume(DotBelow);
                        ipa += U'b';
                        break;
                }
            } break;

            case U'c':
                if (it.consume(Acute)) ipa += U"ɕʶ";
                else if (it.consume(DotBelow)) ipa += U"ȷ̊";
                else HandleApostropheH(U'ɕ', U'x');
                break;

            /// 'd' can be followed by a dot, or '’h’.
            case U'd':
                if (it.consume(DotBelow)) ipa += 'd';
                else HandleApostropheH(U'd', U'ð');
                break;

            case U'f':
                ipa += U'ɸ';
                break;

            case U'h':
                ipa += U'h';
                break;

            /// We sometimes use dotless ‘j’ so we don’t end up
            /// with a dot *and* an acute.
            case U'ȷ':
            case U'j':
                ipa += U'ʑ';
                if (it.consume(Acute)) ipa += U'ʶ';
                break;

            /// Also handle `ll`.
            case U'l':
                if (it.consume(DotBelow)) {
                    ipa += U"ʎ̝̃";
                    while (it.matches(U"ḷ")) {
                        it++;
                        it++;
                        ipa += U'ː';
                    }
                } else {
                    ipa += U"ɮ̃";
                    while (*it == U'l' and not it.matches(U"ḷ")) {
                        it++;
                        ipa += U'ː';
                    }
                }
                break;

            case U'ł':
                ipa += U"ɮ̃ʶ";
                while (it.consume(U'ł')) ipa += U'ː';
                break;

            case U'n':
                ipa += U"n";
                break;

            case U'r':
                ipa += U"ɰ";
                while (it.consume(U'r')) ipa += U'ː';
                break;

            case U's':
                if (it.consume(Acute)) {
                    ipa += U"sʶ";
                    while (it.matches(U"ś")) {
                        it++;
                        it++;
                        ipa += U'ː';
                    }
                } else {
                    ipa += U's';
                    while (*it == U's' and not it.matches(U"ś")) {
                        it++;
                        ipa += U'ː';
                    }
                }
                break;

            /// 't' is always 't’h'
            case U't':
                it.consume_any(apos);
                it.consume(U'h');
                ipa += U'θ';
                break;

            case U'v':
                if (it.consume(Acute)) ipa += U"βʶ";
                else {
                    ipa += U"ʋ̃";
                    while (*it == U'v' and not it.matches(U"v́")) {
                        it++;
                        ipa += U'ː';
                    }
                }
                break;

            case U'w':
                ipa += U"ɰ̃";
                break;

            case U'z':
                ipa += U'z';
                if (it.consume(Acute)) ipa += U'ʶ';
                break;

            default: {
                std::u32string s;
                s += c;
                auto u8char = to_utf8(s);
                fmt::print(
                    stderr,
                    "[ULTRAFRENCHER] Warning: unsupported character U+{:04X}: {}\n",
                    u32(c),
                    u8char
                );

                if (show_unsupported) ipa += fmt::format(U"\033[33m<U+{:04X}>\033[m", u32(c));
            } break;
        }
    }

    fmt::print(stdout, "{}\n", to_utf8(ipa));
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
    else fmt::print("{} {}", argv[0], options::help());
}
