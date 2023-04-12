#pragma once

#include <memory>
#include <string>

#include <scope.h>

class Scheme {
public:
    Scheme() : global_scope_(std::make_shared<Scope>()) {
    }
    std::string Evaluate(const std::string& expression);

private:
    std::shared_ptr<Scope> global_scope_ = nullptr;
};