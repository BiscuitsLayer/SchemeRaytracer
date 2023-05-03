#include "lambda.hpp"

namespace Interp {

ObjectPtr BuildLambda(std::optional<std::string> name, ObjectPtr init, ScopePtr scope, bool eval_immediately) {
    std::vector<ObjectPtr> arguments = Interp::ListToVector(init);

    std::vector<ObjectPtr> commands{};
    std::vector<std::string> arguments_idx_to_name{};

    if (arguments.size() < 2) {
        throw SyntaxError("More than 1 argument required for \"BuildLambda\" function");
    }

    int64_t argument_idx = 0;

    if (!eval_immediately) {
        // Handle lambda arguments
        if (arguments[argument_idx] && !Is<Cell>(arguments[argument_idx]) && !eval_immediately) {
            throw RuntimeError("\"BuildLambda\" error: first argument (lambda arguments) is not a list");
        }

        std::shared_ptr<Cell> lambda_arg_init = As<Cell>(arguments[argument_idx]);
        for (std::shared_ptr<Cell> cell = As<Cell>(lambda_arg_init); cell;
            cell = As<Cell>(cell->GetSecond())) {
            if (!Is<Symbol>(cell->GetFirst())) {
                throw RuntimeError("\"BuildLambda\" error: first argument (lambda arguments): not a symbol met");
            }
            std::string argument_name = As<Symbol>(cell->GetFirst())->GetName();
            arguments_idx_to_name.push_back(argument_name);
        }

        // Prepare for lambda body
        ++argument_idx;
    }

    // Handle lambda body
    if (!Is<Cell>(arguments[argument_idx])) {
        throw RuntimeError("\"Lambda\" error: second argument (body) is not a list");
    }

    for (; argument_idx < arguments.size(); ++argument_idx) {
        commands.push_back(arguments[argument_idx]);
    }

    if (eval_immediately) {
        // If we evaluate immediately, this means we are using "begin" keyword and don't need a new scope
        return std::make_shared<LambdaInterp>(commands, arguments_idx_to_name, scope);
    }
    
    // // If we do not evaluate immediately, we create a new scope and fill with variables
    // auto scope_variables = scope->GetVariableValueMap();
    ScopePtr lambda_self_scope = std::make_shared<Scope>();
    // for (auto& [name, value] : scope_variables) {
    //     lambda_self_scope->SetVariableValue(name, value);
    // }
    return std::make_shared<LambdaInterp>(commands, arguments_idx_to_name, lambda_self_scope);
}

std::pair<std::string, ObjectPtr> BuildLambdaSugar(std::vector<ObjectPtr> parts, ScopePtr scope) {
    if (parts.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"BuildLambdaSugar\" function");
    }

    std::vector<ObjectPtr> arguments = Interp::ListToVector(parts[0]);
    ObjectPtr command = parts[1];

    std::vector<ObjectPtr> commands{};
    std::vector<std::string> arguments_idx_to_name{};

    std::string lambda_name = As<Symbol>(arguments[0])->GetName();
    for (size_t argument_idx = 1; argument_idx < arguments.size(); ++argument_idx) {
        if (!Is<Symbol>(arguments[argument_idx])) {
            throw SyntaxError("\"BuildLambdaSugar\" function error: argument passed is not a symbol");
        }
        std::string argument_name = As<Symbol>(arguments[argument_idx])->GetName();
        arguments_idx_to_name.push_back(argument_name);
    }
    commands.push_back(command);

    ScopePtr lambda_self_scope = std::make_shared<Scope>();
    // auto scope_variables = scope->GetVariableValueMap();
    // for (auto& [name, value] : scope_variables) {
    //     lambda_self_scope->SetVariableValue(name, value);
    // }

    return std::make_pair(lambda_name, std::make_shared<LambdaInterp>(commands, arguments_idx_to_name, lambda_self_scope));
}

} // namespace Interp

