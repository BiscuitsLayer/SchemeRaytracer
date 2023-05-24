#pragma once

#include <array>
#include <memory>
#include <vector>

struct SimContext {
    // General
    uint32_t ir;
    std::array<int32_t, 16> registers;
    uint32_t memory_address_register;
    uint32_t memory_data_register;

    // Entry
    uint32_t entry;

    // Extend
    std::vector<uint8_t> memory;
    uint8_t* stack_start;
    uint8_t* stack_end;

    // Current instruction data
    uint8_t op;
    uint8_t ra, rb, rc;
    int64_t cx;
};