#include "object.hpp"

#include <helpers/helpers.hpp>
#include <scope/scope.hpp>
#include <lambda/lambda.hpp>

ObjectPtr Number::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    return shared_from_this();
}

llvm::Value* Number::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    return Codegen::CreateStoreNewNumber(value_);
}

ObjectPtr Symbol::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (is_quote) {
        return shared_from_this();
    }
    return scope->GetVariableValueRecursive(name_);
}

llvm::Value* Symbol::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (is_quote) {
        return Codegen::CreateStoreNewSymbol(name_);
    }
    return scope->GetVariableValueRecursiveCodegen(name_);
}

ObjectPtr Symbol::GetVariableInterp(ScopePtr scope) {
    ObjectPtr value = scope->GetVariableValueRecursive(name_);
    return value;
}

llvm::Value* Symbol::GetVariableCodegen(ScopePtr scope) {
    llvm::Value* object = scope->GetVariableValueRecursiveCodegen(name_);
    return object;
}

ObjectPtr Symbol::GetFunctionInterp(ScopePtr scope) {
    ObjectPtr value = scope->GetVariableFunctionRecursive(name_);
    return value;
}

ObjectPtr Boolean::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    return shared_from_this();
}

llvm::Value* Boolean::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    return Codegen::CreateStoreNewBoolean(value_);
}

ObjectPtr Cell::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (is_quote) {
        return shared_from_this();
    }
    
    if (!GetFirst()) {  // Empty list case
        return shared_from_this();
    }

    ObjectPtr first = GetFirst();
    ObjectPtr function = nullptr;

    if (Is<Quote>(first)) {
        // special case for '(smth) form of quote
        ObjectPtr function = first;
        std::vector<ObjectPtr> quote_arguments = Interp::ListToVector(GetSecond());
        return function->Evaluate(quote_arguments, scope);
    } else if (Is<Symbol>(first)) {
        if (As<Symbol>(first)->GetName() == "begin") {
            std::vector<ObjectPtr> commands = Interp::ListToVector(GetSecond());
            ObjectPtr return_value = nullptr;
            for (auto command : commands) {
                return_value = command->Evaluate({}, scope);
            }
            return return_value;
        }
        function = As<Symbol>(first)->GetFunctionInterp(scope);
    } else if (Interp::CheckIfCellIsLambda(first)) {
        std::shared_ptr<Cell> lambda_cell = As<Cell>(first);
        function = Interp::BuildLambda(std::nullopt, lambda_cell->GetSecond(), scope);
    } else {
        throw RuntimeError("Lists are not self evaliating, use \"quote\"");
    }
    std::vector<ObjectPtr> function_arguments = Interp::ListToVector(GetSecond());
    return function->Evaluate(function_arguments, scope);
}

llvm::Value* Cell::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    // TODO: quote case
    if (is_quote) {
        return nullptr;
    }
    
    // TODO: empty list case
    auto& context = Codegen::Context::Get();

    ObjectPtr first = GetFirst();
    ObjectPtr function = nullptr;

    if (Is<Quote>(first)) {
        // special case for '(smth) form of quote
        ObjectPtr function = first;
        std::vector<ObjectPtr> quote_arguments = Interp::ListToVector(GetSecond());
        return function->Codegen(quote_arguments, scope);
    } else if (Is<Symbol>(first)) {
        if (As<Symbol>(first)->GetName() == "begin") {
            std::vector<ObjectPtr> commands = Interp::ListToVector(GetSecond());
            llvm::Value* return_value = nullptr;
            for (auto command : commands) {
                return_value = command->Codegen({}, scope);
            }
            return return_value;
        }
        function = As<Symbol>(first)->GetFunctionInterp(scope);
    } else if (Is<Cell>(first)) {
        // in this case this is definetely lambda in-place call
        std::shared_ptr<Cell> lambda_cell = As<Cell>(first);
        std::shared_ptr<Symbol> maybe_lambda_keyword = As<Symbol>(lambda_cell->GetFirst());
        if (!maybe_lambda_keyword) {
            throw RuntimeError("Unknown cell first argument!");
        }
        if (maybe_lambda_keyword->GetName() == "lambda") {
            function = Codegen::BuildLambdaCodegen(std::nullopt, lambda_cell->GetSecond(), scope);
        }
    } else {
        throw RuntimeError("Lists are not self evaliating, use \"quote\"");
    }
    std::vector<ObjectPtr> function_arguments = Interp::ListToVector(GetSecond());
    return function->Codegen(function_arguments, scope);
}

