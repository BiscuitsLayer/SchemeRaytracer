#include "helpers.hpp"

#include <external/external.hpp>

namespace Interp {

bool CheckIfCellIsLambda(ObjectPtr maybe_lambda_cell) {
    if (Is<Cell>(maybe_lambda_cell)) {
        std::shared_ptr<Cell> lambda_cell = As<Cell>(maybe_lambda_cell);
        std::shared_ptr<Symbol> maybe_lambda_keyword = As<Symbol>(lambda_cell->GetFirst());
        if (!maybe_lambda_keyword) {
            throw RuntimeError("Unknown cell first argument!");
        }
        if (maybe_lambda_keyword->GetName() == "lambda") {
            return true;
        }
    }
    return false;
}

std::string ObjectToString(ObjectPtr value) {
    std::string ans{};

    if (!value) {
        ans = "()";
    } else if (Is<Number>(value)) {
        number_t unhandled_value = As<Number>(value)->GetValue();
        if (unhandled_value % PRECISION == 0) {
            number_t value = unhandled_value / PRECISION;
            ans = std::to_string(value);
        } else {
            double value = 1.0 * unhandled_value / PRECISION;
            ans = std::to_string(value);
        }
    } else if (Is<Boolean>(value)) {
        bool new_value = As<Boolean>(value)->GetValue();
        ans = new_value ? "#t" : "#f";
    } else if (Is<Cell>(value)) {
        ans = ListToString(value);
    } else if (Is<Symbol>(value)) {
        ans = As<Symbol>(value)->GetName();
    } else {
        throw RuntimeError("Cannot handle output!");
    }

    return ans;
}

std::vector<ObjectPtr> ListToVector(ObjectPtr init) {
    std::vector<ObjectPtr> ans{};
    for (std::shared_ptr<Cell> cell = As<Cell>(init); cell; cell = As<Cell>(cell->GetSecond())) {
        ObjectPtr obj = cell->GetFirst();
        if (!obj && !cell->GetSecond()) {
            return ans;
        }
        ans.push_back(obj);
    }
    return ans;
}

std::string ListToString(ObjectPtr init) {
    std::string ans = "(";
    for (std::shared_ptr<Cell> cell = As<Cell>(init); cell; cell = As<Cell>(cell->GetSecond())) {
        ObjectPtr first = cell->GetFirst();
        if (!first) {
            ans += ")";
            return ans;
        }

        std::string value = ObjectToString(first);
        ObjectPtr second = cell->GetSecond();
        if (!second) {
            ans += value + ")";
            return ans;
        } else {
            ans += value + " ";
            if (!Is<Cell>(second)) {  // If second is not Cell, we should use Dot
                value = ObjectToString(second); 
                ans += ". " + value + ")";
                return ans;
            }
        }
    }
    return ans;
}

} // namespace Interp

