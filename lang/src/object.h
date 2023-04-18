#pragma once

#include <iostream>
#include <memory>
#include <string>
#include <vector>
#include <cmath>

#include <scheme.h>
#include <error.h>
#include <graphics/graphics.h>

const int64_t PRECISION = 100;

// Forward declaration
class Object;
class Cell;
class Quote;

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
    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) = 0;
    virtual llvm::Value* Codegen(std::shared_ptr<llvm::Module> module, llvm::IRBuilder<>& builder, llvm::StructType* object_type, const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) {
        throw std::runtime_error("Unimplemented codegen");
    }
    virtual ~Object() = default;
};

// OTHERS //

class Number : public Object {
public:
    Number(int64_t value) : value_(value) {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>&,
                                             std::shared_ptr<Scope>) override {

        return shared_from_this();
    }

    virtual llvm::Value* Codegen(std::shared_ptr<llvm::Module> module, llvm::IRBuilder<>& builder, llvm::StructType* object_type, const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override {
        llvm::AllocaInst* object_value = builder.CreateAlloca(object_type, nullptr, "number");

        std::vector<llvm::Value*> object_value_type_field_indices {
            builder.getInt32(0), // because there is no array, so just the object itself
            builder.getInt32(0) // zeroth field - type
        };
        llvm::Value* object_value_type_field = builder.CreateGEP(object_type, object_value, object_value_type_field_indices);
        // store 0 <- its a number
        builder.CreateStore(builder.getInt32(0), object_value_type_field);

        std::vector<llvm::Value*> object_value_number_field_indices {
            builder.getInt32(0), // because there is no array, so just the object itself
            builder.getInt32(1) // first field - number
        };
        llvm::Value* object_value_number_field = builder.CreateGEP(object_type, object_value, object_value_number_field_indices);
        // store number value
        builder.CreateStore(builder.getInt64(value_), object_value_number_field);

        return object_value;
    }

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

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>&,
                                             std::shared_ptr<Scope> scope) override {
        std::shared_ptr<Object> value = scope->GetVariableValueRecursive(name_);
        return value;
    }

    virtual llvm::Value* Codegen(std::shared_ptr<llvm::Module> module, llvm::IRBuilder<>& builder, llvm::StructType* object_type, const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override {
        llvm::AllocaInst* object_value = builder.CreateAlloca(object_type, nullptr, "symbol");

        std::vector<llvm::Value*> object_value_type_field_indices {
            builder.getInt32(0), // because there is no array, so just the object itself
            builder.getInt32(0) // zeroth field - type
        };
        llvm::Value* object_value_type_field = builder.CreateGEP(object_type, object_value, object_value_type_field_indices);
        // store 2 <- its a symbol
        builder.CreateStore(builder.getInt32(2), object_value_type_field);

        std::vector<llvm::Value*> object_value_symbol_field_indices {
            builder.getInt32(0), // because there is no array, so just the object itself
            builder.getInt32(3) // third field - symbol
        };
        llvm::Value* object_value_symbol_field = builder.CreateGEP(object_type, object_value, object_value_symbol_field_indices);
        // store symbol value
        llvm::Value* symbol_global = builder.CreateGlobalString(name_, "symbol_global");
        builder.CreateStore(symbol_global, object_value_symbol_field);

        return object_value;
    }

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

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>&,
                                             std::shared_ptr<Scope>) override {
        return shared_from_this();
    }

    virtual llvm::Value* Codegen(std::shared_ptr<llvm::Module> module, llvm::IRBuilder<>& builder, llvm::StructType* object_type, const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override {
        llvm::AllocaInst* object_value = builder.CreateAlloca(object_type, nullptr, "boolean");

        std::vector<llvm::Value*> object_value_type_field_indices {
            builder.getInt32(0), // because there is no array, so just the object itself
            builder.getInt32(0) // zeroth field - type
        };
        llvm::Value* object_value_type_field = builder.CreateGEP(object_type, object_value, object_value_type_field_indices);
        // store 1 <- its a boolean
        builder.CreateStore(builder.getInt32(1), object_value_type_field);

        std::vector<llvm::Value*> object_value_boolean_field_indices {
            builder.getInt32(0), // because there is no array, so just the object itself
            builder.getInt32(2) // second field - boolean
        };
        llvm::Value* object_value_boolean_field = builder.CreateGEP(object_type, object_value, object_value_boolean_field_indices);
        // store boolean value
        builder.CreateStore(builder.getInt1(value_), object_value_boolean_field);

        return object_value;
    }

    bool GetValue() const {
        return value_;
    }

private:
    bool value_ = 0;
};

// CELL //

std::vector<std::shared_ptr<Object>> ListToVector(std::shared_ptr<Object> init);
std::string ListToString(std::shared_ptr<Object> init);
std::shared_ptr<Object> BuildLambda(std::shared_ptr<Object> init, std::shared_ptr<Scope> scope, bool eval_immediately = false);
std::pair<std::string, std::shared_ptr<Object>> BuildLambdaSugar(
    std::vector<std::shared_ptr<Object>> parts, std::shared_ptr<Scope> scope);

class Cell : public Object {
public:
    Cell(std::shared_ptr<Object> first, std::shared_ptr<Object> second)
        : first_(first), second_(second) {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>&,
                                             std::shared_ptr<Scope> scope) override {
        if (!GetFirst()) {  // Empty list case
            return shared_from_this();
        }

        std::shared_ptr<Object> function = GetFirst();
        std::shared_ptr<Object> maybe_lambda_keyword = function;
        if (Is<Symbol>(maybe_lambda_keyword) &&
            (As<Symbol>(maybe_lambda_keyword)->GetName() == "lambda")) {
            return BuildLambda(GetSecond(), scope);
        } else if (Is<Symbol>(maybe_lambda_keyword) &&
            (As<Symbol>(maybe_lambda_keyword)->GetName() == "begin")) {
            auto lambda_to_eval_immediately = BuildLambda(GetSecond(), scope, true);
            return lambda_to_eval_immediately->Evaluate({}, scope);
        } else if (!Is<Quote>(function)) {
            if (Is<Symbol>(function) || Is<Cell>(function)) {
                function = function->Evaluate({}, scope);  // Get function object from scope variables
            } else {
                throw RuntimeError("Lists are not self evaliating, use \"quote\"");
            }
        }

        std::shared_ptr<Object> arguments_start = GetSecond();

        std::vector<std::shared_ptr<Object>> function_arguments = ListToVector(arguments_start);
        return function->Evaluate(function_arguments, scope);
    }

