; ModuleID = 'scheme.ll'
source_filename = "scheme.ll"

%SchemeObject = type { i64, i64, i1, ptr, ptr, ptr }

@symbol_global = private unnamed_addr constant [7 x i8] c"phrase\00", align 1

define i32 @main() {
entry:
  %number = alloca %SchemeObject, align 8
  %0 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %0, align 4
  %1 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 500, ptr %1, align 4
  call void @__GLPrint(ptr %number)
  %symbol = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %symbol, i32 0, i32 0
  store i64 2, ptr %2, align 4
  %3 = getelementptr %SchemeObject, ptr %symbol, i32 0, i32 3
  store ptr @symbol_global, ptr %3, align 8
  call void @__GLPrint(ptr %symbol)
  %boolean = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %4, align 4
  %5 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %5, align 1
  call void @__GLPrint(ptr %boolean)
  call void @__GLInit()
  call void @__GLClear()
  %is-open = alloca %SchemeObject, align 8
  %6 = call %SchemeObject @__GLIsOpen()
  store %SchemeObject %6, ptr %is-open, align 8
  call void @__GLPrint(ptr %is-open)
  %number1 = alloca %SchemeObject, align 8
  %7 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 0
  store i64 0, ptr %7, align 4
  %8 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 1
  store i64 1000, ptr %8, align 4
  %number2 = alloca %SchemeObject, align 8
  %9 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  store i64 0, ptr %9, align 4
  %10 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  store i64 1000, ptr %10, align 4
  %number3 = alloca %SchemeObject, align 8
  %11 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 0
  store i64 0, ptr %11, align 4
  %12 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 1
  store i64 100, ptr %12, align 4
  %number4 = alloca %SchemeObject, align 8
  %13 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 0
  store i64 0, ptr %13, align 4
  %14 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 1
  store i64 100, ptr %14, align 4
  %number5 = alloca %SchemeObject, align 8
  %15 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  store i64 0, ptr %15, align 4
  %16 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 100, ptr %16, align 4
  call void @__GLPutPixel(ptr %number1, ptr %number2, ptr %number3, ptr %number4, ptr %number5)
  call void @__GLDraw()
  call void @__GLFinish()
  %boolean6 = alloca %SchemeObject, align 8
  %17 = getelementptr %SchemeObject, ptr %boolean6, i32 0, i32 0
  store i64 1, ptr %17, align 4
  %18 = getelementptr %SchemeObject, ptr %boolean6, i32 0, i32 2
  store i1 false, ptr %18, align 1
  call void @__GLPrint(ptr %boolean6)
  %number7 = alloca %SchemeObject, align 8
  %19 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 0
  store i64 0, ptr %19, align 4
  %20 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 45, ptr %20, align 4
  call void @__GLPrint(ptr %number7)
  ret i32 0
}

declare void @__GLInit()

declare void @__GLClear()

declare void @__GLPutPixel(ptr, ptr, ptr, ptr, ptr)

declare %SchemeObject @__GLIsOpen()

declare void @__GLDraw()

declare void @__GLFinish()

declare void @__GLPrint(ptr)
