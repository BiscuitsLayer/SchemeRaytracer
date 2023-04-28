#include <memory>
#include <algorithm>
#include <unordered_map>
#include <optional>

#include <helpers/llvm_headers.hpp>

// Forward declaration
class Object;

class Scope : public std::enable_shared_from_this<Scope> {
public:
    Scope() : previous_scope_(nullptr), variables_({}) {
    }

    void SetPreviousScope(std::shared_ptr<Scope> previous_scope);
    std::optional<std::shared_ptr<Object>> GetVariableValueLocal(std::string name);
    std::shared_ptr<Object> GetVariableValueRecursive(std::string name);
    void SetVariableValue(std::string name, std::shared_ptr<Object> value);
    std::unordered_map<std::string, std::shared_ptr<Object>> GetVariablesMap();

    ///// CODEGEN

    std::optional<llvm::Value*> GetVariableValueLocalCodegen(std::string name);
    llvm::Value* GetVariableValueRecursiveCodegen(std::string name);
    void SetVariableValueCodegen(std::string name, llvm::Value* value);
    std::unordered_map<std::string, llvm::Value*> GetVariablesMapCodegen();

private:
    std::shared_ptr<Scope> previous_scope_ = nullptr;
    std::unordered_map<std::string, std::shared_ptr<Object>> variables_{};

    ///// CODEGEN
    std::unordered_map<std::string, llvm::Value*> codegen_variables_{};
};