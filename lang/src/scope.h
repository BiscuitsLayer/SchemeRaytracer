#include <memory>
#include <algorithm>
#include <unordered_map>
#include <optional>

#include <llvm_headers.h>

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

private:
    std::shared_ptr<Scope> previous_scope_ = nullptr;
    std::unordered_map<std::string, std::shared_ptr<Object>> variables_{};

    // codegen
    std::unordered_map<std::string, llvm::Value*> codegen_variables_{};
    std::unordered_map<std::string, llvm::Function*> codegen_functions_{};
};