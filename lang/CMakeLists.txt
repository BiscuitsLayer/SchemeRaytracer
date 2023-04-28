cmake_minimum_required(VERSION 3.10)
project(Scheme)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/tools/cmake")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}")

find_package(Catch REQUIRED)

find_package(LLVM REQUIRED PATHS "D:/smartcar/LLVM0task/llvm-project/build" NO_DEFAULT_PATH)
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

### OOGL ###
set(OOGL_DIR "../include/OOGL")
set(OOGL_INCLUDE_DIR "${OOGL_DIR}/include")
set(OOGL_BINARY_DIR "${CMAKE_BINARY_DIR}/lib/OOGL")
add_subdirectory(${OOGL_DIR} ${OOGL_BINARY_DIR})
include_directories(${OOGL_INCLUDE_DIR})

# Library scheme
file(GLOB SRC "src/*/*.cpp")
add_library(libscheme ${SRC})
target_include_directories(libscheme PUBLIC src)
target_link_libraries(libscheme PUBLIC ${OPENGL_LIBRARIES} OOGL)

# Main
include_directories("src")
file(GLOB SRC_REPL "src/main.cpp")
add_executable(SchemeMain ${SRC_REPL})
target_link_libraries(SchemeMain libscheme)

# Link LLVM libraries to main target
include_directories(${LLVM_INCLUDE_DIRS})
separate_arguments(LLVM_DEFINITIONS_LIST NATIVE_COMMAND ${LLVM_DEFINITIONS})
add_definitions(${LLVM_DEFINITIONS_LIST})
llvm_map_components_to_libnames(llvm_libs support core irreader executionengine interpreter)
target_link_libraries(SchemeMain libscheme ${llvm_libs})

# Tests
file(GLOB SRC_TEST "test/*.cpp")
add_executable(SchemeTest ${SRC_TEST} ${SRC_CATCH})
target_link_libraries(SchemeTest libscheme contrib_catch_main)