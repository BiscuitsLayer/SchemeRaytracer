#include "scope.hpp"

// std::optional<ObjectPtr> Scope::GetVariableValueLocal(std::string name) {
//     std::unordered_map<std::string, ObjectPtr>* cur_variables = &variables_;
//     ScopePtr cur_scope = shared_from_this();

//     auto found = std::find_if(cur_variables->begin(), cur_variables->end(),
//                               [&](const auto& p) { return p.first == name; });
//     if (found != cur_variables->end()) {
//         return found->second;
//     }

//     if (name == "lambda") {
//         throw SyntaxError("Syntax Error: trying to get lambda as a variable");
//     }

//     return std::nullopt;
// }

// std::optional<llvm::Value*> Scope::GetVariableValueLocalCodegen(std::string name) {
//     std::unordered_map<std::string, llvm::Value*>* cur_variables = &codegen_variables_;
//     ScopePtr cur_scope = shared_from_this();

//     auto found = std::find_if(cur_variables->begin(), cur_variables->end(),
//                               [&](const auto& p) { return p.first == name; });
//     if (found != cur_variables->end()) {
//         return found->second;
//     }

//     if (name == "lambda") {
//         throw SyntaxError("Syntax Error: trying to get lambda as a variable");
//     }

//     return std::nullopt;
// }

ObjectPtr Scope::GetVariableValueRecursive(std::string name) {
    std::unordered_map<std::string, ObjectPtr>* cur_variables = &variables_;
    ScopePtr cur_scope = shared_from_this();

    while (cur_scope) {
        auto found = std::find_if(cur_variables->begin(), cur_variables->end(),
                                  [&](const auto& p) { return p.first == name; });
        if (found != cur_variables->end()) {
            return found->second;
        }
        cur_scope = cur_scope->previous_scope_;
        if (cur_scope) {
            cur_variables = &cur_scope->variables_;
        }
    }

    if (name == "lambda") {
        throw SyntaxError("Syntax Error: trying to get lambda as a variable");
    }
    throw NameError(name);
}

llvm::Value* Scope::GetVariableValueRecursiveCodegen(std::string name) {
    std::unordered_map<std::string, llvm::Value*>* cur_variables = &codegen_variables_;
    ScopePtr cur_scope = shared_from_this();

    while (cur_scope) {
        auto found = std::find_if(cur_variables->begin(), cur_variables->end(),
                                  [&](const auto& p) { return p.first == name; });
        if (found != cur_variables->end()) {
            return found->second;
        }
        cur_scope = cur_scope->previous_scope_;
        if (cur_scope) {
            cur_variables = &cur_scope->codegen_variables_;
        }
    }

    if (name == "lambda") {
        throw SyntaxError("Syntax Error: trying to get lambda as a variable");
    }
    throw NameError(name);
}

ObjectPtr Scope::GetVariableFunctionRecursive(std::string name) {
    std::unordered_map<std::string, ObjectPtr>* cur_functions = &functions_;
    ScopePtr cur_scope = shared_from_this();

    while (cur_scope) {
        auto found = std::find_if(cur_functions->begin(), cur_functions->end(),
                                  [&](const auto& p) { return p.first == name; });
        if (found != cur_functions->end()) {
            return found->second;
        }
        cur_scope = cur_scope->previous_scope_;
        if (cur_scope) {
            cur_functions = &cur_scope->functions_;
        }
    }

    if (name == "lambda") {
        throw SyntaxError("Syntax Error: trying to get lambda as a variable");
    }
    throw NameError(name);
}

void Scope::SetVariableValue(std::string name, ObjectPtr value, bool is_new) {
    if (is_new) {
        variables_[name] = value;
        return;
    }

    std::unordered_map<std::string, ObjectPtr>* cur_variables = &variables_;
    ScopePtr cur_scope = shared_from_this();

    while (cur_scope) {
        auto found = std::find_if(cur_variables->begin(), cur_variables->end(),
                                  [&](const auto& p) { return p.first == name; });
        if (found != cur_variables->end()) {
            cur_variables->at(name) = value;
            return;
        }

        cur_scope = cur_scope->previous_scope_;
        if (cur_scope) {
            cur_variables = &cur_scope->variables_;
        }
    }

    if (name == "lambda") {
        throw SyntaxError("Syntax Error: trying to set lambda as a variable");
    }
}

void Scope::SetVariableValueCodegen(std::string name, llvm::Value* value, bool is_new) {
    auto& context = Codegen::Context::Get();

    if (is_new) {
        llvm::Value* object_value_field = context.builder->CreateAlloca(context.object_type, nullptr, "variable");

        std::vector<llvm::Value*> new_value_indices {
            context.builder->getInt32(0), // because there is no array, so just the object itself
        };
        llvm::Value* new_value_field = context.builder->CreateGEP(context.object_type, value, new_value_indices);
        llvm::Value* new_value = context.builder->CreateLoad(context.object_type, new_value_field);
        
        context.builder->CreateStore(new_value, object_value_field);
        codegen_variables_[name] = object_value_field;
        return;
    }

    std::unordered_map<std::string, llvm::Value*>* cur_variables = &codegen_variables_;
    ScopePtr cur_scope = shared_from_this();

    while (cur_scope) {
        auto found = std::find_if(cur_variables->begin(), cur_variables->end(),
                                  [&](const auto& p) { return p.first == name; });
        if (found != cur_variables->end()) {
            llvm::Value* object_value_field = codegen_variables_.at(name);

            std::vector<llvm::Value*> new_value_indices {
                context.builder->getInt32(0), // because there is no array, so just the object itself
            };
            llvm::Value* new_value_field = context.builder->CreateGEP(context.object_type, value, new_value_indices);
            llvm::Value* new_value = context.builder->CreateLoad(context.object_type, new_value_field);
            
            context.builder->CreateStore(new_value, object_value_field);
            cur_variables->at(name) = object_value_field;
            return;
        }

        cur_scope = cur_scope->previous_scope_;
        if (cur_scope) {
            cur_variables = &cur_scope->codegen_variables_;
        }
    }

    if (name == "lambda") {
        throw SyntaxError("Syntax Error: trying to set lambda as a variable");
    }
}

void Scope::SetVariableFunction(std::string name, ObjectPtr value) {
    functions_[name] = value;
}

void Scope::SetVariableFunctionCall(std::string name, ObjectPtr function, bool is_new) {
    if (is_new) {
        ObjectPtr call = function->Evaluate({}, shared_from_this());
        functions_[name] = call;
        return;
    }

    std::unordered_map<std::string, ObjectPtr>* cur_functions = &functions_;
    ScopePtr cur_scope = shared_from_this();

    while (cur_scope) {
        auto found = std::find_if(cur_functions->begin(), cur_functions->end(),
                                  [&](const auto& p) { return p.first == name; });
        if (found != cur_functions->end()) {
            ObjectPtr call = function->Evaluate({}, cur_scope);
            cur_functions->at(name) = call;
            return;
        }

        cur_scope = cur_scope->previous_scope_;
        if (cur_scope) {
            cur_functions = &cur_scope->functions_;
        }
    }

    if (name == "lambda") {
        throw SyntaxError("Syntax Error: trying to set lambda as a variable");
    }
}

std::unordered_map<std::string, ObjectPtr> Scope::GetVariableValueMap() {
    return variables_;
}

std::unordered_map<std::string, llvm::Value*> Scope::GetVariableValueMapCodegen() {
    return codegen_variables_;
}

std::unordered_map<std::string, ObjectPtr> Scope::GetVariableFunctionMap() {
    return functions_;
}