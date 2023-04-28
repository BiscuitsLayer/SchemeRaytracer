#pragma once

#include <error/error.hpp>
#include <object/object.hpp>

#include <variant>
#include <istream>

namespace Tokenizer {

struct SymbolToken {
    std::string name;

    bool operator==(const SymbolToken& other) const {
        return name == other.name;
    }
};

struct QuoteToken {
    bool operator==(const QuoteToken&) const {
        return true;
    }
};

struct DotToken {
    bool operator==(const DotToken&) const {
        return true;
    }
};

enum class BracketToken { OPEN, CLOSE };

struct ConstantToken {
public:
    ConstantToken(int64_t new_value = 0, int64_t new_fractional_part = 0, int64_t new_fractional_power = 1)
        : value(new_value), fractional_part(new_fractional_part), fractional_power(new_fractional_power) {}

    int64_t GetValueWithPrecision() const;

    bool operator==(const ConstantToken& other) const {
        return (value == other.value) || (fractional_part == other.fractional_part);
    }

private:
    int64_t value;
    int64_t fractional_part = 0;
    int64_t fractional_power = 1;
};

enum class DummyToken { DUMMY };

using Token = std::variant<ConstantToken, BracketToken, SymbolToken, QuoteToken, DotToken, DummyToken>;

class Tokenizer {
public:
    Tokenizer(std::istream* in): in_{in}, cur_token_{DummyToken{}}, is_end_(false) { Next(); }

    bool IsEnd() { return is_end_; }
    void Next();
    Token GetToken() { return cur_token_; }

private:
    std::istream* in_ = nullptr;
    Token cur_token_{};
    bool is_end_ = false;
};

} // namespace Tokenizer