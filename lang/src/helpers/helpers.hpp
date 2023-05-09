#pragma once

#include <optional>
#include <cstdint>

#include "llvm_headers.hpp"
#include <external/external.hpp>
#include <scope/scope.hpp>

namespace Interp {

bool CheckIfCellIsLambda(ObjectPtr maybe_lambda_cell);

std::string ObjectToString(ObjectPtr value);
std::vector<ObjectPtr> ListToVector(ObjectPtr init);
std::string ListToString(ObjectPtr init);

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
llvm::Value* CreateIsZeroThenOneCheck(llvm::Value* number_value);

} // namespace Codegen