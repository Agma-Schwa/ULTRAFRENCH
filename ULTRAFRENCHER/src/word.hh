#ifndef ULTRAFRENCHER_WORD_HH
#define ULTRAFRENCHER_WORD_HH

#include <optional>
#include <unicode/normalizer2.h>
#include <unicode/schriter.h>
#include <unicode/uchriter.h>
#include <unicode/unistr.h>
#include <utils.hh>

class word {
    icu::UnicodeString data;

    /// Normalise a string to NFD.
    static auto nfd(const icu::UnicodeString& s) -> icu::UnicodeString;

    /// Normalise a string to NFC.
    static auto nfc(const icu::UnicodeString& s) -> icu::UnicodeString;
public:
    class sentinel {};
    class iterator {
        icu::StringCharacterIterator iter;

    public:
        explicit iterator (icu::UnicodeString& str) : iter(str) {}
        explicit operator bool() { return iter.hasNext(); }
        auto operator*() const -> c32 { return c32(iter.current32()); }
        auto operator!=(const sentinel&) -> bool { return iter.hasNext(); }
        auto operator++() -> iterator& { iter.next32(); return *this; }

        /// Get the underlying iterator.
        auto handle() -> icu::StringCharacterIterator& { return iter; }
    };

    /// Create an empty word.
    word() = default;

    /// Create a word from a string.
    word(const icu::UnicodeString& str);

    /// Create a word from U32 data.
    word(std::u32string_view data);

    /// Create a word from U8 data.
    word(std::string_view data);

    /// Create a word from U32 data.
    template <usz sz>
    word(const c32 (&d)[sz]) : word(std::u32string_view(d, sz)) {}

    /// Create a word from raw data.
    word(const void* raw_data, usz size);

    /// Append to the end of a word.
    void append(std::u32string_view str);

    /// Get an iterator to the first character of the word.
    auto begin() -> iterator;

    /// Get the size of the word in bytes.
    ///
    /// \return How many bytes the word takes up.
    auto bytes() const -> usz;

    /// Check if this word is empty.
    bool empty() const;

    /// Get a sentinel value to compare against `begin()`.
    auto end() const -> sentinel;

    /// Check if this word ends with a string.
    bool ends_with(std::u32string_view str) const;

    /// Check if this word ends with a word.
    bool ends_with(const word& str) const;

    /// Get the first character of the word.
    auto first() -> c32;

    /// Get the last character of the word.
    auto last() -> c32;

    /// Append to the front of a word.
    void prepend(std::u32string_view str);

    /// Get the raw word data.
    ///
    /// This is valid until the word is modified. The returned pointer
    /// is owned by the word and may not be freed. The buffer pointed
    /// to by the pointer is *not* null-terminated.
    ///
    /// \return A pointer to the raw word data.
    auto raw() const -> const char*;

    /// Check if this word starts with a string.
    bool starts_with(std::u32string_view str) const;

    /// Check if this word starts with a word.
    bool starts_with(const word& str) const;

    /// Get the contents as a string.
    auto string() const -> std::string;

    /// Get the character at a given index.
    auto operator[](usz index) -> c32;
};

#endif // ULTRAFRENCHER_WORD_HH
