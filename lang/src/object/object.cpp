#include "object.hpp"

std::shared_ptr<Object> Number::Evaluate(const std::vector<std::shared_ptr<Object>>&,
    std::shared_ptr<Scope>) {

    return shared_from_this();
}

llvm::Value* Number::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    return Codegen::CreateStoreNewNumber(value_);
}

std::shared_ptr<Object> Symbol::Evaluate(const std::vector<std::shared_ptr<Object>>&,
    std::shared_ptr<Scope> scope) {
    std::shared_ptr<Object> value = scope->GetVariableValueRecursive(name_);
    return value;
}

llvm::Value* Symbol::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    if (is_quote) {
        is_quote = false;
        return Codegen::CreateStoreNewSymbol(name_);
    }
    llvm::Value* object = scope->GetVariableValueRecursiveCodegen(name_);
    return object;
}

std::shared_ptr<Object> Boolean::Evaluate(const std::vector<std::shared_ptr<Object>>&,
    std::shared_ptr<Scope>) {
    return shared_from_this();
}

llvm::Value* Boolean::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    return Codegen::CreateStoreNewBoolean(value_);
}

std::shared_ptr<Object> Cell::Evaluate(const std::vector<std::shared_ptr<Object>>&,
    std::shared_ptr<Scope> scope) {
    if (!GetFirst()) {  // Empty list case
        return shared_from_this();
    }

    std::shared_ptr<Object> function = GetFirst();
    std::shared_ptr<Object> maybe_lambda_keyword = function;
    if (Is<Symbol>(maybe_lambda_keyword) &&
        (As<Symbol>(maybe_lambda_keyword)->GetName() == "lambda")) {
        return Interp::BuildLambda(GetSecond(), scope);
    } else if (Is<Symbol>(maybe_lambda_keyword) &&
        (As<Symbol>(maybe_lambda_keyword)->GetName() == "begin")) {
        auto lambda_to_eval_immediately = Interp::BuildLambda(GetSecond(), scope, true);
        return lambda_to_eval_immediately->Evaluate({}, scope);
    } else if (!Is<Quote>(function)) {
        if (Is<Symbol>(function) || Is<Cell>(function)) {
            function = function->Evaluate({}, scope);  // Get function object from scope variables
        } else {
            throw RuntimeError("Lists are not self evaliating, use \"quote\"");
        }
    }

    std::shared_ptr<Object> arguments_start = GetSecond();

    std::vector<std::shared_ptr<Object>> function_arguments = Interp::ListToVector(arguments_start);
    return function->Evaluate(function_arguments, scope);
}

llvm::Value* Cell::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    // TODO: empty list case
    auto& context = Codegen::Context::Get();

    std::shared_ptr<Object> function = GetFirst();
    std::shared_ptr<Object> maybe_lambda_keyword = function;
    if (Is<Symbol>(maybe_lambda_keyword) && (As<Symbol>(maybe_lambda_keyword)->GetName() == "lambda")) {
        // TODO: return??
        // function = Codegen::BuildLambdaCodegen(GetSecond(), scope);
        // return nullptr;
    } else if (Is<Symbol>(maybe_lambda_keyword) && (As<Symbol>(maybe_lambda_keyword)->GetName() == "begin")) {
        auto lambda_to_eval_immediately = Codegen::BuildLambdaCodegen(GetSecond(), scope, true);
        return lambda_to_eval_immediately->Codegen({}, scope);
    } else if (!Is<Quote>(function)) {
        if (Is<Symbol>(function) || Is<Cell>(function)) {
            // WARNING: there we need to evaluate, not codegen
            // but handle one special case, when we need codegen, not evaluate:
            if (Is<Cell>(function) && Is<Symbol>(As<Cell>(function)->GetFirst()) && As<Symbol>(As<Cell>(function)->GetFirst())->GetName() == "lambda") {
                auto child_first = As<Cell>(function)->GetFirst();
                auto child_second = As<Cell>(function)->GetSecond();

                function = Codegen::BuildLambdaCodegen(child_second, scope);
            } else {
                function = function->Evaluate({}, scope);  // Get function object from scope variables
            }
        } else {
            throw RuntimeError("Lists are not self evaliating, use \"quote\"");
        }
    }

    std::shared_ptr<Object> arguments_start = GetSecond();

    std::vector<std::shared_ptr<Object>> function_arguments = Interp::ListToVector(arguments_start);
    return function->Codegen(function_arguments, scope);
}

std::shared_ptr<Object> GLInit::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope>) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLInit\" function");
    }
    __GLInit();
    return nullptr;
}

llvm::Value* GLInit::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLInit\" function");
    }

    auto& context = Codegen::Context::Get();
    llvm::Function* function = context.llvm_module->getFunction("__GLInit");
    context.builder->CreateCall(function, {});
    return nullptr;
}

std::shared_ptr<Object> GLClear::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope>) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLClear\" function");
    }
    __GLClear();
    return nullptr;
}

llvm::Value* GLClear::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLClear\" function");
    }

    auto& context = Codegen::Context::Get();
    llvm::Function* function = context.llvm_module->getFunction("__GLClear");
    context.builder->CreateCall(function, {});
    return nullptr;
}

std::shared_ptr<Object> GLPutPixel::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
    if (arguments.size() != 5) {
        throw SyntaxError("Exactly 5 arguments required for \"GLPutPixel\" function");
    }

    std::shared_ptr<Object> x_object = arguments[0]->Evaluate({}, scope);
    std::shared_ptr<Object> y_object = arguments[1]->Evaluate({}, scope);
    std::shared_ptr<Object> r_object = arguments[2]->Evaluate({}, scope);
    std::shared_ptr<Object> g_object = arguments[3]->Evaluate({}, scope);
    std::shared_ptr<Object> b_object = arguments[4]->Evaluate({}, scope);

    // TODO: fix
    //__GLPutPixel(x_coord, y_coord, r_component, g_component, b_component);
    return nullptr;
}

