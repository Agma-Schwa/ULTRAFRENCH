#include <clopts.hh>
#include <functional>
#include <inflect.hh>
#include <word.hh>

namespace {
template <typename T>
requires std::is_enum_v<T>
constexpr std::underlying_type_t<T> operator+(T t) {
    return static_cast<std::underlying_type_t<T>>(t);
}

/// Compile-time string.
template <size_t sz>
struct static_string {
    char32_t data[sz]{};
    size_t size{};

    /// Construct an empty string.
    constexpr static_string() {}

    /// Construct from a string literal.
    constexpr static_string(const char32_t (&_data)[sz]) {
        std::copy_n(_data, sz, data);
        size = sz - 1;
    }

    /// Get the string as a \c std::u32string_view.
    [[nodiscard]] constexpr auto sv() const -> std::u32string_view { return {data, size}; }
};

/// ========================================================================
///  Data.
/// ========================================================================
enum struct tense {
    present,
    present_anterior,
    preterite,
    future_i,
    future_ii,
    conditional,
    future_anterior,
};

enum struct mood {
    indicative,
    subjunctive,
};

enum struct person {
    none,
    _1sg,
    _2sg,
    _3msg,
    _3fsg,
    _3nsg,
    _1pl,
    _2pl,
    _3mpl,
    _3fpl,
    _3npl,
    inf,
    part,
};

enum struct voice {
    active,
    passive,
};

enum struct form_kind {
    tense,
    mood,
    voice,
    person,
};

static const map<std::pair<form_kind, int>> forms{
    {"1sg", {form_kind::person, +person::_1sg}},
    {"2sg", {form_kind::person, +person::_2sg}},
    {"3msg", {form_kind::person, +person::_3msg}},
    {"3fsg", {form_kind::person, +person::_3fsg}},
    {"3nsg", {form_kind::person, +person::_3nsg}},
    {"3sg", {form_kind::person, +person::_3nsg}},
    {"1pl", {form_kind::person, +person::_1pl}},
    {"2pl", {form_kind::person, +person::_2pl}},
    {"3mpl", {form_kind::person, +person::_3mpl}},
    {"3fpl", {form_kind::person, +person::_3fpl}},
    {"3npl", {form_kind::person, +person::_3npl}},
    {"3pl", {form_kind::person, +person::_3npl}},
    {"inf", {form_kind::person, +person::inf}},
    {"part", {form_kind::person, +person::part}},

    {"ind", {form_kind::mood, +mood::indicative}},
    {"subj", {form_kind::mood, +mood::subjunctive}},

    {"act", {form_kind::voice, +voice::active}},
    {"pass", {form_kind::voice, +voice::passive}},

    {"pres", {form_kind::tense, +tense::present}},
    {"pres-ant", {form_kind::tense, +tense::present_anterior}},
    {"pret", {form_kind::tense, +tense::preterite}},
    {"fut1", {form_kind::tense, +tense::future_i}},
    {"fut2", {form_kind::tense, +tense::future_ii}},
    {"cond", {form_kind::tense, +tense::conditional}},
    {"fut-ant", {form_kind::tense, +tense::future_anterior}},
};

/// ========================================================================
///  Combining Rules.
/// ========================================================================
template <static_string... vals>
struct is {
    static bool test(word& w) {
        return ((w == vals.sv()) or ...);
    }
};

template <typename... preds>
struct either {
    static bool test(word& w) {
        return (preds::test(w) or ...);
    }
};

template <typename... preds>
struct none {
    static bool test(word& w) {
        return not either<preds...>::test(w);
    }
};

template <typename... preds>
struct all {
    static bool test(word& w) {
        return (preds::test(w) and ...);
    }
};

/// Select between conditions.
template <typename rule, typename output, typename... rest>
struct cond {
    static void apply(word& w) {
        if (rule::test(w)) {
            output::apply(w);
        } else {
            if constexpr (sizeof...(rest)) {
                cond<rest...>::apply(w);
            }
        }
    }
};

/// Add an affix only if a condition is true.
template <typename condition, typename output>
struct when {
    static void apply(word& w) {
        if (condition::test(w)) output::apply(w);
    }
};

/// Always returns true.
struct otherwise {
    static bool test(word&) { return true; }
};

/// Invert a condition.
template <typename condition>
struct inv {
    static bool test(word& w) { return not condition::test(w); }
};

/// ========================================================================
///  Primitives.
/// ========================================================================
/// Prepend a string.
template <static_string val>
struct prefix {
    constexpr explicit prefix() = default;
    static void apply(word& w) { w.prepend(val.sv()); }
};

/// Append a string.
template <static_string val>
struct suffix {
    constexpr explicit suffix() = default;
    static void apply(word& w) { w.append(val.sv()); }
};

/// Check if a string starts with something.
template <typename...>
struct starts_with;

template <typename...>
struct starts_with {
    static bool test(auto&&... word) = delete;
};

template <static_string... alts>
struct starts_with<is<alts...>> {
    static bool test(word& w) {
        return ((w.starts_with(alts.sv())) or ...);
    }
};

template <typename predicate>
struct starts_with<predicate> {
    static bool test(word& w) { return predicate::test(w); }
};

/// Check if a string ends with something.
template <typename...>
struct ends_with;

template <typename...>
struct ends_with {
    static bool test(auto&&... word) = delete;
};

template <static_string... alts>
struct ends_with<is<alts...>> {
    static bool test(word& w) { return ((w.ends_with(alts.sv())) or ...); }
};

template <typename predicate>
struct ends_with<predicate> {
    static bool test(word& w) { return predicate::test(w); }
};

/// Check if something is a vowel.
struct is_vowel {
    static bool test(word& s) {
        if (s.empty()) return false;

        auto it = s.begin();
        auto c = *it;
        switch (c) {
            case U'a':
            case U'e':
            case U'i':
            case U'o':
            case U'u':
                ++it;
                break;

            case U'y':
                ++it;
                break;

            default:
                return false;
        }

        while (it) {
            switch (*it) {
                case U'́':
                case U'̀':
                case U'̂':
                case U'̣':
                case U'̈':
                    ++it;
                    continue;

                /// y' and ý' are not vowels.
                case U'\'':
                    if (c == U'y') return false;
                    [[fallthrough]];

                /// Anything else means we can stop.
                default:
                    return true;
            }
        }

        return true;
    }
};

struct is_consonant {
    static bool test(word& w) { return not is_vowel::test(w); }
};

/// Apply nasalisation.
struct nasalise_end {
    static void apply(word&) {
        throw std::runtime_error("Nasalisation is not implemented yet");
    }
};

/// Do nothing.
struct nop {
    static void apply(word&) {}
};

/// An affix that can be applied to a word.
template <typename... affixes>
struct affix {
    /// Affixes to apply.
    static void apply(word& w) { (affixes::apply(w), ...); }
};

/// ========================================================================
///  Affixes.
/// ========================================================================
/// Present tense active/passive affixes.
namespace present_affixes { // clang-format off
using is_o = is<U"o", U"ó", U"ò" U"ô">;
using is_e = is<U"e", U"é", U"è", U"ê">;

/// Active singular.
using act_1sg = prefix<U"j">;
using act_2sg = affix<
    when<starts_with<is_consonant>,
         prefix<U"ẹ">>,
    prefix<U"ḍ">
>;
using act_3msg = affix<
    when<starts_with<is_consonant>,
         prefix<U"ẹ">>,
    prefix<U"l">
>;
using act_3fsg = affix<
    when<starts_with<is_consonant>,
         prefix<U"a">>,
    prefix<U"ll">
>;
using act_3nsg = prefix<U"s">;

/// Active plural.
using act_1pl = affix<
    cond<
        starts_with<is_o>, prefix<U"w">,
        starts_with<is_vowel>, prefix<U"r">,
        otherwise, prefix<U"aú">
    >,
    cond<
        ends_with<is_consonant>, suffix<U"ó">,
        ends_with<is_o>, nasalise_end,
        otherwise, suffix<U"y'ó">
    >
>;
using act_2pl = affix<
    when<all<is_consonant, inv<starts_with<is<U"y'", U"ý'">>>>,
         suffix<U"y">>,
    prefix<U"b'h">,
    cond<
        ends_with<is_consonant>, suffix<U"é">,
        ends_with<is_e>, nasalise_end,
        otherwise, suffix<U"y'é">
    >
>;
using act_3mpl = act_3msg;
using act_3fpl = affix<
    when<starts_with<is_consonant>,
         prefix<U"ẹ">>,
    prefix<U"ll">
>;
using act_3npl = affix<
    when<starts_with<is_consonant>,
         prefix<U"a">>,
    prefix<U"l">
>;

/// Active non-finite.
using act_inf = affix<
    when<starts_with<is_consonant>,
         prefix<U"ẹ">>,
    prefix<U"d">
>;
using act_part = suffix<U"â">;

/// Passive singular.
using pass_1sg = prefix<U"v">;
using pass_2sg = affix<
    when<starts_with<is_consonant>,
         prefix<U"ẹ">>,
    prefix<U"ḍ">
>;

using pass_3msg = prefix<U"y'">;
using pass_3fsg = pass_3msg;
using pass_3nsg = prefix<U"sy">;

/// Passive plural.
using pass_1pl = affix<
    cond<
        starts_with<is_o>, prefix<U"w">,
        starts_with<is_vowel>, prefix<U"r">,
        otherwise, prefix<U"aú">
    >
>;
using pass_2pl = affix<
    when<all<is_consonant, inv<starts_with<is<U"y'", U"ý'">>>>,
         suffix<U"y">>,
    prefix<U"b'h">
>;

/// Passive non-finite.
using pass_3pl = prefix<U"lý">;
using pass_inf = cond<
    starts_with<is<U"a", U"à">>, prefix<U"á">,
    starts_with<is<U"á", U"â">>, prefix<U"â">,
    starts_with<is_vowel>, prefix<U"h">,
    otherwise, prefix<U"a">
>;

} // clang-format on

/// Helper that holds state for a single inflection.
struct inflexion {
    word present_stem;
    word future_stem;
    word subjunctive_stem;
    person pa; /// Active person.
    person pp; /// Passive person.
    tense t;
    mood m;