namespace Codegen {

Context& Context::Get() {
    static Context instance;
    return instance;
}

Context::Context() {
    llvm_context.emplace();
    llvm_module.emplace("outfile.ll", llvm_context.value());
    builder.emplace(llvm_context.value());

    llvm::FunctionType* main_function_type = llvm::FunctionType::get(builder->getInt32Ty(), false);
    llvm::Function* main_function = llvm::Function::Create(main_function_type, llvm::Function::ExternalLinkage, "main", llvm_module.value());
    llvm::BasicBlock* main_function_entry = llvm::BasicBlock::Create(llvm_context.value(), "entry", main_function);
    builder->SetInsertPoint(main_function_entry);

    object_type = llvm::StructType::create(llvm_context.value());
    object_ptr_type = llvm::PointerType::get(object_type, 0);
    llvm::PointerType* char_ptr_type = llvm::PointerType::get(builder->getInt8Ty(), 0);

    object_type->setName("SchemeObject");
    std::vector<llvm::Type*> object_type_subtypes = {
        BuilderGetNumberType(),   // type enum
        BuilderGetNumberType(),   // number
        builder->getInt1Ty(),     // boolean
        char_ptr_type,            // symbol
        object_ptr_type,          // first
        object_ptr_type           // second
    };
    object_type->setBody(object_type_subtypes);

    nullptr_value = llvm::Constant::getNullValue(object_ptr_type);

    SetExternalFunctions();
}

Context::~Context() {
    builder->CreateRet(builder->getInt32(0));
    
    std::error_code EC;
    llvm::raw_fd_ostream output_file("../codegen/outfile.ll", EC);
    llvm_module->print(output_file, nullptr);
}

void Context::SetExternalFunctions() {
    SetExternalFunction("__GLInit", builder->getVoidTy(), {});
    SetExternalFunction("__GLClear", builder->getVoidTy(), {});
    SetExternalFunction("__GLPutPixel", builder->getVoidTy(), 
        { 
            object_ptr_type, 
            object_ptr_type, 
            object_ptr_type, 
            object_ptr_type, 
            object_ptr_type
        }
    );
    SetExternalFunction("__GLIsOpen", object_type, {});
    SetExternalFunction("__GLDraw", builder->getVoidTy(), {});
    SetExternalFunction("__GLFinish", builder->getVoidTy(), {});
    SetExternalFunction("__GLPrint", builder->getVoidTy(),
        { 
            object_ptr_type
        }
    );
    llvm::PointerType* char_ptr_type = llvm::PointerType::get(builder->getInt8Ty(), 0);
    SetExternalFunction("__GLAssert", builder->getVoidTy(),
        { 
            builder->getInt1Ty(),
            char_ptr_type,
            object_ptr_type
        }
    );
    SetExternalFunction("__GLExpt", object_type,
        { 
            object_ptr_type,
            object_ptr_type
        }
    );
    SetExternalFunction("__GLSqrt", object_type,
        { 
            object_ptr_type
        }
    );
    SetExternalFunction("__GLMax", object_type,
        { 
            object_ptr_type,
            object_ptr_type
        }
    );
    SetExternalFunction("__GLMin", object_type,
        { 
            object_ptr_type,
            object_ptr_type
        }
    );
}

void Context::SetExternalFunction(std::string name, llvm::Type* return_value_type, const std::vector<llvm::Type*>& argument_types) {
    llvm::FunctionType* function_type = llvm::FunctionType::get(return_value_type, argument_types, false);
    llvm::Function* function = llvm::Function::Create(function_type, llvm::Function::ExternalLinkage, name, llvm_module.value());
}

llvm::Value* CreateValueCopy(llvm::Value* object_value, llvm::BasicBlock* object_value_branch) {
    auto& context = Codegen::Context::Get();

    llvm::PHINode* new_object_value = context.builder->CreatePHI(context.object_ptr_type, 1);
    new_object_value->addIncoming(object_value, object_value_branch);
    return new_object_value;
}

llvm::Value* CreateValueCopy(const std::vector<std::pair<llvm::Value*, llvm::BasicBlock*>>& object_value_and_branch_vector) {
    auto& context = Codegen::Context::Get();

    llvm::PHINode* new_object_value = context.builder->CreatePHI(context.object_ptr_type, object_value_and_branch_vector.size());
    for (auto object_value_and_branch : object_value_and_branch_vector) {
        new_object_value->addIncoming(object_value_and_branch.first, object_value_and_branch.second);
    }
    return new_object_value;
}

void CreateStackSave() {
    auto& context = Codegen::Context::Get();

    llvm::Function* stack_save_function = llvm::Intrinsic::getDeclaration(&context.llvm_module.value(), llvm::Intrinsic::stacksave);
    llvm::Value* stack_state_before_loop = context.builder->CreateCall(stack_save_function);

    context.last_stack_saves.push(stack_state_before_loop);
}

void CreateStackRestore() {
    auto& context = Codegen::Context::Get();
    auto stack_state_before_loop = context.last_stack_saves.top();
    context.last_stack_saves.pop();

    llvm::Function* stack_restore_function = llvm::Intrinsic::getDeclaration(&context.llvm_module.value(), llvm::Intrinsic::stackrestore);
    context.builder->CreateCall(stack_restore_function, {stack_state_before_loop});
}

llvm::Value* CreateStoreNewCell() {
    auto& context = Codegen::Context::Get();
    llvm::Value* object_value = context.builder->CreateAlloca(context.object_type, nullptr);

    std::vector<llvm::Value*> object_value_type_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_TYPE)
    };
    llvm::Value* object_value_type_field = context.builder->CreateGEP(context.object_type, object_value, object_value_type_field_indices);
    context.builder->CreateStore(context.BuilderGetNumber(ObjectType::TYPE_CELL), object_value_type_field);

    std::vector<llvm::Value*> object_value_first_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_FIRST)
    };
    llvm::Value* object_value_first_field = context.builder->CreateGEP(context.object_type, object_value, object_value_first_field_indices);
    context.builder->CreateStore(context.nullptr_value, object_value_first_field);

    std::vector<llvm::Value*> object_value_second_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_SECOND)
    };
    llvm::Value* object_value_second_field = context.builder->CreateGEP(context.object_type, object_value, object_value_second_field_indices);
    context.builder->CreateStore(context.nullptr_value, object_value_second_field);

    return object_value;
}

