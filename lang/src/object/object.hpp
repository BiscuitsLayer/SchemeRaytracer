#pragma once
#include "object_fwd.hpp"

#include <iostream>
#include <memory>
#include <string>
#include <vector>
#include <cmath>

#include <scheme/scheme.hpp>
#include <error/error.hpp>
#include <external/external.hpp>
#include <helpers/helpers.hpp>

#include <scope/scope_fwd.hpp>
#include <lambda/lambda_fwd.hpp>

template <class T>
std::shared_ptr<T> As(const ObjectPtr& obj) {
    return std::dynamic_pointer_cast<T>(obj);
}

template <class T>
bool Is(const ObjectPtr& obj) {
    return std::dynamic_pointer_cast<T>(obj) != nullptr;
}

// OBJECT //

class Object : public std::enable_shared_from_this<Object> {
public:
    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) = 0;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) = 0;
    virtual ~Object() = default;
};

// OTHERS //

class Number : public Object {
public:
    Number(int64_t value) : value_(value) {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;

    int64_t GetValue() const {
        return value_;
    }

private:
    int64_t value_ = 0;
};

class Function : public Object {
public:
    Function(const std::string& name) : name_(name) {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override {
        throw RuntimeError("Tried to run Evaluate method with Function!");
    }
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override {
        throw RuntimeError("Tried to run Codegen method with Function!");
    }

    const std::string& GetName() const {
        return name_;
    }

private:
    std::string name_{};
};

class Symbol : public Object {
public:
    Symbol(const std::string& name) : name_(name) {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;

    ObjectPtr GetVariableInterp(ScopePtr scope);
    llvm::Value* GetVariableCodegen(ScopePtr scope);
    ObjectPtr GetFunctionInterp(ScopePtr scope);

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

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;

    bool GetValue() const {
        return value_;
    }

private:
    bool value_ = 0;
};

class Cell : public Object {
public:
    Cell(ObjectPtr first, ObjectPtr second)
        : first_(first), second_(second) {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;

    ObjectPtr GetFirst() const {
        return first_;
    }
    ObjectPtr GetSecond() const {
        return second_;
    }

    void SetFirst(ObjectPtr first) {
        first_ = first;
    }
    void SetSecond(ObjectPtr second) {
        second_ = second;
    }

private:
    ObjectPtr first_{};
    ObjectPtr second_{};
};

// GRAPHICS //

class GLInit : public Function {
public:
    GLInit() : Function("gl-init") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class GLClear : public Function {
public:
    GLClear() : Function("gl-clear") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class GLPutPixel : public Function {
public:
    GLPutPixel() : Function("gl-put-pixel") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class GLIsOpen : public Function {
public:
    GLIsOpen() : Function("gl-is-open") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class GLDraw : public Function {
public:
    GLDraw() : Function("gl-draw") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class GLFinish : public Function {
public:
    GLFinish() : Function("gl-finish") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

// FUNCTIONS //

class Print : public Function {
public:
    Print() : Function("print") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class IsBoolean : public Function {
public:
    IsBoolean() : Function("boolean?") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class IsNumber : public Function {
public:
    IsNumber() : Function("number?") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class IsSymbol : public Function {
public:
    IsSymbol() : Function("symbol?") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class IsPair : public Function {
public:
    IsPair() : Function("pair?") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class IsNull : public Function {
public:
    IsNull() : Function("null?") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class IsList : public Function {
public:
    IsList() : Function("list?") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Quote : public Function {
public:
    Quote() : Function("quote") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Not : public Function {
public:
    Not() : Function("not") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class And : public Function {
public:
    And() : Function("and") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Or : public Function {
public:
    Or() : Function("or") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Equal : public Function {
public:
    Equal() : Function("=") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Greater : public Function {
public:
    Greater() : Function(">") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class GreaterEqual : public Function {
public:
    GreaterEqual() : Function(">=") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Less : public Function {
public:
    Less() : Function("<") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class LessEqual : public Function {
public:
    LessEqual() : Function("<=") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Add : public Function {
public:
    Add() : Function("+") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Multiply : public Function {
public:
    Multiply() : Function("*") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Subtract : public Function {
public:
    Subtract() : Function("-") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Divide : public Function {
public:
    Divide() : Function("/") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Quotient : public Function {
public:
    Quotient() : Function("quotient") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Mod : public Function {
public:
    Mod() : Function("mod") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Expt : public Function {
public:
    Expt() : Function("expt") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Sqrt : public Function {
public:
    Sqrt() : Function("sqrt") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Max : public Function {
public:
    Max() : Function("max") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Min : public Function {
public:
    Min() : Function("min") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Abs : public Function {
public:
    Abs() : Function("abs") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Set : public Function {
public:
    Set() : Function("set!") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class If : public Function {
public:
    If() : Function("if") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class While : public Function {
public:
    While() : Function("while") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Cons : public Function {
public:
    Cons() : Function("cons") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Car : public Function {
public:
    Car() : Function("car") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class Cdr : public Function {
public:
    Cdr() : Function("cdr") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class SetCar : public Function {
public:
    SetCar() : Function("set-car!") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class SetCdr : public Function {
public:
    SetCdr() : Function("set-cdr!") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class List : public Function {
public:
    List() : Function("list") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class ListRef : public Function {
public:
    ListRef() : Function("list-ref") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class ListTail : public Function {
public:
    ListTail() : Function("list-tail") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};

class LambdaInterp : public Object {
public:
    LambdaInterp(std::vector<ObjectPtr>& commands, std::vector<std::string>& arguments_idx_to_name, ScopePtr lambda_self_scope)
        : commands_(commands), arguments_idx_to_name_(arguments_idx_to_name), lambda_self_scope_(lambda_self_scope) {}

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override {
        throw RuntimeError("Tried to run Codegen method with LambdaInterp!");
    }

private:
    std::vector<ObjectPtr> commands_{};
    std::vector<std::string> arguments_idx_to_name_{};
    ScopePtr lambda_self_scope_{};
};

class LambdaCodegen : public Object {
public:
    LambdaCodegen(llvm::Function* function)
        : function_(function) {}

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override {
        throw RuntimeError("Tried to run Evaluate method with LambdaCodegen!");
    }
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;

private:
    llvm::Function* function_;
};

class Define : public Function {
public:
    Define() : Function("define") {
    }

    virtual ObjectPtr Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
    virtual llvm::Value* Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote = false) override;
};