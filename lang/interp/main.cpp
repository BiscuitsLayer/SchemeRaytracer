#include <scheme.h>

#include <iostream>
#include <fstream>
#include <stack>

std::string last_expression;

int main(int argc, char** argv) {
    Scheme scheme;
    std::cout << "Scheme 1.0.0\n";

    // CODEGEN
    llvm::LLVMContext context;
    std::shared_ptr<llvm::Module> module = std::make_shared<llvm::Module>("scheme.ll", context);
    llvm::IRBuilder<> builder{context};

    // declare void @main()
    llvm::FunctionType* funcType = llvm::FunctionType::get(builder.getInt32Ty(), false);
    llvm::Function* mainFunc = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "main", module.get());
    llvm::BasicBlock* entryBB = llvm::BasicBlock::Create(context, "entry", mainFunc);
    builder.SetInsertPoint(entryBB);

    // CREATE OBJECT CLASS
    llvm::StructType* object_type = llvm::StructType::create(context);
    llvm::PointerType* object_ptr_type = llvm::PointerType::get(object_type, 0);
    object_type->setName("SchemeObject");
    std::vector<llvm::Type*> object_type_subtypes = {
        builder.getInt64Ty(), // type
        builder.getInt64Ty(), // number
        builder.getInt1Ty(), // boolean
        builder.getInt8PtrTy(), // string
        object_ptr_type, // pointer to itself (first)
        object_ptr_type // pointer to itself (second)
    };
    object_type->setBody(object_type_subtypes);

    scheme.basic_block_stack.push(entryBB);
    scheme.object_type = object_type;

    std::vector<llvm::Type*> function_arguments;
    llvm::Function* function;


    // CODEGEN EXTERNAL FUNCTIONS
    function_arguments = {};
    funcType = llvm::FunctionType::get(builder.getVoidTy(), function_arguments, false);
    function = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "__GLInit", module.get());
    
    function_arguments = {};
    funcType = llvm::FunctionType::get(builder.getVoidTy(), function_arguments, false);
    function = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "__GLClear", module.get());

    // function_arguments = { object_type, object_type, object_type, object_type, object_type };
    function_arguments = { builder.getInt8PtrTy(), builder.getInt8PtrTy(), builder.getInt8PtrTy(), builder.getInt8PtrTy(), builder.getInt8PtrTy() };
    funcType = llvm::FunctionType::get(builder.getVoidTy(), function_arguments, false);
    function = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "__GLPutPixel", module.get());

    function_arguments = {};
    funcType = llvm::FunctionType::get(object_type, function_arguments, false);
    function = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "__GLIsOpen", module.get());

    function_arguments = {};
    funcType = llvm::FunctionType::get(builder.getVoidTy(), function_arguments, false);
    function = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "__GLDraw", module.get());

    function_arguments = {};
    funcType = llvm::FunctionType::get(builder.getVoidTy(), function_arguments, false);
    function = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "__GLFinish", module.get());

    function_arguments = { builder.getInt8PtrTy() };
    funcType = llvm::FunctionType::get(builder.getVoidTy(), function_arguments, false);
    function = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "__GLPrint", module.get());

    function_arguments = { builder.getInt1Ty() };
    funcType = llvm::FunctionType::get(builder.getVoidTy(), function_arguments, false);
    function = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "__GLAssert", module.get());

    function_arguments = { builder.getInt8PtrTy(), builder.getInt8PtrTy() };
    funcType = llvm::FunctionType::get(object_type, function_arguments, false);
    function = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "__GLExpt", module.get());

    function_arguments = { builder.getInt8PtrTy() };
    funcType = llvm::FunctionType::get(object_type, function_arguments, false);
    function = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "__GLSqrt", module.get());
    // CODEGEN EXTERNAL FUNCTIONS


    // CODEGEN

    if (argc != 2) {
        std::cout << "usage: ./SchemeInterp.exe file.scm" << std::endl;
        return 1;
    }

    std::stack<std::pair<std::string, size_t>> file_loader_stack{};

    std::string init_filename{argv[1]};
    auto init_folder_end_idx = init_filename.find_last_of("/");
    if (init_folder_end_idx == std::string::npos) {
        init_folder_end_idx = init_filename.find_last_of("\\");
    }
    std::string init_folder = init_filename.substr(0, init_folder_end_idx + 1);
    std::ifstream instream{init_filename, std::ifstream::binary};
    if (!instream) {
        throw std::runtime_error("Error opening input file");
    }

    instream.seekg(0, instream.end);
    int init_length = instream.tellg();
    instream.seekg(0, instream.beg);

    std::string init_buffer(init_length, 0);
    instream.read(init_buffer.data(), init_length);
    instream.close();

    file_loader_stack.push(std::make_pair(init_buffer, 0));

    while (!file_loader_stack.empty()) {
        int expression_start = 0;
        int bracket_counter = 0;
        int buffer_idx = file_loader_stack.top().second;

        for (; buffer_idx < file_loader_stack.top().first.size(); ++buffer_idx) {
            if (file_loader_stack.top().first[buffer_idx] == ';') {
                while ((file_loader_stack.top().first[buffer_idx] != '\n') && (buffer_idx < file_loader_stack.top().first.size())) {
                    file_loader_stack.top().first[buffer_idx] = ' ';
                    ++buffer_idx;
                }
            }
            if (file_loader_stack.top().first[buffer_idx] == '(') {
                if (bracket_counter == 0) {
                    expression_start = buffer_idx;
                }
                ++bracket_counter;
            } else if (file_loader_stack.top().first[buffer_idx] == ')') {
                --bracket_counter;
                if (bracket_counter == 0) {
                    last_expression = file_loader_stack.top().first.substr(expression_start, buffer_idx - expression_start + 1);
                    std::cout << "got: " << last_expression << std::endl;

                    // Handle "load" case
                    if ((last_expression.size() > 5) && last_expression.substr(1, 4) == "load") {
                        file_loader_stack.top().second = buffer_idx + 1;

                        auto filename_start_idx = last_expression.find_first_of('\'') + 1;
                            
                        auto filename_end_idx = last_expression.find_last_of(')');
                        std::string filename = init_folder + last_expression .substr(
                            filename_start_idx, filename_end_idx - filename_start_idx
                        );
                        std::cout << "Loading file: " << filename << "..." << std::endl;

                        std::ifstream instream{std::string{filename}, std::ifstream::binary};
                        if (!instream) {
                            throw std::runtime_error("Error opening file: " + filename);
                        }

                        instream.seekg(0, instream.end);
                        int length = instream.tellg();
                        instream.seekg(0, instream.beg);

                        std::string buffer(length, 0);
                        instream.read(buffer.data(), length);
                        instream.close();

                        file_loader_stack.push(std::make_pair(buffer, 0));
                        break;
                    } else {
                        scheme.Codegen(last_expression, module, builder);
                        //auto result = scheme.Evaluate(last_expression);
                        //std::cout << "Result: " << result << std::endl;
                    }
                }
            } else {
                continue;
            }
        }

        if (buffer_idx >= file_loader_stack.top().first.size()) {
            file_loader_stack.pop();
        }
    }

    // CODEGEN
    scheme.basic_block_stack.pop();

    builder.CreateRet(builder.getInt32(0));
    std::error_code EC;
    llvm::raw_fd_ostream output_file("../codegen/outfile.ll", EC);
    module->print(output_file, nullptr);

    std::cout << "Codegen happened" << std::endl;
    // CODEGEN

    return 0;

}