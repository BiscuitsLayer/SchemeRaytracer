; ModuleID = 'scheme.ll'
source_filename = "scheme.ll"

%SchemeObject = type { i32, i64, i1, ptr, ptr, ptr }

@symbol_global = private unnamed_addr constant [7 x i8] c"phrase\00", align 1

define i32 @main() {
entry:
  %number = alloca %SchemeObject, align 8
  %0 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i32 0, ptr %0, align 4
  %1 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 500, ptr %1, align 4
  %2 = call i32 @__GLPrint(ptr %number)
  %symbol = alloca %SchemeObject, align 8
  %3 = getelementptr %SchemeObject, ptr %symbol, i32 0, i32 0
  store i32 2, ptr %3, align 4
  %4 = getelementptr %SchemeObject, ptr %symbol, i32 0, i32 3
  store ptr @symbol_global, ptr %4, align 8
  %5 = call i32 @__GLPrint(ptr %symbol)
  %boolean = alloca %SchemeObject, align 8
  %6 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i32 1, ptr %6, align 4
  %7 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %7, align 1
  %8 = call i32 @__GLPrint(ptr %boolean)
  ret i32 0
}

declare i32 @__GLPrint(ptr)
