#include <iostream>

//  LLVM HEADERS
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/ExecutionEngine/ExecutionEngine.h>
#include <llvm/ExecutionEngine/GenericValue.h>
#include <llvm/Support/TargetSelect.h>

llvm::Function* ReadFunction;
int ReadFunctionImpl() {
    int res = 0;
    std::cin >> res;
    return res; 
}

int main() {
    //llvm::InitializeNativeTarget();
    //llvm::InitializeNativeTargetAsmPrinter();

    llvm::LLVMContext context;
    llvm::Module* module = new llvm::Module("main.c", context);
    llvm::IRBuilder<> builder{context};

    // declare void @main()
    llvm::FunctionType* funcType = llvm::FunctionType::get(builder.getInt32Ty(), false);
    llvm::Function* mainFunc = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "main", module);
    // entry:
    llvm::BasicBlock* entryBB = llvm::BasicBlock::Create(context, "entry", mainFunc);

    builder.SetInsertPoint(entryBB);
    
    funcType = llvm::FunctionType::get(builder.getInt32Ty(), false);
    ReadFunction = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "ReadFunction", module);

    // CODEGEN HAPPENS HERE
    llvm::Value* value_lhs = builder.CreateCall(ReadFunction);
    //llvm::Value* value_rhs = builder.CreateCall(readFunc);
    //llvm::Value* value_lhs = builder.getInt32(5);
    llvm::Value* value_rhs = builder.getInt32(7);

    llvm::Value* value_add = builder.CreateAdd(value_lhs, value_rhs);
    llvm::Value* value_ret = builder.CreateRet(value_add);

    llvm::outs() << "#[LLVM IR]:\n";
    module->print(llvm::outs(), nullptr);

    // Interpreter of LLVM IR
    llvm::outs() << "Running code...\n";
	llvm::ExecutionEngine *ee = llvm::EngineBuilder(std::unique_ptr<llvm::Module>(module)).create();
    ee->InstallLazyFunctionCreator([&](const std::string &fnName) -> void * {
        if (fnName == "ReadFunction") { return reinterpret_cast<void *>(ReadFunctionImpl); }
        return nullptr;
    });
    ee->finalizeObject();
	std::vector<llvm::GenericValue> noargs;
	llvm::GenericValue res = ee->runFunction(mainFunc, noargs);
	llvm::outs() << "Code was run. Result = " << res.IntVal << "\n";

    return 0;
}