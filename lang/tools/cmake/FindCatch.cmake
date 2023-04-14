set(SRC_CATCH "tools/catch/catch_main.cpp")
add_library(contrib_catch_main ${SRC_CATCH})
target_include_directories(contrib_catch_main PUBLIC tools/catch)
