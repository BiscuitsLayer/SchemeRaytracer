cmake_minimum_required(VERSION 3.10)
project(CPU0)

# add_executable(${PROJECT_NAME} cpu0.cpp)

include_directories(include/ELFIO)
add_executable(${PROJECT_NAME} src/main.cpp)