ObjectPtr GLInit::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLInit\" function");
    }
    __GLInit();
    return nullptr;
}

llvm::Value* GLInit::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLInit\" function");
    }

    auto& context = Codegen::Context::Get();
    llvm::Function* function = context.llvm_module->getFunction("__GLInit");
    context.builder->CreateCall(function, {});
    return Codegen::CreateStoreNewCell();
}

ObjectPtr GLClear::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLClear\" function");
    }
    __GLClear();
    return nullptr;
}

llvm::Value* GLClear::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLClear\" function");
    }

    auto& context = Codegen::Context::Get();
    llvm::Function* function = context.llvm_module->getFunction("__GLClear");
    context.builder->CreateCall(function, {});
    return Codegen::CreateStoreNewCell();
}

ObjectPtr GLPutPixel::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 5) {
        throw SyntaxError("Exactly 5 arguments required for \"GLPutPixel\" function");
    }

    ObjectPtr x_object = arguments[0]->Evaluate({}, scope);
    ObjectPtr y_object = arguments[1]->Evaluate({}, scope);
    ObjectPtr r_object = arguments[2]->Evaluate({}, scope);
    ObjectPtr g_object = arguments[3]->Evaluate({}, scope);
    ObjectPtr b_object = arguments[4]->Evaluate({}, scope);

    SchemeObject* x_scheme_object = new SchemeObject;
    x_scheme_object->type = ObjectType::TYPE_NUMBER;
    x_scheme_object->number = As<Number>(x_object)->GetValue();

    SchemeObject* y_scheme_object = new SchemeObject;
    y_scheme_object->type = ObjectType::TYPE_NUMBER;
    y_scheme_object->number = As<Number>(y_object)->GetValue();

    SchemeObject* r_scheme_object = new SchemeObject;
    r_scheme_object->type = ObjectType::TYPE_NUMBER;
    r_scheme_object->number = As<Number>(r_object)->GetValue();

    SchemeObject* g_scheme_object = new SchemeObject;
    g_scheme_object->type = ObjectType::TYPE_NUMBER;
    g_scheme_object->number = As<Number>(g_object)->GetValue();

    SchemeObject* b_scheme_object = new SchemeObject;
    b_scheme_object->type = ObjectType::TYPE_NUMBER;
    b_scheme_object->number = As<Number>(b_object)->GetValue();

    __GLPutPixel(
        x_scheme_object, 
        y_scheme_object,
        r_scheme_object,
        g_scheme_object,
        b_scheme_object
    );
    return nullptr;
}

llvm::Value* GLPutPixel::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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
    return Codegen::CreateStoreNewCell();
}

ObjectPtr GLIsOpen::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLIsOpen\" function");
    }
    return __GLIsOpen().boolean ? std::make_shared<Boolean>(true)
        : std::make_shared<Boolean>(false);
}

llvm::Value* GLIsOpen::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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

ObjectPtr GLDraw::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLDraw\" function");
    }
    __GLDraw();
    return nullptr;
}

llvm::Value* GLDraw::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLDraw\" function");
    }

    auto& context = Codegen::Context::Get();
    llvm::Function* function = context.llvm_module->getFunction("__GLDraw");
    context.builder->CreateCall(function, {});
    return Codegen::CreateStoreNewCell();
}

ObjectPtr GLFinish::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLFinish\" function");
    }
    __GLFinish();
    return nullptr;
}

llvm::Value* GLFinish::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 0) {
        throw SyntaxError("No arguments required for \"GLFinish\" function");
    }

    auto& context = Codegen::Context::Get();
    llvm::Function* function = context.llvm_module->getFunction("__GLFinish");
    context.builder->CreateCall(function, {});
    return Codegen::CreateStoreNewCell();
}

ObjectPtr Print::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"Print\" function");
    }
    ObjectPtr object = arguments[0]->Evaluate({}, scope);
    std::cout << "Print: " << Interp::ObjectToString(object) << std::endl;
    return object;
}

llvm::Value* Print::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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

ObjectPtr IsBoolean::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"IsBoolean\" function");
    }
    ObjectPtr value = arguments[0]->Evaluate({}, scope);
    return Is<Boolean>(value) ? std::make_shared<Boolean>(true)
        : std::make_shared<Boolean>(false);
}