    /// The form we're building.
    word form{};

    /// Conjugate a verb.
    word operator()() {
        /// Determine stem.
        word* stem = &present_stem;
        switch (m) {
            case mood::subjunctive: stem = &subjunctive_stem; break;
            case mood::indicative:
                switch (t) {
                    case tense::future_ii:
                    case tense::future_anterior:
                    case tense::conditional:
                        stem = &future_stem;
                        break;

                    default:
                        break;
                }
        }

        /// Start with the stem.
        form = *stem;

        /// Present tense is easy, append the affixes.
        if (t == tense::present) {
            apply_act_pass_affixes();
            return form;
        }

        throw std::runtime_error("Not implemented yet");
    }

    /// Apply base active/passive affixes to the form.
    void apply_act_pass_affixes() {
        /// Passive prefix is inside, unless it is a
        /// non-finite form.
        if (pp == person::inf or pp == person::part) {
            apply_base_act_pass_affix(pa, true);
            apply_base_act_pass_affix(pp, false);
        } else {
            apply_base_act_pass_affix(pp, false);
            apply_base_act_pass_affix(pa, true);
        }
    }

    /// Apply an affix to a form.
    void apply_base_act_pass_affix(person p, bool active) {
        using namespace present_affixes;
        if (active) {
            switch (p) {
                case person::none: break;
                case person::_1sg: act_1sg::apply(form); break;
                case person::_2sg: act_2sg::apply(form); break;
                case person::_3msg: act_3msg::apply(form); break;
                case person::_3fsg: act_3fsg::apply(form); break;
                case person::_3nsg: act_3nsg::apply(form); break;
                case person::_1pl: act_1pl::apply(form); break;
                case person::_2pl: act_2pl::apply(form); break;
                case person::_3mpl: act_3mpl::apply(form); break;
                case person::_3fpl: act_3fpl::apply(form); break;
                case person::_3npl: act_3npl::apply(form); break;
                case person::inf: act_inf::apply(form); break;
                case person::part: act_part::apply(form); break;
            }
        } else {
            switch (p) {
                case person::none: break;
                case person::_1sg: pass_1sg::apply(form); break;
                case person::_2sg: pass_2sg::apply(form); break;
                case person::_3msg: pass_3msg::apply(form); break;
                case person::_3fsg: pass_3fsg::apply(form); break;
                case person::_3nsg: pass_3nsg::apply(form); break;
                case person::_1pl: pass_1pl::apply(form); break;
                case person::_2pl: pass_2pl::apply(form); break;
                case person::_3mpl: pass_3pl::apply(form); break;
                case person::_3fpl: pass_3pl::apply(form); break;
                case person::_3npl: pass_3pl::apply(form); break;
                case person::inf: pass_inf::apply(form); break;
                case person::part: pass_inf::apply(form); break;
            }
        }
    }
};
} // namespace

