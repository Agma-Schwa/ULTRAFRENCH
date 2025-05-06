#ifndef IPA_HH
#define IPA_HH

#include <base/Result.hh>
#include <string>

namespace ipa {
[[nodiscard]] auto Translate(std::string_view text) -> base::Result<std::string>;
}

#endif
