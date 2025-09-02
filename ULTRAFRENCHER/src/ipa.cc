#include <base/Base.hh>
#include <base/Text.hh>
#include <ipa.hh>
#include <print>

using namespace base;

namespace {
[[maybe_unused]] constexpr char32_t VoicelessAbove = U'̊';
constexpr char32_t Acute = U'́';
constexpr char32_t Grave = U'̀';
constexpr char32_t Circumflex = U'̂';
constexpr char32_t Tilde = U'̃';
constexpr char32_t VoicelessBelow = U'̥';
constexpr char32_t Diaeresis = U'̈';
constexpr char32_t DotBelow = U'̣';
constexpr str32 WSOrPipe = U" \t\v\f\n\r|";
constexpr str32 Apostrophe = U"'`’\N{MODIFIER LETTER APOSTROPHE}";

// Convert a sound to its nasal equivalent (but without
// any diacritics)
constexpr char32_t Nasal(char32_t c) {
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
} // namespace

auto ipa::Translate(str text) -> Result<std::string> {
    // Convert it to a u32 string.
    // Map the text to IPA.
    auto input = text::Normalise(text::ToLower(text::ToUTF32(text)), text::NormalisationForm::NFD);
    std::u32string ipa;
    char32_t c{};
    str32 s{input};

    // Helper to handle apostrophe-h combinations. Some letters
    // may be followed by '’h', which turns them into fricatives;
    // if the apostrophe is not followed by a 'h', then it is simply
    // discarded. This handles that case.
    const auto HandleApostropheH = [&](char32_t base, char32_t fricative) {
        if (s.consume_any(Apostrophe) and s.consume(U'h')) ipa += fricative;
        else ipa += base;
    };

    // Word-final schwa is always voiceless. This handles that.
    const auto AtEndOfWord = [&] {
        if (ipa.ends_with(U'ə')) ipa += VoicelessBelow;
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
            case U'(':
            case U')':
            case U'₁':
            case U'₂':
            case U'₃':
            case U'₄':
            case U'₅':
                AtEndOfWord();
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
                AtEndOfWord();
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
                        if (s.consume_any(Apostrophe)) ipa += U"ɥ̃";
                        else {
                            ipa += Nasal(c);
                            ipa += Tilde;
                        }
                        break;

                    default:
                        if (s.consume_any(Apostrophe)) ipa += U"ɥ";
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

            // 's' can start:
            //   - ś
            //   - ss
            //   - śś
            //   - s’h (northern dialect)
            //   - ṣ’h (northern dialect)
            case U's':
                (void) s.consume(DotBelow);
                if (s.consume_any(Apostrophe) and s.consume('h')) {
                    ipa += U"ʃ";
                } else if (s.consume(Acute)) {
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
                HandleApostropheH(U't', U'θ');
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

            default: return Error(
                "Unsupported character U+{:04X}: {}\n",
                u32(c),
                text::ToUTF8(c)
            );
        }
    }

    AtEndOfWord();
    return text::ToUTF8(ipa);
}
