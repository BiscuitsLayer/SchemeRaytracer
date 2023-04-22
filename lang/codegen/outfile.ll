; ModuleID = 'scheme.ll'
source_filename = "scheme.ll"

%SchemeObject = type { i64, i64, i1, ptr, ptr, ptr }

@symbol_global = private unnamed_addr constant [7 x i8] c"SAMPLE\00", align 1

define i32 @main() {
entry:
  %0 = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0, i32 0
  store i64 3, ptr %1, align 4
  %2 = getelementptr %SchemeObject, ptr %0, i32 0, i32 4
  %number = alloca %SchemeObject, align 8
  %3 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %3, align 4
  %4 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 100, ptr %4, align 4
  store ptr %number, ptr %2, align 8
  %5 = alloca %SchemeObject, align 8
  %6 = getelementptr %SchemeObject, ptr %0, i32 0, i32 0
  store i64 3, ptr %6, align 4
  %7 = getelementptr %SchemeObject, ptr %0, i32 0, i32 5
  store ptr %5, ptr %7, align 8
  %8 = getelementptr %SchemeObject, ptr %5, i32 0, i32 4
  %number1 = alloca %SchemeObject, align 8
  %9 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 0
  store i64 0, ptr %9, align 4
  %10 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 1
  store i64 200, ptr %10, align 4
  store ptr %number1, ptr %8, align 8
  %11 = alloca %SchemeObject, align 8
  %12 = getelementptr %SchemeObject, ptr %5, i32 0, i32 0
  store i64 3, ptr %12, align 4
  %13 = getelementptr %SchemeObject, ptr %5, i32 0, i32 5
  store ptr %11, ptr %13, align 8
  %14 = getelementptr %SchemeObject, ptr %11, i32 0, i32 4
  %number2 = alloca %SchemeObject, align 8
  %15 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  store i64 0, ptr %15, align 4
  %16 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  store i64 300, ptr %16, align 4
  store ptr %number2, ptr %14, align 8
  %17 = alloca %SchemeObject, align 8
  %18 = getelementptr %SchemeObject, ptr %11, i32 0, i32 0
  store i64 3, ptr %18, align 4
  %19 = getelementptr %SchemeObject, ptr %11, i32 0, i32 5
  store ptr %17, ptr %19, align 8
  %20 = getelementptr %SchemeObject, ptr %17, i32 0, i32 4
  %21 = alloca %SchemeObject, align 8
  %22 = getelementptr %SchemeObject, ptr %21, i32 0, i32 0
  store i64 3, ptr %22, align 4
  %23 = getelementptr %SchemeObject, ptr %21, i32 0, i32 4
  %number3 = alloca %SchemeObject, align 8
  %24 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 0
  store i64 0, ptr %24, align 4
  %25 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 1
  store i64 300, ptr %25, align 4
  store ptr %number3, ptr %23, align 8
  %26 = alloca %SchemeObject, align 8
  %27 = getelementptr %SchemeObject, ptr %21, i32 0, i32 0
  store i64 3, ptr %27, align 4
  %28 = getelementptr %SchemeObject, ptr %21, i32 0, i32 5
  store ptr %26, ptr %28, align 8
  %29 = getelementptr %SchemeObject, ptr %26, i32 0, i32 4
  %number4 = alloca %SchemeObject, align 8
  %30 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 0
  store i64 0, ptr %30, align 4
  %31 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 1
  store i64 400, ptr %31, align 4
  store ptr %number4, ptr %29, align 8
  %32 = alloca %SchemeObject, align 8
  %33 = getelementptr %SchemeObject, ptr %26, i32 0, i32 0
  store i64 3, ptr %33, align 4
  %34 = getelementptr %SchemeObject, ptr %26, i32 0, i32 5
  store ptr %32, ptr %34, align 8
  %35 = getelementptr %SchemeObject, ptr %32, i32 0, i32 4
  %symbol = alloca %SchemeObject, align 8
  %36 = getelementptr %SchemeObject, ptr %symbol, i32 0, i32 0
  store i64 2, ptr %36, align 4
  %37 = getelementptr %SchemeObject, ptr %symbol, i32 0, i32 3
  store ptr @symbol_global, ptr %37, align 8
  store ptr %symbol, ptr %35, align 8
  %38 = alloca %SchemeObject, align 8
  %39 = getelementptr %SchemeObject, ptr %32, i32 0, i32 0
  store i64 3, ptr %39, align 4
  %40 = getelementptr %SchemeObject, ptr %32, i32 0, i32 5
  store ptr %38, ptr %40, align 8
  %41 = getelementptr %SchemeObject, ptr %32, i32 0, i32 5
  store i64 0, ptr %41, align 4
  store ptr %21, ptr %20, align 8
  %42 = alloca %SchemeObject, align 8
  %43 = getelementptr %SchemeObject, ptr %17, i32 0, i32 0
  store i64 3, ptr %43, align 4
  %44 = getelementptr %SchemeObject, ptr %17, i32 0, i32 5
  store ptr %42, ptr %44, align 8
  %45 = getelementptr %SchemeObject, ptr %17, i32 0, i32 5
  store i64 0, ptr %45, align 4
  call void @__GLPrint(ptr %0)
  %number5 = alloca %SchemeObject, align 8
  %46 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  store i64 0, ptr %46, align 4
  %47 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 500, ptr %47, align 4
  %number6 = alloca %SchemeObject, align 8
  %48 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 0
  store i64 0, ptr %48, align 4
  %49 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 1
  store i64 200, ptr %49, align 4
  %expt = alloca %SchemeObject, align 8
  %50 = call %SchemeObject @__GLExpt(ptr %number5, ptr %number6)
  store %SchemeObject %50, ptr %expt, align 8
  call void @__GLPrint(ptr %expt)
  %number7 = alloca %SchemeObject, align 8
  %51 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 0
  store i64 0, ptr %51, align 4
  %52 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 2500, ptr %52, align 4
  %sqrt = alloca %SchemeObject, align 8
  %53 = call %SchemeObject @__GLSqrt(ptr %number7)
  store %SchemeObject %53, ptr %sqrt, align 8
  call void @__GLPrint(ptr %sqrt)
  %number8 = alloca %SchemeObject, align 8
  %54 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 0
  store i64 0, ptr %54, align 4
  %55 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 1
  store i64 200, ptr %55, align 4
  %sqrt9 = alloca %SchemeObject, align 8
  %56 = call %SchemeObject @__GLSqrt(ptr %number8)
  store %SchemeObject %56, ptr %sqrt9, align 8
  call void @__GLPrint(ptr %sqrt9)
  ret i32 0
}

declare void @__GLInit()

declare void @__GLClear()

declare void @__GLPutPixel(ptr, ptr, ptr, ptr, ptr)

declare %SchemeObject @__GLIsOpen()

declare void @__GLDraw()

declare void @__GLFinish()

declare void @__GLPrint(ptr)

declare void @__GLAssert(i1)

declare %SchemeObject @__GLExpt(ptr, ptr)

declare %SchemeObject @__GLSqrt(ptr)
