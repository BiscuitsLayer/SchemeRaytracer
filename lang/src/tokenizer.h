#pragma once

#include <error.h>
#include <object.h>

#include <variant>
#include <istream>

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
private:
    int64_t value;
    int64_t fractional_part = 0;
    int64_t fractional_power = 1;

public:
    ConstantToken(int64_t new_value = 0, int64_t new_fractional_part = 0, int64_t new_fractional_power = 1)
    : value(new_value), fractional_part(new_fractional_part), fractional_power(new_fractional_power) {}

    int64_t GetValueWithPrecision() const {
        if (fractional_part != 0) { 
            int64_t temp = fractional_part;
            double divisor = (1.0f * fractional_power) / (1.0f * PRECISION);
            int64_t fractional_part_result = static_cast<int64_t>(1.0f * fractional_part / divisor);
            return value * PRECISION + fractional_part_result;
        }
        return value * PRECISION;
    }

    bool operator==(const ConstantToken& other) const {
        return (value == other.value) || (fractional_part == other.fractional_part);
    }
};

enum class DummyToken { DUMMY };

using Token =
    std::variant<ConstantToken, BracketToken, SymbolToken, QuoteToken, DotToken, DummyToken>;

// Интерфейс позволяющий читать токены по одному из потока.
class Tokenizer {
public:
    Tokenizer(std::istream* in) : in_{in}, cur_token_{DummyToken{}}, is_end_(false) {
        Next();
    }

    bool IsEnd() {
        return is_end_;
    }

    // Three cool facts:
    // 1. (*in_ >> std::ws).peek() <- allows to skip whitespaces and peek next non-whitespace symbol
    // 2. in_->peek() sets eof_bit, reading the last symbol in stream doesn't do that, so
    // in_->peek() should be called before checking in_->eof()
    // 3. while (...) { ... return; } <=> if (...) { ... return; } <- acting the same way
    // but in the while-case we can use "break" to get out
    void Next() {
        if (is_end_) {
            throw SyntaxError("Expected Token, got EOF");
        }

        // End Token
        char symbol = 0;
        if (!(*in_ >> symbol)) {
            is_end_ = true;
            return;
        }
        is_end_ = false;

        // Constant Token
        while (isdigit(symbol) || (isdigit(in_->peek()) && ((symbol == '-') || (symbol == '+')))) {
            int64_t number = 0;
            int64_t sign = 0;
            if (isdigit(symbol)) {
                number += symbol - '0';
                sign = +1;
            } else if (isdigit(in_->peek())) {
                number = 0;
                if (symbol == '-') {
                    sign = -1;
                } else if (symbol == '+') {
                    sign = +1;
                }
            }
            // while (in_->peek(), !in_->eof() && isdigit(in_->peek())) {
            //     number *= 10;
            //     *in_ >> symbol;
            //     number += (symbol - '0');
            // }
            while (in_->peek(), !in_->eof() && (isdigit(in_->peek()) || in_->peek() == '.')) {
                *in_ >> symbol;
                if (isdigit(symbol)) {
                    number *= 10;
                    number += (symbol - '0');
                } else { // symbol == '.'
                    int64_t fractional_part = 0;
                    int64_t fractional_power = 1;
                    while (in_->peek(), !in_->eof() && isdigit(in_->peek())) {
                        *in_ >> symbol;
                        fractional_part *= 10;
                        fractional_power *= 10;
                        fractional_part += (symbol - '0');
                    }
                    cur_token_ = ConstantToken{sign * number, sign * fractional_part, fractional_power};
                    return;
                }
            }
            cur_token_ = ConstantToken{sign * number};
            return;
        }

        // Service Tokens
        if (!isdigit(symbol)) {
            std::string str{};
            switch (symbol) {
                case '\'': {
                    cur_token_ = QuoteToken{};
                    return;
                }
                case '.': {
                    cur_token_ = DotToken{};
                    return;
                }
                case '(': {
                    cur_token_ = BracketToken::OPEN;
                    return;
                }
                case ')': {
                    cur_token_ = BracketToken::CLOSE;
                    return;
                }
            }
            std::string service{".()' "};
            str += symbol;
            while (in_->peek(),
                   !in_->eof() && !iswspace(in_->peek()) &&
                    (std::find(service.begin(), service.end(), in_->peek()) == service.end())) {
                *in_ >> symbol;
                str += symbol;
            }
            cur_token_ = SymbolToken{str};
            return;
        }
    }

    Token GetToken() {
        return cur_token_;
    }

private:
    std::istream* in_ = nullptr;
    Token cur_token_{};
    bool is_end_ = false;
};