llvm::Value* IsBoolean::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"IsBoolean\" function");
    }

    auto& context = Codegen::Context::Get();
    auto& llvm_context = context.llvm_context.value();

    llvm::Function* current_function = context.builder->GetInsertBlock()->getParent();
    llvm::BasicBlock* true_branch = llvm::BasicBlock::Create(llvm_context, "true_branch", current_function);
    llvm::BasicBlock* false_branch = llvm::BasicBlock::Create(llvm_context, "false_branch", current_function);
    llvm::BasicBlock* merge_branch = llvm::BasicBlock::Create(llvm_context, "merge_branch", current_function);

    llvm::Value* object = arguments[0]->Codegen({}, scope);
    Codegen::CreateObjectTypeCheck(object, ObjectType::TYPE_BOOLEAN, true_branch, false_branch);

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

ObjectPtr IsNumber::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"IsNumber\" function");
    }
    ObjectPtr value = arguments[0]->Evaluate({}, scope);
    return Is<Number>(value) ? std::make_shared<Boolean>(true)
        : std::make_shared<Boolean>(false);
}

llvm::Value* IsNumber::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"IsBoolean\" function");
    }

    auto& context = Codegen::Context::Get();
    auto& llvm_context = context.llvm_context.value();

    llvm::Function* current_function = context.builder->GetInsertBlock()->getParent();
    llvm::BasicBlock* true_branch = llvm::BasicBlock::Create(llvm_context, "true_branch", current_function);
    llvm::BasicBlock* false_branch = llvm::BasicBlock::Create(llvm_context, "false_branch", current_function);
    llvm::BasicBlock* merge_branch = llvm::BasicBlock::Create(llvm_context, "merge_branch", current_function);

    llvm::Value* object = arguments[0]->Codegen({}, scope);
    Codegen::CreateObjectTypeCheck(object, ObjectType::TYPE_NUMBER, true_branch, false_branch);

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

ObjectPtr IsSymbol::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"IsSymbol\" function");
    }
    ObjectPtr value = arguments[0]->Evaluate({}, scope);
    return Is<Symbol>(value) ? std::make_shared<Boolean>(true)
        : std::make_shared<Boolean>(false);
}

llvm::Value* IsSymbol::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"IsBoolean\" function");
    }

    auto& context = Codegen::Context::Get();
    auto& llvm_context = context.llvm_context.value();

    llvm::Function* current_function = context.builder->GetInsertBlock()->getParent();
    llvm::BasicBlock* true_branch = llvm::BasicBlock::Create(llvm_context, "true_branch", current_function);
    llvm::BasicBlock* false_branch = llvm::BasicBlock::Create(llvm_context, "false_branch", current_function);
    llvm::BasicBlock* merge_branch = llvm::BasicBlock::Create(llvm_context, "merge_branch", current_function);

    llvm::Value* object = arguments[0]->Codegen({}, scope);
    Codegen::CreateObjectTypeCheck(object, ObjectType::TYPE_SYMBOL, true_branch, false_branch);

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

ObjectPtr IsPair::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"IsPair\" function");
    }
    ObjectPtr value = arguments[0]->Evaluate({}, scope);

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

llvm::Value* IsPair::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

ObjectPtr IsNull::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"IsNull\" function");
    }
    ObjectPtr value = arguments[0]->Evaluate({}, scope);

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

llvm::Value* IsNull::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    throw std::runtime_error("null? codegen unimplemented");
}

ObjectPtr IsList::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"IsList\" function");
    }
    ObjectPtr value = arguments[0]->Evaluate({}, scope);

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

llvm::Value* IsList::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    throw std::runtime_error("list? codegen unimplemented");
}

ObjectPtr Quote::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.empty()) {
        return std::make_shared<Cell>(nullptr, nullptr);
    }
    if (arguments.size() > 1) {
        throw SyntaxError("Exactly 1 argument (list) required for \"Quote\" function");
    }
    return arguments[0]->Evaluate({}, scope, true);
}

llvm::Value* Quote::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.empty()) {
        // TODO: return empty cell
        return nullptr;
    }
    if (arguments.size() > 1) {
        throw SyntaxError("Exactly 1 argument (list) required for \"Quote\" function");
    }
    return arguments[0]->Codegen({}, scope, true);
}

ObjectPtr Not::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 1) {
        throw RuntimeError("Exactly 1 argument required for \"Not\" function");
    }
    ObjectPtr value = arguments[0]->Evaluate({}, scope);

    if (Is<Boolean>(value)) {
        return As<Boolean>(value)->GetValue() ? std::make_shared<Boolean>(false)
            : std::make_shared<Boolean>(true);
    }
    return std::make_shared<Boolean>(false);
}

