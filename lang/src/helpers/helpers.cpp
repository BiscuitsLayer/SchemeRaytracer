#include "helpers.hpp"

#include <external/external.hpp>

namespace Interp {

std::string ObjectToString(std::shared_ptr<Object> value) {
    std::string ans{};

    if (!value) {
        ans = "()";
    } else if (Is<Number>(value)) {
        int64_t unhandled_value = As<Number>(value)->GetValue();
        if (unhandled_value % PRECISION == 0) {
            int64_t value = unhandled_value / PRECISION;
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
        throw std::runtime_error("Unimplemented");
    }

    return ans;
}

std::vector<std::shared_ptr<Object>> ListToVector(std::shared_ptr<Object> init) {
    std::vector<std::shared_ptr<Object>> ans{};
    for (std::shared_ptr<Cell> cell = As<Cell>(init); cell; cell = As<Cell>(cell->GetSecond())) {
        std::shared_ptr<Object> obj = cell->GetFirst();
        if (!obj && !cell->GetSecond()) {
            return ans;
        }
        ans.push_back(obj);
    }
    return ans;
}

std::string ListToString(std::shared_ptr<Object> init) {
    std::string ans = "(";
    for (std::shared_ptr<Cell> cell = As<Cell>(init); cell; cell = As<Cell>(cell->GetSecond())) {
        std::shared_ptr<Object> first = cell->GetFirst();
        if (!first) {
            ans += ")";
            return ans;
        }

        std::string value = ObjectToString(first);
        std::shared_ptr<Object> second = cell->GetSecond();
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

std::shared_ptr<Object> BuildLambda(std::shared_ptr<Object> init, std::shared_ptr<Scope> scope, bool eval_immediately) {
    std::vector<std::shared_ptr<Object>> arguments = ListToVector(init);

    std::vector<std::shared_ptr<Object>> commands{};
    std::vector<std::string> arguments_idx_to_name{};

    if (arguments.size() < 2) {
        throw SyntaxError("More than 1 argument required for \"BuildLambda\" function");
    }

    int64_t argument_idx = 0;

    if (!eval_immediately) {
        // Handle lambda arguments
        if (arguments[argument_idx] && !Is<Cell>(arguments[argument_idx]) && !eval_immediately) {
            throw RuntimeError(
                "\"BuildLambda\" error: first argument (lambda arguments) is not a list");
        }
        std::shared_ptr<Cell> lambda_arg_init = As<Cell>(arguments[argument_idx]);
        for (std::shared_ptr<Cell> cell = As<Cell>(lambda_arg_init); cell;
             cell = As<Cell>(cell->GetSecond())) {
            if (!Is<Symbol>(cell->GetFirst())) {
                throw RuntimeError(
                    "\"BuildLambda\" error: first argument (lambda arguments): not a symbol met");
            }
            std::string argument_name = As<Symbol>(cell->GetFirst())->GetName();
            arguments_idx_to_name.push_back(argument_name);
        }

        // Prepare for lambda body
        ++argument_idx;
    }

    // Handle lambda body
    if (!Is<Cell>(arguments[argument_idx])) {
        throw RuntimeError("\"Lambda\" error: second argument (body) is not a list");
    }

    for (; argument_idx < arguments.size(); ++argument_idx) {
        commands.push_back(arguments[argument_idx]);
    }

    std::shared_ptr<Object> ans;
    
    if (!eval_immediately) {
        // If we do not evaluate immediately, we create a new scope and fill with variables
        auto scope_variables = scope->GetVariablesMap();
        std::shared_ptr<Scope> self_scope = std::make_shared<Scope>();
        for (auto& [name, value] : scope_variables) {
            self_scope->SetVariableValue(name, value);
        }
        ans = std::make_shared<Lambda>(commands, arguments_idx_to_name, self_scope);
    } else {
        // If we evaluate immediately, this means we are using "begin" keyword and don't need a new scope
        ans = std::make_shared<Lambda>(commands, arguments_idx_to_name, scope);
    }
    return ans;
}

std::pair<std::string, std::shared_ptr<Object>> BuildLambdaSugar(
    std::vector<std::shared_ptr<Object>> parts, std::shared_ptr<Scope> scope) {
    if (parts.size() != 2) {
        throw SyntaxError("Exactly 2 arguments required for \"BuildLambdaSugar\" function");
    }

    std::vector<std::shared_ptr<Object>> arguments = ListToVector(parts[0]);
    std::shared_ptr<Object> command = parts[1];

    std::vector<std::shared_ptr<Object>> commands{};
    std::vector<std::string> arguments_idx_to_name{};
    std::shared_ptr<Scope> self_scope = std::make_shared<Scope>();

    std::string lambda_name = As<Symbol>(arguments[0])->GetName();
    for (size_t argument_idx = 1; argument_idx < arguments.size(); ++argument_idx) {
        if (!Is<Symbol>(arguments[argument_idx])) {
            throw SyntaxError("\"BuildLambdaSugar\" function error: argument passed is not a symbol");
        }
        std::string argument_name = As<Symbol>(arguments[argument_idx])->GetName();
        arguments_idx_to_name.push_back(argument_name);
    }
    commands.push_back(command);

    auto scope_variables = scope->GetVariablesMap();
    for (auto& [name, value] : scope_variables) {
        self_scope->SetVariableValue(name, value);
    }

    std::shared_ptr<Object> ans =
        std::make_shared<Lambda>(commands, arguments_idx_to_name, self_scope);
    return std::make_pair(lambda_name, ans);
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
    llvm::PointerType* object_ptr_type = llvm::PointerType::get(object_type, 0);
    object_type->setName("SchemeObject");
    std::vector<llvm::Type*> object_type_subtypes = {
        builder->getInt64Ty(),   // type enum
        builder->getInt64Ty(),   // number
        builder->getInt1Ty(),    // boolean
        builder->getInt8PtrTy(), // string
        object_ptr_type,        // pointer to itself (first)
        object_ptr_type         // pointer to itself (second)
    };
    object_type->setBody(object_type_subtypes);

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
            builder->getInt8PtrTy(), 
            builder->getInt8PtrTy(), 
            builder->getInt8PtrTy(), 
            builder->getInt8PtrTy(), 
            builder->getInt8PtrTy()
        }
    );
    SetExternalFunction("__GLIsOpen", object_type, {});
    SetExternalFunction("__GLDraw", builder->getVoidTy(), {});
    SetExternalFunction("__GLFinish", builder->getVoidTy(), {});
    SetExternalFunction("__GLPrint", builder->getVoidTy(),
        { 
            builder->getInt8PtrTy()
        }
    );
    SetExternalFunction("__GLAssert", builder->getVoidTy(),
        { 
            builder->getInt1Ty()
        }
    );
    SetExternalFunction("__GLExpt", object_type,
        { 
            builder->getInt8PtrTy(),
            builder->getInt8PtrTy()
        }
    );
    SetExternalFunction("__GLSqrt", object_type,
        { 
            builder->getInt8PtrTy()
        }
    );
}

void Context::SetExternalFunction(std::string name, llvm::Type* return_value_type, const std::vector<llvm::Type*>& argument_types) {
    llvm::FunctionType* function_type = llvm::FunctionType::get(return_value_type, argument_types, false);
    llvm::Function* function = llvm::Function::Create(function_type, llvm::Function::ExternalLinkage, name, llvm_module.value());
}

llvm::Value* CreateStoreNewCell() {
    auto& context = Codegen::Context::Get();
    llvm::Value* object_value = context.builder->CreateAlloca(context.object_type, nullptr);

    std::vector<llvm::Value*> object_value_type_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_TYPE)
    };
    llvm::Value* object_value_type_field = context.builder->CreateGEP(context.object_type, object_value, object_value_type_field_indices);
    context.builder->CreateStore(context.builder->getInt64(ObjectType::TYPE_CELL), object_value_type_field);

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

llvm::Value* CreateStoreNewNumber(int64_t number) {
    auto& context = Codegen::Context::Get();
    llvm::AllocaInst* object_value = context.builder->CreateAlloca(context.object_type, nullptr, "number");

    std::vector<llvm::Value*> object_value_type_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_TYPE)
    };
    llvm::Value* object_value_type_field = context.builder->CreateGEP(context.object_type, object_value, object_value_type_field_indices);
    context.builder->CreateStore(context.builder->getInt64(ObjectType::TYPE_NUMBER), object_value_type_field);

    std::vector<llvm::Value*> object_value_number_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_NUMBER)
    };
    llvm::Value* object_value_number_field = context.builder->CreateGEP(context.object_type, object_value, object_value_number_field_indices);
    context.builder->CreateStore(context.builder->getInt64(number), object_value_number_field);

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
    context.builder->CreateStore(context.builder->getInt64(ObjectType::TYPE_SYMBOL), object_value_type_field);

    std::vector<llvm::Value*> object_value_symbol_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_SYMBOL)
    };
    llvm::Value* object_value_symbol_field = context.builder->CreateGEP(context.object_type, object_value, object_value_symbol_field_indices);

    llvm::Value* symbol_global = context.builder->CreateGlobalString(symbol, "symbol_global");
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
    context.builder->CreateStore(context.builder->getInt64(ObjectType::TYPE_BOOLEAN), object_value_type_field);

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
    context.builder->CreateStore(context.builder->getInt64(ObjectType::TYPE_NUMBER), object_value_type_field);

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
    context.builder->CreateStore(context.builder->getInt64(ObjectType::TYPE_SYMBOL), object_value_type_field);

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
    context.builder->CreateStore(context.builder->getInt64(ObjectType::TYPE_BOOLEAN), object_value_type_field);

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