llvm::Value* GLPutPixel::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    if (arguments.size() != 5) {
        throw SyntaxError("Exactly 5 arguments required for \"GLPutPixel\" function");
    }

    llvm::Value* x_object = arguments[0]->Codegen({}, scope);
    llvm::Value* y_object = arguments[1]->Codegen({}, scope);
    llvm::Value* r_object = arguments[2]->Codegen({}, scope);
    llvm::Value* g_object = arguments[3]->Codegen({}, scope);
    llvm::Value* b_object = arguments[4]->Codegen({}, scope);

    auto& context = Codegen::Context::Get();
    llvm::Function* function = context.llvm_module->getFunction("__GLPutPixel");
    context.builder->CreateCall(function, {x_object, y_object, r_object, g_object, b_object});
    return nullptr;
}

std::shared_ptr<Object> GLIsOpen::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope>) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLIsOpen\" function");
    }
    return __GLIsOpen().boolean ? std::make_shared<Boolean>(true)
        : std::make_shared<Boolean>(false);
}

llvm::Value* GLIsOpen::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLIsOpen\" function");
    }

    std::vector<llvm::Value*> function_call_arguments{};

    auto& context = Codegen::Context::Get();
    llvm::Function* function = context.llvm_module->getFunction("__GLIsOpen");
    llvm::Value* is_open_return_value = context.builder->CreateAlloca(context.object_type, nullptr, "is-open");
    context.builder->CreateStore(context.builder->CreateCall(function, function_call_arguments), is_open_return_value);
    return is_open_return_value;
}

std::shared_ptr<Object> GLDraw::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope>) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLDraw\" function");
    }
    __GLDraw();
    return nullptr;
}

llvm::Value* GLDraw::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLDraw\" function");
    }

    auto& context = Codegen::Context::Get();
    llvm::Function* function = context.llvm_module->getFunction("__GLDraw");
    context.builder->CreateCall(function, {});
    return nullptr;
}

std::shared_ptr<Object> GLFinish::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope>) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLFinish\" function");
    }
    __GLFinish();
    return nullptr;
}

llvm::Value* GLFinish::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLFinish\" function");
    }

    auto& context = Codegen::Context::Get();
    llvm::Function* function = context.llvm_module->getFunction("__GLFinish");
    context.builder->CreateCall(function, {});
    return nullptr;
}

std::shared_ptr<Object> Print::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"Print\" function");
    }
    std::shared_ptr<Object> object = arguments[0]->Evaluate({}, scope);
    std::cout << "Print: " << Interp::ObjectToString(object) << std::endl;
    return object;
}

llvm::Value* Print::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"Print\" function");
    }

    auto& context = Codegen::Context::Get();
    llvm::Value* object = arguments[0]->Codegen({}, scope);
    std::vector<llvm::Value*> function_call_arguments = {object};
    llvm::Function* function = context.llvm_module->getFunction("__GLPrint");
    context.builder->CreateCall(function, function_call_arguments);
    return object;
}

std::shared_ptr<Object> IsBoolean::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"IsBoolean\" function");
    }
    std::shared_ptr<Object> value = arguments[0]->Evaluate({}, scope);
    return Is<Boolean>(value) ? std::make_shared<Boolean>(true)
        : std::make_shared<Boolean>(false);
}

llvm::Value* IsBoolean::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

std::shared_ptr<Object> IsNumber::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"IsNumber\" function");
    }
    std::shared_ptr<Object> value = arguments[0]->Evaluate({}, scope);
    return Is<Number>(value) ? std::make_shared<Boolean>(true)
        : std::make_shared<Boolean>(false);
}

llvm::Value* IsNumber::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("number? codegen unimplemented");
}

std::shared_ptr<Object> IsSymbol::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"IsSymbol\" function");
    }
    std::shared_ptr<Object> value = arguments[0]->Evaluate({}, scope);
    return Is<Symbol>(value) ? std::make_shared<Boolean>(true)
        : std::make_shared<Boolean>(false);
}

llvm::Value* IsSymbol::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

std::shared_ptr<Object> IsPair::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* IsPair::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

std::shared_ptr<Object> IsNull::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* IsNull::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("null? codegen unimplemented");
}

std::shared_ptr<Object> IsList::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* IsList::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("list? codegen unimplemented");
}

std::shared_ptr<Object> Quote::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope>) {
    if (arguments.empty()) {
        return std::make_shared<Cell>(nullptr, nullptr);
    }
    if (arguments.size() > 1) {
        throw SyntaxError("Exactly 1 argument (list) required for \"Quote\" function");
    }
    return arguments[0];
}

llvm::Value* Quote::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    if (arguments.empty()) {
        return nullptr;
    }
    if (arguments.size() > 1) {
        throw SyntaxError("Exactly 1 argument (list) required for \"Quote\" function");
    }
    return arguments[0]->Codegen({}, scope, true);
}

std::shared_ptr<Object> Not::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* Not::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

std::shared_ptr<Object> And::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* And::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("and codegen unimplemented");
}

std::shared_ptr<Object> Or::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* Or::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

