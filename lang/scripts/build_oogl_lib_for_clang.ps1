cd ..
cd build
mkdir oogl_lib
cd oogl_lib

../../../include/llvm-project-mod/build/Debug/bin/clang++.exe -c `
    -g `
    -I ../../../include/OOGL/include/ `
    -I ../../../include/OOGL/src/ `
    ../../../include/OOGL/src/GL/GL/*.cpp `
    ../../../include/OOGL/src/GL/Math/*.cpp `
    ../../../include/OOGL/src/GL/Util/*.cpp `
    ../../../include/OOGL/src/GL/Window/*.cpp `

../../../include/llvm-project-mod/build/Debug/bin/clang.exe -c `
    -g `
    ../../../include/OOGL/src/GL/Util/libjpeg/*.c `
    ../../../include/OOGL/src/GL/Util/libpng/*.c `
    ../../../include/OOGL/src/GL/Util/zlib/*.c `

../../../include/llvm-project-mod/build/Debug/bin/llvm-ar.exe rc lib.a *.o

cd ../..
cd scripts