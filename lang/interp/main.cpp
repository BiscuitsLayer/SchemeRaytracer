#include <scheme.h>

#include <iostream>
#include <fstream>
#include <stack>

std::string last_expression;

int main(int argc, char** argv) try {
    Scheme scheme;
    std::cout << "Scheme 1.0.0\n";

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
                        auto result = scheme.Evaluate(last_expression);
                        std::cout << "Result: " << result << std::endl;
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

    return 0;

} catch (const std::runtime_error& ex) {
    std::cout << ex.what() << std::endl;
    std::cout << "Expression: " << last_expression << std::endl;
}