llvm::Value* Not::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

ObjectPtr And::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    ObjectPtr ans = std::make_shared<Boolean>(true);
    ObjectPtr value = nullptr;

    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        value = arguments[argument_idx]->Evaluate({}, scope);
        ans = value;
        if (Is<Boolean>(value) && (As<Boolean>(value)->GetValue() == false)) {
            break;
        }
    }

    return ans;
}

llvm::Value* And::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    auto& context = Codegen::Context::Get();
    auto old_branch = context.builder->GetInsertBlock();

    auto& llvm_context = context.llvm_context.value();
    llvm::Function* current_function = context.builder->GetInsertBlock()->getParent();
    llvm::BasicBlock* end_branch = llvm::BasicBlock::Create(llvm_context, "end_branch", current_function);

    llvm::Value* value = nullptr;
    llvm::BasicBlock* continue_branch = old_branch;

    std::vector<Codegen::PairValueBB> incoming_values_for_phi_node;

    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        value = arguments[argument_idx]->Codegen({}, scope);

        continue_branch = llvm::BasicBlock::Create(llvm_context, "continue_branch", current_function);
        std::vector<Codegen::PairValueBB> new_incoming_values_for_phi_node = Codegen::CreateIsBooleanSmthThenBranch<false>(value, continue_branch, end_branch);
        incoming_values_for_phi_node.push_back(new_incoming_values_for_phi_node[0]);
        if (argument_idx + 1 == arguments.size()) {
            // Adding value only from the very last "continue_branch" to the final phi node
            incoming_values_for_phi_node.push_back(new_incoming_values_for_phi_node[1]);
        }
    }

    context.builder->CreateBr(end_branch);
    context.builder->SetInsertPoint(end_branch);

    if (incoming_values_for_phi_node.empty()) {
        return Codegen::CreateStoreNewBoolean(true);
    }

    llvm::PHINode* phi_node = context.builder->CreatePHI(context.builder->getInt8PtrTy(), incoming_values_for_phi_node.size());
    for (auto incoming_value_for_phi_node : incoming_values_for_phi_node) {
        phi_node->addIncoming(incoming_value_for_phi_node.first, incoming_value_for_phi_node.second);
    }
    return phi_node;
}

ObjectPtr Or::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    ObjectPtr ans = std::make_shared<Boolean>(false);
    ObjectPtr value = nullptr;
    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        value = arguments[argument_idx]->Evaluate({}, scope);
        ans = value;
        if (Is<Boolean>(value) && (As<Boolean>(value)->GetValue() == true)) {
            break;
        }
    }
    return ans;
}

llvm::Value* Or::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    auto& context = Codegen::Context::Get();
    auto old_branch = context.builder->GetInsertBlock();

    auto& llvm_context = context.llvm_context.value();
    llvm::Function* current_function = context.builder->GetInsertBlock()->getParent();
    llvm::BasicBlock* end_branch = llvm::BasicBlock::Create(llvm_context, "end_branch", current_function);

    llvm::Value* value = nullptr;
    llvm::BasicBlock* continue_branch = old_branch;

    std::vector<Codegen::PairValueBB> incoming_values_for_phi_node;

    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        value = arguments[argument_idx]->Codegen({}, scope);

        continue_branch = llvm::BasicBlock::Create(llvm_context, "continue_branch", current_function);
        std::vector<Codegen::PairValueBB> new_incoming_values_for_phi_node = Codegen::CreateIsBooleanSmthThenBranch<true>(value, continue_branch, end_branch);
        incoming_values_for_phi_node.push_back(new_incoming_values_for_phi_node[0]);
        if (argument_idx + 1 == arguments.size()) {
            // Adding value only from the very last "continue_branch" to the final phi node
            incoming_values_for_phi_node.push_back(new_incoming_values_for_phi_node[1]);
        }
    }

    context.builder->CreateBr(end_branch);
    context.builder->SetInsertPoint(end_branch);

    if (incoming_values_for_phi_node.empty()) {
        return Codegen::CreateStoreNewBoolean(false);
    }

    llvm::PHINode* phi_node = context.builder->CreatePHI(context.builder->getInt8PtrTy(), incoming_values_for_phi_node.size());
    for (auto incoming_value_for_phi_node : incoming_values_for_phi_node) {
        phi_node->addIncoming(incoming_value_for_phi_node.first, incoming_value_for_phi_node.second);
    }
    return phi_node;
}

