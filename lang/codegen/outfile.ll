; ModuleID = 'outfile.ll'
source_filename = "outfile.ll"

%SchemeObject = type { i64, i64, i1, ptr, ptr, ptr }

define i32 @main() {
entry:
  %number = alloca %SchemeObject, align 8
  %0 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %0, align 4
  %1 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 6161616100, ptr %1, align 4
  %variable = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %number, i32 0
  %3 = load %SchemeObject, ptr %2, align 8
  store %SchemeObject %3, ptr %variable, align 8
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

define %SchemeObject @LambdaFunction() {
entry:
  %number = alloca %SchemeObject, align 8
  %0 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %0, align 4
  %1 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 0, ptr %1, align 4
  %number1 = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 0
  store i64 0, ptr %2, align 4
  %3 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 1
  store i64 100, ptr %3, align 4
  %number2 = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  store i64 0, ptr %4, align 4
  %5 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  store i64 1680700, ptr %5, align 4
  %6 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  %7 = load i64, ptr %6, align 4
  %8 = icmp eq i64 %7, 0
  call void @__GLAssert(i1 %8)
  %9 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 1
  %10 = load i64, ptr %9, align 4
  %11 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  %12 = load i64, ptr %11, align 4
  %13 = mul i64 %10, %12
  %14 = sdiv i64 %13, 100
  %15 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 1
  store i64 %14, ptr %15, align 4
  %16 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %17 = load i64, ptr %16, align 4
  %18 = icmp eq i64 %17, 0
  call void @__GLAssert(i1 %18)
  %19 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 1
  %20 = load i64, ptr %19, align 4
  %21 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 1
  %22 = load i64, ptr %21, align 4
  %23 = mul i64 %20, %22
  %24 = sdiv i64 %23, 100
  %25 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 1
  store i64 %24, ptr %25, align 4
  %26 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 0
  %27 = load i64, ptr %26, align 4
  %28 = icmp eq i64 %27, 0
  call void @__GLAssert(i1 %28)
  %29 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %30 = load i64, ptr %29, align 4
  %31 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 1
  %32 = load i64, ptr %31, align 4
  %33 = add i64 %30, %32
  %34 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 %33, ptr %34, align 4
  %number3 = alloca %SchemeObject, align 8
  %35 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 0
  store i64 0, ptr %35, align 4
  %36 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 1
  store i64 0, ptr %36, align 4
  %37 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 0
  %38 = load i64, ptr %37, align 4
  %39 = icmp eq i64 %38, 0
  call void @__GLAssert(i1 %39)
  %40 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %41 = load i64, ptr %40, align 4
  %42 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 1
  %43 = load i64, ptr %42, align 4
  %44 = add i64 %41, %43
  %45 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 %44, ptr %45, align 4
  %46 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  %47 = load i64, ptr %46, align 4
  %48 = icmp eq i64 %47, 0
  call void @__GLAssert(i1 %48)
  %49 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %50 = load i64, ptr %49, align 4
  %51 = srem i64 %50, 100
  %52 = icmp eq i64 %51, 0
  call void @__GLAssert(i1 %52)
  %number4 = alloca %SchemeObject, align 8
  %53 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 0
  store i64 0, ptr %53, align 4
  %54 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 1
  store i64 214748364700, ptr %54, align 4
  %55 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 0
  %56 = load i64, ptr %55, align 4
  %57 = icmp eq i64 %56, 0
  call void @__GLAssert(i1 %57)
  %58 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 1
  %59 = load i64, ptr %58, align 4
  %60 = srem i64 %59, 100
  %61 = icmp eq i64 %60, 0
  call void @__GLAssert(i1 %61)
  %62 = icmp ne i64 %59, 0
  br i1 %62, label %continue_branch, label %modify_branch

modify_branch:                                    ; preds = %entry
  br label %continue_branch

continue_branch:                                  ; preds = %modify_branch, %entry
  %63 = phi i64 [ 1, %modify_branch ], [ %59, %entry ]
  %64 = srem i64 %50, %63
  %number5 = alloca %SchemeObject, align 8
  %65 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  store i64 0, ptr %65, align 4
  %66 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 %64, ptr %66, align 4
  ret i32 0
}
