#include "scheme.hpp"

#include <sstream>
#include <stdexcept>
#include <vector>
#include <map>

#include <tokenizer/tokenizer.hpp>
#include <parser/parser.hpp>
#include <helpers/helpers.hpp>

namespace Scheme {

std::string Scheme::Evaluate(const std::string& expression) {
    std::stringstream ss{expression};
    Tokenizer::Tokenizer tokenizer{&ss};
    Parser::Parser parser;
    ObjectPtr current = parser.Read(&tokenizer);

    if (!current) {  // Empty list, but not evaliated
        throw RuntimeError("Empty list given, lists are not self evaliating, use \"quote\"");
    }

    SetSystemFunctions();
    ObjectPtr ans = current->Evaluate({}, global_scope_);
    return Interp::ObjectToString(ans);
}

llvm::Value* Scheme::Codegen(const std::string& expression) {
    auto& context = Codegen::Context::Get();
    
    std::stringstream ss{expression};
    Tokenizer::Tokenizer tokenizer{&ss};
    Parser::Parser parser;
    ObjectPtr current = parser.Read(&tokenizer);

    if (!current) {  // Empty list, but not evaliated
        throw RuntimeError("Empty list given, lists are not self evaliating, use \"quote\"");
    }

    SetSystemFunctions();
    current->Codegen({}, global_scope_);
    return nullptr;
}

void Scheme::SetSystemFunctions() {
    // Also set PRECISION variable in global scope
    // WARNING! Precision value should be also precised
    global_scope_->SetVariableValue("PRECISION", std::make_shared<Number>(PRECISION * PRECISION), true);

    // Graphics
    global_scope_->SetVariableFunction("gl-init", std::make_shared<GLInit>());
    global_scope_->SetVariableFunction("gl-clear", std::make_shared<GLClear>());
    global_scope_->SetVariableFunction("gl-put-pixel", std::make_shared<GLPutPixel>());
    global_scope_->SetVariableFunction("gl-is-open", std::make_shared<GLIsOpen>());
    global_scope_->SetVariableFunction("gl-draw", std::make_shared<GLDraw>());
    global_scope_->SetVariableFunction("gl-finish", std::make_shared<GLFinish>());

    // Print
    global_scope_->SetVariableFunction("print", std::make_shared<Print>());

    // "Is" methods
    global_scope_->SetVariableFunction("boolean?", std::make_shared<IsBoolean>());
    global_scope_->SetVariableFunction("number?", std::make_shared<IsNumber>());
    global_scope_->SetVariableFunction("symbol?", std::make_shared<IsSymbol>());
    global_scope_->SetVariableFunction("pair?", std::make_shared<IsPair>());
    global_scope_->SetVariableFunction("null?", std::make_shared<IsNull>());
    global_scope_->SetVariableFunction("list?", std::make_shared<IsList>());

    // Logical operators
    global_scope_->SetVariableFunction("not", std::make_shared<Not>());
    global_scope_->SetVariableFunction("and", std::make_shared<And>());
    global_scope_->SetVariableFunction("or", std::make_shared<Or>());

    // Comparisons
    global_scope_->SetVariableFunction("=", std::make_shared<Equal>());
    global_scope_->SetVariableFunction(">", std::make_shared<Greater>());
    global_scope_->SetVariableFunction(">=", std::make_shared<GreaterEqual>());
    global_scope_->SetVariableFunction("<", std::make_shared<Less>());
    global_scope_->SetVariableFunction("<=", std::make_shared<LessEqual>());

    // Arithmetic
    global_scope_->SetVariableFunction("+", std::make_shared<Add>());
    global_scope_->SetVariableFunction("*", std::make_shared<Multiply>());
    global_scope_->SetVariableFunction("-", std::make_shared<Subtract>());
    global_scope_->SetVariableFunction("/", std::make_shared<Divide>());
    global_scope_->SetVariableFunction("quotient", std::make_shared<Quotient>());
    global_scope_->SetVariableFunction("mod", std::make_shared<Mod>());

    global_scope_->SetVariableFunction("expt", std::make_shared<Expt>());
    global_scope_->SetVariableFunction("sqrt", std::make_shared<Sqrt>());
    global_scope_->SetVariableFunction("max", std::make_shared<Max>());
    global_scope_->SetVariableFunction("min", std::make_shared<Min>());
    global_scope_->SetVariableFunction("abs", std::make_shared<Abs>());

    // Variable
    global_scope_->SetVariableFunction("define", std::make_shared<Define>());
    global_scope_->SetVariableFunction("set!", std::make_shared<Set>());

    // Control-flow
    global_scope_->SetVariableFunction("if", std::make_shared<If>());
    global_scope_->SetVariableFunction("while", std::make_shared<While>());

    // Quote
    global_scope_->SetVariableFunction("quote", std::make_shared<Quote>());

    // List operations
    global_scope_->SetVariableFunction("cons", std::make_shared<Cons>());
    global_scope_->SetVariableFunction("car", std::make_shared<Car>());
    global_scope_->SetVariableFunction("cdr", std::make_shared<Cdr>());
    global_scope_->SetVariableFunction("set-car!", std::make_shared<SetCar>());
    global_scope_->SetVariableFunction("set-cdr!", std::make_shared<SetCdr>());
    global_scope_->SetVariableFunction("list", std::make_shared<List>());
    global_scope_->SetVariableFunction("list-ref", std::make_shared<ListRef>());
    global_scope_->SetVariableFunction("list-tail", std::make_shared<ListTail>());
}

} // namespace Scheme