ObjectPtr Equal::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    ObjectPtr ans = std::make_shared<Boolean>(true);

    ObjectPtr last_value = nullptr;
    ObjectPtr value = nullptr;

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

llvm::Value* Equal::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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
        comparison_branch = context.builder->GetInsertBlock();

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

ObjectPtr Greater::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    ObjectPtr ans = std::make_shared<Boolean>(true);

    ObjectPtr last_value = nullptr;
    ObjectPtr value = nullptr;

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

llvm::Value* Greater::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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
        comparison_branch = context.builder->GetInsertBlock();

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

ObjectPtr GreaterEqual::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    ObjectPtr ans = std::make_shared<Boolean>(true);

    ObjectPtr last_value = nullptr;
    ObjectPtr value = nullptr;

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

llvm::Value* GreaterEqual::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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
        comparison_branch = context.builder->GetInsertBlock();

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

ObjectPtr Less::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    ObjectPtr ans = std::make_shared<Boolean>(true);

    ObjectPtr last_value = nullptr;
    ObjectPtr value = nullptr;

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

llvm::Value* Less::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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
        comparison_branch = context.builder->GetInsertBlock();

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

ObjectPtr LessEqual::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    ObjectPtr ans = std::make_shared<Boolean>(true);

    ObjectPtr last_value = nullptr;
    ObjectPtr value = nullptr;

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

llvm::Value* LessEqual::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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
        comparison_branch = context.builder->GetInsertBlock();

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

ObjectPtr Add::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    ObjectPtr ans = std::make_shared<Number>(0 * PRECISION);
    ObjectPtr value = nullptr;

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

llvm::Value* Add::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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

ObjectPtr Multiply::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    ObjectPtr ans = std::make_shared<Number>(1 * PRECISION);
    ObjectPtr value = nullptr;

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

llvm::Value* Multiply::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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

ObjectPtr Subtract::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() <= 1) {
        throw RuntimeError("More than 1 argument required for \"Subtract\" function");
    }
    ObjectPtr ans = std::make_shared<Number>(0 * PRECISION);
    ObjectPtr value = nullptr;

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

llvm::Value* Subtract::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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

ObjectPtr Divide::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() <= 1) {
        throw RuntimeError("More than 1 argument required for \"Divide\" function");
    }
    ObjectPtr ans = std::make_shared<Number>(1 * PRECISION);
    ObjectPtr value = nullptr;

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

llvm::Value* Divide::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    auto& context = Codegen::Context::Get();

    llvm::Value* ans = Codegen::CreateStoreNewNumber(1 * PRECISION);
    llvm::Value* value = nullptr;

    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        value = arguments[argument_idx]->Codegen({}, scope);
        Codegen::CreateObjectTypeCheck(value, ObjectType::TYPE_NUMBER);

        llvm::Value* ans_value_number = Codegen::CreateLoadNumber(ans);
        llvm::Value* object_value_number_not_checked = Codegen::CreateLoadNumber(value);
        llvm::Value* object_value_number_checked = Codegen::CreateIsZeroThenOneCheck(object_value_number_not_checked);

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

ObjectPtr Quotient::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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

    ObjectPtr ans = std::make_shared<Number>(lhs_value * PRECISION / (rhs_value != 0 ? rhs_value : 1));
    return ans;
}

llvm::Value* Quotient::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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

    llvm::Value* rhs_value_number_checked = Codegen::CreateIsZeroThenOneCheck(rhs_value_number_not_checked);

    llvm::Value* lhs_value_number_precised = context.builder->CreateMul(lhs_value_number, context.builder->getInt64(PRECISION));
    llvm::Value* ans_value_number = context.builder->CreateSDiv(lhs_value_number_precised, rhs_value_number_checked);

    llvm::Value* ans = Codegen::CreateStoreNewNumber(ans_value_number);
    return ans;
}

ObjectPtr Mod::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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

    ObjectPtr ans = std::make_shared<Number>(lhs_value % (rhs_value != 0 ? rhs_value : 1));
    return ans;
}

llvm::Value* Mod::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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

    llvm::Value* rhs_value_number_checked = Codegen::CreateIsZeroThenOneCheck(rhs_value_number_not_checked);

    llvm::Value* ans_value_number = context.builder->CreateSRem(lhs_value_number, rhs_value_number_checked);

    llvm::Value* ans = Codegen::CreateStoreNewNumber(ans_value_number);
    return ans;
}