    virtual llvm::Value* Codegen(std::shared_ptr<llvm::Module> module, llvm::IRBuilder<>& builder, llvm::StructType* object_type, const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override {
        std::shared_ptr<Object> function = GetFirst();

        if (!Is<Quote>(function)) {
            if (Is<Symbol>(function) || Is<Cell>(function)) {
                function = function->Evaluate({}, scope);  // Get function object from scope variables
            } else {
                throw RuntimeError("Lists are not self evaliating, use \"quote\"");
            }
        }

        std::shared_ptr<Object> arguments_start = GetSecond();

        std::vector<std::shared_ptr<Object>> function_arguments = ListToVector(arguments_start);
        return function->Codegen(module, builder, object_type, function_arguments, scope);
    }

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

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope>) override {
        if (arguments.size() != 0) {
            throw SyntaxError("No arguments required for \"GLInit\" function");
        }
        __GLInit();
        return nullptr;
    }
};

class GLClear : public Symbol {
public:
    GLClear() : Symbol("gl-clear") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope>) override {
        if (arguments.size() != 0) {
            throw SyntaxError("No arguments required for \"GLClear\" function");
        }
        __GLClear();
        return nullptr;
    }
};

class GLPutPixel : public Symbol {
public:
    GLPutPixel() : Symbol("gl-put-pixel") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 5) {
            throw SyntaxError("Exactly 5 arguments required for \"GLPutPixel\" function");
        }

        std::shared_ptr<Object> x_object = arguments[0]->Evaluate({}, scope);
        if (!Is<Number>(x_object)) {
            throw RuntimeError("GLPutPixel: not a number given for x coordinate");
        }
        int64_t unhandled_x_value = As<Number>(x_object)->GetValue();
        if (unhandled_x_value % PRECISION != 0) {
            throw RuntimeError("GLPutPixel: not an integer given for x coordinate");
        }
        int64_t x_coord = unhandled_x_value / PRECISION;

        std::shared_ptr<Object> y_object = arguments[1]->Evaluate({}, scope);
        if (!Is<Number>(y_object)) {
            throw RuntimeError("GLPutPixel: not a number given for y coordinate");
        }
        int64_t unhandled_y_value = As<Number>(y_object)->GetValue();
        if (unhandled_y_value % PRECISION != 0) {
            throw RuntimeError("GLPutPixel: not an integer given for y coordinate");
        }
        int64_t y_coord = unhandled_y_value / PRECISION;

        std::shared_ptr<Object> r_object = arguments[2]->Evaluate({}, scope);
        if (!Is<Number>(r_object)) {
            throw RuntimeError("GLPutPixel: not a number given for red color commponent");
        }
        int unhandled_r_value = As<Number>(r_object)->GetValue();
        int r_component = 255 * unhandled_r_value / PRECISION;

        std::shared_ptr<Object> g_object = arguments[3]->Evaluate({}, scope);
        if (!Is<Number>(g_object)) {
            throw RuntimeError("GLPutPixel: not a number given for green color commponent");
        }
        int unhandled_g_value = As<Number>(g_object)->GetValue();
        int g_component = 255 * unhandled_g_value / PRECISION;

        std::shared_ptr<Object> b_object = arguments[4]->Evaluate({}, scope);
        if (!Is<Number>(b_object)) {
            throw RuntimeError("GLPutPixel: not a number given for blue color commponent");
        }
        int unhandled_b_value = As<Number>(b_object)->GetValue();
        int b_component = 255 * unhandled_b_value / PRECISION;

        __GLPutPixel(x_coord, y_coord, r_component, g_component, b_component);
        return nullptr;
    }
};

