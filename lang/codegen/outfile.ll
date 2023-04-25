; ModuleID = 'scheme.ll'
source_filename = "scheme.ll"

%SchemeObject = type { i64, i64, i1, ptr, ptr, ptr }

define i32 @main() {
entry:
  %number = alloca %SchemeObject, align 8
  %0 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %0, align 4
  %1 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 300, ptr %1, align 4
  %number1 = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 0
  store i64 0, ptr %2, align 4
  %3 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 1
  store i64 300, ptr %3, align 4
  %function_returned = alloca %SchemeObject, align 8
  %4 = call %SchemeObject @LambdaFunction(ptr %number, ptr %number1)
  store %SchemeObject %4, ptr %function_returned, align 8
  call void @__GLPrint(ptr %function_returned)
  %5 = alloca %SchemeObject, align 8
  %6 = getelementptr %SchemeObject, ptr %5, i32 0, i32 0
  store i64 0, ptr %6, align 4
  %7 = getelementptr %SchemeObject, ptr %5, i32 0, i32 1
  store i64 0, ptr %7, align 4
  %8 = getelementptr %SchemeObject, ptr %function_returned, i32 0, i32 0
  %9 = load i64, ptr %8, align 4
  %10 = icmp eq i64 %9, 0
  call void @__GLAssert(i1 %10)
  %11 = getelementptr %SchemeObject, ptr %5, i32 0, i32 1
  %12 = load i64, ptr %11, align 4
  %13 = getelementptr %SchemeObject, ptr %function_returned, i32 0, i32 1
  %14 = load i64, ptr %13, align 4
  %15 = add i64 %12, %14
  %16 = getelementptr %SchemeObject, ptr %5, i32 0, i32 1
  store i64 %15, ptr %16, align 4
  %number2 = alloca %SchemeObject, align 8
  %17 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  store i64 0, ptr %17, align 4
  %18 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  store i64 100, ptr %18, align 4
  %19 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  %20 = load i64, ptr %19, align 4
  %21 = icmp eq i64 %20, 0
  call void @__GLAssert(i1 %21)
  %22 = getelementptr %SchemeObject, ptr %5, i32 0, i32 1
  %23 = load i64, ptr %22, align 4
  %24 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  %25 = load i64, ptr %24, align 4
  %26 = add i64 %23, %25
  %27 = getelementptr %SchemeObject, ptr %5, i32 0, i32 1
  store i64 %26, ptr %27, align 4
  call void @__GLPrint(ptr %5)
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
  br label %comparison_branch

true_branch:                                      ; preds = %merge_branch3
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch3
  %2 = alloca %SchemeObject, align 8
  %3 = getelementptr %SchemeObject, ptr %2, i32 0, i32 0
  store i64 0, ptr %3, align 4
  %4 = getelementptr %SchemeObject, ptr %2, i32 0, i32 1
  store i64 0, ptr %4, align 4
  %5 = getelementptr %SchemeObject, ptr %0, i32 0, i32 0
  %6 = load i64, ptr %5, align 4
  %7 = icmp eq i64 %6, 0
  call void @__GLAssert(i1 %7)
  %8 = getelementptr %SchemeObject, ptr %2, i32 0, i32 1
  %9 = load i64, ptr %8, align 4
  %10 = getelementptr %SchemeObject, ptr %0, i32 0, i32 1
  %11 = load i64, ptr %10, align 4
  %12 = sub i64 %9, %11
  %13 = getelementptr %SchemeObject, ptr %2, i32 0, i32 1
  store i64 %11, ptr %13, align 4
  %number4 = alloca %SchemeObject, align 8
  %14 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 0
  store i64 0, ptr %14, align 4
  %15 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 1
  store i64 100, ptr %15, align 4
  %16 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 0
  %17 = load i64, ptr %16, align 4
  %18 = icmp eq i64 %17, 0
  call void @__GLAssert(i1 %18)
  %19 = getelementptr %SchemeObject, ptr %2, i32 0, i32 1
  %20 = load i64, ptr %19, align 4
  %21 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 1
  %22 = load i64, ptr %21, align 4
  %23 = sub i64 %20, %22
  %24 = getelementptr %SchemeObject, ptr %2, i32 0, i32 1
  store i64 %23, ptr %24, align 4
  %25 = alloca %SchemeObject, align 8
  %26 = getelementptr %SchemeObject, ptr %25, i32 0, i32 0
  store i64 0, ptr %26, align 4
  %27 = getelementptr %SchemeObject, ptr %25, i32 0, i32 1
  store i64 0, ptr %27, align 4
  %28 = getelementptr %SchemeObject, ptr %1, i32 0, i32 0
  %29 = load i64, ptr %28, align 4
  %30 = icmp eq i64 %29, 0
  call void @__GLAssert(i1 %30)
  %31 = getelementptr %SchemeObject, ptr %25, i32 0, i32 1
  %32 = load i64, ptr %31, align 4
  %33 = getelementptr %SchemeObject, ptr %1, i32 0, i32 1
  %34 = load i64, ptr %33, align 4
  %35 = add i64 %32, %34
  %36 = getelementptr %SchemeObject, ptr %25, i32 0, i32 1
  store i64 %35, ptr %36, align 4
  %number5 = alloca %SchemeObject, align 8
  %37 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  store i64 0, ptr %37, align 4
  %38 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 100, ptr %38, align 4
  %39 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  %40 = load i64, ptr %39, align 4
  %41 = icmp eq i64 %40, 0
  call void @__GLAssert(i1 %41)
  %42 = getelementptr %SchemeObject, ptr %25, i32 0, i32 1
  %43 = load i64, ptr %42, align 4
  %44 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  %45 = load i64, ptr %44, align 4
  %46 = add i64 %43, %45
  %47 = getelementptr %SchemeObject, ptr %25, i32 0, i32 1
  store i64 %46, ptr %47, align 4
  %function_returned = alloca %SchemeObject, align 8
  %48 = call %SchemeObject @LambdaFunction(ptr %2, ptr %25)
  store %SchemeObject %48, ptr %function_returned, align 8
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %49 = phi ptr [ %1, %true_branch ], [ %function_returned, %false_branch ]
  %50 = getelementptr %SchemeObject, ptr %49, i32 0
  %51 = load %SchemeObject, ptr %50, align 8
  ret %SchemeObject %51

comparison_branch:                                ; preds = %entry
  %52 = getelementptr %SchemeObject, ptr %0, i32 0, i32 0
  %53 = load i64, ptr %52, align 4
  %54 = icmp eq i64 %53, 0
  call void @__GLAssert(i1 %54)
  %number = alloca %SchemeObject, align 8
  %55 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %55, align 4
  %56 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 0, ptr %56, align 4
  %57 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  %58 = load i64, ptr %57, align 4
  %59 = icmp eq i64 %58, 0
  call void @__GLAssert(i1 %59)
  %60 = getelementptr %SchemeObject, ptr %0, i32 0, i32 1
  %61 = load i64, ptr %60, align 4
  %62 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %63 = load i64, ptr %62, align 4
  %64 = icmp ne i64 %61, %63
  br i1 %64, label %false_branch2, label %true_branch1

true_branch1:                                     ; preds = %comparison_branch
  %65 = alloca %SchemeObject, align 8
  %66 = getelementptr %SchemeObject, ptr %65, i32 0, i32 0
  store i64 1, ptr %66, align 4
  %67 = getelementptr %SchemeObject, ptr %65, i32 0, i32 2
  store i1 true, ptr %67, align 1
  br label %merge_branch3

false_branch2:                                    ; preds = %comparison_branch
  %68 = alloca %SchemeObject, align 8
  %69 = getelementptr %SchemeObject, ptr %68, i32 0, i32 0
  store i64 1, ptr %69, align 4
  %70 = getelementptr %SchemeObject, ptr %68, i32 0, i32 2
  store i1 false, ptr %70, align 1
  br label %merge_branch3

merge_branch3:                                    ; preds = %false_branch2, %true_branch1
  %71 = phi ptr [ %65, %true_branch1 ], [ %68, %false_branch2 ]
  %72 = getelementptr %SchemeObject, ptr %71, i32 0, i32 0
  %73 = load i64, ptr %72, align 4
  %74 = icmp eq i64 %73, 1
  %75 = getelementptr %SchemeObject, ptr %71, i32 0, i32 2
  %76 = load i1, ptr %75, align 1
  br i1 %76, label %true_branch, label %false_branch
}