ObjectPtr Expt::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 2) {
        throw RuntimeError("Exactly 2 arguments required for \"Expt\" function");
    }
    ObjectPtr value = arguments[0]->Evaluate({}, scope);
    ObjectPtr power = arguments[1]->Evaluate({}, scope);

    if (!Is<Number>(value)) {
        throw RuntimeError("\"Expt\" error: not a number given for lhs");
    }
    double value_number = static_cast<double>(As<Number>(value)->GetValue()) / PRECISION;

    if (!Is<Number>(power)) {
        throw RuntimeError("\"Expt\" error: not a number given for rhs");
    }
    double power_number = static_cast<double>(As<Number>(power)->GetValue()) / PRECISION;

    ObjectPtr ans = std::make_shared<Number>(std::pow(value_number, power_number) * PRECISION);
    return ans;
}

llvm::Value* Expt::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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

ObjectPtr Sqrt::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 1) {
        throw RuntimeError("Exactly 1 argument required for \"Sqrt\" function");
    }
    ObjectPtr value = arguments[0]->Evaluate({}, scope);

    if (!Is<Number>(value)) {
        throw RuntimeError("\"Sqrt\" error: not a number given");
    }
    double value_number = static_cast<double>(As<Number>(value)->GetValue()) / PRECISION;

    ObjectPtr ans = std::make_shared<Number>(std::sqrt(value_number) * PRECISION);
    return ans;
}

llvm::Value* Sqrt::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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

ObjectPtr Max::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.empty()) {
        throw RuntimeError("At least 1 argument required for \"Max\" function");
    }
    ObjectPtr ans = nullptr;
    ObjectPtr value = nullptr;

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

llvm::Value* Max::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

ObjectPtr Min::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.empty()) {
        throw RuntimeError("At least 1 argument required for \"Min\" function");
    }
    ObjectPtr ans = nullptr;
    ObjectPtr value = nullptr;

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

llvm::Value* Min::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    throw std::runtime_error("min unimplemented codegen");
}

ObjectPtr Abs::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 1) {
        throw RuntimeError("Exactly 1 argument required for \"Abs\" function");
    }
    ObjectPtr ans = nullptr;
    ObjectPtr value = nullptr;

    value = arguments[0]->Evaluate({}, scope);
    if (!Is<Number>(value)) {
        throw RuntimeError("\"Abs\" error: not a number given");
    }

    int64_t new_number = As<Number>(value)->GetValue();
    new_number = abs(new_number);
    ans = std::make_shared<Number>(new_number);

    return ans;
}

llvm::Value* Abs::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

ObjectPtr Set::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"Set\" function");
    }

    if (!Is<Symbol>(arguments[0])) {
        throw RuntimeError("\"Set\" error: first argument should be a variable name");
    }
    std::string name = As<Symbol>(arguments[0])->GetName();
    ObjectPtr old_value = scope->GetVariableValueRecursive(name);  // to make sure the variable exists

    ObjectPtr new_value = arguments[1]->Evaluate({}, scope);
    scope->SetVariableValue(name, new_value, false);
    return new_value;
}

llvm::Value* Set::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"Set\" function");
    }

    if (!Is<Symbol>(arguments[0])) {
        throw RuntimeError("\"Set\" error: first argument should be a variable name");
    }
    std::string name = As<Symbol>(arguments[0])->GetName();
    llvm::Value* old_object = scope->GetVariableValueRecursiveCodegen(name);  // to make sure the variable exists

    llvm::Value* new_object = arguments[1]->Codegen({}, scope);
    scope->SetVariableValueCodegen(name, new_object, false);
    return new_object;
}

ObjectPtr If::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if ((arguments.size() < 2) || (arguments.size() > 3)) {
        throw SyntaxError("Exactly 2 or 3 arguments required for \"If\" function");
    }

    ObjectPtr condition = arguments[0]->Evaluate({}, scope);
    if (!Is<Boolean>(condition)) {
        throw RuntimeError("\"If\" error: condition is not Boolean");
    }

    if (As<Boolean>(condition)->GetValue()) {
        return arguments[1]->Evaluate({}, scope);
    } 

    if (arguments.size() == 3) {
        return arguments[2]->Evaluate({}, scope);
    }
    return nullptr;
}

llvm::Value* If::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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

