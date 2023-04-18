#pragma once

#include <memory>
#include <string>
#include <stack>

#include <scope.h>

class Scheme {
public:
    Scheme() : global_scope_(std::make_shared<Scope>()) {
    }
    std::string Evaluate(const std::string& expression);
    llvm::Value* Codegen(const std::string& expression, std::shared_ptr<llvm::Module> module, llvm::IRBuilder<>& builder);

private:
    std::shared_ptr<Scope> global_scope_ = nullptr;

public: // CODEGEN
    llvm::StructType* object_type;
    std::stack<llvm::BasicBlock*> basic_block_stack;
};