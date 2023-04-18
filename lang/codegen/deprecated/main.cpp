#include <iostream>

//  LLVM HEADERS
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/Verifier.h>
#include <llvm/ExecutionEngine/Interpreter.h>
#include <llvm/ExecutionEngine/ExecutionEngine.h>
#include <llvm/ExecutionEngine/GenericValue.h>
#include <llvm/Support/TargetSelect.h>

int main() {
    llvm::LLVMContext context;
    std::shared_ptr<llvm::Module> module = std::make_shared<llvm::Module>("llvm_test.cpp", context);
    llvm::IRBuilder<> builder{context};

    // CREATE OBJECT CLASS
    llvm::StructType* object_type = llvm::StructType::create(context);
    llvm::PointerType* object_ptr_type = llvm::PointerType::get(object_type, 0);
    object_type->setName("OBJECT_TYPE");
    std::vector<llvm::Type*> object_type_subtypes = {
        builder.getInt32Ty(), // type
        builder.getInt64Ty(), // number
        builder.getInt1Ty(), // boolean
        builder.getInt8PtrTy(), // string
        object_ptr_type, // pointer to itself (first)
        object_ptr_type // pointer to itself (second)
    };
    object_type->setBody(object_type_subtypes);

    llvm::Value* a_letter = builder.getInt8('a');
    std::vector<llvm::Value*> values { 
        builder.getInt32(0),
        builder.getInt64(0), 
        builder.getInt1(0), 
        builder.getInt64(0),
        builder.getInt64(0),
        builder.getInt64(0)
    };

    // declare void @main()
    llvm::FunctionType* funcType = llvm::FunctionType::get(builder.getInt32Ty(), false);
    llvm::Function* mainFunc = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "main", module.get());
    // entry:
    llvm::BasicBlock* entryBB = llvm::BasicBlock::Create(context, "entry", mainFunc);
    builder.SetInsertPoint(entryBB);

    // object type object creation
    llvm::AllocaInst* object_value = builder.CreateAlloca(object_type, nullptr, "my_object");
    std::vector<llvm::Value*> object_value_type_field_indices {
        builder.getInt32(0), // because there is no array, so just the object itself
        builder.getInt32(0) // zeroth field - type
    };
    llvm::Value* object_value_type_field = builder.CreateGEP(object_type, object_value, object_value_type_field_indices);
    builder.CreateStore(builder.getInt64(0), object_value_type_field);

    std::string hello_llvm_string = "Hello, LLVM!";
    llvm::Value* hello_llvm_value = builder.CreateGlobalString(hello_llvm_string, "hello_llvm_global");

    // declare external ReadFunction
    // std::vector<llvm::Type*> readFuncArguments = { builder.getInt32Ty() };
    funcType = llvm::FunctionType::get(builder.getInt32Ty(), false);
    llvm::Function* ReadFunction = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "ReadFunction", module.get());

    // declare external PrintFunction
    std::vector<llvm::Type*> printFuncArguments = { builder.getInt32Ty() };
    funcType = llvm::FunctionType::get(builder.getInt32Ty(), printFuncArguments, false);
    llvm::Function* PrintFunction = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "PrintFunction", module.get());

    // declare external PrintStringFunction
    std::vector<llvm::Type*> printStringFuncArguments = { builder.getInt8PtrTy() };
    funcType = llvm::FunctionType::get(builder.getInt32Ty(), printStringFuncArguments, false);
    llvm::Function* PrintStringFunction = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "PrintStringFunction", module.get());

    // declare external PrintObjectFunction
    std::vector<llvm::Type*> printObjectFuncArguments = { builder.getInt8PtrTy() };
    funcType = llvm::FunctionType::get(builder.getInt32Ty(), printObjectFuncArguments, false);
    llvm::Function* PrintObjectFunction = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "PrintObjectFunction", module.get());

    // print object value
    std::vector<llvm::Value*> printObjectFuncCallArguments = { object_value };
    builder.CreateCall(PrintObjectFunction, printObjectFuncCallArguments);

    // print predefined string
    std::vector<llvm::Value*> printStringFuncCallArguments = { hello_llvm_value };
    builder.CreateCall(PrintStringFunction, printStringFuncCallArguments);

    // CODEGEN HAPPENS HERE
    //std::vector<llvm::Value*> readFuncCallArguments = { builder.getInt32(5) };
    llvm::Value* read_result = builder.CreateCall(ReadFunction);
    
    // FUNCTION GENERATION
    std::vector<llvm::Type*> addFuncArguments = { builder.getInt32Ty() };
    funcType = llvm::FunctionType::get(builder.getInt32Ty(), addFuncArguments, false);
    llvm::Function* AddFunction = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "AddFunction", module.get());

    llvm::Value* greater_than_zero = builder.CreateICmpSGT(read_result, builder.getInt32(0));
    llvm::Function *current_function = builder.GetInsertBlock()->getParent();
    llvm::BasicBlock *true_branch = llvm::BasicBlock::Create(context, "true_branch", current_function);
    llvm::BasicBlock *false_branch = llvm::BasicBlock::Create(context, "false_branch", current_function);
    llvm::BasicBlock *merge_branch = llvm::BasicBlock::Create(context, "merge_branch", current_function);

    builder.CreateCondBr(greater_than_zero, true_branch, false_branch);

    builder.SetInsertPoint(true_branch);
    // FUNCTION CALL
    llvm::Function* AddFunctionToCall = module->getFunction("AddFunction");
    std::vector<llvm::Value*> addFuncCallArguments = { read_result };
    llvm::Value* true_branch_result = builder.CreateCall(AddFunctionToCall, addFuncCallArguments);
    builder.CreateBr(merge_branch);
    true_branch = builder.GetInsertBlock();

    builder.SetInsertPoint(false_branch);
    llvm::Value* false_branch_result = builder.CreateSub(read_result, builder.getInt32(7));
    builder.CreateBr(merge_branch);
    false_branch = builder.GetInsertBlock();

    builder.SetInsertPoint(merge_branch);
    llvm::PHINode* phi_node = builder.CreatePHI(builder.getInt32Ty(), 2);

    phi_node->addIncoming(true_branch_result, true_branch);
    phi_node->addIncoming(false_branch_result, false_branch);
    



   
    llvm::Function* AddFunctionAlreadyDefinedByExtern = module->getFunction("AddFunction");
    if (AddFunctionAlreadyDefinedByExtern->empty()) {
        llvm::BasicBlock* AddFunctionBB = llvm::BasicBlock::Create(context, "entry", AddFunction);
        builder.SetInsertPoint(AddFunctionBB);

        llvm::Value* value_lhs = AddFunction->getArg(0);
        llvm::Value* value_rhs = builder.getInt32(7);
        llvm::Value* value_add = builder.CreateAdd(value_lhs, value_rhs);
        builder.CreateRet(value_add);

        llvm::verifyFunction(*AddFunction);
    }
    builder.SetInsertPoint(merge_branch);

    std::vector<llvm::Value*> printFuncCallArguments = { phi_node };
    builder.CreateCall(PrintFunction, printFuncCallArguments);


    llvm::Value* value_ret = builder.CreateRet(builder.getInt32(0));

    std::error_code EC;
    llvm::raw_fd_ostream output_file("outfile.ll", EC);
    
    llvm::outs() << "#[LLVM IR]:\n";
    module->print(output_file, nullptr);

    // Interpreter of LLVM IR
    llvm::outs() << "Running code...\n";

	llvm::ExecutionEngine *ee = llvm::EngineBuilder(std::unique_ptr<llvm::Module>(module.get())).create();
    ee->finalizeObject();

	//std::vector<llvm::GenericValue> noargs;
	//llvm::GenericValue res = ee->runFunction(mainFunc, noargs);
	//llvm::outs() << "Code was run. Result = " << res.IntVal << "\n";

    return 0;
}