ObjectPtr While::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"While\" function");
    }

    ObjectPtr condition = arguments[0]->Evaluate({}, scope);
    if (!Is<Boolean>(condition)) {
        throw RuntimeError("\"While\" error: condition is not Boolean");
    }

    ObjectPtr result;
    while (As<Boolean>(condition)->GetValue()) {
        result = arguments[1]->Evaluate({}, scope);
        condition = arguments[0]->Evaluate({}, scope);
    }
    return result;
}

llvm::Value* While::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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
    
    Codegen::CreateStackSave();
    llvm::Value* loop_branch_return_result = arguments[1]->Codegen({}, scope);
    Codegen::CreateStackRestore();

    context.builder->CreateBr(condition_branch);
    loop_branch = context.builder->GetInsertBlock();

    // MERGE BRANCH
    context.builder->SetInsertPoint(merge_branch);
    return loop_branch_return_result;
}

ObjectPtr Cons::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"Cons\" function");
    }

    ObjectPtr ans = std::make_shared<Cell>(nullptr, nullptr);
    As<Cell>(ans)->SetFirst(arguments[0]->Evaluate({}, scope));
    As<Cell>(ans)->SetSecond(arguments[1]->Evaluate({}, scope));
    return ans;
}

llvm::Value* Cons::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    throw std::runtime_error("cons unimplemented codegen");
}

ObjectPtr Car::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"Car\" function");
    }

    ObjectPtr value = arguments[0]->Evaluate({}, scope);
    ObjectPtr ans = value;
    if (Is<Cell>(value)) {
        ans = As<Cell>(value)->GetFirst();
    }
    return ans;
}

llvm::Value* Car::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    throw std::runtime_error("car unimplemented codegen");
}

ObjectPtr Cdr::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 1) {
        throw SyntaxError("Exactly 1 argument required for \"Cdr\" function");
    }

    ObjectPtr value = arguments[0]->Evaluate({}, scope);
    ObjectPtr ans = nullptr;
    if (Is<Cell>(value)) {
        ans = As<Cell>(value)->GetSecond();
    }
    return ans;
}

llvm::Value* Cdr::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    throw std::runtime_error("cdr unimplemented codegen");
}

ObjectPtr SetCar::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"SetCar\" function");
    }

    ObjectPtr source = arguments[0]->Evaluate({}, scope);
    if (!Is<Cell>(source)) {
        throw RuntimeError("\"SetCar\" error: not a pair or list given");
    }
    ObjectPtr value = arguments[1]->Evaluate({}, scope);
    As<Cell>(source)->SetFirst(value);
    return nullptr;
}

llvm::Value* SetCar::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

ObjectPtr SetCdr::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"SetCdr\" function");
    }

    ObjectPtr source = arguments[0]->Evaluate({}, scope);
    if (!Is<Cell>(source)) {
        throw RuntimeError("\"SetCdr\" error: not a pair or list given");
    }
    ObjectPtr value = arguments[1]->Evaluate({}, scope);
    As<Cell>(source)->SetSecond(value);
    return nullptr;
}

llvm::Value* SetCdr::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

ObjectPtr List::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    ObjectPtr previous = nullptr;
    ObjectPtr current = std::make_shared<Cell>(nullptr, nullptr);
    ObjectPtr ans = current;
    ObjectPtr next = nullptr;

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

llvm::Value* List::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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

ObjectPtr ListRef::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"ListRef\" function");
    }

    ObjectPtr init = arguments[0]->Evaluate({}, scope);
    ObjectPtr idx = arguments[1]->Evaluate({}, scope);
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

llvm::Value* ListRef::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

ObjectPtr ListTail::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"ListTail\" function");
    }
    ObjectPtr init = arguments[0]->Evaluate({}, scope);
    ObjectPtr idx = arguments[1]->Evaluate({}, scope);
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

llvm::Value* ListTail::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    throw std::runtime_error("Ignoring by now, TODO later");
}