class GLIsOpen : public Symbol {
public:
    GLIsOpen() : Symbol("gl-is-open") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope>) override {
        if (arguments.size() != 0) {
            throw SyntaxError("No arguments required for \"GLIsOpen\" function");
        }
        return __GLIsOpen() ? std::make_shared<Boolean>(true)
                                  : std::make_shared<Boolean>(false);
    }
};

class GLDraw : public Symbol {
public:
    GLDraw() : Symbol("gl-draw") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope>) override {
        if (arguments.size() != 0) {
            throw SyntaxError("No arguments required for \"GLDraw\" function");
        }
        __GLDraw();
        return nullptr;
    }
};

class GLFinish : public Symbol {
public:
    GLFinish() : Symbol("gl-finish") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope>) override {
        if (arguments.size() != 0) {
            throw SyntaxError("No arguments required for \"GLFinish\" function");
        }
        __GLFinish();
        return nullptr;
    }
};

// FUNCTIONS //

std::string ObjectToString(std::shared_ptr<Object> value);

class Print : public Symbol {
public:
    Print() : Symbol("print") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 1) {
            throw SyntaxError("Exactly 1 argument required for \"Print\" function");
        }
        std::shared_ptr<Object> object = arguments[0]->Evaluate({}, scope);
        std::cout << "Print: " << ObjectToString(object) << std::endl;
        return object;
    }

    virtual llvm::Value* Codegen(std::shared_ptr<llvm::Module> module, llvm::IRBuilder<>& builder, llvm::StructType* object_type, const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 1) {
            throw SyntaxError("Exactly 1 argument required for \"Print\" function");
        }
        
        // CODEGEN FUNCTION CALL
        std::vector<llvm::Value*> print_function_call_arguments;
        print_function_call_arguments.push_back(arguments[0]->Codegen(module, builder, object_type, {}, scope));

        llvm::Function* PrintFunction = module->getFunction("__GLPrint");
        builder.CreateCall(PrintFunction, print_function_call_arguments);
    }
};

class IsBoolean : public Symbol {
public:
    IsBoolean() : Symbol("boolean?") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 1) {
            throw SyntaxError("Exactly 1 argument required for \"IsBoolean\" function");
        }
        std::shared_ptr<Object> value = arguments[0]->Evaluate({}, scope);
        return Is<Boolean>(value) ? std::make_shared<Boolean>(true)
                                  : std::make_shared<Boolean>(false);
    }
};

class IsNumber : public Symbol {
public:
    IsNumber() : Symbol("number?") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 1) {
            throw SyntaxError("Exactly 1 argument required for \"IsNumber\" function");
        }
        std::shared_ptr<Object> value = arguments[0]->Evaluate({}, scope);
        return Is<Number>(value) ? std::make_shared<Boolean>(true)
                                 : std::make_shared<Boolean>(false);
    }
};

class IsSymbol : public Symbol {
public:
    IsSymbol() : Symbol("symbol?") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 1) {
            throw SyntaxError("Exactly 1 argument required for \"IsSymbol\" function");
        }
        std::shared_ptr<Object> value = arguments[0]->Evaluate({}, scope);
        return Is<Symbol>(value) ? std::make_shared<Boolean>(true)
                                 : std::make_shared<Boolean>(false);
    }
};

class IsPair : public Symbol {
public:
    IsPair() : Symbol("pair?") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 1) {
            throw SyntaxError("Exactly 1 argument required for \"IsPair\" function");
        }
        std::shared_ptr<Object> value = arguments[0]->Evaluate({}, scope);

        std::shared_ptr<Boolean> ans = std::make_shared<Boolean>(true);
        if (!Is<Cell>(value)) {
            return std::make_shared<Boolean>(false);
        } else {
            std::shared_ptr<Cell> cell = As<Cell>(value);
            if (!cell->GetFirst()) {
                return std::make_shared<Boolean>(false);
            } else {
                if (!Is<Cell>(cell->GetSecond())) {
                    return std::make_shared<Boolean>(true);
                }
                cell = As<Cell>(cell->GetSecond());
                if (cell->GetSecond()) {
                    return std::make_shared<Boolean>(false);
                }
                return cell->GetFirst() ? std::make_shared<Boolean>(true)
                                        : std::make_shared<Boolean>(false);
            }
        }
    }
};

class IsNull : public Symbol {
public:
    IsNull() : Symbol("null?") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 1) {
            throw SyntaxError("Exactly 1 argument required for \"IsNull\" function");
        }
        std::shared_ptr<Object> value = arguments[0]->Evaluate({}, scope);

        if (!value) {
            return std::make_shared<Boolean>(true);
        }

        if (!Is<Cell>(value)) {
            return std::make_shared<Boolean>(false);
        }
        std::shared_ptr<Cell> cell = As<Cell>(value);
        if (!cell->GetFirst() && !cell->GetSecond()) {
            return std::make_shared<Boolean>(true);
        }
        return std::make_shared<Boolean>(false);
    }
};

class IsList : public Symbol {
public:
    IsList() : Symbol("list?") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 1) {
            throw SyntaxError("Exactly 1 argument required for \"IsList\" function");
        }
        std::shared_ptr<Object> value = arguments[0]->Evaluate({}, scope);

        if (!Is<Cell>(value)) {
            return std::make_shared<Boolean>(false);
        }
        for (std::shared_ptr<Cell> cell = As<Cell>(value); cell;
             cell = As<Cell>(cell->GetSecond())) {
            if (cell->GetSecond() && !Is<Cell>(cell->GetSecond())) {
                return std::make_shared<Boolean>(false);
            }
        }
        return std::make_shared<Boolean>(true);
    }
};

