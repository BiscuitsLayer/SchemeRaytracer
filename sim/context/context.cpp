#include "context.hpp"

namespace Sim {

Context& Context::Get() {
    static Context instance;
    return instance;
}

Context::Context()
    : name_to_opcode(std::nullopt) {
        name_to_opcode.emplace();

        // getting only name and opcode from ISA string
        #define _ISA(_opcode, _name, _execute, _asmargs, _disasmargs, _dumpregs) \
        name_to_opcode.value()[#_name] = _opcode;                                \

        // list of all instructions
        #include "../ISA.hpp"

        #undef _ISA
    }

} // namesapce Sim