ObjectPtr LambdaInterp::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    ScopePtr lambda_call_scope = std::make_shared<Scope>();
    lambda_call_scope->SetPreviousScope(scope);

    if (arguments_idx_to_name_.size() != arguments.size()) {
        throw RuntimeError("\"Lambda\" call error: wrong number of arguments passed");
    }

    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        std::string name = arguments_idx_to_name_[argument_idx];
        ObjectPtr value = arguments[argument_idx]->Evaluate({}, scope);
        lambda_call_scope->SetVariableValue(name, value, true);
    }

    // Set variables before entering the function
    // auto lambda_self_scope_variables = lambda_self_scope_->GetVariableValueMap();
    // for (auto& [name, value] : lambda_self_scope_variables) {
    //     if (!lambda_call_scope->GetVariableValueLocal(name).has_value()) {
    //         lambda_call_scope->SetVariableValue(name, value);
    //     }
    // }

    ObjectPtr return_value = nullptr;
    for (size_t command_idx = 0; command_idx < commands_.size(); ++command_idx) {
        // if the very last cell in lambda is also a lambda
        // then we should build generator function and proxy call
        if (command_idx + 1 == commands_.size() && Interp::CheckIfCellIsLambda(commands_[command_idx])) {
            std::cout << "last command lambda found" << std::endl;
            std::shared_ptr<Cell> lambda_cell = As<Cell>(commands_[command_idx]);
            ObjectPtr function = Interp::BuildLambda(std::nullopt, lambda_cell->GetSecond(), scope);
            return_value = function;
        } else {
            return_value = commands_[command_idx]->Evaluate({}, lambda_call_scope);
        }
    }

    // Update variables after finishing the function
    // auto lambda_call_scope_variables = lambda_call_scope->GetVariableValueMap();
    // for (auto& [name, value] : lambda_call_scope_variables) {
    //     lambda_self_scope_->SetVariableValue(name, value);
    // }
    return return_value;
}

llvm::Value* LambdaCodegen::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    auto& context = Codegen::Context::Get();

    std::vector<llvm::Value*> function_call_arguments{};
    for (size_t argument_idx = 0; argument_idx < arguments.size(); ++argument_idx) {
        llvm::Value* value = arguments[argument_idx]->Codegen({}, scope);
        function_call_arguments.push_back(value);
    }

    llvm::AllocaInst* function_returned_object = context.builder->CreateAlloca(context.object_type, nullptr, "function_returned");
    Codegen::CreateStackSave();
    context.builder->CreateStore(context.builder->CreateCall(function_, function_call_arguments), function_returned_object);
    Codegen::CreateStackRestore();

    return function_returned_object;
}

ObjectPtr Define::Evaluate(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
    if (arguments.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"Define\" function");
    }

    if (Is<Cell>(arguments[0])) {
        auto name_and_value = Interp::BuildLambdaSugar(arguments, scope);
        scope->SetVariableFunction(name_and_value.first, name_and_value.second);
        return nullptr;
    }
    if (!Is<Symbol>(arguments[0])) {
        throw RuntimeError("\"Define\" error: first argument should be a variable name or sugar like \"(f x y) (x + y)\"");
    }
    std::string name = As<Symbol>(arguments[0])->GetName();

    if (Is<Cell>(arguments[1])) {
        ObjectPtr maybe_lambda_keyword = As<Cell>(arguments[1])->GetFirst();
        if (Is<Symbol>(maybe_lambda_keyword) && As<Symbol>(maybe_lambda_keyword)->GetName() == "lambda") {
            ObjectPtr function = Interp::BuildLambda(name, As<Cell>(arguments[1])->GetSecond(), scope);
            scope->SetVariableFunction(name, function);
            return nullptr;
        }
        // if it is not lambda, then is function (maybe even lambda) call
        // scope->SetVariableFunctionCall(name, arguments[1], true);
        ObjectPtr value = arguments[1]->Evaluate({}, scope);
        scope->SetVariableValue(name, value, true);
    } else {
        ObjectPtr value = arguments[1]->Evaluate({}, scope);
        scope->SetVariableValue(name, value, true);
    }

    return nullptr;
}

llvm::Value* Define::Codegen(const std::vector<ObjectPtr>& arguments, ScopePtr scope, bool is_quote) {
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

    if (Is<Cell>(arguments[1])) {
        ObjectPtr maybe_lambda_keyword = As<Cell>(arguments[1])->GetFirst();
        if (Is<Symbol>(maybe_lambda_keyword) && As<Symbol>(maybe_lambda_keyword)->GetName() == "lambda") {
            ObjectPtr function = Codegen::BuildLambdaCodegen(name, As<Cell>(arguments[1])->GetSecond(), scope);
            scope->SetVariableFunction(name, function);
            return nullptr;
        }
        // if it is not lambda, then is function (maybe even lambda) call
        // scope->SetVariableFunctionCall(name, arguments[1], true);
        llvm::Value* value = arguments[1]->Codegen({}, scope);
        scope->SetVariableValueCodegen(name, value, true);
    } else {
        llvm::Value* value = arguments[1]->Codegen({}, scope);
        scope->SetVariableValueCodegen(name, value, true);
    }

    return nullptr;
}