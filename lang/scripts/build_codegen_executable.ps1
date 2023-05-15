# D:\smartcar\LLVM0task\llvm-project\build\Debug\bin\
../../include/llvm-project-mod/build/Debug/bin/clang++.exe `
    ..\codegen\outfile.ll `
    ..\src\external\external.cpp `
    -I ..\..\include\OOGL\include\ `
    -o ..\codegen/codegen.exe `
    -g `
    -O `
    -std=c++2a `
    ..\build\oogl_lib\lib.a `
    -lopengl32 `
    -luser32 `
    -lgdi32 