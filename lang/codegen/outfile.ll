; ModuleID = 'outfile.ll'
source_filename = "outfile.ll"

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
  %number2 = alloca %SchemeObject, align 8
  %5 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  store i64 0, ptr %5, align 4
  %6 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  store i64 0, ptr %6, align 4
  %7 = getelementptr %SchemeObject, ptr %function_returned, i32 0, i32 0
  %8 = load i64, ptr %7, align 4
  %9 = icmp eq i64 %8, 0
  call void @__GLAssert(i1 %9)
  %10 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  %11 = load i64, ptr %10, align 4
  %12 = getelementptr %SchemeObject, ptr %function_returned, i32 0, i32 1
  %13 = load i64, ptr %12, align 4
  %14 = add i64 %11, %13
  %15 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  store i64 %14, ptr %15, align 4
  %number3 = alloca %SchemeObject, align 8
  %16 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 0
  store i64 0, ptr %16, align 4
  %17 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 1
  store i64 100, ptr %17, align 4
  %18 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 0
  %19 = load i64, ptr %18, align 4
  %20 = icmp eq i64 %19, 0
  call void @__GLAssert(i1 %20)
  %21 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  %22 = load i64, ptr %21, align 4
  %23 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 1
  %24 = load i64, ptr %23, align 4
  %25 = add i64 %22, %24
  %26 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  store i64 %25, ptr %26, align 4
  call void @__GLPrint(ptr %number2)
  br label %condition_branch

condition_branch:                                 ; preds = %entry
  br label %comparison_branch

loop_branch:                                      ; No predecessors!

merge_branch:                                     ; No predecessors!

comparison_branch:                                ; preds = %condition_branch
  ret i32 0

true_branch:                                      ; No predecessors!

false_branch:                                     ; No predecessors!

merge_branch4:                                    ; No predecessors!
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
  %number5 = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  store i64 0, ptr %2, align 4
  %3 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 0, ptr %3, align 4
  %4 = getelementptr %SchemeObject, ptr %0, i32 0, i32 0
  %5 = load i64, ptr %4, align 4
  %6 = icmp eq i64 %5, 0
  call void @__GLAssert(i1 %6)
  %7 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  %8 = load i64, ptr %7, align 4
  %9 = getelementptr %SchemeObject, ptr %0, i32 0, i32 1
  %10 = load i64, ptr %9, align 4
  %11 = sub i64 %8, %10
  %12 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 %10, ptr %12, align 4
  %number6 = alloca %SchemeObject, align 8
  %13 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 0
  store i64 0, ptr %13, align 4
  %14 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 1
  store i64 100, ptr %14, align 4
  %15 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 0
  %16 = load i64, ptr %15, align 4
  %17 = icmp eq i64 %16, 0
  call void @__GLAssert(i1 %17)
  %18 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  %19 = load i64, ptr %18, align 4
  %20 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 1
  %21 = load i64, ptr %20, align 4
  %22 = sub i64 %19, %21
  %23 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 %22, ptr %23, align 4
  %number7 = alloca %SchemeObject, align 8
  %24 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 0
  store i64 0, ptr %24, align 4
  %25 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 0, ptr %25, align 4
  %26 = getelementptr %SchemeObject, ptr %1, i32 0, i32 0
  %27 = load i64, ptr %26, align 4
  %28 = icmp eq i64 %27, 0
  call void @__GLAssert(i1 %28)
  %29 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  %30 = load i64, ptr %29, align 4
  %31 = getelementptr %SchemeObject, ptr %1, i32 0, i32 1
  %32 = load i64, ptr %31, align 4
  %33 = add i64 %30, %32
  %34 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 %33, ptr %34, align 4
  %number8 = alloca %SchemeObject, align 8
  %35 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 0
  store i64 0, ptr %35, align 4
  %36 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 1
  store i64 100, ptr %36, align 4
  %37 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 0
  %38 = load i64, ptr %37, align 4
  %39 = icmp eq i64 %38, 0
  call void @__GLAssert(i1 %39)
  %40 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  %41 = load i64, ptr %40, align 4
  %42 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 1
  %43 = load i64, ptr %42, align 4
  %44 = add i64 %41, %43
  %45 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 %44, ptr %45, align 4
  %function_returned = alloca %SchemeObject, align 8
  %46 = call %SchemeObject @LambdaFunction(ptr %number5, ptr %number7)
  store %SchemeObject %46, ptr %function_returned, align 8
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %47 = phi ptr [ %1, %true_branch ], [ %function_returned, %false_branch ]
  %48 = getelementptr %SchemeObject, ptr %47, i32 0
  %49 = load %SchemeObject, ptr %48, align 8
  ret %SchemeObject %49

comparison_branch:                                ; preds = %entry
  %50 = getelementptr %SchemeObject, ptr %0, i32 0, i32 0
  %51 = load i64, ptr %50, align 4
  %52 = icmp eq i64 %51, 0
  call void @__GLAssert(i1 %52)
  %number = alloca %SchemeObject, align 8
  %53 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %53, align 4
  %54 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 0, ptr %54, align 4
  %55 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  %56 = load i64, ptr %55, align 4
  %57 = icmp eq i64 %56, 0
  call void @__GLAssert(i1 %57)
  %58 = getelementptr %SchemeObject, ptr %0, i32 0, i32 1
  %59 = load i64, ptr %58, align 4
  %60 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %61 = load i64, ptr %60, align 4
  %62 = icmp ne i64 %59, %61
  br i1 %62, label %false_branch2, label %true_branch1

true_branch1:                                     ; preds = %comparison_branch
  %boolean = alloca %SchemeObject, align 8
  %63 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %63, align 4
  %64 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %64, align 1
  br label %merge_branch3

false_branch2:                                    ; preds = %comparison_branch
  %boolean4 = alloca %SchemeObject, align 8
  %65 = getelementptr %SchemeObject, ptr %boolean4, i32 0, i32 0
  store i64 1, ptr %65, align 4
  %66 = getelementptr %SchemeObject, ptr %boolean4, i32 0, i32 2
  store i1 false, ptr %66, align 1
  br label %merge_branch3

merge_branch3:                                    ; preds = %false_branch2, %true_branch1
  %67 = phi ptr [ %boolean, %true_branch1 ], [ %boolean4, %false_branch2 ]
  %68 = getelementptr %SchemeObject, ptr %67, i32 0, i32 0
  %69 = load i64, ptr %68, align 4
  %70 = icmp eq i64 %69, 1
  call void @__GLAssert(i1 %70)
  %71 = getelementptr %SchemeObject, ptr %67, i32 0, i32 2
  %72 = load i1, ptr %71, align 1
  br i1 %72, label %true_branch, label %false_branch
}
