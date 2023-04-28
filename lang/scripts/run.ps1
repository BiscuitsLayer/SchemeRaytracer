cd ..
cd build
.\Debug\SchemeMain.exe 2 ..\test\codegen.scm

cd ..
cd scripts
./build_codegen_executable.ps1
./../codegen/codegen.exe