class Quote : public Symbol {
public:
    Quote() : Symbol("quote") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope>) override {
        if (arguments.empty()) {
            return std::make_shared<Cell>(nullptr, nullptr);
        }
        if (arguments.size() > 1) {
            throw SyntaxError("Exactly 1 argument (list) required for \"Quote\" function");
        }
        return arguments[0];
    }

    virtual llvm::Value* Codegen(std::shared_ptr<llvm::Module> module, llvm::IRBuilder<>& builder, llvm::StructType* object_type, const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope) override {
        if (arguments.empty()) {
            return nullptr;
        }
        if (arguments.size() > 1) {
            throw SyntaxError("Exactly 1 argument (list) required for \"Quote\" function");
        }
        return arguments[0]->Codegen(module, builder, object_type, {}, scope);
    }
};

class Not : public Symbol {
public:
    Not() : Symbol("not") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 1) {
            throw RuntimeError("Exactly 1 argument required for \"Not\" function");
        }
        std::shared_ptr<Object> value = arguments[0]->Evaluate({}, scope);

        if (Is<Boolean>(value)) {
            return As<Boolean>(value)->GetValue() ? std::make_shared<Boolean>(false)
                                                  : std::make_shared<Boolean>(true);
        }
        return std::make_shared<Boolean>(false);
    }
};

class And : public Symbol {
public:
    And() : Symbol("and") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        std::shared_ptr<Object> ans = std::make_shared<Boolean>(true);
        std::shared_ptr<Object> value = nullptr;
        for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
            value = arguments[argument_idx]->Evaluate({}, scope);
            if (Is<Boolean>(value)) {
                if (!As<Boolean>(value)->GetValue()) {
                    ans = std::make_shared<Boolean>(false);
                    return ans;
                }
            } else {
                ans = value;
            }
        }
        return ans;
    }
};

class Or : public Symbol {
public:
    Or() : Symbol("or") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        std::shared_ptr<Object> ans = std::make_shared<Boolean>(false);
        std::shared_ptr<Object> value = nullptr;
        for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
            value = arguments[argument_idx]->Evaluate({}, scope);
            if (Is<Boolean>(value)) {
                if (As<Boolean>(value)->GetValue()) {
                    ans = std::make_shared<Boolean>(true);
                    return ans;
                }
            } else {
                ans = value;
            }
        }
        return ans;
    }
};

class Equal : public Symbol {
public:
    Equal() : Symbol("=") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        std::shared_ptr<Object> ans = std::make_shared<Boolean>(true);

        std::shared_ptr<Object> last_value = nullptr;
        std::shared_ptr<Object> value = nullptr;

        for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
            last_value = value;
            value = arguments[argument_idx]->Evaluate({}, scope);
            if (!Is<Number>(value)) {
                throw RuntimeError("\"Equal\" error: not a number given");
            }
            if (argument_idx != 0) {
                if (As<Number>(last_value)->GetValue() != As<Number>(value)->GetValue()) {
                    ans = std::make_shared<Boolean>(false);
                }
            }
        }
        return ans;
    }
};

class Greater : public Symbol {
public:
    Greater() : Symbol(">") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        std::shared_ptr<Object> ans = std::make_shared<Boolean>(true);

        std::shared_ptr<Object> last_value = nullptr;
        std::shared_ptr<Object> value = nullptr;

        for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
            last_value = value;
            value = arguments[argument_idx]->Evaluate({}, scope);
            if (!Is<Number>(value)) {
                throw RuntimeError("\"Greater\" error: not a number given");
            }
            if (argument_idx != 0) {
                if (As<Number>(last_value)->GetValue() <= As<Number>(value)->GetValue()) {
                    ans = std::make_shared<Boolean>(false);
                }
            }
        }
        return ans;
    }
};

class GreaterEqual : public Symbol {
public:
    GreaterEqual() : Symbol(">=") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        std::shared_ptr<Object> ans = std::make_shared<Boolean>(true);

        std::shared_ptr<Object> last_value = nullptr;
        std::shared_ptr<Object> value = nullptr;

        for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
            last_value = value;
            value = arguments[argument_idx]->Evaluate({}, scope);
            if (!Is<Number>(value)) {
                throw RuntimeError("\"GreaterEqual\" error: not a number given");
            }
            if (argument_idx != 0) {
                if (As<Number>(last_value)->GetValue() < As<Number>(value)->GetValue()) {
                    ans = std::make_shared<Boolean>(false);
                }
            }
        }
        return ans;
    }
};

class Less : public Symbol {
public:
    Less() : Symbol("<") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        std::shared_ptr<Object> ans = std::make_shared<Boolean>(true);

        std::shared_ptr<Object> last_value = nullptr;
        std::shared_ptr<Object> value = nullptr;

