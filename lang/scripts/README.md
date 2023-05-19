# How to run tests
```
# Create build directory
cd lang
mkdir build
cd build

# Cmake and build scheme
cmake ..
cmake --build .

# You can run scheme test to make sure everything works
# (except lambda scopes, so now lambda cannot be returned from lambda)
./Debug/SchemeTest.exe

# Move to scripts folder and build graphics lib for clang
cd ../scripts
./build_oogl_lib_for_clang.ps1

# Check graphics works fine
./run_draw_test.ps1
```