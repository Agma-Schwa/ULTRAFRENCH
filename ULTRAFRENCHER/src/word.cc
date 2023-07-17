#include <word.hh>

word::word(const icu::UnicodeString& str) : data(nfd(str)) {}
word::word(std::u32string_view _data) {
    data = nfd(icu::UnicodeString::fromUTF32(
        reinterpret_cast<const UChar32*>(_data.data()),
        i32(_data.size())
    ));
}

word::word(std::string_view _data) {
    data = nfd(icu::UnicodeString::fromUTF8(icu::StringPiece(_data)));
}

word::word(const void* raw_data, usz size) {
    data.append(reinterpret_cast<const UChar*>(raw_data), i32(size / 2));
}

auto word::nfd(const icu::UnicodeString& s) -> icu::UnicodeString {
    /// Get singleton.
    UErrorCode ec = U_ZERO_ERROR;
    auto nfd = icu::Normalizer2::getNFDInstance(ec);
    if (U_FAILURE(ec)) die("Internal Error: Failed to get NFD instance: {}", u_errorName(ec));

    /// Normalise.
    ec = U_ZERO_ERROR;
    auto result = nfd->normalize(s, ec);
    if (U_FAILURE(ec)) die("Failed to nfd string: {}", u_errorName(ec));
    return result;
}

auto word::nfc(const icu::UnicodeString& s) -> icu::UnicodeString {
    /// Get singleton.
    UErrorCode ec = U_ZERO_ERROR;
    auto nfc = icu::Normalizer2::getNFCInstance(ec);
    if (U_FAILURE(ec)) die("Internal Error: Failed to get NFC instance: {}", u_errorName(ec));

    /// Normalise.
    ec = U_ZERO_ERROR;
    auto result = nfc->normalize(s, ec);
    if (U_FAILURE(ec)) die("Failed to nfc string: {}", u_errorName(ec));
    return result;
}

auto word::append(std::u32string_view v) -> void {
    auto s = icu::UnicodeString::fromUTF32(
        reinterpret_cast<const UChar32*>(v.data()),
        i32(v.size())
    );

    data.append(s);
}

auto word::begin() -> iterator {
    return iterator{data};
}

auto word::bytes() const -> usz {
    return usz(data.length()) * 2;
}

bool word::empty() const {
    return data.isEmpty();
}

auto word::end() const -> sentinel {
    return {};
}

bool word::ends_with(std::u32string_view str) const {
    return data.endsWith(
        icu::UnicodeString::fromUTF32(
            reinterpret_cast<const UChar32*>(str.data()),
            i32(str.size())
        )
    );
}

bool word::ends_with(const word& str) const {
    return data.endsWith(str.data);
}

auto word::first() -> c32 {
    return c32(data.char32At(0));
}

auto word::last() -> c32 {
    return c32(begin().handle().last32());
}

void word::prepend(std::u32string_view c) {
    auto s = icu::UnicodeString::fromUTF32(
        reinterpret_cast<const UChar32*>(c.data()),
        i32(c.size())
    );

    data.insert(0, s);
}

auto word::raw() const -> const char* {
    return reinterpret_cast<const char*>(data.getBuffer());
}

bool word::starts_with(std::u32string_view str) const {
    return data.startsWith(
        icu::UnicodeString::fromUTF32(
            reinterpret_cast<const UChar32*>(str.data()),
            i32(str.size())
        )
    );
}

bool word::starts_with(const word& str) const {
    return data.startsWith(str.data);
}

auto word::string() const -> std::string {
    std::string result;
    nfc(data).toUTF8String(result);
    return result;
}

auto word::operator[](usz index) -> c32 {
    auto it = begin();
    if (index >= usz(it.handle().endIndex())) die("word::operator[]: Index out of bounds");
    it.handle().setIndex(i32(index));
    return c32(it.handle().current32());
}
