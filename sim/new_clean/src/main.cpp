#include <elfio/elfio.hpp>
#include <iostream>

#include "context.hpp"
#include "instructions.hpp"

using namespace ELFIO;

int main(int argc, char** argv)
{
    if (argc != 2) {
        std::cout << "Usage: tutorial <elf_file>" << std::endl;
        return 1;
    }

    ELFIO::elfio reader;
    // Load ELF data
    if (!reader.load(argv[1])) {
        std::cout << "Can't find or process ELF file " << argv[1] << std::endl;
        return 2;
    }

    // Print ELF file properties
    std::cout << "ELF file class : ";
    if (reader.get_class() == ELFCLASS32)
        std::cout << "ELF32" << std::endl;
    else
        std::cout << "ELF64" << std::endl;

    std::cout << "ELF file encoding : ";
    if (reader.get_encoding() == ELFDATA2LSB)
        std::cout << "Little endian" << std::endl;
    else
        std::cout << "Big endian" << std::endl;

    // Print ELF file sections info
    Elf_Half sec_num = reader.sections.size();
    std::cout << "Number of sections: " << sec_num << std::endl;
    for (int i = 0; i < sec_num; ++i) {
        const section* psec = reader.sections[i];
        std::cout << " [" << i << "] "
                  << psec->get_name()
                  << "\t"
                  << psec->get_type()
                  << "\t"
                  << psec->get_size()
                  << std::endl;
        // Access section's data
        const char* p = reader.sections[i]->get_data();
    }

    // Print ELF file segments info
    Elf_Half seg_num = reader.segments.size();
    std::cout << "Number of segments: " << seg_num << std::endl;
    for (int i = 0; i < seg_num; ++i) {
        const segment* pseg = reader.segments[i];
        std::cout << " [" << i << "] 0x" << std::hex
                  << pseg->get_flags()
                  << "\t0x"
                  << pseg->get_virtual_address()
                  << "\t0x"
                  << pseg->get_file_size()
                  << "\t0x"
                  << pseg->get_memory_size()
                  << std::endl;
        // Access segments's data
        const char* p = reader.segments[i]->get_data();
    }

    SimContext context;

    // Allocate memory
    // context.memory = new uint8_t [0xFFFFFFFF] ();
    context.memory = std::vector<uint8_t>(0xFFFFFFFF, 0);

    // PC
    context.entry = 0;
    context.registers[15] = context.entry;

    // Stack memory
    context.stack_start = reinterpret_cast<uint8_t*>(
        reinterpret_cast<uint32_t>(context.memory.data()) + 0x000000);
    context.stack_end = reinterpret_cast<uint8_t*>(
        reinterpret_cast<uint32_t>(context.memory.data()) + context.entry);
    context.registers[13] = context.entry;

    for (int i = 0; i < sec_num; ++i) {

        const auto& section = reader.sections[i];
        if (section->get_name() != ".text") {
            continue;
        }
        // const section* psec = reader.sections[i];
        // if (psec->get_type() != ELFIO::PT_TEXT)

        const uint8_t* section_data = reinterpret_cast<const uint8_t*>(section->get_data());
        // assert(segment_data);

        context.entry = section->get_offset();;
        context.registers[15] = context.entry;

        std::memcpy(context.memory.data() + static_cast<uint32_t>(section->get_offset()), 
                    reinterpret_cast<const char *>(section_data),
                    static_cast<size_t>(section->get_size()) * sizeof(uint8_t));
    }

    int i = 0;
    while (i++ < 0x524) {
        std::cout << std::hex << "PC = " << context.registers[15] - context.entry << std::endl;
        context.ir = *(uint32_t *)((size_t)context.memory.data() + context.registers[15]); //fetch code
        context.registers[15] += sizeof(uint32_t);

        context.op = (context.ir & 0x000000FF) >> 4*0;

        if (OP_CODES.find(context.op) != OP_CODES.end()) {
            OP_CODES[context.op](context);

            std::cout << std::hex << (int32_t)context.ra << std::endl;
            std::cout << std::hex << (int32_t)context.rb << std::endl;
            std::cout << std::hex << (int32_t)context.rc << std::endl;
            std::cout << std::hex << (int32_t)context.cx << std::endl;
        }
    }

    return 0;
}