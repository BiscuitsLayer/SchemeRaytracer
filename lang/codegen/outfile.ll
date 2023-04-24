; ModuleID = 'scheme.ll'
source_filename = "scheme.ll"

%SchemeObject = type { i64, i64, i1, ptr, ptr, ptr }

define i32 @main() {
entry:
  %number = alloca %SchemeObject, align 8
  %0 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %0, align 4
  %1 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 200, ptr %1, align 4
  %number1 = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 0
  store i64 0, ptr %2, align 4
  %3 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 1
  store i64 1000, ptr %3, align 4
  %4 = call ptr @LambdaFunction(ptr %number1)
  %number2 = alloca %SchemeObject, align 8
  %5 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  store i64 0, ptr %5, align 4
  %6 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  store i64 1000, ptr %6, align 4
  %7 = call ptr @LambdaFunction.1(ptr %number2)
  call void @__GLPrint(ptr %number)
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

define ptr @LambdaFunction(ptr %0) {
entry:
  call void @__GLPrint(ptr %0)
  ret ptr %0
}

define ptr @LambdaFunction.1(ptr %0) {
entry:
  %1 = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %1, i32 0, i32 0
  store i64 0, ptr %2, align 4
  %3 = getelementptr %SchemeObject, ptr %1, i32 0, i32 1
  store i64 0, ptr %3, align 4
  %4 = getelementptr %SchemeObject, ptr %0, i32 0, i32 0
  %5 = load i64, ptr %4, align 4
  %6 = icmp eq i64 %5, 0
  call void @__GLAssert(i1 %6)
  %7 = getelementptr %SchemeObject, ptr %1, i32 0, i32 1
  %8 = load i64, ptr %7, align 4
  %9 = getelementptr %SchemeObject, ptr %0, i32 0, i32 1
  %10 = load i64, ptr %9, align 4
  %11 = add i64 %8, %10
  %12 = getelementptr %SchemeObject, ptr %1, i32 0, i32 1
  store i64 %11, ptr %12, align 4
  %number = alloca %SchemeObject, align 8
  %13 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %13, align 4
  %14 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 100, ptr %14, align 4
  %15 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  %16 = load i64, ptr %15, align 4
  %17 = icmp eq i64 %16, 0
  call void @__GLAssert(i1 %17)
  %18 = getelementptr %SchemeObject, ptr %1, i32 0, i32 1
  %19 = load i64, ptr %18, align 4
  %20 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %21 = load i64, ptr %20, align 4
  %22 = add i64 %19, %21
  %23 = getelementptr %SchemeObject, ptr %1, i32 0, i32 1
  store i64 %22, ptr %23, align 4
  call void @__GLPrint(ptr %1)
  ret ptr %1
}
