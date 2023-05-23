../../include/llvm-project-mod/build/Debug/bin/llc.exe `
    ..\codegen\outfile.ll `
    -march=cpu0 `
    -relocation-model=pic `
    -filetype=obj `
    -o ..\codegen/codegen.elf