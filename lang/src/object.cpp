#include <object.h>

std::vector<std::shared_ptr<Object>> ListToVector(std::shared_ptr<Object> init) {
    std::vector<std::shared_ptr<Object>> ans{};
    for (std::shared_ptr<Cell> cell = As<Cell>(init); cell; cell = As<Cell>(cell->GetSecond())) {
        std::shared_ptr<Object> obj = cell->GetFirst();
        if (!obj && !cell->GetSecond()) {
            return ans;
        }
        ans.push_back(obj);
    }
    return ans;
}

std::string ListToString(std::shared_ptr<Object> init) {
    std::string ans = "(";
    for (std::shared_ptr<Cell> cell = As<Cell>(init); cell; cell = As<Cell>(cell->GetSecond())) {
        std::shared_ptr<Object> first = cell->GetFirst();
        if (!first) {
            ans += ")";
            return ans;
        }

        std::string value = ObjectToString(first);
        std::shared_ptr<Object> second = cell->GetSecond();
        if (!second) {
            ans += value + ")";
            return ans;
        } else {
            ans += value + " ";
            if (!Is<Cell>(second)) {  // If second is not Cell, we should use Dot
                value = ObjectToString(second); 
                ans += ". " + value + ")";
                return ans;
            }
        }
    }
    return ans;
}

