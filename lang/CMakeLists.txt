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
file(GLOB SRC "src/*.cpp" "src/graphics/graphics.cpp")
add_library(libscheme ${SRC})
target_include_directories(libscheme PUBLIC src)
target_link_libraries(libscheme PUBLIC ${OPENGL_LIBRARIES} OOGL)

# REPL mode
file(GLOB SRC_REPL "repl/main.cpp")
add_executable(SchemeRepl ${SRC_REPL})
target_link_libraries(SchemeRepl libscheme)

# Interpretator mode
file(GLOB SRC_INTERP "interp/main.cpp")
add_executable(SchemeInterp ${SRC_INTERP})
target_link_libraries(SchemeInterp libscheme)

include_directories(${LLVM_INCLUDE_DIRS})
separate_arguments(LLVM_DEFINITIONS_LIST NATIVE_COMMAND ${LLVM_DEFINITIONS})
add_definitions(${LLVM_DEFINITIONS_LIST})
llvm_map_components_to_libnames(llvm_libs support core irreader executionengine interpreter)
target_link_libraries(SchemeInterp libscheme ${llvm_libs})


# Testing
file(GLOB SRC_TEST "test/*.cpp")
add_executable(SchemeTest ${SRC_TEST} ${SRC_CATCH})
target_link_libraries(SchemeTest libscheme contrib_catch_main)

# # LLVM Codegen
# file(GLOB SRC_CODEGEN "codegen/main.cpp")
# include_directories(${LLVM_INCLUDE_DIRS})
# separate_arguments(LLVM_DEFINITIONS_LIST NATIVE_COMMAND ${LLVM_DEFINITIONS})
# add_executable(SchemeCodegen ${SRC_CODEGEN})

# {
#     "demangle", "support", "tablegen", "core", "fuzzmutate", 
#     "filecheck", "interfacestub", "irreader", "codegen", 
#     "selectiondag", "asmprinter", "mirparser", "globalisel", 
#     "binaryformat", "bitreader", "bitwriter", "bitstreamreader", 
#     "dwarflinker", "extensions", "frontendopenmp", "transformutils", 
#     "instrumentation", "aggressiveinstcombine", "instcombine", 
#     "scalaropts", "ipo", "vectorize", "objcarcopts", "coroutines", 
#     "cfguard", "linker", "analysis", "lto", "mc", "mcparser", 
#     "mcdisassembler", "mca", "object", "objectyaml", "option", 
#     "remarks", "debuginfodwarf", "debuginfogsym", "debuginfomsf", 
#     "debuginfocodeview", "debuginfopdb", "symbolize", "executionengine", 
#     "interpreter", "jitlink", "mcjit", "orcjit", "orcshared", 
#     "orctargetprocess", "runtimedyld", "target", "asmparser", 
#     "lineeditor", "profiledata", "coverage", "passes", "textapi", 
#     "dlltooldriver", "libdriver", "xray", "windowsmanifest"
# }

# llvm_map_components_to_libnames(llvm_libs support core irreader executionengine interpreter)
# target_link_libraries(SchemeCodegen libscheme ${llvm_libs})