        for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
            last_value = value;
            value = arguments[argument_idx]->Evaluate({}, scope);
            if (!Is<Number>(value)) {
                throw RuntimeError("\"Less\" error: not a number given");
            }
            if (argument_idx != 0) {
                if (As<Number>(last_value)->GetValue() >= As<Number>(value)->GetValue()) {
                    ans = std::make_shared<Boolean>(false);
                }
            }
        }
        return ans;
    }
};

class LessEqual : public Symbol {
public:
    LessEqual() : Symbol("<=") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        std::shared_ptr<Object> ans = std::make_shared<Boolean>(true);

        std::shared_ptr<Object> last_value = nullptr;
        std::shared_ptr<Object> value = nullptr;

        for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
            last_value = value;
            value = arguments[argument_idx]->Evaluate({}, scope);
            if (!Is<Number>(value)) {
                throw RuntimeError("\"LessEqual\" error: not a number given");
            }
            if (argument_idx != 0) {
                if (As<Number>(last_value)->GetValue() > As<Number>(value)->GetValue()) {
                    ans = std::make_shared<Boolean>(false);
                }
            }
        }
        return ans;
    }
};

class Add : public Symbol {
public:
    Add() : Symbol("+") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        std::shared_ptr<Object> ans = std::make_shared<Number>(0 * PRECISION);
        std::shared_ptr<Object> value = nullptr;

        for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
            value = arguments[argument_idx]->Evaluate({}, scope);
            if (!Is<Number>(value)) {
                throw RuntimeError("\"Add\" error: not a number given");
            } else {
                int64_t old_number = As<Number>(ans)->GetValue();
                int64_t update_number = As<Number>(value)->GetValue();

                ans = std::make_shared<Number>(old_number + update_number);
            }
        }
        return ans;
    }
};

class Multiply : public Symbol {
public:
    Multiply() : Symbol("*") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        std::shared_ptr<Object> ans = std::make_shared<Number>(1 * PRECISION);
        std::shared_ptr<Object> value = nullptr;

        for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
            value = arguments[argument_idx]->Evaluate({}, scope);
            if (!Is<Number>(value)) {
                throw RuntimeError("\"Multiply\" error: not a number given");
            } else {
                int64_t old_number = As<Number>(ans)->GetValue();
                int64_t update_number = As<Number>(value)->GetValue();
                
                ans = std::make_shared<Number>((old_number * update_number) / PRECISION);
            }
        }
        return ans;
    }
};

class Subtract : public Symbol {
public:
    Subtract() : Symbol("-") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() <= 1) {
            throw RuntimeError("More than 1 argument required for \"Subtract\" function");
        }
        std::shared_ptr<Object> ans = std::make_shared<Number>(0 * PRECISION);
        std::shared_ptr<Object> value = nullptr;

        for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
            value = arguments[argument_idx]->Evaluate({}, scope);
            if (!Is<Number>(value)) {
                throw RuntimeError("\"Subtract\" error: not a number given");
            } else {
                if (argument_idx == 0) {
                    int64_t update_number = As<Number>(value)->GetValue();

                    ans = std::make_shared<Number>(update_number);
                } else {
                    int64_t old_number = As<Number>(ans)->GetValue();
                    int64_t update_number = As<Number>(value)->GetValue();

                    ans = std::make_shared<Number>(old_number - update_number);
                }
            }
        }
        return ans;
    }
};

class Divide : public Symbol {
public:
    Divide() : Symbol("/") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() <= 1) {
            throw RuntimeError("More than 1 argument required for \"Divide\" function");
        }
        std::shared_ptr<Object> ans = std::make_shared<Number>(1 * PRECISION);
        std::shared_ptr<Object> value = nullptr;

        for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
            value = arguments[argument_idx]->Evaluate({}, scope);
            if (!Is<Number>(value)) {
                throw RuntimeError("\"Divide\" error: not a number given");
            } else {
                if (argument_idx == 0) {
                    int64_t update_number = As<Number>(value)->GetValue();

                    ans = std::make_shared<Number>(update_number);
                } else {
                    int64_t old_number = As<Number>(ans)->GetValue();
                    int64_t update_number = As<Number>(value)->GetValue();

                    ans = std::make_shared<Number>(old_number * PRECISION / (update_number != 0 ? update_number : 1));
                }
            }
        }
        return ans;
    }
};

class Quotient : public Symbol {
public:
    Quotient() : Symbol("quotient") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 2) {
            throw RuntimeError("Exactly 2 arguments required for \"Quotient\" function");
        }

        auto lhs = arguments[0]->Evaluate({}, scope);
        if (!Is<Number>(lhs)) {
            throw RuntimeError("\"Quotient\" error: not a number given as lhs");
        }
        auto lhs_value = As<Number>(lhs)->GetValue();
        if (lhs_value % PRECISION != 0) {
            throw RuntimeError("\"Quotient\" error: not an integer given as lhs");
        }

        auto rhs = arguments[1]->Evaluate({}, scope);
        if (!Is<Number>(rhs)) {
            throw RuntimeError("\"Quotient\" error: not a number given as rhs");
        }
        auto rhs_value = As<Number>(rhs)->GetValue();
        if (rhs_value % PRECISION != 0) {
            throw RuntimeError("\"Quotient\" error: not an integer given as rhs");
        }

        std::shared_ptr<Object> ans = std::make_shared<Number>(lhs_value * PRECISION / rhs_value);
        return ans;
    }
};