std::shared_ptr<Object> Equal::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* Equal::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();
    auto& llvm_context = context.llvm_context.value();

    llvm::Function* current_function = context.builder->GetInsertBlock()->getParent();
    llvm::BasicBlock* comparison_branch = llvm::BasicBlock::Create(llvm_context, "comparison_branch", current_function);
    llvm::BasicBlock* true_branch = llvm::BasicBlock::Create(llvm_context, "true_branch", current_function);
    llvm::BasicBlock* false_branch = llvm::BasicBlock::Create(llvm_context, "false_branch", current_function);
    llvm::BasicBlock* merge_branch = llvm::BasicBlock::Create(llvm_context, "merge_branch", current_function);

    llvm::Value* last_object = nullptr;
    llvm::Value* object = nullptr;

    context.builder->CreateBr(comparison_branch);

    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        context.builder->SetInsertPoint(comparison_branch);

        last_object = object;
        object = arguments[argument_idx]->Codegen({}, scope);
        Codegen::CreateObjectTypeCheck(object, ObjectType::TYPE_NUMBER);

        if (argument_idx != 0) {
            llvm::BasicBlock* next_comparison_branch = nullptr;
            if (argument_idx + 1 < arguments.size()) {
                next_comparison_branch = llvm::BasicBlock::Create(llvm_context, "comparison_branch", current_function);
            } else {
                next_comparison_branch = true_branch;
            }

            llvm::Value* last_object_value_number = Codegen::CreateLoadNumber(last_object);
            llvm::Value* object_value_number = Codegen::CreateLoadNumber(object);

            llvm::Value* cmp_result = context.builder->CreateICmpNE(last_object_value_number, object_value_number);
            context.builder->CreateCondBr(cmp_result, false_branch, next_comparison_branch);

            comparison_branch = context.builder->GetInsertBlock();
            comparison_branch = next_comparison_branch;
        }
    }

    // TRUE BRANCH
    context.builder->SetInsertPoint(true_branch);
    llvm::Value* true_ans = Codegen::CreateStoreNewBoolean(true);
    context.builder->CreateBr(merge_branch);
    true_branch = context.builder->GetInsertBlock();

    // FALSE BRANCH
    context.builder->SetInsertPoint(false_branch);
    llvm::Value* false_ans = Codegen::CreateStoreNewBoolean(false);
    context.builder->CreateBr(merge_branch);
    false_branch = context.builder->GetInsertBlock();

    // PHI NODE
    context.builder->SetInsertPoint(merge_branch);
    llvm::PHINode* ans_value = context.builder->CreatePHI(context.builder->getInt8PtrTy(), 2);
    ans_value->addIncoming(true_ans, true_branch);
    ans_value->addIncoming(false_ans, false_branch);

    return ans_value;
}

std::shared_ptr<Object> Greater::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* Greater::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();
    auto& llvm_context = context.builder->getContext();
    llvm::Function* current_function = context.builder->GetInsertBlock()->getParent();
    llvm::BasicBlock* comparison_branch = llvm::BasicBlock::Create(llvm_context, "comparison_branch", current_function);
    llvm::BasicBlock* true_branch = llvm::BasicBlock::Create(llvm_context, "true_branch", current_function);
    llvm::BasicBlock* false_branch = llvm::BasicBlock::Create(llvm_context, "false_branch", current_function);
    llvm::BasicBlock* merge_branch = llvm::BasicBlock::Create(llvm_context, "merge_branch", current_function);

    llvm::Value* last_object = nullptr;
    llvm::Value* object = nullptr;

    context.builder->CreateBr(comparison_branch);

    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        context.builder->SetInsertPoint(comparison_branch);

        last_object = object;
        object = arguments[argument_idx]->Codegen({}, scope);
        Codegen::CreateObjectTypeCheck(object, ObjectType::TYPE_NUMBER);

        if (argument_idx != 0) {
            llvm::BasicBlock* next_comparison_branch = nullptr;
            if (argument_idx + 1 < arguments.size()) {
                next_comparison_branch = llvm::BasicBlock::Create(llvm_context, "comparison_branch", current_function);
            } else {
                next_comparison_branch = true_branch;
            }

            llvm::Value* last_object_value_number = Codegen::CreateLoadNumber(last_object);
            llvm::Value* object_value_number = Codegen::CreateLoadNumber(object);

            llvm::Value* cmp_result = context.builder->CreateICmpSLE(last_object_value_number, object_value_number);
            context.builder->CreateCondBr(cmp_result, false_branch, next_comparison_branch);

            comparison_branch = context.builder->GetInsertBlock();
            comparison_branch = next_comparison_branch;
        }
    }

    // TRUE BRANCH
    context.builder->SetInsertPoint(true_branch);
    llvm::Value* true_ans = Codegen::CreateStoreNewBoolean(true);
    context.builder->CreateBr(merge_branch);
    true_branch = context.builder->GetInsertBlock();

    // FALSE BRANCH
    context.builder->SetInsertPoint(false_branch);
    llvm::Value* false_ans = Codegen::CreateStoreNewBoolean(false);
    context.builder->CreateBr(merge_branch);
    false_branch = context.builder->GetInsertBlock();

    // PHI NODE
    context.builder->SetInsertPoint(merge_branch);
    llvm::PHINode* ans_value = context.builder->CreatePHI(context.builder->getInt8PtrTy(), 2);
    ans_value->addIncoming(true_ans, true_branch);
    ans_value->addIncoming(false_ans, false_branch);

    return ans_value;
}

