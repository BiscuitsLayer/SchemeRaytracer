#pragma once

#include <object/object.hpp>
#include <tokenizer/tokenizer.hpp>

namespace Parser {

class Parser {
public:
    ObjectPtr Read(Tokenizer::Tokenizer* tokenizer);
    ObjectPtr ReadList(Tokenizer::Tokenizer* tokenizer);

private:
    ObjectPtr GetSymbolQuoteConstant(Tokenizer::Tokenizer* tokenizer, Tokenizer::Token& token);
    std::string ObjectToString(ObjectPtr value);
};

} // namespace Parser