auto inflect_verb(
    std::string_view present_stem,
    std::string_view future_stem,
    std::string_view subjunctive_stem,
    std::span<std::string> form_parts
) -> std::optional<std::string> {
    /// Parse forms.
    person p1 = person::none, p2 = person::none;
    voice v1 = voice::active, v2 = voice::active;
    tense t = tense::present;
    mood m = mood::indicative;
    usz voice_count = 0;

    for (auto el : form_parts) {
        auto it = forms.find(el);
        if (it == forms.end()) {
            fmt::print("Unknown form '{}'\n", el);
            return std::nullopt;
        }

        switch (it->second.first) {
            case form_kind::person:
                if (p1 == person::none) p1 = person(it->second.second);
                else p2 = person(it->second.second);
                break;

            case form_kind::voice:
                switch (voice_count++) {
                    case 0: v1 = voice(it->second.second); break;
                    case 1: v2 = voice(it->second.second); break;
                    default: {
                        fmt::print("Too many voices specified.\n");
                        return std::nullopt;
                    }
                }
                break;

            case form_kind::tense:
                t = tense(it->second.second);
                break;

            case form_kind::mood:
                m = mood(it->second.second);
                break;
        }
    }

    /// Inflect the verb.
    auto inflected = inflexion(
        present_stem,
        future_stem,
        subjunctive_stem,
        v1 == voice::active ? p1 : p2,
        v2 == voice::passive ? p2 : p1,
        t,
        m
    )();

    return inflected.string();
}