std::shared_ptr<Object> GreaterEqual::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* GreaterEqual::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();
    auto& llvm_context = context.builder->getContext();
    llvm::Function* current_function = context.builder->GetInsertBlock()->getParent();
    llvm::BasicBlock* comparison_branch = llvm::BasicBlock::Create(llvm_context, "comparison_branch", current_function);
    llvm::BasicBlock* true_branch = llvm::BasicBlock::Create(llvm_context, "true_branch", current_function);
    llvm::BasicBlock* false_branch = llvm::BasicBlock::Create(llvm_context, "false_branch", current_function);
    llvm::BasicBlock* merge_branch = llvm::BasicBlock::Create(llvm_context, "merge_branch", current_function);

    llvm::Value* last_object = nullptr;
    llvm::Value* object = nullptr;

    context.builder->CreateBr(comparison_branch);

    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        context.builder->SetInsertPoint(comparison_branch);

        last_object = object;
        object = arguments[argument_idx]->Codegen({}, scope);
        Codegen::CreateObjectTypeCheck(object, ObjectType::TYPE_NUMBER);

        if (argument_idx != 0) {
            llvm::BasicBlock* next_comparison_branch = nullptr;
            if (argument_idx + 1 < arguments.size()) {
                next_comparison_branch = llvm::BasicBlock::Create(llvm_context, "comparison_branch", current_function);
            } else {
                next_comparison_branch = true_branch;
            }

            llvm::Value* last_object_value_number = Codegen::CreateLoadNumber(last_object);
            llvm::Value* object_value_number = Codegen::CreateLoadNumber(object);

            llvm::Value* cmp_result = context.builder->CreateICmpSLT(last_object_value_number, object_value_number);
            context.builder->CreateCondBr(cmp_result, false_branch, next_comparison_branch);

            comparison_branch = context.builder->GetInsertBlock();
            comparison_branch = next_comparison_branch;
        }
    }

    // TRUE BRANCH
    context.builder->SetInsertPoint(true_branch);
    llvm::Value* true_ans = Codegen::CreateStoreNewBoolean(true);
    context.builder->CreateBr(merge_branch);
    true_branch = context.builder->GetInsertBlock();

    // FALSE BRANCH
    context.builder->SetInsertPoint(false_branch);
    llvm::Value* false_ans = Codegen::CreateStoreNewBoolean(false);
    context.builder->CreateBr(merge_branch);
    false_branch = context.builder->GetInsertBlock();

    // PHI NODE
    context.builder->SetInsertPoint(merge_branch);
    llvm::PHINode* ans_value = context.builder->CreatePHI(context.builder->getInt8PtrTy(), 2);
    ans_value->addIncoming(true_ans, true_branch);
    ans_value->addIncoming(false_ans, false_branch);

    return ans_value;
}

std::shared_ptr<Object> Less::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* Less::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();
    auto& llvm_context = context.builder->getContext();
    llvm::Function* current_function = context.builder->GetInsertBlock()->getParent();
    llvm::BasicBlock* comparison_branch = llvm::BasicBlock::Create(llvm_context, "comparison_branch", current_function);
    llvm::BasicBlock* true_branch = llvm::BasicBlock::Create(llvm_context, "true_branch", current_function);
    llvm::BasicBlock* false_branch = llvm::BasicBlock::Create(llvm_context, "false_branch", current_function);
    llvm::BasicBlock* merge_branch = llvm::BasicBlock::Create(llvm_context, "merge_branch", current_function);

    llvm::Value* last_object = nullptr;
    llvm::Value* object = nullptr;

    context.builder->CreateBr(comparison_branch);

    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        context.builder->SetInsertPoint(comparison_branch);

        last_object = object;
        object = arguments[argument_idx]->Codegen({}, scope);
        Codegen::CreateObjectTypeCheck(object, ObjectType::TYPE_NUMBER);

        if (argument_idx != 0) {
            llvm::BasicBlock* next_comparison_branch = nullptr;
            if (argument_idx + 1 < arguments.size()) {
                next_comparison_branch = llvm::BasicBlock::Create(llvm_context, "comparison_branch", current_function);
            } else {
                next_comparison_branch = true_branch;
            }

            llvm::Value* last_object_value_number = Codegen::CreateLoadNumber(last_object);
            llvm::Value* object_value_number = Codegen::CreateLoadNumber(object);

            llvm::Value* cmp_result = context.builder->CreateICmpSGE(last_object_value_number, object_value_number);
            context.builder->CreateCondBr(cmp_result, false_branch, next_comparison_branch);

            comparison_branch = context.builder->GetInsertBlock();
            comparison_branch = next_comparison_branch;
        }
    }

    // TRUE BRANCH
    context.builder->SetInsertPoint(true_branch);
    llvm::Value* true_ans = Codegen::CreateStoreNewBoolean(true);
    context.builder->CreateBr(merge_branch);
    true_branch = context.builder->GetInsertBlock();

    // FALSE BRANCH
    context.builder->SetInsertPoint(false_branch);
    llvm::Value* false_ans = Codegen::CreateStoreNewBoolean(false);
    context.builder->CreateBr(merge_branch);
    false_branch = context.builder->GetInsertBlock();

    // PHI NODE
    context.builder->SetInsertPoint(merge_branch);
    llvm::PHINode* ans_value = context.builder->CreatePHI(context.builder->getInt8PtrTy(), 2);
    ans_value->addIncoming(true_ans, true_branch);
    ans_value->addIncoming(false_ans, false_branch);

    return ans_value;
}

std::shared_ptr<Object> LessEqual::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* LessEqual::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();
    auto& llvm_context = context.builder->getContext();
    llvm::Function* current_function = context.builder->GetInsertBlock()->getParent();
    llvm::BasicBlock* comparison_branch = llvm::BasicBlock::Create(llvm_context, "comparison_branch", current_function);
    llvm::BasicBlock* true_branch = llvm::BasicBlock::Create(llvm_context, "true_branch", current_function);
    llvm::BasicBlock* false_branch = llvm::BasicBlock::Create(llvm_context, "false_branch", current_function);
    llvm::BasicBlock* merge_branch = llvm::BasicBlock::Create(llvm_context, "merge_branch", current_function);

    llvm::Value* last_object = nullptr;
    llvm::Value* object = nullptr;

    context.builder->CreateBr(comparison_branch);

    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        context.builder->SetInsertPoint(comparison_branch);

        last_object = object;
        object = arguments[argument_idx]->Codegen({}, scope);
        Codegen::CreateObjectTypeCheck(object, ObjectType::TYPE_NUMBER);

        if (argument_idx != 0) {
            llvm::BasicBlock* next_comparison_branch = nullptr;
            if (argument_idx + 1 < arguments.size()) {
                next_comparison_branch = llvm::BasicBlock::Create(llvm_context, "comparison_branch", current_function);
            } else {
                next_comparison_branch = true_branch;
            }

            llvm::Value* last_object_value_number = Codegen::CreateLoadNumber(last_object);
            llvm::Value* object_value_number = Codegen::CreateLoadNumber(object);

            llvm::Value* cmp_result = context.builder->CreateICmpSGT(last_object_value_number, object_value_number);
            context.builder->CreateCondBr(cmp_result, false_branch, next_comparison_branch);

            comparison_branch = context.builder->GetInsertBlock();
            comparison_branch = next_comparison_branch;
        }
    }

    // TRUE BRANCH
    context.builder->SetInsertPoint(true_branch);
    llvm::Value* true_ans = Codegen::CreateStoreNewBoolean(true);
    context.builder->CreateBr(merge_branch);
    true_branch = context.builder->GetInsertBlock();

    // FALSE BRANCH
    context.builder->SetInsertPoint(false_branch);
    llvm::Value* false_ans = Codegen::CreateStoreNewBoolean(false);
    context.builder->CreateBr(merge_branch);
    false_branch = context.builder->GetInsertBlock();

    // PHI NODE
    context.builder->SetInsertPoint(merge_branch);
    llvm::PHINode* ans_value = context.builder->CreatePHI(context.builder->getInt8PtrTy(), 2);
    ans_value->addIncoming(true_ans, true_branch);
    ans_value->addIncoming(false_ans, false_branch);

    return ans_value;
}

