cd ..
cd build
.\Debug\SchemeMain.exe 2 ..\test\all_tests_codegen.scm

cd ..
cd scripts
./build_codegen_executable.ps1
../codegen/codegen.exe
