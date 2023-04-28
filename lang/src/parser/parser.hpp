#pragma once

#include <object/object.hpp>
#include <tokenizer/tokenizer.hpp>

namespace Parser {

class Parser {
public:
    std::shared_ptr<Object> Read(Tokenizer::Tokenizer* tokenizer);
    std::shared_ptr<Object> ReadList(Tokenizer::Tokenizer* tokenizer);

private:
    std::shared_ptr<Object> GetSymbolQuoteConstant(Tokenizer::Tokenizer* tokenizer, Tokenizer::Token& token);
    std::string ObjectToString(std::shared_ptr<Object> value);
};

} // namespace Parser