std::shared_ptr<Object> Add::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* Add::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();

    llvm::Value* ans = Codegen::CreateStoreNewNumber(0 * PRECISION);
    llvm::Value* value = nullptr;

    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        value = arguments[argument_idx]->Codegen({}, scope);
        Codegen::CreateObjectTypeCheck(value, ObjectType::TYPE_NUMBER);

        llvm::Value* ans_value_number = Codegen::CreateLoadNumber(ans);
        llvm::Value* object_value_number = Codegen::CreateLoadNumber(value);

        llvm::Value* new_ans_number = context.builder->CreateAdd(ans_value_number, object_value_number);
        Codegen::CreateStoreNumber(ans, new_ans_number);
    }

    return ans;
}

std::shared_ptr<Object> Multiply::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* Multiply::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();

    llvm::Value* ans = Codegen::CreateStoreNewNumber(1 * PRECISION);
    llvm::Value* value = nullptr;

    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        value = arguments[argument_idx]->Codegen({}, scope);
        Codegen::CreateObjectTypeCheck(value, ObjectType::TYPE_NUMBER);

        llvm::Value* ans_value_number = Codegen::CreateLoadNumber(ans);
        llvm::Value* object_value_number = Codegen::CreateLoadNumber(value);

        llvm::Value* new_ans_number_not_precised = context.builder->CreateMul(ans_value_number, object_value_number);
        llvm::Value* new_ans_number = context.builder->CreateSDiv(new_ans_number_not_precised, context.builder->getInt64(PRECISION));

        Codegen::CreateStoreNumber(ans, new_ans_number);
    }

    return ans;
}

std::shared_ptr<Object> Subtract::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* Subtract::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();

    llvm::Value* ans = Codegen::CreateStoreNewNumber(0 * PRECISION);
    llvm::Value* value = nullptr;

    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        value = arguments[argument_idx]->Codegen({}, scope);
        Codegen::CreateObjectTypeCheck(value, ObjectType::TYPE_NUMBER);

        llvm::Value* ans_value_number = Codegen::CreateLoadNumber(ans);
        llvm::Value* object_value_number = Codegen::CreateLoadNumber(value);

        llvm::Value* new_ans_number = context.builder->CreateSub(ans_value_number, object_value_number);
        if (argument_idx == 0) {
            Codegen::CreateStoreNumber(ans, object_value_number);
        } else {
            Codegen::CreateStoreNumber(ans, new_ans_number);
        }
    }

    return ans;
}

std::shared_ptr<Object> Divide::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* Divide::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();

    llvm::Value* ans = Codegen::CreateStoreNewNumber(1 * PRECISION);
    llvm::Value* value = nullptr;

    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        value = arguments[argument_idx]->Codegen({}, scope);
        Codegen::CreateObjectTypeCheck(value, ObjectType::TYPE_NUMBER);

        llvm::Value* ans_value_number = Codegen::CreateLoadNumber(ans);
        llvm::Value* object_value_number_not_checked = Codegen::CreateLoadNumber(value);
        llvm::Value* object_value_number_checked = Codegen::CreateIsZeroThanOneCheck(object_value_number_not_checked);

        llvm::Value* ans_value_number_precised = context.builder->CreateMul(ans_value_number, context.builder->getInt64(PRECISION));
        llvm::Value* new_ans_number = context.builder->CreateSDiv(ans_value_number_precised, object_value_number_checked);
        if (argument_idx == 0) {
            Codegen::CreateStoreNumber(ans, object_value_number_not_checked);
        } else {
            Codegen::CreateStoreNumber(ans, new_ans_number);
        }
    }

    return ans;
}

std::shared_ptr<Object> Quotient::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

    std::shared_ptr<Object> ans = std::make_shared<Number>(lhs_value * PRECISION / (rhs_value != 0 ? rhs_value : 1));
    return ans;
}

