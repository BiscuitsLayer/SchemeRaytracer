#pragma once
#include "scope_fwd.hpp"

#include <memory>
#include <algorithm>
#include <unordered_map>
#include <optional>

#include <helpers/llvm_headers.hpp>
#include <error/error.hpp>

#include <object/object.hpp>

class Scope : public std::enable_shared_from_this<Scope> {
public:
    Scope() : previous_scope_(nullptr) {
    }

    void SetPreviousScope(ScopePtr previous_scope) {
        previous_scope_ = previous_scope;
    }

    // std::optional<ObjectPtr> GetVariableValueLocal(std::string name);
    // std::optional<llvm::Value*> GetVariableValueLocalCodegen(std::string name);

    ObjectPtr GetVariableValueRecursive(std::string name);
    llvm::Value* GetVariableValueRecursiveCodegen(std::string name);
    ObjectPtr GetVariableFunctionRecursive(std::string name);

    void SetVariableValue(std::string name, ObjectPtr value, bool is_new);
    void SetVariableValueCodegen(std::string name, llvm::Value* value, bool is_new);
    void SetVariableFunction(std::string name, ObjectPtr value);
    void SetVariableFunctionCall(std::string name, ObjectPtr function, bool is_new);

    std::unordered_map<std::string, ObjectPtr> GetVariableValueMap();
    std::unordered_map<std::string, llvm::Value*> GetVariableValueMapCodegen();
    std::unordered_map<std::string, ObjectPtr> GetVariableFunctionMap();

private:
    ScopePtr previous_scope_ = nullptr;
    
    std::unordered_map<std::string, ObjectPtr> variables_{};
    std::unordered_map<std::string, llvm::Value*> codegen_variables_{};
    std::unordered_map<std::string, ObjectPtr> functions_{};
};