#pragma once

#include <optional>
#include <sstream>
#include <array>
#include <map>

#include "../context/context.hpp"

namespace Sim {

class CPU {
public:
    CPU() {

    }

private:
    void HandleLabel(const std::string& input_string) {
        std::stringstream input_stream{input_string};
        uint32_t line_counter = 0;

        while (input_stream.rdbuf()->in_avail()) {
            std::string current_line;
            std::getline(input_stream, current_line);
            if (current_line.empty()) {
                continue;
            }

            // searching for label in current line
            auto found = current_line.find(':');
            if (found != std::string::npos) {
                auto label_name = current_line.substr(0, found);
                label_to_line_number_[label_name] = line_counter;
            }
        }
    }

    std::map<std::string, uint32_t> label_to_line_number_;
    std::array<MemoryDataType, MEMORY_SIZE> memory_;
    PCType current_pc_ = 0;
    PCType next_pc_ = 0;

    bool is_running_ = false;
};

} // namespace Sim