// void CreateStoreSymbol(llvm::Value* object_value, llvm::Value* symbol_value) {

// }

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
    llvm::Value* object_value_number = context.builder->CreateLoad(context.builder->getInt64Ty(), object_value_number_field);

    return object_value_number;
}

// TODO: implement
// llvm::Value* CreateLoadSymbol(llvm::Value* object_value) {
//     auto& context = Codegen::Context::Get();

//     std::vector<llvm::Value*> object_value_symbol_field_indices {
//         context.builder->getInt32(0), // because there is no array, so just the object itself
//         context.builder->getInt32(FieldType::FIELD_SYMBOL)
//     };
//     llvm::Value* object_value_symbol_field = context.builder->CreateGEP(context.object_type, object_value, object_value_symbol_field_indices);
//     llvm::Value* object_value_symbol = context.builder->CreateLoad(context.builder->getInt64Ty(), object_value_symbol_field);

//     return object_value_symbol;
// }

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

    std::vector<llvm::Value*> object_value_type_field_indices {
        context.builder->getInt32(0), // because there is no array, so just the object itself
        context.builder->getInt32(FieldType::FIELD_TYPE)
    };
    llvm::Value* object_value_type_field = context.builder->CreateGEP(context.object_type, object_value, object_value_type_field_indices);
    llvm::Value* object_value_type = context.builder->CreateLoad(context.builder->getInt64Ty(), object_value_type_field);

    std::vector<llvm::Value*> assert_function_call_arguments = { context.builder->CreateICmpEQ(object_value_type, context.builder->getInt64(type)) };
    llvm::Function* assert_function = context.llvm_module->getFunction("__GLAssert");
    context.builder->CreateCall(assert_function, assert_function_call_arguments);
}