namespace Codegen {

ObjectPtr BuildLambdaCodegen(std::optional<std::string> name, ObjectPtr init, ScopePtr scope, bool eval_immediately) {
    auto& context = Codegen::Context::Get();

    std::vector<ObjectPtr> arguments = Interp::ListToVector(init);
    ScopePtr lambda_call_and_self_scope = std::make_shared<Scope>();
    lambda_call_and_self_scope->SetPreviousScope(scope);

    // LLVM CTORS
    int temp_argument_counter = 0; // TODO: fix
    std::shared_ptr<Cell> lambda_arg_init = As<Cell>(arguments[0]);
    for (std::shared_ptr<Cell> cell = As<Cell>(lambda_arg_init); cell; cell = As<Cell>(cell->GetSecond())) {
        ++temp_argument_counter;
    }
    int arguments_count = eval_immediately ? 0 : temp_argument_counter;
    std::vector<llvm::Type*> new_function_arguments(arguments_count, context.builder->getInt8PtrTy());
    llvm::FunctionType* new_function_type = llvm::FunctionType::get(context.object_type, new_function_arguments, false);
    llvm::Function* new_function = llvm::Function::Create(new_function_type, llvm::Function::ExternalLinkage, "LambdaFunction", context.llvm_module.value());
    assert(new_function->empty());

    if (name.has_value()) {
        scope->SetVariableFunction(name.value(), std::make_shared<LambdaCodegen>(new_function));
    }
    
    // SET INSERT POINT
    llvm::BasicBlock* old_insert_point = context.builder->GetInsertBlock();
    auto& llvm_context = context.builder->getContext();
    llvm::BasicBlock* new_function_main = llvm::BasicBlock::Create(llvm_context, "entry", new_function);
    context.builder->SetInsertPoint(new_function_main);

    // HANDLE ARGUMENTS
    std::vector<std::string> arguments_idx_to_name{};
    if (arguments.size() < 2) {
        throw SyntaxError("More than 1 argument required for \"BuildLambda\" function");
    }
    int64_t argument_idx = 0;

    if (!eval_immediately) {
        // Handle lambda arguments
        if (arguments[argument_idx] && !Is<Cell>(arguments[argument_idx]) && !eval_immediately) {
            throw RuntimeError("\"BuildLambda\" error: first argument (lambda arguments) is not a list");
        }
        std::shared_ptr<Cell> lambda_arg_init = As<Cell>(arguments[argument_idx]);
        for (std::shared_ptr<Cell> cell = As<Cell>(lambda_arg_init); cell; cell = As<Cell>(cell->GetSecond())) {
            if (!Is<Symbol>(cell->GetFirst())) {
                throw RuntimeError("\"BuildLambda\" error: first argument (lambda arguments): not a symbol met");
            }
            std::string argument_name = As<Symbol>(cell->GetFirst())->GetName();
            arguments_idx_to_name.push_back(argument_name);
        }

        for (int idx = 0; idx < arguments_idx_to_name.size(); ++idx) {
            llvm::Value* argument_value = new_function->getArg(idx);
            lambda_call_and_self_scope->SetVariableValueCodegen(arguments_idx_to_name[idx], argument_value);
        }

        // Prepare for lambda body
        ++argument_idx;
    }

    // Handle lambda body
    if (!Is<Cell>(arguments[argument_idx])) {
        throw RuntimeError("\"Lambda\" error: second argument (body) is not a list");
    }
    
    std::shared_ptr<LambdaCodegen> ans = nullptr;
    if (eval_immediately) {
        llvm::Value* return_value = nullptr;
        for (; argument_idx < arguments.size(); ++argument_idx) {
            return_value = arguments[argument_idx]->Codegen({}, lambda_call_and_self_scope);
        }
        context.builder->CreateRet(return_value);

        // If we evaluate immediately, this means we are using "begin" keyword and don't need a new scope
        ans = std::make_shared<LambdaCodegen>(new_function);
    } 
    else {
        // // If we do not evaluate immediately, we create a new scope and fill with variables
        // auto scope_variables = scope->GetVariableValueMapCodegen();
        // for (auto& [name, value] : scope_variables) {
        //     lambda_call_and_self_scope->SetVariableValueCodegen(name, value);
        // }

        llvm::Value* return_value = nullptr;
        for (; argument_idx < arguments.size(); ++argument_idx) {
            return_value = arguments[argument_idx]->Codegen({}, lambda_call_and_self_scope);
        }

        std::vector<llvm::Value*> return_value_scheme_object_indices {
            context.builder->getInt32(0), // because there is no array, so just the object itself
        };
        llvm::Value* return_value_scheme_object_field = context.builder->CreateGEP(context.object_type, return_value, return_value_scheme_object_indices);
        llvm::Value* return_value_scheme_object = context.builder->CreateLoad(context.object_type, return_value_scheme_object_field);
        context.builder->CreateRet(return_value_scheme_object);

        ans = std::make_shared<LambdaCodegen>(new_function);
    }

    llvm::verifyFunction(*new_function);
    context.builder->SetInsertPoint(old_insert_point);
    return ans;
}

} // namespace Codegen