void CreateStoreCellFirst(llvm::Value* object_value, llvm::Value* first_value) {
    auto& context = Codegen::Context::Get();
    std::vector<llvm::Value*> object_value_first_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_FIRST)
    };
    llvm::Value* object_value_first_field = context.builder->CreateGEP(context.object_type, object_value, object_value_first_field_indices);
    context.builder->CreateStore(first_value, object_value_first_field);
}

void CreateStoreCellSecond(llvm::Value* object_value, llvm::Value* second_value) {
    auto& context = Codegen::Context::Get();
    std::vector<llvm::Value*> object_value_second_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_SECOND)
    };
    llvm::Value* object_value_second_field = context.builder->CreateGEP(context.object_type, object_value, object_value_second_field_indices);
    context.builder->CreateStore(second_value, object_value_second_field);
}

llvm::Value* CreateLoadCellFirst(llvm::Value* object_value) {
    auto& context = Codegen::Context::Get();

    std::vector<llvm::Value*> object_value_first_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_FIRST)
    };
    llvm::Value* object_value_first_field = context.builder->CreateGEP(context.object_type, object_value, object_value_first_field_indices);
    llvm::Value* object_value_first = context.builder->CreateLoad(context.object_ptr_type, object_value_first_field);

    return object_value_first;
}

llvm::Value* CreateLoadCellSecond(llvm::Value* object_value) {
    auto& context = Codegen::Context::Get();

    std::vector<llvm::Value*> object_value_second_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_SECOND)
    };
    llvm::Value* object_value_second_field = context.builder->CreateGEP(context.object_type, object_value, object_value_second_field_indices);
    llvm::Value* object_value_second = context.builder->CreateLoad(context.object_ptr_type, object_value_second_field);

    return object_value_second;
}

llvm::Value* CreateStoreNewNumber(number_t number) {
    auto& context = Codegen::Context::Get();
    llvm::AllocaInst* object_value = context.builder->CreateAlloca(context.object_type, nullptr, "number");

    std::vector<llvm::Value*> object_value_type_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_TYPE)
    };
    llvm::Value* object_value_type_field = context.builder->CreateGEP(context.object_type, object_value, object_value_type_field_indices);
    context.builder->CreateStore(context.BuilderGetNumber(ObjectType::TYPE_NUMBER), object_value_type_field);

    std::vector<llvm::Value*> object_value_number_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_NUMBER)
    };
    llvm::Value* object_value_number_field = context.builder->CreateGEP(context.object_type, object_value, object_value_number_field_indices);
    context.builder->CreateStore(context.BuilderGetNumber(number), object_value_number_field);

    return object_value;
}

llvm::Value* CreateStoreNewSymbol(std::string symbol) {
    auto& context = Codegen::Context::Get();
    llvm::AllocaInst* object_value = context.builder->CreateAlloca(context.object_type, nullptr, "symbol");

    std::vector<llvm::Value*> object_value_type_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_TYPE)
    };
    llvm::Value* object_value_type_field = context.builder->CreateGEP(context.object_type, object_value, object_value_type_field_indices);
    context.builder->CreateStore(context.BuilderGetNumber(ObjectType::TYPE_SYMBOL), object_value_type_field);

    std::vector<llvm::Value*> object_value_symbol_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_SYMBOL)
    };
    llvm::Value* object_value_symbol_field = context.builder->CreateGEP(context.object_type, object_value, object_value_symbol_field_indices);

    llvm::Value* symbol_global = context.builder->CreateGlobalStringPtr(symbol, "symbol_global");
    context.builder->CreateStore(symbol_global, object_value_symbol_field);

    return object_value;
}

llvm::Value* CreateStoreNewBoolean(bool boolean) {
    auto& context = Codegen::Context::Get();
    llvm::AllocaInst* object_value = context.builder->CreateAlloca(context.object_type, nullptr, "boolean");

    std::vector<llvm::Value*> object_value_type_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_TYPE)
    };
    llvm::Value* object_value_type_field = context.builder->CreateGEP(context.object_type, object_value, object_value_type_field_indices);
    context.builder->CreateStore(context.BuilderGetNumber(ObjectType::TYPE_BOOLEAN), object_value_type_field);

    std::vector<llvm::Value*> object_value_boolean_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_BOOLEAN)
    };
    llvm::Value* object_value_boolean_field = context.builder->CreateGEP(context.object_type, object_value, object_value_boolean_field_indices);
    context.builder->CreateStore(context.builder->getInt1(boolean), object_value_boolean_field);

    return object_value;
}