llvm::Value* Quotient::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();

    if (arguments.size() != 2) {
        throw RuntimeError("Exactly 2 arguments required for \"Quotient\" function");
    }

    llvm::Value* lhs_value = arguments[0]->Codegen({}, scope);
    Codegen::CreateObjectTypeCheck(lhs_value, ObjectType::TYPE_NUMBER);

    llvm::Value* lhs_value_number = Codegen::CreateLoadNumber(lhs_value);
    Codegen::CreateIsIntegerCheck(lhs_value_number);

    llvm::Value* rhs_value = arguments[1]->Codegen({}, scope);
    Codegen::CreateObjectTypeCheck(rhs_value, ObjectType::TYPE_NUMBER);

    llvm::Value* rhs_value_number_not_checked = Codegen::CreateLoadNumber(rhs_value);
    Codegen::CreateIsIntegerCheck(rhs_value_number_not_checked);

    llvm::Value* rhs_value_number_checked = Codegen::CreateIsZeroThanOneCheck(rhs_value_number_not_checked);

    llvm::Value* lhs_value_number_precised = context.builder->CreateMul(lhs_value_number, context.builder->getInt64(PRECISION));
    llvm::Value* ans_value_number = context.builder->CreateSDiv(lhs_value_number_precised, rhs_value_number_checked);

    llvm::Value* ans = Codegen::CreateStoreNewNumber(ans_value_number);
    return ans;
}

std::shared_ptr<Object> Mod::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

    std::shared_ptr<Object> ans = std::make_shared<Number>(lhs_value % (rhs_value != 0 ? rhs_value : 1));
    return ans;
}

llvm::Value* Mod::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();

    if (arguments.size() != 2) {
        throw RuntimeError("Exactly 2 arguments required for \"Quotient\" function");
    }

    llvm::Value* lhs_value = arguments[0]->Codegen({}, scope);
    Codegen::CreateObjectTypeCheck(lhs_value, ObjectType::TYPE_NUMBER);

    llvm::Value* lhs_value_number = Codegen::CreateLoadNumber(lhs_value);
    Codegen::CreateIsIntegerCheck(lhs_value_number);

    llvm::Value* rhs_value = arguments[1]->Codegen({}, scope);
    Codegen::CreateObjectTypeCheck(rhs_value, ObjectType::TYPE_NUMBER);

    llvm::Value* rhs_value_number_not_checked = Codegen::CreateLoadNumber(rhs_value);
    Codegen::CreateIsIntegerCheck(rhs_value_number_not_checked);

    llvm::Value* rhs_value_number_checked = Codegen::CreateIsZeroThanOneCheck(rhs_value_number_not_checked);

    llvm::Value* ans_value_number = context.builder->CreateSRem(lhs_value_number, rhs_value_number_checked);

    llvm::Value* ans = Codegen::CreateStoreNewNumber(ans_value_number);
    return ans;
}

std::shared_ptr<Object> Expt::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* Expt::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();

    if (arguments.size() != 2) {
        throw RuntimeError("Exactly 2 arguments required for \"Expt\" function");
    }

    std::vector<llvm::Value*> function_call_arguments{};
    llvm::Value* value = arguments[0]->Codegen({}, scope);
    function_call_arguments.push_back(value);
    llvm::Value* power = arguments[1]->Codegen({}, scope);
    function_call_arguments.push_back(power);

    llvm::Function* function = context.llvm_module->getFunction("__GLExpt");
    llvm::Value* expt_return_value = context.builder->CreateAlloca(context.object_type, nullptr, "expt");
    context.builder->CreateStore(context.builder->CreateCall(function, function_call_arguments), expt_return_value);
    return expt_return_value;
}

std::shared_ptr<Object> Sqrt::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* Sqrt::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();

    if (arguments.size() != 1) {
        throw RuntimeError("Exactly 1 argument required for \"Sqrt\" function");
    }

    std::vector<llvm::Value*> function_call_arguments{};
    llvm::Value* value = arguments[0]->Codegen({}, scope);
    function_call_arguments.push_back(value);

    llvm::Function* function = context.llvm_module->getFunction("__GLSqrt");
    llvm::Value* sqrt_return_value = context.builder->CreateAlloca(context.object_type, nullptr, "sqrt");
    context.builder->CreateStore(context.builder->CreateCall(function, function_call_arguments), sqrt_return_value);
    return sqrt_return_value;
}

std::shared_ptr<Object> Max::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* Max::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

std::shared_ptr<Object> Min::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* Min::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("min unimplemented codegen");
}

std::shared_ptr<Object> Abs::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* Abs::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

std::shared_ptr<Object> Set::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
    if (arguments.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"Set\" function");
    }

    if (!Is<Symbol>(arguments[0])) {
        throw RuntimeError("\"Set\" error: first argument should be a variable name");
    }
    std::string name = As<Symbol>(arguments[0])->GetName();
    std::shared_ptr<Object> old_value = scope->GetVariableValueRecursive(name);  // to make sure the variable exists

    std::shared_ptr<Object> new_value = arguments[1]->Evaluate({}, scope);
    scope->SetVariableValue(name, new_value);
    return nullptr;
}

llvm::Value* Set::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    if (arguments.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"Set\" function");
    }

    if (!Is<Symbol>(arguments[0])) {
        throw RuntimeError("\"Set\" error: first argument should be a variable name");
    }
    std::string name = As<Symbol>(arguments[0])->GetName();
    llvm::Value* old_object = scope->GetVariableValueRecursiveCodegen(name);  // to make sure the variable exists

    llvm::Value* new_object = arguments[1]->Codegen({}, scope);
    scope->SetVariableValueCodegen(name, new_object);
    return nullptr;
}

