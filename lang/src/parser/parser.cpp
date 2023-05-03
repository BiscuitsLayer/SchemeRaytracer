#include "parser.hpp"

#include <error/error.hpp>
#include <object/object.hpp>
#include <tokenizer/tokenizer.hpp>

#include <stdexcept>
#include <iostream>

namespace Parser {

ObjectPtr Parser::Read(Tokenizer::Tokenizer* tokenizer) {
    ObjectPtr first = nullptr;
    ObjectPtr second = nullptr;

    ObjectPtr previous = nullptr;
    ObjectPtr current = std::make_shared<Cell>(nullptr, nullptr);
    ObjectPtr ans = current;
    ObjectPtr next = nullptr;

    Tokenizer::Token token{};

    while (!tokenizer->IsEnd()) {
        token = tokenizer->GetToken();
        tokenizer->Next();

        if (Tokenizer::BracketToken* open_bracket = std::get_if<Tokenizer::BracketToken>(&token);
            open_bracket && *open_bracket == Tokenizer::BracketToken::OPEN) {
            first = ReadList(tokenizer);
        } else {
            first = GetSymbolQuoteConstant(tokenizer, token);
        }

        As<Cell>(current)->SetFirst(first);
        next = std::make_shared<Cell>(nullptr, nullptr);
        As<Cell>(current)->SetSecond(next);

        previous = current;
        current = next;
    }
    As<Cell>(previous)->SetSecond(nullptr);

    // If ans consists of a single cell, set ans = ans->first
    if (!As<Cell>(ans)->GetSecond()) {
        ans = As<Cell>(ans)->GetFirst();
    }
    return ans;
}

ObjectPtr Parser::ReadList(Tokenizer::Tokenizer* tokenizer) {
    ObjectPtr first = nullptr;
    ObjectPtr second = nullptr;

    ObjectPtr previous = nullptr;
    ObjectPtr current = std::make_shared<Cell>(nullptr, nullptr);
    ObjectPtr ans = current;
    ObjectPtr next = nullptr;

    Tokenizer::Token token{};
    if (tokenizer->IsEnd()) {
        throw SyntaxError("No tokens after Tokenizer::BracketToken::OPEN");
    }
    while (!tokenizer->IsEnd()) {
        token = tokenizer->GetToken();
        tokenizer->Next();

        if (Tokenizer::BracketToken* open_bracket = std::get_if<Tokenizer::BracketToken>(&token);
            open_bracket && *open_bracket == Tokenizer::BracketToken::OPEN) {
            first = ReadList(tokenizer);
        } else if (Tokenizer::BracketToken* close_bracket = std::get_if<Tokenizer::BracketToken>(&token);
                   close_bracket && *close_bracket == Tokenizer::BracketToken::CLOSE) {
            if (current == ans) {
                // Empty list <=> nullptr
                return nullptr;
            }
            break;
        } else if (Tokenizer::DotToken* dot_token = std::get_if<Tokenizer::DotToken>(&token); dot_token) {
            if (current == ans) {
                throw SyntaxError("Tokenizer::DotToken after Tokenizer::BracketToken::OPEN");
            }
            break;
        } else {
            first = GetSymbolQuoteConstant(tokenizer, token);
        }

        As<Cell>(current)->SetFirst(first);
        next = std::make_shared<Cell>(nullptr, nullptr);
        As<Cell>(current)->SetSecond(next);

        previous = current;
        current = next;
    }
    As<Cell>(previous)->SetSecond(nullptr);

    // Handle Tokenizer::DotToken
    if (Tokenizer::DotToken* dot_token = std::get_if<Tokenizer::DotToken>(&token); dot_token) {
        if (tokenizer->IsEnd()) {
            throw SyntaxError("No token after Tokenizer::DotToken");
        }
        token = tokenizer->GetToken();
        tokenizer->Next();

        if (Tokenizer::BracketToken* open_bracket = std::get_if<Tokenizer::BracketToken>(&token);
            open_bracket && *open_bracket == Tokenizer::BracketToken::OPEN) {
            second = ReadList(tokenizer);
        } else if (Tokenizer::ConstantToken* constant_token = std::get_if<Tokenizer::ConstantToken>(&token);
                   constant_token) {
            second = std::make_shared<Number>(constant_token->GetValueWithPrecision());
        } else {
            throw SyntaxError("Invalid token after Tokenizer::DotToken");
        }
        As<Cell>(previous)->SetSecond(second);

        token = tokenizer->GetToken();
        tokenizer->Next();
    }

    if (Tokenizer::BracketToken* close_bracket = std::get_if<Tokenizer::BracketToken>(&token);
        close_bracket && *close_bracket == Tokenizer::BracketToken::CLOSE) {
        return ans;
    } else {
        throw SyntaxError("Close bracket error");
    }
}

ObjectPtr Parser::GetSymbolQuoteConstant(Tokenizer::Tokenizer* tokenizer, Tokenizer::Token& token) {
    ObjectPtr first = nullptr;

    if (Tokenizer::SymbolToken* symbol_token = std::get_if<Tokenizer::SymbolToken>(&token); symbol_token) {
        if (symbol_token->name == "#t") {
            first = std::make_shared<Boolean>(true);
        } else if (symbol_token->name == "#f") {
            first = std::make_shared<Boolean>(false);
        } else {
            first = std::make_shared<Symbol>(symbol_token->name);
        }
    } else if (Tokenizer::QuoteToken* quote_token = std::get_if<Tokenizer::QuoteToken>(&token); quote_token) {
        ObjectPtr quote_cell = std::make_shared<Cell>(nullptr, nullptr);
        As<Cell>(quote_cell)->SetFirst(std::make_shared<Quote>());
        token = tokenizer->GetToken();
        if (Tokenizer::BracketToken* open_bracket = std::get_if<Tokenizer::BracketToken>(&token);
            open_bracket && *open_bracket == Tokenizer::BracketToken::OPEN) {
            tokenizer->Next();
            ObjectPtr argument = std::make_shared<Cell>(nullptr, nullptr);
            As<Cell>(argument)->SetFirst(ReadList(tokenizer));
            As<Cell>(quote_cell)->SetSecond(argument);
            first = quote_cell;
        } else if (Tokenizer::SymbolToken* symbol_token = std::get_if<Tokenizer::SymbolToken>(&token); symbol_token) {
            ObjectPtr argument = std::make_shared<Cell>(nullptr, nullptr);
            ObjectPtr symbol = std::make_shared<Symbol>(symbol_token->name);
            tokenizer->Next();
            As<Cell>(argument)->SetFirst(symbol);
            As<Cell>(quote_cell)->SetSecond(argument);
            first = quote_cell;
        } else {
            throw SyntaxError(
                "Invalid token after quote: expected Tokenizer::BracketToken::OPEN or Tokenizer::SymbolToken");
        }
    } else if (Tokenizer::ConstantToken* constant_token = std::get_if<Tokenizer::ConstantToken>(&token); constant_token) {
        first = std::make_shared<Number>(constant_token->GetValueWithPrecision());
    } else {
        throw SyntaxError("Invalid token");
    }

    return first;
}

} // namespace Parser