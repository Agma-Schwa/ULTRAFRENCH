#include <algorithm>
#include <clopts.hh>
#include <ranges>
#include <string>
#include <unicode/translit.h>
#include <unicode/stringoptions.h>
#include <unicode/unistr.h>
#include <utils.hh>
#include <variant>
#include <vector>

namespace rgs = std::ranges;
namespace vws = std::ranges::views;

#define DICT_FILE "DICTIONARY.txt"

static icu::Transliterator* normaliser;

void trim(std::u32string& s) {
    while (s.back() == ' ') { s.pop_back(); }
    auto it = s.begin();
    while (it != s.end() and std::isspace(u8(*it))) it++;
    s.erase(s.begin(), it);
}

[[nodiscard]] auto trim(std::u32string_view s) -> std::u32string_view {
    while (s.back() == ' ') { s.remove_suffix(1); }
    auto it = s.begin();
    while (it != s.end() and std::isspace(u8(*it))) it++;
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
                /// If the first part contains no spaces, insert \pfabbr.
                if (i == 1 and not parts[i].contains(U' ')) fmt::print("{{\\pfabbr {}}}", to_utf8(parts[i]));
                else fmt::print("{{{}}}", to_utf8(parts[i]));
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

int main(int argc, char** argv) {
    using namespace command_line_options;
    using options = clopts< // clang-format off
        positional<"file", "The file to process", file<>, true>,
        help<>
    >; // clang-format on

    /// Read file.
    options::parse(argc, argv);

    /// Get NFKD normaliser.
    UErrorCode err{U_ZERO_ERROR};
    normaliser = icu::Transliterator::createInstance(
        "NFKD; [:M:] Remove; NFC; Lower;",
        UTRANS_FORWARD,
        err
    );
    if (U_FAILURE(err)) die("Failed to get NFKD normalizer: {}", u_errorName(err));

    /// Convert text to u32.
    std::u32string text;
    auto us = icu::UnicodeString::fromUTF8(options::get<"file">()->contents);
    text.resize(usz(us.length()));
    auto sz = us.toUTF32(reinterpret_cast<UChar32*>(text.data()), i32(text.size()), err);
    if (U_FAILURE(err)) die("Failed to convert text to UTF-32: {}", u_errorName(err));
    text.resize(usz(sz));

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