void CreateIsIntegerCheck(llvm::Value* number_value) {
    auto& context = Codegen::Context::Get();
    llvm::Value* number_value_reminder = context.builder->CreateSRem(number_value, context.builder->getInt64(PRECISION));

    std::vector<llvm::Value*> assert_function_call_arguments = { context.builder->CreateICmpEQ(number_value_reminder, context.builder->getInt64(0)) };
    llvm::Function* assert_function = context.llvm_module->getFunction("__GLAssert");
    context.builder->CreateCall(assert_function, assert_function_call_arguments);
}

llvm::Value* CreateIsZeroThanOneCheck(llvm::Value* number_value) {
    auto& context = Codegen::Context::Get();
    auto old_branch = context.builder->GetInsertBlock();

    auto& llvm_context = context.llvm_context.value();
    llvm::Function* current_function = context.builder->GetInsertBlock()->getParent();
    llvm::BasicBlock* modify_branch = llvm::BasicBlock::Create(llvm_context, "modify_branch", current_function);
    llvm::BasicBlock* continue_branch = llvm::BasicBlock::Create(llvm_context, "continue_branch", current_function);

    llvm::Value* is_not_zero = context.builder->CreateICmpNE(number_value, context.builder->getInt64(0));
    context.builder->CreateCondBr(is_not_zero, continue_branch, modify_branch);

    context.builder->SetInsertPoint(modify_branch);
    llvm::Value* one = context.builder->getInt64(1);
    context.builder->CreateBr(continue_branch);
    modify_branch = context.builder->GetInsertBlock();

    context.builder->SetInsertPoint(continue_branch);
    llvm::PHINode* ans = context.builder->CreatePHI(context.builder->getInt64Ty(), 2);
    ans->addIncoming(one, modify_branch);
    ans->addIncoming(number_value, old_branch);
    continue_branch = context.builder->GetInsertBlock();

    return ans;
}

