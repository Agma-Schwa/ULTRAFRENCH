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
    auto handle_unknown_macro(dict::TexParser&, str macro) -> Result<dict::Node::Ptr> override;
    auto preprocess_full_entry(std::vector<std::u32string>&) -> Result<> override;
    auto to_ipa(str word) -> Result<std::string> override {
        return ipa::Translate(word);
    }
};

auto UFOps::handle_unknown_macro(dict::TexParser& p, str macro) -> Result<dict::Node::Ptr> {
    if (p.backend_is<dict::JsonBackend>()) {
        if (macro == "pf") {
            auto a = Try(p.parse_arg());
            return p.group(p.formatting("<f-pf>"), std::move(a), p.formatting("</f-pf>"));
        }

        if (macro == "L") return p.formatting("<f-mut><sup>L</sup></f-mut>");
        if (macro == "N") return p.formatting("<f-mut><sup>N</sup></f-mut>");
    } else if (p.backend_is<dict::TypstBackend>()) {
        if (macro == "pf") {
            auto a = Try(p.parse_arg());
            return p.group(p.formatting("#s[pf]~#emph["), std::move(a), p.formatting("]"));
        }

        if (macro == "L") return p.formatting("#super[L]");
        if (macro == "N") return p.formatting("#super[N]");
    } else {
        Unreachable();
    }

    return LanguageOps::handle_unknown_macro(p, macro);
}

auto UFOps::preprocess_full_entry(std::vector<std::u32string>& parts) -> Result<> {
    // Warn about non-typographic quotes, after comment deletion
    // because it’s technically fine to have them in comments.
    for (const auto& part : parts) {
        if (part.contains(U'\'')) return Error(
            "Non-typographic quote! Please use ‘’ (and “” for nested quotes) instead!"
        );
    }

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
        flag<"--json", "Output the dictionary as JSON">,
        flag<"--minify", "Minify JSON output">,
        help<>
    >; // clang-format on

    auto opts = options::parse(argc, argv);

    // Generate the dictionary.
    if (auto d = opts.get<"--dict">()) {
        using namespace dict;
        UFOps ops;
        auto backend = opts.get<"--json">()
            ? Backend::New<JsonBackend>(ops, opts.get<"--minify">())
            : Backend::New<TypstBackend>(ops);

        std::print(stderr, "[ULTRAFRENCHER] Generating dictionary...\n");
        Generator generator{*backend};
        generator.parse(d->contents);
        return generator.emit();
    }

    // Convert text to IPA.
    if (auto i = opts.get<"-i">())
        std::println("{}", ipa::Translate(*i).value());

    // Convert a text file to IPA.
    else if (auto f = opts.get<"-f">()) std::println("{}", ipa::Translate(f->contents).value());

    // User didn’t specify an action.
    else std::print("{} {}", argv[0], options::help());
}
