#include <scheme/scheme.hpp>

#include <iostream>
#include <fstream>
#include <stack>
#include <iostream>

enum class Mode : int32_t {
    MODE_REPL = 0,
    MODE_INTERP = 1,
    MODE_CODEGEN = 2
};

int main(int argc, char** argv) try {
    Scheme::Scheme scheme;
    std::string expression;
    std::cout << "Scheme 1.0.0\n";

    if (argc < 2) {
        std::cout << "usage: ./SchemeInterp.exe <mode> <file>" << std::endl;
        std::cout << "modes: 0 - repl (without file)" << std::endl;
        std::cout << "       1 - interp (with file)" << std::endl;
        std::cout << "       2 - codegen (with file)" << std::endl;
        return 1;
    }
    Mode mode = static_cast<Mode>(std::strtol(argv[1], nullptr, 10));

    switch (mode) {
        case Mode::MODE_REPL: {
            while (std::cin) {
                std::cout << ">>> ";
                std::getline(std::cin, expression);
                if (expression.empty()) {
                    continue;
                }
                try {
                    std::cout << scheme.Evaluate(expression);
                } catch (const std::runtime_error& ex) {
                    std::cout << ex.what();
                }
                std::cout << '\n';
            }
        } break;
        case Mode::MODE_INTERP:
        case Mode::MODE_CODEGEN: {
            if (argc < 3) {
                std::cout << "usage: ./SchemeInterp.exe <mode> <file>" << std::endl;
                std::cout << "modes: 0 - repl (without file)" << std::endl;
                std::cout << "       1 - interp (with file)" << std::endl;
                std::cout << "       2 - codegen (with file)" << std::endl;
                return 1;
            }

            std::string last_expression;
            std::stack<std::pair<std::string, size_t>> file_loader_stack{};

            std::string init_filename{argv[2]};
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
                    if (file_loader_stack.top().first[buffer_idx] == '(' ||
                        (
                            file_loader_stack.top().first[buffer_idx] == '\'' 
                            &&
                            (buffer_idx + 1 < file_loader_stack.top().first.size())
                            &&
                            file_loader_stack.top().first[buffer_idx + 1] == '('
                        )
                    ) {
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
                                if (mode == Mode::MODE_INTERP) {
                                    scheme.Evaluate(last_expression);
                                } else {
                                    scheme.Codegen(last_expression);
                                }
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

            if (mode == Mode::MODE_INTERP) {
                std::cout << "Interp done!" << std::endl;
            } else {
                std::cout << "Codegen done!" << std::endl;
            }
        } break;
        default: {
            std::cout << "Wrong mode chosen!" << std::endl;
            return 2;
        }
    }

    return 0;
} catch (std::exception& e) {
    std::cout << e.what() << std::endl;
    return 0;
}