#ifndef ULTRAFRENCHER_UTILS_HH
#define ULTRAFRENCHER_UTILS_HH

#include <fmt/format.h>
#include <unordered_map>

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

using c32 = char32_t;

#define STR_(X) #X
#define STR(X) STR_(X)

#define CAT_(X, Y) X##Y
#define CAT(X, Y) CAT_(X, Y)

template <typename ...arguments>
[[noreturn]] void die(fmt::format_string<arguments...> fmt, arguments&& ...args) {
    fmt::print(stderr, fmt, std::forward<arguments>(args)...);
    fmt::print(stderr, "\n");
    std::exit(1);
}

struct str_hash {
    using is_transparent = void;
    [[nodiscard]] size_t operator()(std::string_view txt) const { return std::hash<std::string_view>{}(txt); }
    [[nodiscard]] size_t operator()(const std::string& txt) const { return std::hash<std::string>{}(txt); }
};

/// Map with heterogeneous lookup.
template <typename value_type>
using map = std::unordered_map<std::string, value_type, str_hash, std::equal_to<>>;

#endif // ULTRAFRENCHER_UTILS_HH