llvm::Value* CreateStoreNewNumber(llvm::Value* number_value) {
    auto& context = Codegen::Context::Get();
    llvm::AllocaInst* object_value = context.builder->CreateAlloca(context.object_type, nullptr, "number");

    std::vector<llvm::Value*> object_value_type_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_TYPE)
    };
    llvm::Value* object_value_type_field = context.builder->CreateGEP(context.object_type, object_value, object_value_type_field_indices);
    context.builder->CreateStore(context.BuilderGetNumber(ObjectType::TYPE_NUMBER), object_value_type_field);

    std::vector<llvm::Value*> object_value_number_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_NUMBER)
    };
    llvm::Value* object_value_number_field = context.builder->CreateGEP(context.object_type, object_value, object_value_number_field_indices);
    context.builder->CreateStore(number_value, object_value_number_field);

    return object_value;
}

llvm::Value* CreateStoreNewSymbol(llvm::Value* symbol_value) {
    auto& context = Codegen::Context::Get();

    llvm::AllocaInst* object_value = context.builder->CreateAlloca(context.object_type, nullptr, "symbol");

    std::vector<llvm::Value*> object_value_type_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_TYPE)
    };
    llvm::Value* object_value_type_field = context.builder->CreateGEP(context.object_type, object_value, object_value_type_field_indices);
    context.builder->CreateStore(context.BuilderGetNumber(ObjectType::TYPE_SYMBOL), object_value_type_field);

    std::vector<llvm::Value*> object_value_symbol_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_SYMBOL)
    };
    llvm::Value* object_value_symbol_field = context.builder->CreateGEP(context.object_type, object_value, object_value_symbol_field_indices);
    context.builder->CreateStore(symbol_value, object_value_symbol_field);

    return object_value;
}

llvm::Value* CreateStoreNewBoolean(llvm::Value* boolean_value) {
    auto& context = Codegen::Context::Get();

    llvm::AllocaInst* object_value = context.builder->CreateAlloca(context.object_type, nullptr, "boolean");

    std::vector<llvm::Value*> object_value_type_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_TYPE)
    };
    llvm::Value* object_value_type_field = context.builder->CreateGEP(context.object_type, object_value, object_value_type_field_indices);
    context.builder->CreateStore(context.BuilderGetNumber(ObjectType::TYPE_BOOLEAN), object_value_type_field);

    std::vector<llvm::Value*> object_value_boolean_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_BOOLEAN)
    };
    llvm::Value* object_value_boolean_field = context.builder->CreateGEP(context.object_type, object_value, object_value_boolean_field_indices);
    context.builder->CreateStore(boolean_value, object_value_boolean_field);

    return object_value;
}

void CreateStoreNumber(llvm::Value* object_value, llvm::Value* number_value) {
    auto& context = Codegen::Context::Get();

    std::vector<llvm::Value*> object_value_number_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_NUMBER)
    };
    llvm::Value* object_value_number_field = context.builder->CreateGEP(context.object_type, object_value, object_value_number_field_indices);
    context.builder->CreateStore(number_value, object_value_number_field);
}

void CreateStoreBoolean(llvm::Value* object_value, llvm::Value* boolean_value) {
    auto& context = Codegen::Context::Get();

    std::vector<llvm::Value*> object_value_boolean_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_BOOLEAN)
    };
    llvm::Value* object_value_boolean_field = context.builder->CreateGEP(context.object_type, object_value, object_value_boolean_field_indices);
    context.builder->CreateStore(boolean_value, object_value_boolean_field);
}

llvm::Value* CreateLoadNumber(llvm::Value* object_value) {
    auto& context = Codegen::Context::Get();

    std::vector<llvm::Value*> object_value_number_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_NUMBER)
    };
    llvm::Value* object_value_number_field = context.builder->CreateGEP(context.object_type, object_value, object_value_number_field_indices);
    llvm::Value* object_value_number = context.builder->CreateLoad(context.BuilderGetNumberType(), object_value_number_field);

    return object_value_number;
}

