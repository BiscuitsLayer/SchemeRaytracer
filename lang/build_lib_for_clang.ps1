cd build_lib

clang++ -c `
    -B output/ `
    -I ../../include/OOGL/include/ `
    -I ../../include/OOGL/src/ `
    ../../include/OOGL/src/GL/GL/*.cpp `
    ../../include/OOGL/src/GL/Math/*.cpp `
    ../../include/OOGL/src/GL/Util/*.cpp `
    ../../include/OOGL/src/GL/Window/*.cpp `

clang -c `
    ../../include/OOGL/src/GL/Util/libjpeg/*.c `
    ../../include/OOGL/src/GL/Util/libpng/*.c `
    ../../include/OOGL/src/GL/Util/zlib/*.c `

llvm-ar rc lib.a *.o

cd ..