std::shared_ptr<Object> If::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* If::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();

    if ((arguments.size() < 2) || (arguments.size() > 3)) {
        throw SyntaxError("Exactly 2 or 3 arguments required for \"If\" function");
    }

    auto& llvm_context = context.builder->getContext();
    llvm::Function* current_function = context.builder->GetInsertBlock()->getParent();
    llvm::BasicBlock* true_branch = llvm::BasicBlock::Create(llvm_context, "true_branch", current_function);
    llvm::BasicBlock* false_branch = nullptr;
    if (arguments.size() == 3) {
        false_branch = llvm::BasicBlock::Create(llvm_context, "false_branch", current_function);
    }
    llvm::BasicBlock* merge_branch = llvm::BasicBlock::Create(llvm_context, "merge_branch", current_function);

    llvm::Value* condition_value = arguments[0]->Codegen({}, scope);
    Codegen::CreateObjectTypeCheck(condition_value, ObjectType::TYPE_BOOLEAN);
    llvm::Value* condition_value_boolean = Codegen::CreateLoadBoolean(condition_value);

    // CONDITION CHECK
    if (arguments.size() == 3) {
        // if we have false branch
        context.builder->CreateCondBr(condition_value_boolean, true_branch, false_branch);
    } else {
        // if we don't have false branch
        context.builder->CreateCondBr(condition_value_boolean, true_branch, merge_branch);
    }
    llvm::Value* return_result = nullptr;

    // TRUE BRANCH
    context.builder->SetInsertPoint(true_branch);
    llvm::Value* true_branch_return_result = arguments[1]->Codegen({}, scope);
    context.builder->CreateBr(merge_branch);
    true_branch = context.builder->GetInsertBlock();

    // FALSE BRANCH
    llvm::Value* false_branch_return_result = nullptr;
    if (arguments.size() == 3) {
        context.builder->SetInsertPoint(false_branch);
        false_branch_return_result = arguments[2]->Codegen({}, scope);
        context.builder->CreateBr(merge_branch);
        false_branch = context.builder->GetInsertBlock();
    }

    // MERGE BRANCH
    context.builder->SetInsertPoint(merge_branch);

    llvm::PHINode* phi_node = nullptr;
    if (arguments.size() == 3) {
        // if we have false branch
        phi_node = context.builder->CreatePHI(context.builder->getInt8PtrTy(), 2);
        phi_node->addIncoming(true_branch_return_result, true_branch);
        phi_node->addIncoming(false_branch_return_result, false_branch);
    } else {
        // if we don't have false branch
        phi_node = context.builder->CreatePHI(context.builder->getInt8PtrTy(), 1);
        phi_node->addIncoming(true_branch_return_result, true_branch);
    }

    return phi_node;
}

std::shared_ptr<Object> While::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* While::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();

    if (arguments.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"While\" function");
    }

    auto& llvm_context = context.builder->getContext();
    llvm::Function* current_function = context.builder->GetInsertBlock()->getParent();
    llvm::BasicBlock* condition_branch = llvm::BasicBlock::Create(llvm_context, "condition_branch", current_function);
    llvm::BasicBlock* loop_branch = llvm::BasicBlock::Create(llvm_context, "loop_branch", current_function);
    llvm::BasicBlock* merge_branch = llvm::BasicBlock::Create(llvm_context, "merge_branch", current_function);

    context.builder->CreateBr(condition_branch);
    context.builder->SetInsertPoint(condition_branch);

    llvm::Value* condition_value = arguments[0]->Codegen({}, scope);
    Codegen::CreateObjectTypeCheck(condition_value, ObjectType::TYPE_BOOLEAN);
    llvm::Value* condition_value_boolean = Codegen::CreateLoadBoolean(condition_value);

    // CONDITION CHECK
    context.builder->CreateCondBr(condition_value_boolean, loop_branch, merge_branch);

    // LOOP BRANCH
    context.builder->SetInsertPoint(loop_branch);
    llvm::Value* loop_branch_return_result = arguments[1]->Codegen({}, scope);
    context.builder->CreateBr(condition_branch);
    loop_branch = context.builder->GetInsertBlock();

    // MERGE BRANCH
    context.builder->SetInsertPoint(merge_branch);
    return loop_branch_return_result;
}

std::shared_ptr<Object> Cons::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
    if (arguments.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"Cons\" function");
    }

    std::shared_ptr<Object> ans = std::make_shared<Cell>(nullptr, nullptr);
    As<Cell>(ans)->SetFirst(arguments[0]->Evaluate({}, scope));
    As<Cell>(ans)->SetSecond(arguments[1]->Evaluate({}, scope));
    return ans;
}

llvm::Value* Cons::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("cons unimplemented codegen");
}

std::shared_ptr<Object> Car::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* Car::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("car unimplemented codegen");
}

std::shared_ptr<Object> Cdr::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* Cdr::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("cdr unimplemented codegen");
}

std::shared_ptr<Object> SetCar::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* SetCar::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

std::shared_ptr<Object> SetCdr::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* SetCdr::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

std::shared_ptr<Object> List::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* List::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();

    llvm::Value* previous = nullptr;
    llvm::Value* current = Codegen::CreateStoreNewCell();
    llvm::Value* ans = current;
    llvm::Value* next = nullptr;

    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        llvm::Value* first = arguments[argument_idx]->Codegen({}, scope);
        Codegen::CreateStoreCellFirst(current, first);

        llvm::Value* next = Codegen::CreateStoreNewCell();
        Codegen::CreateStoreCellSecond(current, next);

        previous = current;
        current = next;
    }

    if (previous) {
        Codegen::CreateStoreCellSecond(previous, context.builder->getInt64(0));
    }

    return ans;
}

std::shared_ptr<Object> ListRef::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* ListRef::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

std::shared_ptr<Object> ListTail::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
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

llvm::Value* ListTail::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

std::shared_ptr<Object> Lambda::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
    std::shared_ptr<Scope> lambda_call_scope = std::make_shared<Scope>();
    lambda_call_scope->SetPreviousScope(scope);

    if (arguments_idx_to_name_.size() != arguments.size()) {
        throw RuntimeError("\"Lambda\" call error: wrong number of arguments passed");
    }

    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        std::string name = arguments_idx_to_name_[argument_idx];
        std::shared_ptr<Object> value = arguments[argument_idx]->Evaluate({}, scope);
        lambda_call_scope->SetVariableValue(name, value);
    }

    // Set variables before entering the function
    auto self_scope_variables = self_scope_->GetVariablesMap();
    for (auto& [name, value] : self_scope_variables) {
        if (!lambda_call_scope->GetVariableValueLocal(name).has_value()) {
            lambda_call_scope->SetVariableValue(name, value);
        }
    }

    std::shared_ptr<Object> ans = nullptr;
    for (size_t command_idx = 0; command_idx < commands_.size(); ++command_idx) {
        ans = commands_[command_idx]->Evaluate({}, lambda_call_scope);
    }

    // Update variables after finishing the function
    auto lambda_call_scope_variables = lambda_call_scope->GetVariablesMap();
    for (auto& [name, value] : lambda_call_scope_variables) {
        self_scope_->SetVariableValue(name, value);
    }
    return ans;
}

