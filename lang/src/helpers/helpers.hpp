#pragma once

#include <optional>
#include <cstdint>

#include "llvm_headers.hpp"
#include <external/external.hpp>
#include <object/object.hpp>

namespace Interp {

std::string ObjectToString(std::shared_ptr<Object> value);

std::vector<std::shared_ptr<Object>> ListToVector(std::shared_ptr<Object> init);
std::string ListToString(std::shared_ptr<Object> init);
std::shared_ptr<Object> BuildLambda(std::shared_ptr<Object> init, std::shared_ptr<Scope> scope, bool eval_immediately = false);
std::pair<std::string, std::shared_ptr<Object>> BuildLambdaSugar(std::vector<std::shared_ptr<Object>> parts, std::shared_ptr<Scope> scope);

} // namespace Interp

namespace Codegen {

/*
    Singleton class to share
    application resources between files
*/
struct Context {
public:
    static Context& Get();

    Context(const Context&) = delete;
    Context& operator=(Context&) = delete;
    ~Context();

    std::optional<llvm::LLVMContext> llvm_context;
    std::optional<llvm::Module> llvm_module;
    std::optional<llvm::IRBuilder<>> builder;
    llvm::StructType* object_type;

private:
    Context();

    void SetExternalFunctions();
    void SetExternalFunction(std::string name, llvm::Type* return_value_type, const std::vector<llvm::Type*>& argument_types);
};



// CELL
llvm::Value* CreateStoreNewCell();
void CreateStoreCellFirst(llvm::Value* object_value, llvm::Value* first_value);
void CreateStoreCellSecond(llvm::Value* object_value, llvm::Value* second_value);

// BUILD NEW FROM CPP TYPE
llvm::Value* CreateStoreNewNumber(int64_t number);
llvm::Value* CreateStoreNewSymbol(std::string symbol);
llvm::Value* CreateStoreNewBoolean(bool boolean);

// BUILD NEW FROM OBJECT TYPE
llvm::Value* CreateStoreNewNumber(llvm::Value* number_value);
llvm::Value* CreateStoreNewSymbol(llvm::Value* symbol_value);
llvm::Value* CreateStoreNewBoolean(llvm::Value* boolean_value);

// STORE FROM OBJECT TYPE
void CreateStoreNumber(llvm::Value* object_value, llvm::Value* number_value);
// void CreateStoreSymbol(llvm::Value* object_value, llvm::Value* symbol_value);
void CreateStoreBoolean(llvm::Value* object_value, llvm::Value* boolean_value);

// LOAD CPP TYPE FROM OBJECT TYPE
llvm::Value* CreateLoadNumber(llvm::Value* object_value);
// llvm::Value* CreateLoadSymbol(llvm::Value* object_value);
llvm::Value* CreateLoadBoolean(llvm::Value* object_value);

// CHECKS
void CreateObjectTypeCheck(llvm::Value* object_value, ObjectType type);
void CreateIsIntegerCheck(llvm::Value* number_value);
llvm::Value* CreateIsZeroThanOneCheck(llvm::Value* number_value);

std::shared_ptr<Object> BuildLambdaCodegen(std::shared_ptr<Object> init, std::shared_ptr<Scope> scope, bool eval_immediately = false, std::optional<std::shared_ptr<Object>> ans = std::nullopt);

} // namespace Codegen