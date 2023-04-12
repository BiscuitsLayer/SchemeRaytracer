#include "instruction.hpp"

namespace Sim {

Instruction::Instruction(CodeType code)
{
    opcode = code >> 24;
    r1 = (code >> 20) & 0xF;
    r2 = (code >> 16) & 0xF;
    r3_imm = code & 0xFFFF;
}

Instruction::Instruction(std::stringstream &input_stream)
{
    std::string op_name;
    input_stream >> op_name;

    auto& context = Sim::Context::Get();
    opcode = context.name_to_opcode.value()[op_name];

    std::string arguments;

    // handle instruction according to its type
    switch (opcode)
    {
    default:
    {
        throw std::runtime_error("Instruction: cannot create from given opcode");
    }
    break;

// getting only asm args from ISA string
#define _ISA(_opcode, _name, _execute, _asmargs, _disasmargs, _dumpregs) \
    case _opcode:                                                        \
    {                                                                    \
        _asmargs                                                         \
    }                                                                    \
    break;

// list of all instructions
#include "ISA.hpp"

#undef _ISA
    }
}

std::string Instruction::Disassemle() const
{
    std::stringstream ans;

    // handle instruction according to its type
    switch (opcode)
    {
    default:
    {
        throw std::runtime_error("Instruction: Disassemble: opcode not found");
    }
    break;

// getting only disasm args from ISA string
#define _ISA(_opcode, _name, _execute, _asmargs, _disasmargs, _dumpregs) \
    case _opcode:                                                        \
    {                                                                    \
        ans << #_name;                                                   \
        _disasmargs;                                                     \
    }                                                                    \
    break;

// list of all instructions
#include "ISA.hpp"

#undef _ISA
    }

    return ans.str();
}

std::string Instruction::DumpRegisters(std::shared_ptr<CPU> cpu)
{
    std::stringstream ans;

    // handle instruction according to its type
    switch (opcode)
    {
    default:
    {
        throw std::runtime_error("Instruction: DumpRegisters: opcode not found");
    }
    break;

// getting only register info from ISA string
#define _ISA(_opcode, _name, _execute, _asmargs, _disasmargs, _dumpregs) \
    case _opcode:                                                        \
    {                                                                    \
        _dumpregs;                                                       \
    }                                                                    \
    break;

// list of all instructions
#include "ISA.hpp"

#undef _ISA
    }

    return ans.str();
}

CodeType Instruction::GetCode() const
{
    return (opcode << 24) | (r1 << 20) | (r2 << 16) | (r3_imm & 0xFFFF);
}

} // namespace Sim