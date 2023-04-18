clang++ `
    codegen\outfile.ll `
    src\graphics\graphics.cpp `
    -I ..\include\OOGL\include\ `
    -o codegen/codegen.exe `
    -std=c++2a `
    build_lib\lib.a `
    -lopengl32 `
    -luser32 `
    -lgdi32