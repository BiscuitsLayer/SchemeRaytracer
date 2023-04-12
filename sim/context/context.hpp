#pragma once

#include <optional>
#include <string>
#include <map>

namespace Sim {

constexpr uint32_t MEMORY_SIZE = 65536u;

using PCType = uint32_t;

using OpcodeType = uint32_t;
using RegisterType = uint32_t;
using ImmOrRegisterType = uint32_t;

using CodeType = uint32_t;
using MemoryDataType = uint32_t;

enum Register : int {
    R0 = 0,
    R1,
    R2,
    R3,
    R4,
    R5,
    R6,
    R7,
    R8,
    R9,
    R10,
    R11,
    R12,
    R13,
    R14,
    R15,
    COUNT
};

/*
    Singleton class to share
    application resources between files
*/
struct Context {
public:
    static Context& Get();

    Context(const Context&) = delete;
    Context& operator=(Context&) = delete;

    std::optional<std::map<std::string, OpcodeType>> name_to_opcode;

private:
    Context();
};

static bool isNumber(std::string &std) {
    return std::find_if(std.begin(), std.end(), [](unsigned char c) { 
        return !std::isdigit(c); 
        }) == std.end();
}

} // namespace Sim