std::shared_ptr<Object> BuildLambda(std::shared_ptr<Object> init, std::shared_ptr<Scope> scope, bool eval_immediately) {
    std::vector<std::shared_ptr<Object>> arguments = ListToVector(init);

    std::vector<std::shared_ptr<Object>> commands{};
    std::vector<std::string> arguments_idx_to_name{};

    if (arguments.size() < 2) {
        throw SyntaxError("More than 1 argument required for \"BuildLambda\" function");
    }

    int64_t argument_idx = 0;

    if (!eval_immediately) {
        // Handle lambda arguments
        if (arguments[argument_idx] && !Is<Cell>(arguments[argument_idx]) && !eval_immediately) {
            throw RuntimeError(
                "\"BuildLambda\" error: first argument (lambda arguments) is not a list");
        }
        std::shared_ptr<Cell> lambda_arg_init = As<Cell>(arguments[argument_idx]);
        for (std::shared_ptr<Cell> cell = As<Cell>(lambda_arg_init); cell;
             cell = As<Cell>(cell->GetSecond())) {
            if (!Is<Symbol>(cell->GetFirst())) {
                throw RuntimeError(
                    "\"BuildLambda\" error: first argument (lambda arguments): not a symbol met");
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

    std::shared_ptr<Object> ans;
    
    if (!eval_immediately) {
        // If we do not evaluate immediately, we create a new scope and fill with variables
        auto scope_variables = scope->GetVariablesMap();
        std::shared_ptr<Scope> self_scope = std::make_shared<Scope>();
        for (auto& [name, value] : scope_variables) {
            self_scope->SetVariableValue(name, value);
        }
        ans = std::make_shared<Lambda>(commands, arguments_idx_to_name, self_scope);
    } else {
        // If we evaluate immediately, this means we are using "begin" keyword and don't need a new scope
        ans = std::make_shared<Lambda>(commands, arguments_idx_to_name, scope);
    }
    return ans;
}

std::shared_ptr<Object> BuildLambdaCodegen(std::shared_ptr<llvm::Module> module, llvm::IRBuilder<>& builder, llvm::StructType* object_type, std::shared_ptr<Object> init, std::shared_ptr<Scope> scope, bool eval_immediately) {
    // ARGUMENTS TO VECTOR
    std::vector<std::shared_ptr<Object>> arguments = ListToVector(init);
    std::shared_ptr<Scope> self_scope = std::make_shared<Scope>();

    // LLVM CTORS
    std::vector<llvm::Type*> new_function_arguments(arguments.size() - 1, builder.getInt8PtrTy());
    llvm::FunctionType* new_function_type = llvm::FunctionType::get(builder.getInt8PtrTy(), new_function_arguments, false);
    llvm::Function* new_function = llvm::Function::Create(new_function_type, llvm::Function::ExternalLinkage, "LambdaFunction", module.get());
    assert(new_function->empty());
    
    // SET INSERT POINT
    llvm::BasicBlock* old_insert_point = builder.GetInsertBlock();
    auto& context = builder.getContext();
    llvm::BasicBlock* new_function_main = llvm::BasicBlock::Create(context, "entry", new_function);
    builder.SetInsertPoint(new_function_main);

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
        for (std::shared_ptr<Cell> cell = As<Cell>(lambda_arg_init); cell;
            cell = As<Cell>(cell->GetSecond())) {
            if (!Is<Symbol>(cell->GetFirst())) {
                throw RuntimeError("\"BuildLambda\" error: first argument (lambda arguments): not a symbol met");
            }
            std::string argument_name = As<Symbol>(cell->GetFirst())->GetName();
            arguments_idx_to_name.push_back(argument_name);
        }

        for (int idx = 0; idx < arguments_idx_to_name.size(); ++idx) {
            llvm::Value* argument_value = new_function->getArg(idx);
            self_scope->SetVariableValueCodegen(arguments_idx_to_name[idx], argument_value);
        }

        // Prepare for lambda body
        ++argument_idx;
    }

    // Handle lambda body
    if (!Is<Cell>(arguments[argument_idx])) {
        throw RuntimeError("\"Lambda\" error: second argument (body) is not a list");
    }

    std::shared_ptr<Object> ans;
    
    if (!eval_immediately) {
        // If we do not evaluate immediately, we create a new scope and fill with variables
        auto scope_variables = scope->GetVariablesMap();
        for (auto& [name, value] : scope_variables) {
            self_scope->SetVariableValue(name, value);
        }

        llvm::Value* return_value = nullptr;
        // CODEGEN COMMANDS
        for (; argument_idx < arguments.size(); ++argument_idx) {
            return_value = arguments[argument_idx]->Codegen(module, builder, object_type, {}, self_scope);
        }
        // TODO: fix function return value
        builder.CreateRet(return_value);

        // ANS = BUILT LAMBDA
        ans = std::make_shared<Lambda>(new_function, self_scope);
    } else {
        llvm::Value* return_value = nullptr;
        // CODEGEN COMMANDS
        for (; argument_idx < arguments.size(); ++argument_idx) {
            return_value = arguments[argument_idx]->Codegen(module, builder, object_type, {}, scope);
        }
        // TODO: fix function return value
        builder.CreateRet(return_value);
        
        // ANS = BUILT LAMBDA
        // If we evaluate immediately, this means we are using "begin" keyword and don't need a new scope
        ans = std::make_shared<Lambda>(new_function, scope);
    }

    llvm::verifyFunction(*new_function);
    builder.SetInsertPoint(old_insert_point);
    return ans;
}

std::pair<std::string, std::shared_ptr<Object>> BuildLambdaSugar(
    std::vector<std::shared_ptr<Object>> parts, std::shared_ptr<Scope> scope) {
    if (parts.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"BuildLambdaSugar\" function");
    }

    std::vector<std::shared_ptr<Object>> arguments = ListToVector(parts[0]);
    std::shared_ptr<Object> command = parts[1];

    std::vector<std::shared_ptr<Object>> commands{};
    std::vector<std::string> arguments_idx_to_name{};
    std::shared_ptr<Scope> self_scope = std::make_shared<Scope>();

    std::string lambda_name = As<Symbol>(arguments[0])->GetName();
    for (size_t argument_idx = 1; argument_idx < arguments.size(); ++argument_idx) {
        if (!Is<Symbol>(arguments[argument_idx])) {
            throw SyntaxError("\"BuildLambdaSugar\" function error: argument passed is not a symbol");
        }
        std::string argument_name = As<Symbol>(arguments[argument_idx])->GetName();
        arguments_idx_to_name.push_back(argument_name);
    }
    commands.push_back(command);

    auto scope_variables = scope->GetVariablesMap();
    for (auto& [name, value] : scope_variables) {
        self_scope->SetVariableValue(name, value);
    }

    std::shared_ptr<Object> ans =
        std::make_shared<Lambda>(commands, arguments_idx_to_name, self_scope);
    return std::make_pair(lambda_name, ans);
}