class Mod : public Symbol {
public:
    Mod() : Symbol("mod") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 2) {
            throw RuntimeError("Exactly 2 arguments required for \"Mod\" function");
        }

        auto lhs = arguments[0]->Evaluate({}, scope);
        if (!Is<Number>(lhs)) {
            throw RuntimeError("\"Mod\" error: not a number given as lhs");
        }
        auto lhs_value = As<Number>(lhs)->GetValue();
        if (lhs_value % PRECISION != 0) {
            throw RuntimeError("\"Mod\" error: not an integer given as lhs");
        }

        auto rhs = arguments[1]->Evaluate({}, scope);
        if (!Is<Number>(rhs)) {
            throw RuntimeError("\"Mod\" error: not a number given as rhs");
        }
        auto rhs_value = As<Number>(rhs)->GetValue();
        if (rhs_value % PRECISION != 0) {
            throw RuntimeError("\"Mod\" error: not an integer given as rhs");
        }

        std::shared_ptr<Object> ans = std::make_shared<Number>(lhs_value % rhs_value);
        return ans;
    }
};

class Expt : public Symbol {
public:
    Expt() : Symbol("expt") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 2) {
            throw RuntimeError("Exactly 2 arguments required for \"Expt\" function");
        }
        std::shared_ptr<Object> value = arguments[0]->Evaluate({}, scope);
        std::shared_ptr<Object> power = arguments[1]->Evaluate({}, scope);

        if (!Is<Number>(value)) {
            throw RuntimeError("\"Expt\" error: not a number given for lhs");
        }
        double value_number = static_cast<double>(As<Number>(value)->GetValue()) / PRECISION;

        if (!Is<Number>(power)) {
            throw RuntimeError("\"Expt\" error: not a number given for rhs");
        }
        double power_number = static_cast<double>(As<Number>(power)->GetValue()) / PRECISION;

        std::shared_ptr<Object> ans = std::make_shared<Number>(std::pow(value_number, power_number) * PRECISION);
        return ans;
    }
};

class Sqrt : public Symbol {
public:
    Sqrt() : Symbol("sqrt") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 1) {
            throw RuntimeError("Exactly 1 argument required for \"Sqrt\" function");
        }
        std::shared_ptr<Object> value = arguments[0]->Evaluate({}, scope);

        if (!Is<Number>(value)) {
            throw RuntimeError("\"Sqrt\" error: not a number given");
        }
        double value_number = static_cast<double>(As<Number>(value)->GetValue()) / PRECISION;

        std::shared_ptr<Object> ans = std::make_shared<Number>(std::sqrt(value_number) * PRECISION);
        return ans;
    }
};

class Max : public Symbol {
public:
    Max() : Symbol("max") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.empty()) {
            throw RuntimeError("At least 1 argument required for \"Max\" function");
        }
        std::shared_ptr<Object> ans = nullptr;
        std::shared_ptr<Object> value = nullptr;

        for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
            value = arguments[argument_idx]->Evaluate({}, scope);
            if (!Is<Number>(value)) {
                throw RuntimeError("\"Max\" error: not a number given");
            } else {
                if (argument_idx == 0) {
                    int64_t new_number = As<Number>(value)->GetValue();

                    ans = std::make_shared<Number>(new_number);
                } else {
                    int64_t old_number = As<Number>(ans)->GetValue();
                    int64_t new_number = As<Number>(value)->GetValue();

                    if (new_number > old_number) {
                        ans = std::make_shared<Number>(new_number);
                    }
                }
            }
        }
        return ans;
    }
};

class Min : public Symbol {
public:
    Min() : Symbol("min") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.empty()) {
            throw RuntimeError("At least 1 argument required for \"Min\" function");
        }
        std::shared_ptr<Object> ans = nullptr;
        std::shared_ptr<Object> value = nullptr;

        for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
            value = arguments[argument_idx]->Evaluate({}, scope);
            if (!Is<Number>(value)) {
                throw RuntimeError("\"Min\" error: not a number given");
            } else {
                if (argument_idx == 0) {
                    int64_t new_number = As<Number>(value)->GetValue();

                    ans = std::make_shared<Number>(new_number);
                } else {
                    int64_t old_number = As<Number>(ans)->GetValue();
                    int64_t new_number = As<Number>(value)->GetValue();

                    if (new_number < old_number) {
                        ans = std::make_shared<Number>(new_number);
                    }
                }
            }
        }
        return ans;
    }
};

class Abs : public Symbol {
public:
    Abs() : Symbol("abs") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 1) {
            throw RuntimeError("Exactly 1 argument required for \"Abs\" function");
        }
        std::shared_ptr<Object> ans = nullptr;
        std::shared_ptr<Object> value = nullptr;

        value = arguments[0]->Evaluate({}, scope);
        if (!Is<Number>(value)) {
            throw RuntimeError("\"Abs\" error: not a number given");
        }

        int64_t new_number = As<Number>(value)->GetValue();
        new_number = abs(new_number);
        ans = std::make_shared<Number>(new_number);

        return ans;
    }
};