llvm::Value* Lambda::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();

    // std::shared_ptr<Scope> lambda_call_scope = std::make_shared<Scope>();
    // lambda_call_scope->SetPreviousScope(scope);

    // if (arguments_idx_to_name_.size() != arguments.size()) {
    //     throw RuntimeError("\"Lambda\" call error: wrong number of arguments passed");
    // }

    std::vector<llvm::Value*> function_call_arguments{};
    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        //std::string name = arguments_idx_to_name_[argument_idx];
        llvm::Value* value = arguments[argument_idx]->Codegen({}, scope);
        // TODO: take this away: in lambda's scope there will be %smth not from function
        // lambda_call_scope->SetVariableValueCodegen(name, value);
        function_call_arguments.push_back(value);
    }

    // Set variables before entering the function
    // auto self_scope_variables = self_scope_->GetVariablesMapCodegen();
    // for (auto& [name, value] : self_scope_variables) {
    //     if (!lambda_call_scope->GetVariableValueLocalCodegen(name).has_value()) {
    //         lambda_call_scope->SetVariableValueCodegen(name, value);
    //     }
    // }

    // FUNCTION CALL
    llvm::AllocaInst* function_returned_object = context.builder->CreateAlloca(context.object_type, nullptr, "function_returned");
    context.builder->CreateStore(context.builder->CreateCall(function_, function_call_arguments), function_returned_object);
    return function_returned_object;
    // FUNCTION CALL

    // TODO: implement that!!!
    // Update variables after finishing the function
    // auto lambda_call_scope_variables = lambda_call_scope->GetVariablesMap();
    // for (auto& [name, value] : lambda_call_scope_variables) {
    //     self_scope_->SetVariableValue(name, value);
    // }
}

std::shared_ptr<Object> Define::Evaluate(const std::vector<std::shared_ptr<Object>>& arguments,
    std::shared_ptr<Scope> scope) {
    if (arguments.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"Define\" function");
    }

    if (Is<Cell>(arguments[0])) {
        auto name_and_value = Interp::BuildLambdaSugar(arguments, scope);
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
        if (Is<Symbol>(maybe_lambda_keyword) && As<Symbol>(maybe_lambda_keyword)->GetName() == "lambda") {
            value = Interp::BuildLambda(As<Cell>(arguments[1])->GetSecond(), scope);
        } else {
            value = arguments[1]->Evaluate({}, scope);
        }
    } else {
        value = arguments[1]->Evaluate({}, scope);
    }
    scope->SetVariableValue(name, value);
    return nullptr;
}

llvm::Value* Define::Codegen(const std::vector<std::shared_ptr<Object>>& arguments, std::shared_ptr<Scope> scope, bool is_quote) {
    auto& context = Codegen::Context::Get();

    if (arguments.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"Define\" function");
    }

    if (Is<Cell>(arguments[0])) {
        // TODO: codegen lambda sugar part
        return nullptr;
    }

    if (!Is<Symbol>(arguments[0])) {
        throw RuntimeError("\"Define\" error: first argument should be a variable name or sugar like \"(f x y) (x + y)\"");
    }
    std::string name = As<Symbol>(arguments[0])->GetName();
    llvm::Value* object = nullptr;

    if (Is<Cell>(arguments[1])) {
        std::shared_ptr<Object> maybe_lambda_keyword = As<Cell>(arguments[1])->GetFirst();
        if (Is<Symbol>(maybe_lambda_keyword) && As<Symbol>(maybe_lambda_keyword)->GetName() == "lambda") {
            // WARNING: predefined_function === function, because we
            // predefine lambda before its body is filled, so we can use recursion





            // TODO: this is argument counter to create llvm::Function* to fill std::shared_ptr<Lambda>
            //// SO BAD CODE

            bool eval_immediately = false;
            std::vector<std::shared_ptr<Object>> bad_code_arguments = Interp::ListToVector(As<Cell>(arguments[1])->GetSecond());
            int temp_argument_counter = 0;
            std::shared_ptr<Cell> lambda_arg_init = As<Cell>(bad_code_arguments[0]);
            for (std::shared_ptr<Cell> cell = As<Cell>(lambda_arg_init); cell; cell = As<Cell>(cell->GetSecond())) {
                ++temp_argument_counter;
            }
            int arguments_count = eval_immediately ? 0 : temp_argument_counter;
            std::vector<llvm::Type*> new_function_arguments(arguments_count, context.builder->getInt8PtrTy());
            llvm::FunctionType* new_function_type = llvm::FunctionType::get(context.object_type, new_function_arguments, false);
            llvm::Function* new_function = llvm::Function::Create(new_function_type, llvm::Function::ExternalLinkage, "LambdaFunction", context.llvm_module.value());

            //// SO BAD CODE






            std::shared_ptr<Object> predefined_function = std::make_shared<Lambda>(new_function, nullptr);
            scope->SetVariableValue(name, predefined_function);
            auto function = Codegen::BuildLambdaCodegen(As<Cell>(arguments[1])->GetSecond(), scope, false, predefined_function);
            // scope->SetVariableValue(name, function);
            return nullptr;
        } else {
            object = arguments[1]->Codegen({}, scope);
        }
    } else {
        object = arguments[1]->Codegen({}, scope);
    }

    scope->SetVariableValueCodegen(name, object);
    return nullptr;
}