std::shared_ptr<Object> BuildLambdaCodegen(std::shared_ptr<Object> init, std::shared_ptr<Scope> scope, bool eval_immediately, std::optional<std::shared_ptr<Object>> ans) {
    auto& context = Codegen::Context::Get();

    // ARGUMENTS TO VECTOR
    std::vector<std::shared_ptr<Object>> arguments = Interp::ListToVector(init);
    std::shared_ptr<Scope> self_scope = std::make_shared<Scope>();

    // LLVM CTORS
    int temp_argument_counter = 0; // TODO: fix
    std::shared_ptr<Cell> lambda_arg_init = As<Cell>(arguments[0]);
    for (std::shared_ptr<Cell> cell = As<Cell>(lambda_arg_init); cell; cell = As<Cell>(cell->GetSecond())) {
        ++temp_argument_counter;
    }
    int arguments_count = eval_immediately ? 0 : temp_argument_counter;
    std::vector<llvm::Type*> new_function_arguments(arguments_count, context.builder->getInt8PtrTy());
    llvm::FunctionType* new_function_type = llvm::FunctionType::get(context.object_type, new_function_arguments, false);
    

    //// TODO: SO BAD CODE
    llvm::Function* new_function = nullptr;
    if (ans.has_value()) {
        new_function = As<Lambda>(ans.value())->function_;
    } else {
        new_function = llvm::Function::Create(new_function_type, llvm::Function::ExternalLinkage, "LambdaFunction", context.llvm_module.value());
    }
    // llvm::Function* new_function = llvm::Function::Create(new_function_type, llvm::Function::ExternalLinkage, "LambdaFunction", context.llvm_module.value());
    
    
    assert(new_function->empty());
    
    // SET INSERT POINT
    llvm::BasicBlock* old_insert_point = context.builder->GetInsertBlock();
    auto& llvm_context = context.builder->getContext();
    llvm::BasicBlock* new_function_main = llvm::BasicBlock::Create(llvm_context, "entry", new_function);
    context.builder->SetInsertPoint(new_function_main);

    // HANDLE ARGUMENTS
    std::vector<std::string> arguments_idx_to_name{};
    if (arguments.size() < 2) {
        throw SyntaxError("More than 1 argument required for \"BuildLambda\" function");
    }
    int64_t argument_idx = 0;

    if (!eval_immediately) {
        // Handle lambda arguments
        if (arguments[argument_idx] && !Is<Cell>(arguments[argument_idx]) && !eval_immediately) {
            throw RuntimeError("\"BuildLambda\" error: first argument (lambda arguments) is not a list");
        }
        std::shared_ptr<Cell> lambda_arg_init = As<Cell>(arguments[argument_idx]);
        for (std::shared_ptr<Cell> cell = As<Cell>(lambda_arg_init); cell; cell = As<Cell>(cell->GetSecond())) {
            if (!Is<Symbol>(cell->GetFirst())) {
                throw RuntimeError("\"BuildLambda\" error: first argument (lambda arguments): not a symbol met");
            }
            std::string argument_name = As<Symbol>(cell->GetFirst())->GetName();
            arguments_idx_to_name.push_back(argument_name);
        }

        for (int idx = 0; idx < arguments_idx_to_name.size(); ++idx) {
            llvm::Value* argument_value = new_function->getArg(idx);
            self_scope->SetVariableValueCodegen(arguments_idx_to_name[idx], argument_value);
        }

        // Prepare for lambda body
        ++argument_idx;
    }

    // Handle lambda body
    if (!Is<Cell>(arguments[argument_idx])) {
        throw RuntimeError("\"Lambda\" error: second argument (body) is not a list");
    }

    if (!ans.has_value()) {
        ans = std::make_shared<Lambda>(nullptr, nullptr);
    }
    
    if (!eval_immediately) {
        // If we do not evaluate immediately, we create a new scope and fill with variables
        auto scope_variables = scope->GetVariablesMap();
        for (auto& [name, value] : scope_variables) {
            self_scope->SetVariableValue(name, value);
        }

        llvm::Value* return_value = nullptr;
        // CODEGEN COMMANDS
        for (; argument_idx < arguments.size(); ++argument_idx) {
            return_value = arguments[argument_idx]->Codegen({}, self_scope);
        }
        // TODO: fix function return value

        std::vector<llvm::Value*> return_value_scheme_object_indices {
            context.builder->getInt32(0), // because there is no array, so just the object itself
        };
        llvm::Value* return_value_scheme_object_field = context.builder->CreateGEP(context.object_type, return_value, return_value_scheme_object_indices);
        llvm::Value* return_value_scheme_object = context.builder->CreateLoad(context.object_type, return_value_scheme_object_field);
        context.builder->CreateRet(return_value_scheme_object);

        // ANS = BUILT LAMBDA
        // ans = std::make_shared<Lambda>(new_function, self_scope);
        As<Lambda>(ans.value())->function_ = new_function;
        As<Lambda>(ans.value())->self_scope_ = self_scope;
    } else {
        llvm::Value* return_value = nullptr;
        // CODEGEN COMMANDS
        for (; argument_idx < arguments.size(); ++argument_idx) {
            return_value = arguments[argument_idx]->Codegen({}, scope);
        }
        // TODO: fix function return value
        context.builder->CreateRet(return_value);
        
        // ANS = BUILT LAMBDA
        // If we evaluate immediately, this means we are using "begin" keyword and don't need a new scope
        // ans = std::make_shared<Lambda>(new_function, scope);
        As<Lambda>(ans.value())->function_ = new_function;
        As<Lambda>(ans.value())->self_scope_ = scope;
    }

    llvm::verifyFunction(*new_function);
    context.builder->SetInsertPoint(old_insert_point);
    return ans.value();
}

} // namespace Codegen