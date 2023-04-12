cmake_minimum_required(VERSION 3.10)
project(MySimulator)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}")

### OOGL ###
set(OOGL_DIR "../include/OOGL")
set(OOGL_INCLUDE_DIR "${OOGL_DIR}/include")
set(OOGL_BINARY_DIR "${CMAKE_BINARY_DIR}/lib/OOGL")
add_subdirectory(${OOGL_DIR} ${OOGL_BINARY_DIR})
include_directories(${OOGL_INCLUDE_DIR})

### ImGui ###
# Provide directories
set(IMGUI_DIR "../include/imgui")
set(IMGUI_BACKENDS_DIR "${IMGUI_DIR}/backends")
# Build new library
file(GLOB SRC_IMGUI "${IMGUI_DIR}/*.cpp" "${IMGUI_BACKENDS_DIR}/imgui_impl_opengl3.cpp" "${IMGUI_BACKENDS_DIR}/imgui_impl_win32.cpp")
add_library(MyImGuiSubset STATIC ${SRC_IMGUI})
# Provide includes
target_include_directories(MyImGuiSubset PUBLIC ${IMGUI_DIR} ${IMGUI_BACKENDS_DIR})
# Link the library
target_link_libraries(MyImGuiSubset PUBLIC dwmapi)
# Provide includes (for main target)
include_directories(${IMGUI_DIR} ${IMGUI_BACKENDS_DIR})

# Simulator
file(GLOB SRC "*.cpp" "*/*.cpp")
add_executable(${PROJECT_NAME} ${SRC})
target_link_libraries(${PROJECT_NAME} PUBLIC ${OPENGL_LIBRARIES} OOGL MyImGuiSubset)