class Define : public Symbol {
public:
    Define() : Symbol("define") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 2) {
            throw SyntaxError("Exactly 2 arguments required for \"Define\" function");
        }

        if (Is<Cell>(arguments[0])) {
            auto name_and_value = BuildLambdaSugar(arguments, scope);
            scope->SetVariableValue(name_and_value.first, name_and_value.second);
            return nullptr;
        }
        if (!Is<Symbol>(arguments[0])) {
            throw RuntimeError(
                "\"Define\" error: first argument should be a variable name or sugar like \"(f x "
                "y) (x + y)\"");
        }
        std::string name = As<Symbol>(arguments[0])->GetName();
        std::shared_ptr<Object> value = nullptr;

        if (Is<Cell>(arguments[1])) {
            std::shared_ptr<Object> maybe_lambda_keyword = As<Cell>(arguments[1])->GetFirst();
            if (Is<Symbol>(maybe_lambda_keyword) &&
                As<Symbol>(maybe_lambda_keyword)->GetName() == "lambda") {
                value = BuildLambda(As<Cell>(arguments[1])->GetSecond(), scope);
            } else {
                value = arguments[1]->Evaluate({}, scope);
            }
        } else {
            value = arguments[1]->Evaluate({}, scope);
        }
        scope->SetVariableValue(name, value);
        return nullptr;
    }
};

class Set : public Symbol {
public:
    Set() : Symbol("set!") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 2) {
            throw SyntaxError("Exactly 2 arguments required for \"Set\" function");
        }

        if (!Is<Symbol>(arguments[0])) {
            throw RuntimeError("\"Set\" error: first argument should be a variable name");
        }
        std::string name = As<Symbol>(arguments[0])->GetName();
        std::shared_ptr<Object> old_value =
            scope->GetVariableValueRecursive(name);  // to make sure the variable exists

        std::shared_ptr<Object> new_value = arguments[1]->Evaluate({}, scope);
        scope->SetVariableValue(name, new_value);
        return nullptr;
    }
};

class If : public Symbol {
public:
    If() : Symbol("if") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if ((arguments.size() < 2) || (arguments.size() > 3)) {
            throw SyntaxError("Exactly 2 or 3 arguments required for \"If\" function");
        }

        std::shared_ptr<Object> condition = arguments[0]->Evaluate({}, scope);
        if (!Is<Boolean>(condition)) {
            throw RuntimeError("\"If\" error: condition is not Boolean");
        }

        if (As<Boolean>(condition)->GetValue()) {
            return arguments[1]->Evaluate({}, scope);
        } else {
            if (arguments.size() == 3) {
                return arguments[2]->Evaluate({}, scope);
            }
            return nullptr;
        }
        return nullptr;
    }
};

class While : public Symbol {
public:
    While() : Symbol("while") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 2) {
            throw SyntaxError("Exactly 2 arguments required for \"While\" function");
        }

        std::shared_ptr<Object> condition = arguments[0]->Evaluate({}, scope);
        if (!Is<Boolean>(condition)) {
            throw RuntimeError("\"While\" error: condition is not Boolean");
        }

        std::shared_ptr<Object> result;
        while (As<Boolean>(condition)->GetValue()) {
            result = arguments[1]->Evaluate({}, scope);
            condition = arguments[0]->Evaluate({}, scope);
        }
        return result;
    }
};

class Cons : public Symbol {
public:
    Cons() : Symbol("cons") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 2) {
            throw SyntaxError("Exactly 2 arguments required for \"Cons\" function");
        }

        std::shared_ptr<Object> ans = std::make_shared<Cell>(nullptr, nullptr);
        As<Cell>(ans)->SetFirst(arguments[0]->Evaluate({}, scope));
        As<Cell>(ans)->SetSecond(arguments[1]->Evaluate({}, scope));
        return ans;
    }
};

class Car : public Symbol {
public:
    Car() : Symbol("car") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 1) {
            throw SyntaxError("Exactly 1 argument required for \"Car\" function");
        }

        std::shared_ptr<Object> value = arguments[0]->Evaluate({}, scope);
        std::shared_ptr<Object> ans = value;
        if (Is<Cell>(value)) {
            ans = As<Cell>(value)->GetFirst();
        }
        return ans;
    }
};

class Cdr : public Symbol {
public:
    Cdr() : Symbol("cdr") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 1) {
            throw SyntaxError("Exactly 1 argument required for \"Cdr\" function");
        }

        std::shared_ptr<Object> value = arguments[0]->Evaluate({}, scope);
        std::shared_ptr<Object> ans = nullptr;
        if (Is<Cell>(value)) {
            ans = As<Cell>(value)->GetSecond();
        }
        return ans;
    }
};

class SetCar : public Symbol {
public:
    SetCar() : Symbol("set-car!") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 2) {
            throw SyntaxError("Exactly 2 arguments required for \"SetCar\" function");
        }

        std::shared_ptr<Object> source = arguments[0]->Evaluate({}, scope);
        if (!Is<Cell>(source)) {
            throw RuntimeError("\"SetCar\" error: not a pair or list given");
        }
        std::shared_ptr<Object> value = arguments[1]->Evaluate({}, scope);
        As<Cell>(source)->SetFirst(value);
        return nullptr;
    }
};

