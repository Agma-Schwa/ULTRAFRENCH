#ifndef ULTRAFRENCHER_INFLECT_HH
#define ULTRAFRENCHER_INFLECT_HH

#include <optional>
#include <span>
#include <string>

auto inflect_verb(
    std::string_view w,
    std::string_view future_stem,
    std::string_view subjunctive_stem,
    std::span<std::string> form_parts
) -> std::optional<std::string>;

//auto inflect_noun(std::string_view form, std::string_view word) -> std::optional<std::string>;

#endif // ULTRAFRENCHER_INFLECT_HH
