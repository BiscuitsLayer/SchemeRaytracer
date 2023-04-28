#pragma once

#include <iostream>
#include <memory>
#include <string>
#include <vector>
#include <cmath>

#include <scheme/scheme.hpp>
#include <error/error.hpp>
#include <external/external.hpp>
#include <helpers/helpers.hpp>

const int64_t PRECISION = 100;

template <class T>
std::shared_ptr<T> As(const std::shared_ptr<Object>& obj) {
    return std::dynamic_pointer_cast<T>(obj);
}

template <class T>
bool Is(const std::shared_ptr<Object>& obj) {
    return std::dynamic_pointer_cast<T>(obj) != nullptr;
}

// OBJECT //

class Object : public std::enable_shared_from_this<Object> {
public:
    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) = 0;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) = 0;
    virtual ~Object() = default;
};

// OTHERS //

class Number : public Object {
public:
    Number(int64_t value) : value_(value) {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;

    int64_t GetValue() const {
        return value_;
    }

private:
    int64_t value_ = 0;
};

class Symbol : public Object {
public:
    Symbol(const std::string& name) : name_(name) {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;

    const std::string& GetName() const {
        return name_;
    }

private:
    std::string name_{};
};

class Boolean : public Object {
public:
    Boolean(bool value) : value_(value) {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;

    bool GetValue() const {
        return value_;
    }

private:
    bool value_ = 0;
};

// CELL //

class Cell : public Object {
public:
    Cell(std::shared_ptr<Object> first, std::shared_ptr<Object> second)
        : first_(first), second_(second) {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;

    std::shared_ptr<Object> GetFirst() const {
        return first_;
    }
    std::shared_ptr<Object> GetSecond() const {
        return second_;
    }

    void SetFirst(std::shared_ptr<Object> first) {
        first_ = first;
    }
    void SetSecond(std::shared_ptr<Object> second) {
        second_ = second;
    }

private:
    std::shared_ptr<Object> first_{};
    std::shared_ptr<Object> second_{};
};

// GRAPHICS //

class GLInit : public Symbol {
public:
    GLInit() : Symbol("gl-init") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class GLClear : public Symbol {
public:
    GLClear() : Symbol("gl-clear") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class GLPutPixel : public Symbol {
public:
    GLPutPixel() : Symbol("gl-put-pixel") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class GLIsOpen : public Symbol {
public:
    GLIsOpen() : Symbol("gl-is-open") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class GLDraw : public Symbol {
public:
    GLDraw() : Symbol("gl-draw") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class GLFinish : public Symbol {
public:
    GLFinish() : Symbol("gl-finish") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

// FUNCTIONS //

class Print : public Symbol {
public:
    Print() : Symbol("print") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class IsBoolean : public Symbol {
public:
    IsBoolean() : Symbol("boolean?") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class IsNumber : public Symbol {
public:
    IsNumber() : Symbol("number?") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class IsSymbol : public Symbol {
public:
    IsSymbol() : Symbol("symbol?") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class IsPair : public Symbol {
public:
    IsPair() : Symbol("pair?") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class IsNull : public Symbol {
public:
    IsNull() : Symbol("null?") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class IsList : public Symbol {
public:
    IsList() : Symbol("list?") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Quote : public Symbol {
public:
    Quote() : Symbol("quote") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Not : public Symbol {
public:
    Not() : Symbol("not") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class And : public Symbol {
public:
    And() : Symbol("and") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Or : public Symbol {
public:
    Or() : Symbol("or") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Equal : public Symbol {
public:
    Equal() : Symbol("=") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Greater : public Symbol {
public:
    Greater() : Symbol(">") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class GreaterEqual : public Symbol {
public:
    GreaterEqual() : Symbol(">=") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Less : public Symbol {
public:
    Less() : Symbol("<") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class LessEqual : public Symbol {
public:
    LessEqual() : Symbol("<=") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Add : public Symbol {
public:
    Add() : Symbol("+") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Multiply : public Symbol {
public:
    Multiply() : Symbol("*") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Subtract : public Symbol {
public:
    Subtract() : Symbol("-") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Divide : public Symbol {
public:
    Divide() : Symbol("/") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Quotient : public Symbol {
public:
    Quotient() : Symbol("quotient") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Mod : public Symbol {
public:
    Mod() : Symbol("mod") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Expt : public Symbol {
public:
    Expt() : Symbol("expt") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Sqrt : public Symbol {
public:
    Sqrt() : Symbol("sqrt") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Max : public Symbol {
public:
    Max() : Symbol("max") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Min : public Symbol {
public:
    Min() : Symbol("min") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Abs : public Symbol {
public:
    Abs() : Symbol("abs") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Set : public Symbol {
public:
    Set() : Symbol("set!") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class If : public Symbol {
public:
    If() : Symbol("if") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class While : public Symbol {
public:
    While() : Symbol("while") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Cons : public Symbol {
public:
    Cons() : Symbol("cons") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Car : public Symbol {
public:
    Car() : Symbol("car") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Cdr : public Symbol {
public:
    Cdr() : Symbol("cdr") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class SetCar : public Symbol {
public:
    SetCar() : Symbol("set-car!") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class SetCdr : public Symbol {
public:
    SetCdr() : Symbol("set-cdr!") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class List : public Symbol {
public:
    List() : Symbol("list") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class ListRef : public Symbol {
public:
    ListRef() : Symbol("list-ref") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class ListTail : public Symbol {
public:
    ListTail() : Symbol("list-tail") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};

class Lambda : public Object {
public:
    Lambda(std::vector<std::shared_ptr<Object>>& commands,
           std::vector<std::string>& arguments_idx_to_name, std::shared_ptr<Scope> self_scope)
        : commands_(commands),
          arguments_idx_to_name_(arguments_idx_to_name),
          self_scope_(self_scope) {}

    Lambda(llvm::Function* function, std::shared_ptr<Scope> self_scope)
        : function_(function), self_scope_(self_scope) {}

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;

// private:
    std::vector<std::shared_ptr<Object>> commands_{};
    std::vector<std::string> arguments_idx_to_name_{};
    std::shared_ptr<Scope> self_scope_{};

    // CODEGEN
    llvm::Function* function_;
};

class Define : public Symbol {
public:
    Define() : Symbol("define") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override;
    virtual llvm::Value* Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote = false) override;
};