llvm::Value* CreateLoadBoolean(llvm::Value* object_value) {
    auto& context = Codegen::Context::Get();

    std::vector<llvm::Value*> object_value_boolean_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_BOOLEAN)
    };
    llvm::Value* object_value_boolean_field = context.builder->CreateGEP(context.object_type, object_value, object_value_boolean_field_indices);
    llvm::Value* object_value_boolean = context.builder->CreateLoad(context.builder->getInt1Ty(), object_value_boolean_field);

    return object_value_boolean;
}

void CreateObjectTypeCheck(llvm::Value* object_value, ObjectType type) {
    auto& context = Codegen::Context::Get();

    static std::string msg{"Type check failed"};
    static llvm::Value* msg_global = context.builder->CreateGlobalStringPtr(msg, "type_check_symbol_global");

    std::vector<llvm::Value*> object_value_type_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_TYPE)
    };
    llvm::Value* object_value_type_field = context.builder->CreateGEP(context.object_type, object_value, object_value_type_field_indices);
    llvm::Value* object_value_type = context.builder->CreateLoad(context.BuilderGetNumberType(), object_value_type_field);

    std::vector<llvm::Value*> assert_function_call_arguments = {
        context.builder->CreateICmpEQ(object_value_type, context.BuilderGetNumber(type)),
        msg_global,
        object_value
    };
    llvm::Function* assert_function = context.llvm_module->getFunction("__GLAssert");
    context.builder->CreateCall(assert_function, assert_function_call_arguments);
}

void CreateObjectTypeCheck(llvm::Value* object_value, ObjectType type, llvm::BasicBlock* true_branch, llvm::BasicBlock* false_branch) {
    auto& context = Codegen::Context::Get();

    std::vector<llvm::Value*> object_value_type_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_TYPE)
    };
    llvm::Value* object_value_type_field = context.builder->CreateGEP(context.object_type, object_value, object_value_type_field_indices);
    llvm::Value* object_value_type = context.builder->CreateLoad(context.BuilderGetNumberType(), object_value_type_field);

    llvm::Value* is_type_check = context.builder->CreateICmpEQ(object_value_type, context.BuilderGetNumber(type), "is_type_check");
    context.builder->CreateCondBr(is_type_check, true_branch, false_branch);
}

void CreateIsIntegerCheck(llvm::Value* number_object) {
    auto& context = Codegen::Context::Get();

    static std::string msg{"Integer check failed"};
    static llvm::Value* msg_global = context.builder->CreateGlobalStringPtr(msg, "integer_check_symbol_global");

    llvm::Value* number_value = Codegen::CreateLoadNumber(number_object);
    llvm::Value* number_value_reminder = context.builder->CreateSRem(number_value, context.BuilderGetNumber(PRECISION));

    std::vector<llvm::Value*> assert_function_call_arguments = { 
        context.builder->CreateICmpEQ(number_value_reminder, context.BuilderGetNumber(0)),
        msg_global,
        number_object
    };
    llvm::Function* assert_function = context.llvm_module->getFunction("__GLAssert");
    context.builder->CreateCall(assert_function, assert_function_call_arguments);
}

llvm::Value* CreateIsZeroThenOneCheck(llvm::Value* number_value) {
    auto& context = Codegen::Context::Get();
    auto old_branch = context.builder->GetInsertBlock();

    auto& llvm_context = context.llvm_context.value();
    llvm::Function* current_function = context.builder->GetInsertBlock()->getParent();
    llvm::BasicBlock* modify_branch = llvm::BasicBlock::Create(llvm_context, "modify_branch", current_function);
    llvm::BasicBlock* continue_branch = llvm::BasicBlock::Create(llvm_context, "continue_branch", current_function);

    llvm::Value* is_not_zero = context.builder->CreateICmpNE(number_value, context.BuilderGetNumber(0), "is_zero_then_one_check");
    context.builder->CreateCondBr(is_not_zero, continue_branch, modify_branch);

    context.builder->SetInsertPoint(modify_branch);
    llvm::Value* one = context.BuilderGetNumber(1);
    context.builder->CreateBr(continue_branch);
    modify_branch = context.builder->GetInsertBlock();

    context.builder->SetInsertPoint(continue_branch);
    llvm::PHINode* ans = context.builder->CreatePHI(context.BuilderGetNumberType(), 2);
    ans->addIncoming(one, modify_branch);
    ans->addIncoming(number_value, old_branch);
    continue_branch = context.builder->GetInsertBlock();

    return ans;
}

} // namespace Codegen