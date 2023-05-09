; ModuleID = 'outfile.ll'
source_filename = "outfile.ll"

%SchemeObject = type { i64, i64, i1, ptr, ptr, ptr }

@symbol_global = private unnamed_addr constant [9 x i8] c"SLOW_ADD\00", align 1

define i32 @main() {
entry:
  %symbol = alloca %SchemeObject, align 8
  %0 = getelementptr %SchemeObject, ptr %symbol, i32 0, i32 0
  store i64 2, ptr %0, align 4
  %1 = getelementptr %SchemeObject, ptr %symbol, i32 0, i32 3
  store ptr @symbol_global, ptr %1, align 8
  call void @__GLPrint(ptr %symbol)
  %number = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %2, align 4
  %3 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 300, ptr %3, align 4
  %number1 = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 0
  store i64 0, ptr %4, align 4
  %5 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 1
  store i64 300, ptr %5, align 4
  %function_returned = alloca %SchemeObject, align 8
  %6 = call %SchemeObject @LambdaFunction(ptr %number, ptr %number1)
  store %SchemeObject %6, ptr %function_returned, align 8
  %variable = alloca %SchemeObject, align 8
  %7 = getelementptr %SchemeObject, ptr %function_returned, i32 0
  %8 = load %SchemeObject, ptr %7, align 8
  store %SchemeObject %8, ptr %variable, align 8
  call void @__GLPrint(ptr %variable)
  %number2 = alloca %SchemeObject, align 8
  %9 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  store i64 0, ptr %9, align 4
  %10 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  store i64 0, ptr %10, align 4
  %11 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %12 = load i64, ptr %11, align 4
  %13 = icmp eq i64 %12, 0
  call void @__GLAssert(i1 %13)
  %14 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  %15 = load i64, ptr %14, align 4
  %16 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 1
  %17 = load i64, ptr %16, align 4
  %18 = add i64 %15, %17
  %19 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  store i64 %18, ptr %19, align 4
  %number3 = alloca %SchemeObject, align 8
  %20 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 0
  store i64 0, ptr %20, align 4
  %21 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 1
  store i64 100, ptr %21, align 4
  %22 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 0
  %23 = load i64, ptr %22, align 4
  %24 = icmp eq i64 %23, 0
  call void @__GLAssert(i1 %24)
  %25 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  %26 = load i64, ptr %25, align 4
  %27 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 1
  %28 = load i64, ptr %27, align 4
  %29 = add i64 %26, %28
  %30 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  store i64 %29, ptr %30, align 4
  call void @__GLPrint(ptr %number2)
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

define %SchemeObject @LambdaFunction(ptr %0, ptr %1) {
entry:
  %variable = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %0, i32 0
  %3 = load %SchemeObject, ptr %2, align 8
  store %SchemeObject %3, ptr %variable, align 8
  %variable1 = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %1, i32 0
  %5 = load %SchemeObject, ptr %4, align 8
  store %SchemeObject %5, ptr %variable1, align 8
  br label %comparison_branch

true_branch:                                      ; preds = %merge_branch4
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch4
  %number6 = alloca %SchemeObject, align 8
  %6 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 0
  store i64 0, ptr %6, align 4
  %7 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 1
  store i64 0, ptr %7, align 4
  %8 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %9 = load i64, ptr %8, align 4
  %10 = icmp eq i64 %9, 0
  call void @__GLAssert(i1 %10)
  %11 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 1
  %12 = load i64, ptr %11, align 4
  %13 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 1
  %14 = load i64, ptr %13, align 4
  %15 = sub i64 %12, %14
  %16 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 1
  store i64 %14, ptr %16, align 4
  %number7 = alloca %SchemeObject, align 8
  %17 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 0
  store i64 0, ptr %17, align 4
  %18 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 100, ptr %18, align 4
  %19 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 0
  %20 = load i64, ptr %19, align 4
  %21 = icmp eq i64 %20, 0
  call void @__GLAssert(i1 %21)
  %22 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 1
  %23 = load i64, ptr %22, align 4
  %24 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  %25 = load i64, ptr %24, align 4
  %26 = sub i64 %23, %25
  %27 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 1
  store i64 %26, ptr %27, align 4
  %number8 = alloca %SchemeObject, align 8
  %28 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 0
  store i64 0, ptr %28, align 4
  %29 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 1
  store i64 0, ptr %29, align 4
  %30 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %31 = load i64, ptr %30, align 4
  %32 = icmp eq i64 %31, 0
  call void @__GLAssert(i1 %32)
  %33 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 1
  %34 = load i64, ptr %33, align 4
  %35 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 1
  %36 = load i64, ptr %35, align 4
  %37 = add i64 %34, %36
  %38 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 1
  store i64 %37, ptr %38, align 4
  %number9 = alloca %SchemeObject, align 8
  %39 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 0
  store i64 0, ptr %39, align 4
  %40 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 1
  store i64 100, ptr %40, align 4
  %41 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 0
  %42 = load i64, ptr %41, align 4
  %43 = icmp eq i64 %42, 0
  call void @__GLAssert(i1 %43)
  %44 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 1
  %45 = load i64, ptr %44, align 4
  %46 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 1
  %47 = load i64, ptr %46, align 4
  %48 = add i64 %45, %47
  %49 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 1
  store i64 %48, ptr %49, align 4
  %function_returned = alloca %SchemeObject, align 8
  %50 = call %SchemeObject @LambdaFunction(ptr %number6, ptr %number8)
  store %SchemeObject %50, ptr %function_returned, align 8
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %51 = phi ptr [ %variable1, %true_branch ], [ %function_returned, %false_branch ]
  %52 = getelementptr %SchemeObject, ptr %51, i32 0
  %53 = load %SchemeObject, ptr %52, align 8
  ret %SchemeObject %53

comparison_branch:                                ; preds = %entry
  %54 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %55 = load i64, ptr %54, align 4
  %56 = icmp eq i64 %55, 0
  call void @__GLAssert(i1 %56)
  %number = alloca %SchemeObject, align 8
  %57 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %57, align 4
  %58 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 0, ptr %58, align 4
  %59 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  %60 = load i64, ptr %59, align 4
  %61 = icmp eq i64 %60, 0
  call void @__GLAssert(i1 %61)
  %62 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 1
  %63 = load i64, ptr %62, align 4
  %64 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %65 = load i64, ptr %64, align 4
  %66 = icmp ne i64 %63, %65
  br i1 %66, label %false_branch3, label %true_branch2

true_branch2:                                     ; preds = %comparison_branch
  %boolean = alloca %SchemeObject, align 8
  %67 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %67, align 4
  %68 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %68, align 1
  br label %merge_branch4

false_branch3:                                    ; preds = %comparison_branch
  %boolean5 = alloca %SchemeObject, align 8
  %69 = getelementptr %SchemeObject, ptr %boolean5, i32 0, i32 0
  store i64 1, ptr %69, align 4
  %70 = getelementptr %SchemeObject, ptr %boolean5, i32 0, i32 2
  store i1 false, ptr %70, align 1
  br label %merge_branch4

merge_branch4:                                    ; preds = %false_branch3, %true_branch2
  %71 = phi ptr [ %boolean, %true_branch2 ], [ %boolean5, %false_branch3 ]
  %72 = getelementptr %SchemeObject, ptr %71, i32 0, i32 0
  %73 = load i64, ptr %72, align 4
  %74 = icmp eq i64 %73, 1
  call void @__GLAssert(i1 %74)
  %75 = getelementptr %SchemeObject, ptr %71, i32 0, i32 2
  %76 = load i1, ptr %75, align 1
  br i1 %76, label %true_branch, label %false_branch
}
