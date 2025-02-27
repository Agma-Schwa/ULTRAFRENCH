#ifndef IPA_HH
#define IPA_HH

#include <string>

namespace ipa {
[[nodiscard]] auto Translate(std::string_view text, bool show_unsupported) -> std::string;
}

#endif
