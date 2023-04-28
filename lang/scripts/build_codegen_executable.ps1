clang++ `
    ..\codegen\outfile.ll `
    ..\src\external\external.cpp `
    -I ..\..\include\OOGL\include\ `
    -o ..\codegen/codegen.exe `
    -std=c++2a `
    ..\build\oogl_lib\lib.a `
    -lopengl32 `
    -luser32 `
    -lgdi32