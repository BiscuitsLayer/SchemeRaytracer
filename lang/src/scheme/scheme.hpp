#pragma once

#include <memory>
#include <string>
#include <stack>

#include <scope/scope.hpp>

namespace Scheme {

class Scheme {
public:
    Scheme(): global_scope_(std::make_shared<Scope>()) {}
    std::string Evaluate(const std::string& expression);
    llvm::Value* Codegen(const std::string& expression);

private:
    void SetSystemFunctions();
    ScopePtr global_scope_ = nullptr;
};

} // namespace Scheme