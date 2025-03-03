#include <algorithm>
#include <base/Assert.hh>
#include <base/Base.hh>
#include <base/Text.hh>
#include <clopts.hh>
#include <dictgen/backends.hh>
#include <dictgen/frontend.hh>
#include <ipa.hh>
#include <print>
#include <string>

using namespace base;

struct UFOps : dict::LanguageOps {
    auto handle_unknown_macro(dict::TeXToHtmlConverter& conv, std::string_view macro) -> Result<> override;
    auto preprocess_full_entry(std::vector<std::u32string>&) -> Result<> override;
    auto to_ipa(std::string_view word) -> std::string override {
        return ipa::Translate(word, false);
    }
};

auto UFOps::handle_unknown_macro(dict::TeXToHtmlConverter& conv, std::string_view macro) -> Result<> {
    if (macro == "pf") Try(conv.single_argument_macro_to_tag("f-pf"));
    else if (macro == "L") conv.drop_empty_and_append_raw("<f-mut><sup>L</sup></f-mut>");
    else if (macro == "N") conv.drop_empty_and_append_raw("<f-mut><sup>N</sup></f-mut>");
    else return LanguageOps::handle_unknown_macro(conv, macro);
    return {};
}

auto UFOps::preprocess_full_entry(std::vector<std::u32string>& parts) -> Result<> {
    // If this is a single word, and the field contains no backslashes,
    // wrap it with '\pf{}'. That takes care of this field for most words
    // (conversely, more complex etymologies often don’t start w/ a PF word).
    // Etymology is empty; don’t do anything here.
    if (auto& part = parts[+dict::FullEntry::Part::EtymPart]; not part.empty()) {
        // If the etymology contains no spaces or macros, it is likely just
        // a single French word, so insert \pf.
        if (not part.contains(U' ') and not part.contains(U'\\'))
            part = U"\\pf{" + std::move(part) + U"}"; // No Utf32 std::format :(
    }
    return {};
}

int main(int argc, char** argv) {
    using namespace command_line_options;
    using options = clopts< // clang-format off
        option<"--dict", "The file to process", file<>>,
        option<"-i", "Convert text to IPA">,
        option<"-f", "Convert a text file to IPA", file<>>,
        flag<"--show-unsupported", "Print <U+XXXX> for unsupported characters">,
        flag<"--json", "Output the dictionary as JSON">,
        flag<"--minify", "Minify JSON output">,
        help<>
    >; // clang-format on

    auto opts = options::parse(argc, argv);
    const bool show_unsupp = opts.get<"--show-unsupported">();

    // Generate the dictionary.
    if (auto d = opts.get<"--dict">()) {
        using namespace dict;
        UFOps ops;
        auto backend = opts.get<"--json">()
            ? Backend::New<JsonBackend>(ops, opts.get<"--minify">())
            : Backend::New<TeXBackend>(ops, d->path.filename().string());

        std::print(stderr, "[ULTRAFRENCHER] Generating dictionary...\n");
        Generator generator{*backend};
        generator.parse(d->contents);
        generator.emit();
    }

    // Convert text to IPA.
    else if (auto i = opts.get<"-i">())
        std::println("{}", ipa::Translate(*i, show_unsupp));

    // Convert a text file to IPA.
    else if (auto f = opts.get<"-f">()) std::println("{}", ipa::Translate(f->contents, show_unsupp));

    // User didn’t specify an action.
    else std::print("{} {}", argv[0], options::help());
}