class SetCdr : public Symbol {
public:
    SetCdr() : Symbol("set-cdr!") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 2) {
            throw SyntaxError("Exactly 2 arguments required for \"SetCdr\" function");
        }

        std::shared_ptr<Object> source = arguments[0]->Evaluate({}, scope);
        if (!Is<Cell>(source)) {
            throw RuntimeError("\"SetCdr\" error: not a pair or list given");
        }
        std::shared_ptr<Object> value = arguments[1]->Evaluate({}, scope);
        As<Cell>(source)->SetSecond(value);
        return nullptr;
    }
};

class List : public Symbol {
public:
    List() : Symbol("list") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        std::shared_ptr<Object> previous = nullptr;
        std::shared_ptr<Object> current = std::make_shared<Cell>(nullptr, nullptr);
        std::shared_ptr<Object> ans = current;
        std::shared_ptr<Object> next = nullptr;

        for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
            As<Cell>(current)->SetFirst(arguments[argument_idx]->Evaluate({}, scope));
            next = std::make_shared<Cell>(nullptr, nullptr);
            As<Cell>(current)->SetSecond(next);

            previous = current;
            current = next;
        }
        if (previous) {
            As<Cell>(previous)->SetSecond(nullptr);
        }

        return ans;
    }
};

class ListRef : public Symbol {
public:
    ListRef() : Symbol("list-ref") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 2) {
            throw SyntaxError("Exactly 2 arguments required for \"ListRef\" function");
        }

        std::shared_ptr<Object> init = arguments[0]->Evaluate({}, scope);
        std::shared_ptr<Object> idx = arguments[1]->Evaluate({}, scope);
        if (!Is<Number>(idx)) {
            throw RuntimeError("\"ListRef\" error: idx is not a number");
        }
        int64_t idx_number = As<Number>(idx)->GetValue() / PRECISION;

        for (std::shared_ptr<Cell> cell = As<Cell>(init); cell;
             cell = As<Cell>(cell->GetSecond())) {
            if (idx_number == 0) {
                return cell->GetFirst();
            }
            --idx_number;
        }
        throw RuntimeError("\"ListRef\" error: idx out of bounds");
    }
};

class ListTail : public Symbol {
public:
    ListTail() : Symbol("list-tail") {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        if (arguments.size() != 2) {
            throw SyntaxError("Exactly 2 arguments required for \"ListTail\" function");
        }
        std::shared_ptr<Object> init = arguments[0]->Evaluate({}, scope);
        std::shared_ptr<Object> idx = arguments[1]->Evaluate({}, scope);
        if (!Is<Number>(idx)) {
            throw RuntimeError("\"ListTail\" error: idx is not a number");
        }
        int64_t idx_number = As<Number>(idx)->GetValue() / PRECISION;

        for (std::shared_ptr<Cell> cell = As<Cell>(init); cell;
             cell = As<Cell>(cell->GetSecond())) {
            if (idx_number == 0) {
                return cell;
            }
            --idx_number;
        }
        if (idx_number == 0) {
            return nullptr;
        }
        throw RuntimeError("\"ListTail\" error: idx out of bounds");
    }
};

class Lambda : public Object {
public:
    Lambda(std::vector<std::shared_ptr<Object>>& commands,
           std::vector<std::string>& arguments_idx_to_name, std::shared_ptr<Scope> self_scope)
        : commands_(commands),
          arguments_idx_to_name_(arguments_idx_to_name),
          self_scope_(self_scope) {
    }

    virtual std::shared_ptr<Object> Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
                                             std::shared_ptr<Scope> scope) override {
        std::shared_ptr<Scope> cur_scope = std::make_shared<Scope>();
        cur_scope->SetPreviousScope(scope);

        if (arguments_idx_to_name_.size() != arguments.size()) {
            throw RuntimeError("\"Lambda\" call error: wrong number of arguments passed");
        }

        for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
            std::string name = arguments_idx_to_name_[argument_idx];
            std::shared_ptr<Object> value = arguments[argument_idx]->Evaluate({}, scope);
            cur_scope->SetVariableValue(name, value);
        }

        // Set variables before entering the function
        auto self_scope_variables = self_scope_->GetVariablesMap();
        for (auto& [name, value] : self_scope_variables) {
            if (!cur_scope->GetVariableValueLocal(name).has_value()) {
                cur_scope->SetVariableValue(name, value);
            }
        }

        std::shared_ptr<Object> ans = nullptr;
        for (size_t command_idx = 0; command_idx < commands_.size(); ++command_idx) {
            ans = commands_[command_idx]->Evaluate({}, cur_scope);
        }

        // Update variables after finishing the function
        auto cur_scope_variables = cur_scope->GetVariablesMap();
        for (auto& [name, value] : cur_scope_variables) {
            self_scope_->SetVariableValue(name, value);
        }
        return ans;
    }

private:
    std::vector<std::shared_ptr<Object>> commands_{};
    std::vector<std::string> arguments_idx_to_name_{};
    std::shared_ptr<Scope> self_scope_{};
};