#include <sstream>

#include "../context/context.hpp"
#include "../cpu/cpu.hpp"

namespace Sim {

class Instruction {
public:
    OpcodeType opcode;
    RegisterType r1;
    RegisterType r2;
    ImmOrRegisterType r3_imm;

    Instruction(CodeType code);
    Instruction(std::stringstream& input_stream);

    std::string Disassemle() const;
    std::string DumpRegisters(std::shared_ptr<CPU> cpu);
    CodeType GetCode() const;
};

} // namespace Sim