; ModuleID = 'outfile.ll'
source_filename = "outfile.ll"

%SchemeObject = type { i64, i64, i1, ptr, ptr, ptr }

define i32 @main() {
entry:
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

define %SchemeObject @LambdaFunction(ptr %0) {
entry:
  %variable = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0
  %2 = load %SchemeObject, ptr %1, align 8
  store %SchemeObject %2, ptr %variable, align 8
  %3 = icmp eq ptr %variable, null
  br i1 %3, label %true_branch1, label %continue_branch

true_branch:                                      ; preds = %merge_branch3
  %number = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %4, align 4
  %5 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 0, ptr %5, align 4
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch3
  %number5 = alloca %SchemeObject, align 8
  %6 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  store i64 0, ptr %6, align 4
  %7 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 0, ptr %7, align 4
  %8 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %9 = load i64, ptr %8, align 4
  %is_type_check9 = icmp eq i64 %9, 3
  br i1 %is_type_check9, label %true_branch6, label %false_branch7

merge_branch:                                     ; preds = %merge_branch12, %true_branch
  %10 = phi ptr [ %number, %true_branch ], [ %number5, %merge_branch12 ]
  %11 = getelementptr %SchemeObject, ptr %10, i32 0
  %12 = load %SchemeObject, ptr %11, align 8
  ret %SchemeObject %12

continue_branch:                                  ; preds = %entry
  %13 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %14 = load i64, ptr %13, align 4
  %is_type_check = icmp eq i64 %14, 3
  br i1 %is_type_check, label %is_cell_branch, label %false_branch2

is_cell_branch:                                   ; preds = %continue_branch
  %15 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 4
  %16 = load ptr, ptr %15, align 8
  %17 = icmp eq ptr %16, null
  br i1 %17, label %is_cell_first_null_branch, label %false_branch2

is_cell_first_null_branch:                        ; preds = %is_cell_branch
  %18 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %19 = load ptr, ptr %18, align 8
  %20 = icmp eq ptr %19, null
  br i1 %20, label %true_branch1, label %false_branch2

true_branch1:                                     ; preds = %is_cell_first_null_branch, %entry
  %boolean = alloca %SchemeObject, align 8
  %21 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %21, align 4
  %22 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %22, align 1
  br label %merge_branch3

false_branch2:                                    ; preds = %is_cell_first_null_branch, %is_cell_branch, %continue_branch
  %boolean4 = alloca %SchemeObject, align 8
  %23 = getelementptr %SchemeObject, ptr %boolean4, i32 0, i32 0
  store i64 1, ptr %23, align 4
  %24 = getelementptr %SchemeObject, ptr %boolean4, i32 0, i32 2
  store i1 false, ptr %24, align 1
  br label %merge_branch3

merge_branch3:                                    ; preds = %false_branch2, %true_branch1
  %25 = phi ptr [ %boolean, %true_branch1 ], [ %boolean4, %false_branch2 ]
  %26 = getelementptr %SchemeObject, ptr %25, i32 0, i32 0
  %27 = load i64, ptr %26, align 4
  %28 = icmp eq i64 %27, 1
  call void @__GLAssert(i1 %28)
  %29 = getelementptr %SchemeObject, ptr %25, i32 0, i32 2
  %30 = load i1, ptr %29, align 1
  br i1 %30, label %true_branch, label %false_branch

true_branch6:                                     ; preds = %false_branch
  %31 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 4
  %32 = load ptr, ptr %31, align 8
  br label %merge_branch8

false_branch7:                                    ; preds = %false_branch
  %33 = phi ptr [ %variable, %false_branch ]
  br label %merge_branch8

merge_branch8:                                    ; preds = %false_branch7, %true_branch6
  %34 = phi ptr [ %32, %true_branch6 ], [ %33, %false_branch7 ]
  %35 = getelementptr %SchemeObject, ptr %34, i32 0, i32 0
  %36 = load i64, ptr %35, align 4
  %37 = icmp eq i64 %36, 0
  call void @__GLAssert(i1 %37)
  %38 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  %39 = load i64, ptr %38, align 4
  %40 = getelementptr %SchemeObject, ptr %34, i32 0, i32 1
  %41 = load i64, ptr %40, align 4
  %42 = add i64 %39, %41
  %43 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 %42, ptr %43, align 4
  %44 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %45 = load i64, ptr %44, align 4
  %is_type_check13 = icmp eq i64 %45, 3
  br i1 %is_type_check13, label %true_branch10, label %false_branch11

true_branch10:                                    ; preds = %merge_branch8
  %46 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %47 = load ptr, ptr %46, align 8
  br label %merge_branch12

false_branch11:                                   ; preds = %merge_branch8
  %48 = alloca %SchemeObject, align 8
  %49 = getelementptr %SchemeObject, ptr %48, i32 0, i32 0
  store i64 3, ptr %49, align 4
  %50 = getelementptr %SchemeObject, ptr %48, i32 0, i32 4
  store ptr null, ptr %50, align 8
  %51 = getelementptr %SchemeObject, ptr %48, i32 0, i32 5
  store ptr null, ptr %51, align 8
  br label %merge_branch12

merge_branch12:                                   ; preds = %false_branch11, %true_branch10
  %52 = phi ptr [ %47, %true_branch10 ], [ %48, %false_branch11 ]
  %function_returned = alloca %SchemeObject, align 8
  %53 = call ptr @llvm.stacksave()
  %54 = call %SchemeObject @LambdaFunction(ptr %52)
  store %SchemeObject %54, ptr %function_returned, align 8
  call void @llvm.stackrestore(ptr %53)
  %55 = getelementptr %SchemeObject, ptr %function_returned, i32 0, i32 0
  %56 = load i64, ptr %55, align 4
  %57 = icmp eq i64 %56, 0
  call void @__GLAssert(i1 %57)
  %58 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  %59 = load i64, ptr %58, align 4
  %60 = getelementptr %SchemeObject, ptr %function_returned, i32 0, i32 1
  %61 = load i64, ptr %60, align 4
  %62 = add i64 %59, %61
  %63 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 %62, ptr %63, align 4
  br label %merge_branch
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare ptr @llvm.stacksave() #0

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.stackrestore(ptr) #0

define %SchemeObject @LambdaFunction.1(ptr %0) {
entry:
  %variable = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0
  %2 = load %SchemeObject, ptr %1, align 8
  store %SchemeObject %2, ptr %variable, align 8
  %3 = icmp eq ptr %variable, null
  br i1 %3, label %true_branch1, label %continue_branch

true_branch:                                      ; preds = %merge_branch3
  %number = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %4, align 4
  %5 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 100, ptr %5, align 4
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch3
  %number5 = alloca %SchemeObject, align 8
  %6 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  store i64 0, ptr %6, align 4
  %7 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 100, ptr %7, align 4
  %8 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %9 = load i64, ptr %8, align 4
  %is_type_check9 = icmp eq i64 %9, 3
  br i1 %is_type_check9, label %true_branch6, label %false_branch7

merge_branch:                                     ; preds = %merge_branch12, %true_branch
  %10 = phi ptr [ %number, %true_branch ], [ %number5, %merge_branch12 ]
  %11 = getelementptr %SchemeObject, ptr %10, i32 0
  %12 = load %SchemeObject, ptr %11, align 8
  ret %SchemeObject %12

continue_branch:                                  ; preds = %entry
  %13 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %14 = load i64, ptr %13, align 4
  %is_type_check = icmp eq i64 %14, 3
  br i1 %is_type_check, label %is_cell_branch, label %false_branch2

is_cell_branch:                                   ; preds = %continue_branch
  %15 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 4
  %16 = load ptr, ptr %15, align 8
  %17 = icmp eq ptr %16, null
  br i1 %17, label %is_cell_first_null_branch, label %false_branch2

is_cell_first_null_branch:                        ; preds = %is_cell_branch
  %18 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %19 = load ptr, ptr %18, align 8
  %20 = icmp eq ptr %19, null
  br i1 %20, label %true_branch1, label %false_branch2

true_branch1:                                     ; preds = %is_cell_first_null_branch, %entry
  %boolean = alloca %SchemeObject, align 8
  %21 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %21, align 4
  %22 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %22, align 1
  br label %merge_branch3

false_branch2:                                    ; preds = %is_cell_first_null_branch, %is_cell_branch, %continue_branch
  %boolean4 = alloca %SchemeObject, align 8
  %23 = getelementptr %SchemeObject, ptr %boolean4, i32 0, i32 0
  store i64 1, ptr %23, align 4
  %24 = getelementptr %SchemeObject, ptr %boolean4, i32 0, i32 2
  store i1 false, ptr %24, align 1
  br label %merge_branch3

merge_branch3:                                    ; preds = %false_branch2, %true_branch1
  %25 = phi ptr [ %boolean, %true_branch1 ], [ %boolean4, %false_branch2 ]
  %26 = getelementptr %SchemeObject, ptr %25, i32 0, i32 0
  %27 = load i64, ptr %26, align 4
  %28 = icmp eq i64 %27, 1
  call void @__GLAssert(i1 %28)
  %29 = getelementptr %SchemeObject, ptr %25, i32 0, i32 2
  %30 = load i1, ptr %29, align 1
  br i1 %30, label %true_branch, label %false_branch

true_branch6:                                     ; preds = %false_branch
  %31 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 4
  %32 = load ptr, ptr %31, align 8
  br label %merge_branch8

false_branch7:                                    ; preds = %false_branch
  %33 = phi ptr [ %variable, %false_branch ]
  br label %merge_branch8

merge_branch8:                                    ; preds = %false_branch7, %true_branch6
  %34 = phi ptr [ %32, %true_branch6 ], [ %33, %false_branch7 ]
  %35 = getelementptr %SchemeObject, ptr %34, i32 0, i32 0
  %36 = load i64, ptr %35, align 4
  %37 = icmp eq i64 %36, 0
  call void @__GLAssert(i1 %37)
  %38 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  %39 = load i64, ptr %38, align 4
  %40 = getelementptr %SchemeObject, ptr %34, i32 0, i32 1
  %41 = load i64, ptr %40, align 4
  %42 = mul i64 %39, %41
  %43 = sdiv i64 %42, 100
  %44 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 %43, ptr %44, align 4
  %45 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %46 = load i64, ptr %45, align 4
  %is_type_check13 = icmp eq i64 %46, 3
  br i1 %is_type_check13, label %true_branch10, label %false_branch11

true_branch10:                                    ; preds = %merge_branch8
  %47 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %48 = load ptr, ptr %47, align 8
  br label %merge_branch12

false_branch11:                                   ; preds = %merge_branch8
  %49 = alloca %SchemeObject, align 8
  %50 = getelementptr %SchemeObject, ptr %49, i32 0, i32 0
  store i64 3, ptr %50, align 4
  %51 = getelementptr %SchemeObject, ptr %49, i32 0, i32 4
  store ptr null, ptr %51, align 8
  %52 = getelementptr %SchemeObject, ptr %49, i32 0, i32 5
  store ptr null, ptr %52, align 8
  br label %merge_branch12

merge_branch12:                                   ; preds = %false_branch11, %true_branch10
  %53 = phi ptr [ %48, %true_branch10 ], [ %49, %false_branch11 ]
  %function_returned = alloca %SchemeObject, align 8
  %54 = call ptr @llvm.stacksave()
  %55 = call %SchemeObject @LambdaFunction.1(ptr %53)
  store %SchemeObject %55, ptr %function_returned, align 8
  call void @llvm.stackrestore(ptr %54)
  %56 = getelementptr %SchemeObject, ptr %function_returned, i32 0, i32 0
  %57 = load i64, ptr %56, align 4
  %58 = icmp eq i64 %57, 0
  call void @__GLAssert(i1 %58)
  %59 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  %60 = load i64, ptr %59, align 4
  %61 = getelementptr %SchemeObject, ptr %function_returned, i32 0, i32 1
  %62 = load i64, ptr %61, align 4
  %63 = mul i64 %60, %62
  %64 = sdiv i64 %63, 100
  %65 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 %64, ptr %65, align 4
  br label %merge_branch
}

define %SchemeObject @LambdaFunction.2(ptr %0, ptr %1, ptr %2) {
entry:
  %variable = alloca %SchemeObject, align 8
  %3 = getelementptr %SchemeObject, ptr %0, i32 0
  %4 = load %SchemeObject, ptr %3, align 8
  store %SchemeObject %4, ptr %variable, align 8
  %variable1 = alloca %SchemeObject, align 8
  %5 = getelementptr %SchemeObject, ptr %1, i32 0
  %6 = load %SchemeObject, ptr %5, align 8
  store %SchemeObject %6, ptr %variable1, align 8
  %variable2 = alloca %SchemeObject, align 8
  %7 = getelementptr %SchemeObject, ptr %2, i32 0
  %8 = load %SchemeObject, ptr %7, align 8
  store %SchemeObject %8, ptr %variable2, align 8
  %9 = alloca %SchemeObject, align 8
  %10 = getelementptr %SchemeObject, ptr %9, i32 0, i32 0
  store i64 3, ptr %10, align 4
  %11 = getelementptr %SchemeObject, ptr %9, i32 0, i32 4
  store ptr null, ptr %11, align 8
  %12 = getelementptr %SchemeObject, ptr %9, i32 0, i32 5
  store ptr null, ptr %12, align 8
  %13 = getelementptr %SchemeObject, ptr %9, i32 0, i32 4
  store ptr %variable, ptr %13, align 8
  %14 = alloca %SchemeObject, align 8
  %15 = getelementptr %SchemeObject, ptr %14, i32 0, i32 0
  store i64 3, ptr %15, align 4
  %16 = getelementptr %SchemeObject, ptr %14, i32 0, i32 4
  store ptr null, ptr %16, align 8
  %17 = getelementptr %SchemeObject, ptr %14, i32 0, i32 5
  store ptr null, ptr %17, align 8
  %18 = getelementptr %SchemeObject, ptr %9, i32 0, i32 5
  store ptr %14, ptr %18, align 8
  %19 = getelementptr %SchemeObject, ptr %14, i32 0, i32 4
  store ptr %variable1, ptr %19, align 8
  %20 = alloca %SchemeObject, align 8
  %21 = getelementptr %SchemeObject, ptr %20, i32 0, i32 0
  store i64 3, ptr %21, align 4
  %22 = getelementptr %SchemeObject, ptr %20, i32 0, i32 4
  store ptr null, ptr %22, align 8
  %23 = getelementptr %SchemeObject, ptr %20, i32 0, i32 5
  store ptr null, ptr %23, align 8
  %24 = getelementptr %SchemeObject, ptr %14, i32 0, i32 5
  store ptr %20, ptr %24, align 8
  %25 = getelementptr %SchemeObject, ptr %20, i32 0, i32 4
  store ptr %variable2, ptr %25, align 8
  %26 = alloca %SchemeObject, align 8
  %27 = getelementptr %SchemeObject, ptr %26, i32 0, i32 0
  store i64 3, ptr %27, align 4
  %28 = getelementptr %SchemeObject, ptr %26, i32 0, i32 4
  store ptr null, ptr %28, align 8
  %29 = getelementptr %SchemeObject, ptr %26, i32 0, i32 5
  store ptr null, ptr %29, align 8
  %30 = getelementptr %SchemeObject, ptr %20, i32 0, i32 5
  store ptr %26, ptr %30, align 8
  %31 = getelementptr %SchemeObject, ptr %20, i32 0, i32 5
  store ptr null, ptr %31, align 8
  %32 = getelementptr %SchemeObject, ptr %9, i32 0
  %33 = load %SchemeObject, ptr %32, align 8
  ret %SchemeObject %33
}

define %SchemeObject @LambdaFunction.3(ptr %0) {
entry:
  %variable = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0
  %2 = load %SchemeObject, ptr %1, align 8
  store %SchemeObject %2, ptr %variable, align 8
  %3 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %4 = load i64, ptr %3, align 4
  %is_type_check = icmp eq i64 %4, 3
  br i1 %is_type_check, label %true_branch, label %false_branch

true_branch:                                      ; preds = %entry
  %5 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 4
  %6 = load ptr, ptr %5, align 8
  br label %merge_branch

false_branch:                                     ; preds = %entry
  %7 = phi ptr [ %variable, %entry ]
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %8 = phi ptr [ %6, %true_branch ], [ %7, %false_branch ]
  %9 = getelementptr %SchemeObject, ptr %8, i32 0
  %10 = load %SchemeObject, ptr %9, align 8
  ret %SchemeObject %10
}

define %SchemeObject @LambdaFunction.4(ptr %0) {
entry:
  %variable = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0
  %2 = load %SchemeObject, ptr %1, align 8
  store %SchemeObject %2, ptr %variable, align 8
  %3 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %4 = load i64, ptr %3, align 4
  %is_type_check = icmp eq i64 %4, 3
  br i1 %is_type_check, label %true_branch1, label %false_branch2

true_branch:                                      ; preds = %merge_branch3
  %5 = getelementptr %SchemeObject, ptr %17, i32 0, i32 4
  %6 = load ptr, ptr %5, align 8
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch3
  %7 = phi ptr [ %17, %merge_branch3 ]
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %8 = phi ptr [ %6, %true_branch ], [ %7, %false_branch ]
  %9 = getelementptr %SchemeObject, ptr %8, i32 0
  %10 = load %SchemeObject, ptr %9, align 8
  ret %SchemeObject %10

true_branch1:                                     ; preds = %entry
  %11 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %12 = load ptr, ptr %11, align 8
  br label %merge_branch3

false_branch2:                                    ; preds = %entry
  %13 = alloca %SchemeObject, align 8
  %14 = getelementptr %SchemeObject, ptr %13, i32 0, i32 0
  store i64 3, ptr %14, align 4
  %15 = getelementptr %SchemeObject, ptr %13, i32 0, i32 4
  store ptr null, ptr %15, align 8
  %16 = getelementptr %SchemeObject, ptr %13, i32 0, i32 5
  store ptr null, ptr %16, align 8
  br label %merge_branch3

merge_branch3:                                    ; preds = %false_branch2, %true_branch1
  %17 = phi ptr [ %12, %true_branch1 ], [ %13, %false_branch2 ]
  %18 = getelementptr %SchemeObject, ptr %17, i32 0, i32 0
  %19 = load i64, ptr %18, align 4
  %is_type_check4 = icmp eq i64 %19, 3
  br i1 %is_type_check4, label %true_branch, label %false_branch
}

define %SchemeObject @LambdaFunction.5(ptr %0) {
entry:
  %variable = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0
  %2 = load %SchemeObject, ptr %1, align 8
  store %SchemeObject %2, ptr %variable, align 8
  %3 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %4 = load i64, ptr %3, align 4
  %is_type_check = icmp eq i64 %4, 3
  br i1 %is_type_check, label %true_branch4, label %false_branch5

true_branch:                                      ; preds = %merge_branch3
  %5 = getelementptr %SchemeObject, ptr %17, i32 0, i32 4
  %6 = load ptr, ptr %5, align 8
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch3
  %7 = phi ptr [ %17, %merge_branch3 ]
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %8 = phi ptr [ %6, %true_branch ], [ %7, %false_branch ]
  %9 = getelementptr %SchemeObject, ptr %8, i32 0
  %10 = load %SchemeObject, ptr %9, align 8
  ret %SchemeObject %10

true_branch1:                                     ; preds = %merge_branch6
  %11 = getelementptr %SchemeObject, ptr %26, i32 0, i32 5
  %12 = load ptr, ptr %11, align 8
  br label %merge_branch3

false_branch2:                                    ; preds = %merge_branch6
  %13 = alloca %SchemeObject, align 8
  %14 = getelementptr %SchemeObject, ptr %13, i32 0, i32 0
  store i64 3, ptr %14, align 4
  %15 = getelementptr %SchemeObject, ptr %13, i32 0, i32 4
  store ptr null, ptr %15, align 8
  %16 = getelementptr %SchemeObject, ptr %13, i32 0, i32 5
  store ptr null, ptr %16, align 8
  br label %merge_branch3

merge_branch3:                                    ; preds = %false_branch2, %true_branch1
  %17 = phi ptr [ %12, %true_branch1 ], [ %13, %false_branch2 ]
  %18 = getelementptr %SchemeObject, ptr %17, i32 0, i32 0
  %19 = load i64, ptr %18, align 4
  %is_type_check8 = icmp eq i64 %19, 3
  br i1 %is_type_check8, label %true_branch, label %false_branch

true_branch4:                                     ; preds = %entry
  %20 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %21 = load ptr, ptr %20, align 8
  br label %merge_branch6

false_branch5:                                    ; preds = %entry
  %22 = alloca %SchemeObject, align 8
  %23 = getelementptr %SchemeObject, ptr %22, i32 0, i32 0
  store i64 3, ptr %23, align 4
  %24 = getelementptr %SchemeObject, ptr %22, i32 0, i32 4
  store ptr null, ptr %24, align 8
  %25 = getelementptr %SchemeObject, ptr %22, i32 0, i32 5
  store ptr null, ptr %25, align 8
  br label %merge_branch6

merge_branch6:                                    ; preds = %false_branch5, %true_branch4
  %26 = phi ptr [ %21, %true_branch4 ], [ %22, %false_branch5 ]
  %27 = getelementptr %SchemeObject, ptr %26, i32 0, i32 0
  %28 = load i64, ptr %27, align 4
  %is_type_check7 = icmp eq i64 %28, 3
  br i1 %is_type_check7, label %true_branch1, label %false_branch2
}

define %SchemeObject @LambdaFunction.6(ptr %0, ptr %1) {
entry:
  %variable = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %0, i32 0
  %3 = load %SchemeObject, ptr %2, align 8
  store %SchemeObject %3, ptr %variable, align 8
  %variable1 = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %1, i32 0
  %5 = load %SchemeObject, ptr %4, align 8
  store %SchemeObject %5, ptr %variable1, align 8
  %6 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %7 = load i64, ptr %6, align 4
  %is_type_check = icmp eq i64 %7, 3
  br i1 %is_type_check, label %true_branch2, label %false_branch3

true_branch:                                      ; preds = %merge_branch4
  %number = alloca %SchemeObject, align 8
  %8 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %8, align 4
  %9 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 0, ptr %9, align 4
  %function_returned = alloca %SchemeObject, align 8
  %10 = call ptr @llvm.stacksave()
  %11 = call %SchemeObject @LambdaFunction.3(ptr %variable)
  store %SchemeObject %11, ptr %function_returned, align 8
  call void @llvm.stackrestore(ptr %10)
  %12 = getelementptr %SchemeObject, ptr %function_returned, i32 0, i32 0
  %13 = load i64, ptr %12, align 4
  %14 = icmp eq i64 %13, 0
  call void @__GLAssert(i1 %14)
  %15 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %16 = load i64, ptr %15, align 4
  %17 = getelementptr %SchemeObject, ptr %function_returned, i32 0, i32 1
  %18 = load i64, ptr %17, align 4
  %19 = add i64 %16, %18
  %20 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 %19, ptr %20, align 4
  %function_returned6 = alloca %SchemeObject, align 8
  %21 = call ptr @llvm.stacksave()
  %22 = call %SchemeObject @LambdaFunction.3(ptr %variable1)
  store %SchemeObject %22, ptr %function_returned6, align 8
  call void @llvm.stackrestore(ptr %21)
  %23 = getelementptr %SchemeObject, ptr %function_returned6, i32 0, i32 0
  %24 = load i64, ptr %23, align 4
  %25 = icmp eq i64 %24, 0
  call void @__GLAssert(i1 %25)
  %26 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %27 = load i64, ptr %26, align 4
  %28 = getelementptr %SchemeObject, ptr %function_returned6, i32 0, i32 1
  %29 = load i64, ptr %28, align 4
  %30 = add i64 %27, %29
  %31 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 %30, ptr %31, align 4
  %number7 = alloca %SchemeObject, align 8
  %32 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 0
  store i64 0, ptr %32, align 4
  %33 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 0, ptr %33, align 4
  %function_returned8 = alloca %SchemeObject, align 8
  %34 = call ptr @llvm.stacksave()
  %35 = call %SchemeObject @LambdaFunction.4(ptr %variable)
  store %SchemeObject %35, ptr %function_returned8, align 8
  call void @llvm.stackrestore(ptr %34)
  %36 = getelementptr %SchemeObject, ptr %function_returned8, i32 0, i32 0
  %37 = load i64, ptr %36, align 4
  %38 = icmp eq i64 %37, 0
  call void @__GLAssert(i1 %38)
  %39 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  %40 = load i64, ptr %39, align 4
  %41 = getelementptr %SchemeObject, ptr %function_returned8, i32 0, i32 1
  %42 = load i64, ptr %41, align 4
  %43 = add i64 %40, %42
  %44 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 %43, ptr %44, align 4
  %function_returned9 = alloca %SchemeObject, align 8
  %45 = call ptr @llvm.stacksave()
  %46 = call %SchemeObject @LambdaFunction.4(ptr %variable1)
  store %SchemeObject %46, ptr %function_returned9, align 8
  call void @llvm.stackrestore(ptr %45)
  %47 = getelementptr %SchemeObject, ptr %function_returned9, i32 0, i32 0
  %48 = load i64, ptr %47, align 4
  %49 = icmp eq i64 %48, 0
  call void @__GLAssert(i1 %49)
  %50 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  %51 = load i64, ptr %50, align 4
  %52 = getelementptr %SchemeObject, ptr %function_returned9, i32 0, i32 1
  %53 = load i64, ptr %52, align 4
  %54 = add i64 %51, %53
  %55 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 %54, ptr %55, align 4
  %number10 = alloca %SchemeObject, align 8
  %56 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 0
  store i64 0, ptr %56, align 4
  %57 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 0, ptr %57, align 4
  %function_returned11 = alloca %SchemeObject, align 8
  %58 = call ptr @llvm.stacksave()
  %59 = call %SchemeObject @LambdaFunction.5(ptr %variable)
  store %SchemeObject %59, ptr %function_returned11, align 8
  call void @llvm.stackrestore(ptr %58)
  %60 = getelementptr %SchemeObject, ptr %function_returned11, i32 0, i32 0
  %61 = load i64, ptr %60, align 4
  %62 = icmp eq i64 %61, 0
  call void @__GLAssert(i1 %62)
  %63 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  %64 = load i64, ptr %63, align 4
  %65 = getelementptr %SchemeObject, ptr %function_returned11, i32 0, i32 1
  %66 = load i64, ptr %65, align 4
  %67 = add i64 %64, %66
  %68 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 %67, ptr %68, align 4
  %function_returned12 = alloca %SchemeObject, align 8
  %69 = call ptr @llvm.stacksave()
  %70 = call %SchemeObject @LambdaFunction.5(ptr %variable1)
  store %SchemeObject %70, ptr %function_returned12, align 8
  call void @llvm.stackrestore(ptr %69)
  %71 = getelementptr %SchemeObject, ptr %function_returned12, i32 0, i32 0
  %72 = load i64, ptr %71, align 4
  %73 = icmp eq i64 %72, 0
  call void @__GLAssert(i1 %73)
  %74 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  %75 = load i64, ptr %74, align 4
  %76 = getelementptr %SchemeObject, ptr %function_returned12, i32 0, i32 1
  %77 = load i64, ptr %76, align 4
  %78 = add i64 %75, %77
  %79 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 %78, ptr %79, align 4
  %function_returned13 = alloca %SchemeObject, align 8
  %80 = call ptr @llvm.stacksave()
  %81 = call %SchemeObject @LambdaFunction.2(ptr %number, ptr %number7, ptr %number10)
  store %SchemeObject %81, ptr %function_returned13, align 8
  call void @llvm.stackrestore(ptr %80)
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch4
  %number14 = alloca %SchemeObject, align 8
  %82 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 0
  store i64 0, ptr %82, align 4
  %83 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  store i64 0, ptr %83, align 4
  %function_returned15 = alloca %SchemeObject, align 8
  %84 = call ptr @llvm.stacksave()
  %85 = call %SchemeObject @LambdaFunction.3(ptr %variable)
  store %SchemeObject %85, ptr %function_returned15, align 8
  call void @llvm.stackrestore(ptr %84)
  %86 = getelementptr %SchemeObject, ptr %function_returned15, i32 0, i32 0
  %87 = load i64, ptr %86, align 4
  %88 = icmp eq i64 %87, 0
  call void @__GLAssert(i1 %88)
  %89 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  %90 = load i64, ptr %89, align 4
  %91 = getelementptr %SchemeObject, ptr %function_returned15, i32 0, i32 1
  %92 = load i64, ptr %91, align 4
  %93 = add i64 %90, %92
  %94 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  store i64 %93, ptr %94, align 4
  %95 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %96 = load i64, ptr %95, align 4
  %97 = icmp eq i64 %96, 0
  call void @__GLAssert(i1 %97)
  %98 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  %99 = load i64, ptr %98, align 4
  %100 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 1
  %101 = load i64, ptr %100, align 4
  %102 = add i64 %99, %101
  %103 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  store i64 %102, ptr %103, align 4
  %number16 = alloca %SchemeObject, align 8
  %104 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 0
  store i64 0, ptr %104, align 4
  %105 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  store i64 0, ptr %105, align 4
  %function_returned17 = alloca %SchemeObject, align 8
  %106 = call ptr @llvm.stacksave()
  %107 = call %SchemeObject @LambdaFunction.4(ptr %variable)
  store %SchemeObject %107, ptr %function_returned17, align 8
  call void @llvm.stackrestore(ptr %106)
  %108 = getelementptr %SchemeObject, ptr %function_returned17, i32 0, i32 0
  %109 = load i64, ptr %108, align 4
  %110 = icmp eq i64 %109, 0
  call void @__GLAssert(i1 %110)
  %111 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  %112 = load i64, ptr %111, align 4
  %113 = getelementptr %SchemeObject, ptr %function_returned17, i32 0, i32 1
  %114 = load i64, ptr %113, align 4
  %115 = add i64 %112, %114
  %116 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  store i64 %115, ptr %116, align 4
  %117 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %118 = load i64, ptr %117, align 4
  %119 = icmp eq i64 %118, 0
  call void @__GLAssert(i1 %119)
  %120 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  %121 = load i64, ptr %120, align 4
  %122 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 1
  %123 = load i64, ptr %122, align 4
  %124 = add i64 %121, %123
  %125 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  store i64 %124, ptr %125, align 4
  %number18 = alloca %SchemeObject, align 8
  %126 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 0
  store i64 0, ptr %126, align 4
  %127 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  store i64 0, ptr %127, align 4
  %function_returned19 = alloca %SchemeObject, align 8
  %128 = call ptr @llvm.stacksave()
  %129 = call %SchemeObject @LambdaFunction.5(ptr %variable)
  store %SchemeObject %129, ptr %function_returned19, align 8
  call void @llvm.stackrestore(ptr %128)
  %130 = getelementptr %SchemeObject, ptr %function_returned19, i32 0, i32 0
  %131 = load i64, ptr %130, align 4
  %132 = icmp eq i64 %131, 0
  call void @__GLAssert(i1 %132)
  %133 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  %134 = load i64, ptr %133, align 4
  %135 = getelementptr %SchemeObject, ptr %function_returned19, i32 0, i32 1
  %136 = load i64, ptr %135, align 4
  %137 = add i64 %134, %136
  %138 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  store i64 %137, ptr %138, align 4
  %139 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %140 = load i64, ptr %139, align 4
  %141 = icmp eq i64 %140, 0
  call void @__GLAssert(i1 %141)
  %142 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  %143 = load i64, ptr %142, align 4
  %144 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 1
  %145 = load i64, ptr %144, align 4
  %146 = add i64 %143, %145
  %147 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  store i64 %146, ptr %147, align 4
  %function_returned20 = alloca %SchemeObject, align 8
  %148 = call ptr @llvm.stacksave()
  %149 = call %SchemeObject @LambdaFunction.2(ptr %number14, ptr %number16, ptr %number18)
  store %SchemeObject %149, ptr %function_returned20, align 8
  call void @llvm.stackrestore(ptr %148)
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %150 = phi ptr [ %function_returned13, %true_branch ], [ %function_returned20, %false_branch ]
  %151 = getelementptr %SchemeObject, ptr %150, i32 0
  %152 = load %SchemeObject, ptr %151, align 8
  ret %SchemeObject %152

true_branch2:                                     ; preds = %entry
  %boolean = alloca %SchemeObject, align 8
  %153 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %153, align 4
  %154 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %154, align 1
  br label %merge_branch4

false_branch3:                                    ; preds = %entry
  %boolean5 = alloca %SchemeObject, align 8
  %155 = getelementptr %SchemeObject, ptr %boolean5, i32 0, i32 0
  store i64 1, ptr %155, align 4
  %156 = getelementptr %SchemeObject, ptr %boolean5, i32 0, i32 2
  store i1 false, ptr %156, align 1
  br label %merge_branch4

merge_branch4:                                    ; preds = %false_branch3, %true_branch2
  %157 = phi ptr [ %boolean, %true_branch2 ], [ %boolean5, %false_branch3 ]
  %158 = getelementptr %SchemeObject, ptr %157, i32 0, i32 0
  %159 = load i64, ptr %158, align 4
  %160 = icmp eq i64 %159, 1
  call void @__GLAssert(i1 %160)
  %161 = getelementptr %SchemeObject, ptr %157, i32 0, i32 2
  %162 = load i1, ptr %161, align 1
  br i1 %162, label %true_branch, label %false_branch
}

define %SchemeObject @LambdaFunction.7(ptr %0, ptr %1) {
entry:
  %variable = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %0, i32 0
  %3 = load %SchemeObject, ptr %2, align 8
  store %SchemeObject %3, ptr %variable, align 8
  %variable1 = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %1, i32 0
  %5 = load %SchemeObject, ptr %4, align 8
  store %SchemeObject %5, ptr %variable1, align 8
  %6 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %7 = load i64, ptr %6, align 4
  %is_type_check = icmp eq i64 %7, 3
  br i1 %is_type_check, label %true_branch2, label %false_branch3

true_branch:                                      ; preds = %merge_branch4
  %number = alloca %SchemeObject, align 8
  %8 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %8, align 4
  %9 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 0, ptr %9, align 4
  %function_returned = alloca %SchemeObject, align 8
  %10 = call ptr @llvm.stacksave()
  %11 = call %SchemeObject @LambdaFunction.3(ptr %variable)
  store %SchemeObject %11, ptr %function_returned, align 8
  call void @llvm.stackrestore(ptr %10)
  %12 = getelementptr %SchemeObject, ptr %function_returned, i32 0, i32 0
  %13 = load i64, ptr %12, align 4
  %14 = icmp eq i64 %13, 0
  call void @__GLAssert(i1 %14)
  %15 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %16 = load i64, ptr %15, align 4
  %17 = getelementptr %SchemeObject, ptr %function_returned, i32 0, i32 1
  %18 = load i64, ptr %17, align 4
  %19 = sub i64 %16, %18
  %20 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 %18, ptr %20, align 4
  %function_returned6 = alloca %SchemeObject, align 8
  %21 = call ptr @llvm.stacksave()
  %22 = call %SchemeObject @LambdaFunction.3(ptr %variable1)
  store %SchemeObject %22, ptr %function_returned6, align 8
  call void @llvm.stackrestore(ptr %21)
  %23 = getelementptr %SchemeObject, ptr %function_returned6, i32 0, i32 0
  %24 = load i64, ptr %23, align 4
  %25 = icmp eq i64 %24, 0
  call void @__GLAssert(i1 %25)
  %26 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %27 = load i64, ptr %26, align 4
  %28 = getelementptr %SchemeObject, ptr %function_returned6, i32 0, i32 1
  %29 = load i64, ptr %28, align 4
  %30 = sub i64 %27, %29
  %31 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 %30, ptr %31, align 4
  %number7 = alloca %SchemeObject, align 8
  %32 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 0
  store i64 0, ptr %32, align 4
  %33 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 0, ptr %33, align 4
  %function_returned8 = alloca %SchemeObject, align 8
  %34 = call ptr @llvm.stacksave()
  %35 = call %SchemeObject @LambdaFunction.4(ptr %variable)
  store %SchemeObject %35, ptr %function_returned8, align 8
  call void @llvm.stackrestore(ptr %34)
  %36 = getelementptr %SchemeObject, ptr %function_returned8, i32 0, i32 0
  %37 = load i64, ptr %36, align 4
  %38 = icmp eq i64 %37, 0
  call void @__GLAssert(i1 %38)
  %39 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  %40 = load i64, ptr %39, align 4
  %41 = getelementptr %SchemeObject, ptr %function_returned8, i32 0, i32 1
  %42 = load i64, ptr %41, align 4
  %43 = sub i64 %40, %42
  %44 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 %42, ptr %44, align 4
  %function_returned9 = alloca %SchemeObject, align 8
  %45 = call ptr @llvm.stacksave()
  %46 = call %SchemeObject @LambdaFunction.4(ptr %variable1)
  store %SchemeObject %46, ptr %function_returned9, align 8
  call void @llvm.stackrestore(ptr %45)
  %47 = getelementptr %SchemeObject, ptr %function_returned9, i32 0, i32 0
  %48 = load i64, ptr %47, align 4
  %49 = icmp eq i64 %48, 0
  call void @__GLAssert(i1 %49)
  %50 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  %51 = load i64, ptr %50, align 4
  %52 = getelementptr %SchemeObject, ptr %function_returned9, i32 0, i32 1
  %53 = load i64, ptr %52, align 4
  %54 = sub i64 %51, %53
  %55 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 %54, ptr %55, align 4
  %number10 = alloca %SchemeObject, align 8
  %56 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 0
  store i64 0, ptr %56, align 4
  %57 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 0, ptr %57, align 4
  %function_returned11 = alloca %SchemeObject, align 8
  %58 = call ptr @llvm.stacksave()
  %59 = call %SchemeObject @LambdaFunction.5(ptr %variable)
  store %SchemeObject %59, ptr %function_returned11, align 8
  call void @llvm.stackrestore(ptr %58)
  %60 = getelementptr %SchemeObject, ptr %function_returned11, i32 0, i32 0
  %61 = load i64, ptr %60, align 4
  %62 = icmp eq i64 %61, 0
  call void @__GLAssert(i1 %62)
  %63 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  %64 = load i64, ptr %63, align 4
  %65 = getelementptr %SchemeObject, ptr %function_returned11, i32 0, i32 1
  %66 = load i64, ptr %65, align 4
  %67 = sub i64 %64, %66
  %68 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 %66, ptr %68, align 4
  %function_returned12 = alloca %SchemeObject, align 8
  %69 = call ptr @llvm.stacksave()
  %70 = call %SchemeObject @LambdaFunction.5(ptr %variable1)
  store %SchemeObject %70, ptr %function_returned12, align 8
  call void @llvm.stackrestore(ptr %69)
  %71 = getelementptr %SchemeObject, ptr %function_returned12, i32 0, i32 0
  %72 = load i64, ptr %71, align 4
  %73 = icmp eq i64 %72, 0
  call void @__GLAssert(i1 %73)
  %74 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  %75 = load i64, ptr %74, align 4
  %76 = getelementptr %SchemeObject, ptr %function_returned12, i32 0, i32 1
  %77 = load i64, ptr %76, align 4
  %78 = sub i64 %75, %77
  %79 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 %78, ptr %79, align 4
  %function_returned13 = alloca %SchemeObject, align 8
  %80 = call ptr @llvm.stacksave()
  %81 = call %SchemeObject @LambdaFunction.2(ptr %number, ptr %number7, ptr %number10)
  store %SchemeObject %81, ptr %function_returned13, align 8
  call void @llvm.stackrestore(ptr %80)
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch4
  %number14 = alloca %SchemeObject, align 8
  %82 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 0
  store i64 0, ptr %82, align 4
  %83 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  store i64 0, ptr %83, align 4
  %function_returned15 = alloca %SchemeObject, align 8
  %84 = call ptr @llvm.stacksave()
  %85 = call %SchemeObject @LambdaFunction.3(ptr %variable)
  store %SchemeObject %85, ptr %function_returned15, align 8
  call void @llvm.stackrestore(ptr %84)
  %86 = getelementptr %SchemeObject, ptr %function_returned15, i32 0, i32 0
  %87 = load i64, ptr %86, align 4
  %88 = icmp eq i64 %87, 0
  call void @__GLAssert(i1 %88)
  %89 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  %90 = load i64, ptr %89, align 4
  %91 = getelementptr %SchemeObject, ptr %function_returned15, i32 0, i32 1
  %92 = load i64, ptr %91, align 4
  %93 = sub i64 %90, %92
  %94 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  store i64 %92, ptr %94, align 4
  %95 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %96 = load i64, ptr %95, align 4
  %97 = icmp eq i64 %96, 0
  call void @__GLAssert(i1 %97)
  %98 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  %99 = load i64, ptr %98, align 4
  %100 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 1
  %101 = load i64, ptr %100, align 4
  %102 = sub i64 %99, %101
  %103 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  store i64 %102, ptr %103, align 4
  %number16 = alloca %SchemeObject, align 8
  %104 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 0
  store i64 0, ptr %104, align 4
  %105 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  store i64 0, ptr %105, align 4
  %function_returned17 = alloca %SchemeObject, align 8
  %106 = call ptr @llvm.stacksave()
  %107 = call %SchemeObject @LambdaFunction.4(ptr %variable)
  store %SchemeObject %107, ptr %function_returned17, align 8
  call void @llvm.stackrestore(ptr %106)
  %108 = getelementptr %SchemeObject, ptr %function_returned17, i32 0, i32 0
  %109 = load i64, ptr %108, align 4
  %110 = icmp eq i64 %109, 0
  call void @__GLAssert(i1 %110)
  %111 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  %112 = load i64, ptr %111, align 4
  %113 = getelementptr %SchemeObject, ptr %function_returned17, i32 0, i32 1
  %114 = load i64, ptr %113, align 4
  %115 = sub i64 %112, %114
  %116 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  store i64 %114, ptr %116, align 4
  %117 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %118 = load i64, ptr %117, align 4
  %119 = icmp eq i64 %118, 0
  call void @__GLAssert(i1 %119)
  %120 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  %121 = load i64, ptr %120, align 4
  %122 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 1
  %123 = load i64, ptr %122, align 4
  %124 = sub i64 %121, %123
  %125 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  store i64 %124, ptr %125, align 4
  %number18 = alloca %SchemeObject, align 8
  %126 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 0
  store i64 0, ptr %126, align 4
  %127 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  store i64 0, ptr %127, align 4
  %function_returned19 = alloca %SchemeObject, align 8
  %128 = call ptr @llvm.stacksave()
  %129 = call %SchemeObject @LambdaFunction.5(ptr %variable)
  store %SchemeObject %129, ptr %function_returned19, align 8
  call void @llvm.stackrestore(ptr %128)
  %130 = getelementptr %SchemeObject, ptr %function_returned19, i32 0, i32 0
  %131 = load i64, ptr %130, align 4
  %132 = icmp eq i64 %131, 0
  call void @__GLAssert(i1 %132)
  %133 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  %134 = load i64, ptr %133, align 4
  %135 = getelementptr %SchemeObject, ptr %function_returned19, i32 0, i32 1
  %136 = load i64, ptr %135, align 4
  %137 = sub i64 %134, %136
  %138 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  store i64 %136, ptr %138, align 4
  %139 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %140 = load i64, ptr %139, align 4
  %141 = icmp eq i64 %140, 0
  call void @__GLAssert(i1 %141)
  %142 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  %143 = load i64, ptr %142, align 4
  %144 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 1
  %145 = load i64, ptr %144, align 4
  %146 = sub i64 %143, %145
  %147 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  store i64 %146, ptr %147, align 4
  %function_returned20 = alloca %SchemeObject, align 8
  %148 = call ptr @llvm.stacksave()
  %149 = call %SchemeObject @LambdaFunction.2(ptr %number14, ptr %number16, ptr %number18)
  store %SchemeObject %149, ptr %function_returned20, align 8
  call void @llvm.stackrestore(ptr %148)
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %150 = phi ptr [ %function_returned13, %true_branch ], [ %function_returned20, %false_branch ]
  %151 = getelementptr %SchemeObject, ptr %150, i32 0
  %152 = load %SchemeObject, ptr %151, align 8
  ret %SchemeObject %152

true_branch2:                                     ; preds = %entry
  %boolean = alloca %SchemeObject, align 8
  %153 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %153, align 4
  %154 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %154, align 1
  br label %merge_branch4

false_branch3:                                    ; preds = %entry
  %boolean5 = alloca %SchemeObject, align 8
  %155 = getelementptr %SchemeObject, ptr %boolean5, i32 0, i32 0
  store i64 1, ptr %155, align 4
  %156 = getelementptr %SchemeObject, ptr %boolean5, i32 0, i32 2
  store i1 false, ptr %156, align 1
  br label %merge_branch4

merge_branch4:                                    ; preds = %false_branch3, %true_branch2
  %157 = phi ptr [ %boolean, %true_branch2 ], [ %boolean5, %false_branch3 ]
  %158 = getelementptr %SchemeObject, ptr %157, i32 0, i32 0
  %159 = load i64, ptr %158, align 4
  %160 = icmp eq i64 %159, 1
  call void @__GLAssert(i1 %160)
  %161 = getelementptr %SchemeObject, ptr %157, i32 0, i32 2
  %162 = load i1, ptr %161, align 1
  br i1 %162, label %true_branch, label %false_branch
}

define %SchemeObject @LambdaFunction.8(ptr %0, ptr %1) {
entry:
  %variable = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %0, i32 0
  %3 = load %SchemeObject, ptr %2, align 8
  store %SchemeObject %3, ptr %variable, align 8
  %variable1 = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %1, i32 0
  %5 = load %SchemeObject, ptr %4, align 8
  store %SchemeObject %5, ptr %variable1, align 8
  %6 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %7 = load i64, ptr %6, align 4
  %is_type_check = icmp eq i64 %7, 3
  br i1 %is_type_check, label %true_branch2, label %false_branch3

true_branch:                                      ; preds = %merge_branch4
  %number = alloca %SchemeObject, align 8
  %8 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %8, align 4
  %9 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 100, ptr %9, align 4
  %function_returned = alloca %SchemeObject, align 8
  %10 = call ptr @llvm.stacksave()
  %11 = call %SchemeObject @LambdaFunction.3(ptr %variable)
  store %SchemeObject %11, ptr %function_returned, align 8
  call void @llvm.stackrestore(ptr %10)
  %12 = getelementptr %SchemeObject, ptr %function_returned, i32 0, i32 0
  %13 = load i64, ptr %12, align 4
  %14 = icmp eq i64 %13, 0
  call void @__GLAssert(i1 %14)
  %15 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %16 = load i64, ptr %15, align 4
  %17 = getelementptr %SchemeObject, ptr %function_returned, i32 0, i32 1
  %18 = load i64, ptr %17, align 4
  %19 = mul i64 %16, %18
  %20 = sdiv i64 %19, 100
  %21 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 %20, ptr %21, align 4
  %function_returned6 = alloca %SchemeObject, align 8
  %22 = call ptr @llvm.stacksave()
  %23 = call %SchemeObject @LambdaFunction.3(ptr %variable1)
  store %SchemeObject %23, ptr %function_returned6, align 8
  call void @llvm.stackrestore(ptr %22)
  %24 = getelementptr %SchemeObject, ptr %function_returned6, i32 0, i32 0
  %25 = load i64, ptr %24, align 4
  %26 = icmp eq i64 %25, 0
  call void @__GLAssert(i1 %26)
  %27 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %28 = load i64, ptr %27, align 4
  %29 = getelementptr %SchemeObject, ptr %function_returned6, i32 0, i32 1
  %30 = load i64, ptr %29, align 4
  %31 = mul i64 %28, %30
  %32 = sdiv i64 %31, 100
  %33 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 %32, ptr %33, align 4
  %number7 = alloca %SchemeObject, align 8
  %34 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 0
  store i64 0, ptr %34, align 4
  %35 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 100, ptr %35, align 4
  %function_returned8 = alloca %SchemeObject, align 8
  %36 = call ptr @llvm.stacksave()
  %37 = call %SchemeObject @LambdaFunction.4(ptr %variable)
  store %SchemeObject %37, ptr %function_returned8, align 8
  call void @llvm.stackrestore(ptr %36)
  %38 = getelementptr %SchemeObject, ptr %function_returned8, i32 0, i32 0
  %39 = load i64, ptr %38, align 4
  %40 = icmp eq i64 %39, 0
  call void @__GLAssert(i1 %40)
  %41 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  %42 = load i64, ptr %41, align 4
  %43 = getelementptr %SchemeObject, ptr %function_returned8, i32 0, i32 1
  %44 = load i64, ptr %43, align 4
  %45 = mul i64 %42, %44
  %46 = sdiv i64 %45, 100
  %47 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 %46, ptr %47, align 4
  %function_returned9 = alloca %SchemeObject, align 8
  %48 = call ptr @llvm.stacksave()
  %49 = call %SchemeObject @LambdaFunction.4(ptr %variable1)
  store %SchemeObject %49, ptr %function_returned9, align 8
  call void @llvm.stackrestore(ptr %48)
  %50 = getelementptr %SchemeObject, ptr %function_returned9, i32 0, i32 0
  %51 = load i64, ptr %50, align 4
  %52 = icmp eq i64 %51, 0
  call void @__GLAssert(i1 %52)
  %53 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  %54 = load i64, ptr %53, align 4
  %55 = getelementptr %SchemeObject, ptr %function_returned9, i32 0, i32 1
  %56 = load i64, ptr %55, align 4
  %57 = mul i64 %54, %56
  %58 = sdiv i64 %57, 100
  %59 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 %58, ptr %59, align 4
  %number10 = alloca %SchemeObject, align 8
  %60 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 0
  store i64 0, ptr %60, align 4
  %61 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 100, ptr %61, align 4
  %function_returned11 = alloca %SchemeObject, align 8
  %62 = call ptr @llvm.stacksave()
  %63 = call %SchemeObject @LambdaFunction.5(ptr %variable)
  store %SchemeObject %63, ptr %function_returned11, align 8
  call void @llvm.stackrestore(ptr %62)
  %64 = getelementptr %SchemeObject, ptr %function_returned11, i32 0, i32 0
  %65 = load i64, ptr %64, align 4
  %66 = icmp eq i64 %65, 0
  call void @__GLAssert(i1 %66)
  %67 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  %68 = load i64, ptr %67, align 4
  %69 = getelementptr %SchemeObject, ptr %function_returned11, i32 0, i32 1
  %70 = load i64, ptr %69, align 4
  %71 = mul i64 %68, %70
  %72 = sdiv i64 %71, 100
  %73 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 %72, ptr %73, align 4
  %function_returned12 = alloca %SchemeObject, align 8
  %74 = call ptr @llvm.stacksave()
  %75 = call %SchemeObject @LambdaFunction.5(ptr %variable1)
  store %SchemeObject %75, ptr %function_returned12, align 8
  call void @llvm.stackrestore(ptr %74)
  %76 = getelementptr %SchemeObject, ptr %function_returned12, i32 0, i32 0
  %77 = load i64, ptr %76, align 4
  %78 = icmp eq i64 %77, 0
  call void @__GLAssert(i1 %78)
  %79 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  %80 = load i64, ptr %79, align 4
  %81 = getelementptr %SchemeObject, ptr %function_returned12, i32 0, i32 1
  %82 = load i64, ptr %81, align 4
  %83 = mul i64 %80, %82
  %84 = sdiv i64 %83, 100
  %85 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 %84, ptr %85, align 4
  %function_returned13 = alloca %SchemeObject, align 8
  %86 = call ptr @llvm.stacksave()
  %87 = call %SchemeObject @LambdaFunction.2(ptr %number, ptr %number7, ptr %number10)
  store %SchemeObject %87, ptr %function_returned13, align 8
  call void @llvm.stackrestore(ptr %86)
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch4
  %number14 = alloca %SchemeObject, align 8
  %88 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 0
  store i64 0, ptr %88, align 4
  %89 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  store i64 100, ptr %89, align 4
  %function_returned15 = alloca %SchemeObject, align 8
  %90 = call ptr @llvm.stacksave()
  %91 = call %SchemeObject @LambdaFunction.3(ptr %variable)
  store %SchemeObject %91, ptr %function_returned15, align 8
  call void @llvm.stackrestore(ptr %90)
  %92 = getelementptr %SchemeObject, ptr %function_returned15, i32 0, i32 0
  %93 = load i64, ptr %92, align 4
  %94 = icmp eq i64 %93, 0
  call void @__GLAssert(i1 %94)
  %95 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  %96 = load i64, ptr %95, align 4
  %97 = getelementptr %SchemeObject, ptr %function_returned15, i32 0, i32 1
  %98 = load i64, ptr %97, align 4
  %99 = mul i64 %96, %98
  %100 = sdiv i64 %99, 100
  %101 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  store i64 %100, ptr %101, align 4
  %102 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %103 = load i64, ptr %102, align 4
  %104 = icmp eq i64 %103, 0
  call void @__GLAssert(i1 %104)
  %105 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  %106 = load i64, ptr %105, align 4
  %107 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 1
  %108 = load i64, ptr %107, align 4
  %109 = mul i64 %106, %108
  %110 = sdiv i64 %109, 100
  %111 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  store i64 %110, ptr %111, align 4
  %number16 = alloca %SchemeObject, align 8
  %112 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 0
  store i64 0, ptr %112, align 4
  %113 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  store i64 100, ptr %113, align 4
  %function_returned17 = alloca %SchemeObject, align 8
  %114 = call ptr @llvm.stacksave()
  %115 = call %SchemeObject @LambdaFunction.4(ptr %variable)
  store %SchemeObject %115, ptr %function_returned17, align 8
  call void @llvm.stackrestore(ptr %114)
  %116 = getelementptr %SchemeObject, ptr %function_returned17, i32 0, i32 0
  %117 = load i64, ptr %116, align 4
  %118 = icmp eq i64 %117, 0
  call void @__GLAssert(i1 %118)
  %119 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  %120 = load i64, ptr %119, align 4
  %121 = getelementptr %SchemeObject, ptr %function_returned17, i32 0, i32 1
  %122 = load i64, ptr %121, align 4
  %123 = mul i64 %120, %122
  %124 = sdiv i64 %123, 100
  %125 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  store i64 %124, ptr %125, align 4
  %126 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %127 = load i64, ptr %126, align 4
  %128 = icmp eq i64 %127, 0
  call void @__GLAssert(i1 %128)
  %129 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  %130 = load i64, ptr %129, align 4
  %131 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 1
  %132 = load i64, ptr %131, align 4
  %133 = mul i64 %130, %132
  %134 = sdiv i64 %133, 100
  %135 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  store i64 %134, ptr %135, align 4
  %number18 = alloca %SchemeObject, align 8
  %136 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 0
  store i64 0, ptr %136, align 4
  %137 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  store i64 100, ptr %137, align 4
  %function_returned19 = alloca %SchemeObject, align 8
  %138 = call ptr @llvm.stacksave()
  %139 = call %SchemeObject @LambdaFunction.5(ptr %variable)
  store %SchemeObject %139, ptr %function_returned19, align 8
  call void @llvm.stackrestore(ptr %138)
  %140 = getelementptr %SchemeObject, ptr %function_returned19, i32 0, i32 0
  %141 = load i64, ptr %140, align 4
  %142 = icmp eq i64 %141, 0
  call void @__GLAssert(i1 %142)
  %143 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  %144 = load i64, ptr %143, align 4
  %145 = getelementptr %SchemeObject, ptr %function_returned19, i32 0, i32 1
  %146 = load i64, ptr %145, align 4
  %147 = mul i64 %144, %146
  %148 = sdiv i64 %147, 100
  %149 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  store i64 %148, ptr %149, align 4
  %150 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %151 = load i64, ptr %150, align 4
  %152 = icmp eq i64 %151, 0
  call void @__GLAssert(i1 %152)
  %153 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  %154 = load i64, ptr %153, align 4
  %155 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 1
  %156 = load i64, ptr %155, align 4
  %157 = mul i64 %154, %156
  %158 = sdiv i64 %157, 100
  %159 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  store i64 %158, ptr %159, align 4
  %function_returned20 = alloca %SchemeObject, align 8
  %160 = call ptr @llvm.stacksave()
  %161 = call %SchemeObject @LambdaFunction.2(ptr %number14, ptr %number16, ptr %number18)
  store %SchemeObject %161, ptr %function_returned20, align 8
  call void @llvm.stackrestore(ptr %160)
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %162 = phi ptr [ %function_returned13, %true_branch ], [ %function_returned20, %false_branch ]
  %163 = getelementptr %SchemeObject, ptr %162, i32 0
  %164 = load %SchemeObject, ptr %163, align 8
  ret %SchemeObject %164

true_branch2:                                     ; preds = %entry
  %boolean = alloca %SchemeObject, align 8
  %165 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %165, align 4
  %166 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %166, align 1
  br label %merge_branch4

false_branch3:                                    ; preds = %entry
  %boolean5 = alloca %SchemeObject, align 8
  %167 = getelementptr %SchemeObject, ptr %boolean5, i32 0, i32 0
  store i64 1, ptr %167, align 4
  %168 = getelementptr %SchemeObject, ptr %boolean5, i32 0, i32 2
  store i1 false, ptr %168, align 1
  br label %merge_branch4

merge_branch4:                                    ; preds = %false_branch3, %true_branch2
  %169 = phi ptr [ %boolean, %true_branch2 ], [ %boolean5, %false_branch3 ]
  %170 = getelementptr %SchemeObject, ptr %169, i32 0, i32 0
  %171 = load i64, ptr %170, align 4
  %172 = icmp eq i64 %171, 1
  call void @__GLAssert(i1 %172)
  %173 = getelementptr %SchemeObject, ptr %169, i32 0, i32 2
  %174 = load i1, ptr %173, align 1
  br i1 %174, label %true_branch, label %false_branch
}

define %SchemeObject @LambdaFunction.9(ptr %0, ptr %1) {
entry:
  %variable = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %0, i32 0
  %3 = load %SchemeObject, ptr %2, align 8
  store %SchemeObject %3, ptr %variable, align 8
  %variable1 = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %1, i32 0
  %5 = load %SchemeObject, ptr %4, align 8
  store %SchemeObject %5, ptr %variable1, align 8
  %6 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %7 = load i64, ptr %6, align 4
  %is_type_check = icmp eq i64 %7, 3
  br i1 %is_type_check, label %true_branch2, label %false_branch3

true_branch:                                      ; preds = %merge_branch4
  %number = alloca %SchemeObject, align 8
  %8 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %8, align 4
  %9 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 100, ptr %9, align 4
  %function_returned = alloca %SchemeObject, align 8
  %10 = call ptr @llvm.stacksave()
  %11 = call %SchemeObject @LambdaFunction.3(ptr %variable)
  store %SchemeObject %11, ptr %function_returned, align 8
  call void @llvm.stackrestore(ptr %10)
  %12 = getelementptr %SchemeObject, ptr %function_returned, i32 0, i32 0
  %13 = load i64, ptr %12, align 4
  %14 = icmp eq i64 %13, 0
  call void @__GLAssert(i1 %14)
  %15 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %16 = load i64, ptr %15, align 4
  %17 = getelementptr %SchemeObject, ptr %function_returned, i32 0, i32 1
  %18 = load i64, ptr %17, align 4
  %is_zero_then_one_check = icmp ne i64 %18, 0
  br i1 %is_zero_then_one_check, label %continue_branch, label %modify_branch

false_branch:                                     ; preds = %merge_branch4
  %number29 = alloca %SchemeObject, align 8
  %19 = getelementptr %SchemeObject, ptr %number29, i32 0, i32 0
  store i64 0, ptr %19, align 4
  %20 = getelementptr %SchemeObject, ptr %number29, i32 0, i32 1
  store i64 100, ptr %20, align 4
  %function_returned30 = alloca %SchemeObject, align 8
  %21 = call ptr @llvm.stacksave()
  %22 = call %SchemeObject @LambdaFunction.3(ptr %variable)
  store %SchemeObject %22, ptr %function_returned30, align 8
  call void @llvm.stackrestore(ptr %21)
  %23 = getelementptr %SchemeObject, ptr %function_returned30, i32 0, i32 0
  %24 = load i64, ptr %23, align 4
  %25 = icmp eq i64 %24, 0
  call void @__GLAssert(i1 %25)
  %26 = getelementptr %SchemeObject, ptr %number29, i32 0, i32 1
  %27 = load i64, ptr %26, align 4
  %28 = getelementptr %SchemeObject, ptr %function_returned30, i32 0, i32 1
  %29 = load i64, ptr %28, align 4
  %is_zero_then_one_check33 = icmp ne i64 %29, 0
  br i1 %is_zero_then_one_check33, label %continue_branch32, label %modify_branch31

merge_branch:                                     ; preds = %continue_branch51, %continue_branch26
  %30 = phi ptr [ %function_returned28, %continue_branch26 ], [ %function_returned53, %continue_branch51 ]
  %31 = getelementptr %SchemeObject, ptr %30, i32 0
  %32 = load %SchemeObject, ptr %31, align 8
  ret %SchemeObject %32

true_branch2:                                     ; preds = %entry
  %boolean = alloca %SchemeObject, align 8
  %33 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %33, align 4
  %34 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %34, align 1
  br label %merge_branch4

false_branch3:                                    ; preds = %entry
  %boolean5 = alloca %SchemeObject, align 8
  %35 = getelementptr %SchemeObject, ptr %boolean5, i32 0, i32 0
  store i64 1, ptr %35, align 4
  %36 = getelementptr %SchemeObject, ptr %boolean5, i32 0, i32 2
  store i1 false, ptr %36, align 1
  br label %merge_branch4

merge_branch4:                                    ; preds = %false_branch3, %true_branch2
  %37 = phi ptr [ %boolean, %true_branch2 ], [ %boolean5, %false_branch3 ]
  %38 = getelementptr %SchemeObject, ptr %37, i32 0, i32 0
  %39 = load i64, ptr %38, align 4
  %40 = icmp eq i64 %39, 1
  call void @__GLAssert(i1 %40)
  %41 = getelementptr %SchemeObject, ptr %37, i32 0, i32 2
  %42 = load i1, ptr %41, align 1
  br i1 %42, label %true_branch, label %false_branch

modify_branch:                                    ; preds = %true_branch
  br label %continue_branch

continue_branch:                                  ; preds = %modify_branch, %true_branch
  %43 = phi i64 [ 1, %modify_branch ], [ %18, %true_branch ]
  %44 = mul i64 %16, 100
  %45 = sdiv i64 %44, %43
  %46 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 %18, ptr %46, align 4
  %function_returned6 = alloca %SchemeObject, align 8
  %47 = call ptr @llvm.stacksave()
  %48 = call %SchemeObject @LambdaFunction.3(ptr %variable1)
  store %SchemeObject %48, ptr %function_returned6, align 8
  call void @llvm.stackrestore(ptr %47)
  %49 = getelementptr %SchemeObject, ptr %function_returned6, i32 0, i32 0
  %50 = load i64, ptr %49, align 4
  %51 = icmp eq i64 %50, 0
  call void @__GLAssert(i1 %51)
  %52 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %53 = load i64, ptr %52, align 4
  %54 = getelementptr %SchemeObject, ptr %function_returned6, i32 0, i32 1
  %55 = load i64, ptr %54, align 4
  %is_zero_then_one_check9 = icmp ne i64 %55, 0
  br i1 %is_zero_then_one_check9, label %continue_branch8, label %modify_branch7

modify_branch7:                                   ; preds = %continue_branch
  br label %continue_branch8

continue_branch8:                                 ; preds = %modify_branch7, %continue_branch
  %56 = phi i64 [ 1, %modify_branch7 ], [ %55, %continue_branch ]
  %57 = mul i64 %53, 100
  %58 = sdiv i64 %57, %56
  %59 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 %58, ptr %59, align 4
  %number10 = alloca %SchemeObject, align 8
  %60 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 0
  store i64 0, ptr %60, align 4
  %61 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 100, ptr %61, align 4
  %function_returned11 = alloca %SchemeObject, align 8
  %62 = call ptr @llvm.stacksave()
  %63 = call %SchemeObject @LambdaFunction.4(ptr %variable)
  store %SchemeObject %63, ptr %function_returned11, align 8
  call void @llvm.stackrestore(ptr %62)
  %64 = getelementptr %SchemeObject, ptr %function_returned11, i32 0, i32 0
  %65 = load i64, ptr %64, align 4
  %66 = icmp eq i64 %65, 0
  call void @__GLAssert(i1 %66)
  %67 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  %68 = load i64, ptr %67, align 4
  %69 = getelementptr %SchemeObject, ptr %function_returned11, i32 0, i32 1
  %70 = load i64, ptr %69, align 4
  %is_zero_then_one_check14 = icmp ne i64 %70, 0
  br i1 %is_zero_then_one_check14, label %continue_branch13, label %modify_branch12

modify_branch12:                                  ; preds = %continue_branch8
  br label %continue_branch13

continue_branch13:                                ; preds = %modify_branch12, %continue_branch8
  %71 = phi i64 [ 1, %modify_branch12 ], [ %70, %continue_branch8 ]
  %72 = mul i64 %68, 100
  %73 = sdiv i64 %72, %71
  %74 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 %70, ptr %74, align 4
  %function_returned15 = alloca %SchemeObject, align 8
  %75 = call ptr @llvm.stacksave()
  %76 = call %SchemeObject @LambdaFunction.4(ptr %variable1)
  store %SchemeObject %76, ptr %function_returned15, align 8
  call void @llvm.stackrestore(ptr %75)
  %77 = getelementptr %SchemeObject, ptr %function_returned15, i32 0, i32 0
  %78 = load i64, ptr %77, align 4
  %79 = icmp eq i64 %78, 0
  call void @__GLAssert(i1 %79)
  %80 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  %81 = load i64, ptr %80, align 4
  %82 = getelementptr %SchemeObject, ptr %function_returned15, i32 0, i32 1
  %83 = load i64, ptr %82, align 4
  %is_zero_then_one_check18 = icmp ne i64 %83, 0
  br i1 %is_zero_then_one_check18, label %continue_branch17, label %modify_branch16

modify_branch16:                                  ; preds = %continue_branch13
  br label %continue_branch17

continue_branch17:                                ; preds = %modify_branch16, %continue_branch13
  %84 = phi i64 [ 1, %modify_branch16 ], [ %83, %continue_branch13 ]
  %85 = mul i64 %81, 100
  %86 = sdiv i64 %85, %84
  %87 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 %86, ptr %87, align 4
  %number19 = alloca %SchemeObject, align 8
  %88 = getelementptr %SchemeObject, ptr %number19, i32 0, i32 0
  store i64 0, ptr %88, align 4
  %89 = getelementptr %SchemeObject, ptr %number19, i32 0, i32 1
  store i64 100, ptr %89, align 4
  %function_returned20 = alloca %SchemeObject, align 8
  %90 = call ptr @llvm.stacksave()
  %91 = call %SchemeObject @LambdaFunction.5(ptr %variable)
  store %SchemeObject %91, ptr %function_returned20, align 8
  call void @llvm.stackrestore(ptr %90)
  %92 = getelementptr %SchemeObject, ptr %function_returned20, i32 0, i32 0
  %93 = load i64, ptr %92, align 4
  %94 = icmp eq i64 %93, 0
  call void @__GLAssert(i1 %94)
  %95 = getelementptr %SchemeObject, ptr %number19, i32 0, i32 1
  %96 = load i64, ptr %95, align 4
  %97 = getelementptr %SchemeObject, ptr %function_returned20, i32 0, i32 1
  %98 = load i64, ptr %97, align 4
  %is_zero_then_one_check23 = icmp ne i64 %98, 0
  br i1 %is_zero_then_one_check23, label %continue_branch22, label %modify_branch21

modify_branch21:                                  ; preds = %continue_branch17
  br label %continue_branch22

continue_branch22:                                ; preds = %modify_branch21, %continue_branch17
  %99 = phi i64 [ 1, %modify_branch21 ], [ %98, %continue_branch17 ]
  %100 = mul i64 %96, 100
  %101 = sdiv i64 %100, %99
  %102 = getelementptr %SchemeObject, ptr %number19, i32 0, i32 1
  store i64 %98, ptr %102, align 4
  %function_returned24 = alloca %SchemeObject, align 8
  %103 = call ptr @llvm.stacksave()
  %104 = call %SchemeObject @LambdaFunction.5(ptr %variable1)
  store %SchemeObject %104, ptr %function_returned24, align 8
  call void @llvm.stackrestore(ptr %103)
  %105 = getelementptr %SchemeObject, ptr %function_returned24, i32 0, i32 0
  %106 = load i64, ptr %105, align 4
  %107 = icmp eq i64 %106, 0
  call void @__GLAssert(i1 %107)
  %108 = getelementptr %SchemeObject, ptr %number19, i32 0, i32 1
  %109 = load i64, ptr %108, align 4
  %110 = getelementptr %SchemeObject, ptr %function_returned24, i32 0, i32 1
  %111 = load i64, ptr %110, align 4
  %is_zero_then_one_check27 = icmp ne i64 %111, 0
  br i1 %is_zero_then_one_check27, label %continue_branch26, label %modify_branch25

modify_branch25:                                  ; preds = %continue_branch22
  br label %continue_branch26

continue_branch26:                                ; preds = %modify_branch25, %continue_branch22
  %112 = phi i64 [ 1, %modify_branch25 ], [ %111, %continue_branch22 ]
  %113 = mul i64 %109, 100
  %114 = sdiv i64 %113, %112
  %115 = getelementptr %SchemeObject, ptr %number19, i32 0, i32 1
  store i64 %114, ptr %115, align 4
  %function_returned28 = alloca %SchemeObject, align 8
  %116 = call ptr @llvm.stacksave()
  %117 = call %SchemeObject @LambdaFunction.2(ptr %number, ptr %number10, ptr %number19)
  store %SchemeObject %117, ptr %function_returned28, align 8
  call void @llvm.stackrestore(ptr %116)
  br label %merge_branch

modify_branch31:                                  ; preds = %false_branch
  br label %continue_branch32

continue_branch32:                                ; preds = %modify_branch31, %false_branch
  %118 = phi i64 [ 1, %modify_branch31 ], [ %29, %false_branch ]
  %119 = mul i64 %27, 100
  %120 = sdiv i64 %119, %118
  %121 = getelementptr %SchemeObject, ptr %number29, i32 0, i32 1
  store i64 %29, ptr %121, align 4
  %122 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %123 = load i64, ptr %122, align 4
  %124 = icmp eq i64 %123, 0
  call void @__GLAssert(i1 %124)
  %125 = getelementptr %SchemeObject, ptr %number29, i32 0, i32 1
  %126 = load i64, ptr %125, align 4
  %127 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 1
  %128 = load i64, ptr %127, align 4
  %is_zero_then_one_check36 = icmp ne i64 %128, 0
  br i1 %is_zero_then_one_check36, label %continue_branch35, label %modify_branch34

modify_branch34:                                  ; preds = %continue_branch32
  br label %continue_branch35

continue_branch35:                                ; preds = %modify_branch34, %continue_branch32
  %129 = phi i64 [ 1, %modify_branch34 ], [ %128, %continue_branch32 ]
  %130 = mul i64 %126, 100
  %131 = sdiv i64 %130, %129
  %132 = getelementptr %SchemeObject, ptr %number29, i32 0, i32 1
  store i64 %131, ptr %132, align 4
  %number37 = alloca %SchemeObject, align 8
  %133 = getelementptr %SchemeObject, ptr %number37, i32 0, i32 0
  store i64 0, ptr %133, align 4
  %134 = getelementptr %SchemeObject, ptr %number37, i32 0, i32 1
  store i64 100, ptr %134, align 4
  %function_returned38 = alloca %SchemeObject, align 8
  %135 = call ptr @llvm.stacksave()
  %136 = call %SchemeObject @LambdaFunction.4(ptr %variable)
  store %SchemeObject %136, ptr %function_returned38, align 8
  call void @llvm.stackrestore(ptr %135)
  %137 = getelementptr %SchemeObject, ptr %function_returned38, i32 0, i32 0
  %138 = load i64, ptr %137, align 4
  %139 = icmp eq i64 %138, 0
  call void @__GLAssert(i1 %139)
  %140 = getelementptr %SchemeObject, ptr %number37, i32 0, i32 1
  %141 = load i64, ptr %140, align 4
  %142 = getelementptr %SchemeObject, ptr %function_returned38, i32 0, i32 1
  %143 = load i64, ptr %142, align 4
  %is_zero_then_one_check41 = icmp ne i64 %143, 0
  br i1 %is_zero_then_one_check41, label %continue_branch40, label %modify_branch39

modify_branch39:                                  ; preds = %continue_branch35
  br label %continue_branch40

continue_branch40:                                ; preds = %modify_branch39, %continue_branch35
  %144 = phi i64 [ 1, %modify_branch39 ], [ %143, %continue_branch35 ]
  %145 = mul i64 %141, 100
  %146 = sdiv i64 %145, %144
  %147 = getelementptr %SchemeObject, ptr %number37, i32 0, i32 1
  store i64 %143, ptr %147, align 4
  %148 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %149 = load i64, ptr %148, align 4
  %150 = icmp eq i64 %149, 0
  call void @__GLAssert(i1 %150)
  %151 = getelementptr %SchemeObject, ptr %number37, i32 0, i32 1
  %152 = load i64, ptr %151, align 4
  %153 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 1
  %154 = load i64, ptr %153, align 4
  %is_zero_then_one_check44 = icmp ne i64 %154, 0
  br i1 %is_zero_then_one_check44, label %continue_branch43, label %modify_branch42

modify_branch42:                                  ; preds = %continue_branch40
  br label %continue_branch43

continue_branch43:                                ; preds = %modify_branch42, %continue_branch40
  %155 = phi i64 [ 1, %modify_branch42 ], [ %154, %continue_branch40 ]
  %156 = mul i64 %152, 100
  %157 = sdiv i64 %156, %155
  %158 = getelementptr %SchemeObject, ptr %number37, i32 0, i32 1
  store i64 %157, ptr %158, align 4
  %number45 = alloca %SchemeObject, align 8
  %159 = getelementptr %SchemeObject, ptr %number45, i32 0, i32 0
  store i64 0, ptr %159, align 4
  %160 = getelementptr %SchemeObject, ptr %number45, i32 0, i32 1
  store i64 100, ptr %160, align 4
  %function_returned46 = alloca %SchemeObject, align 8
  %161 = call ptr @llvm.stacksave()
  %162 = call %SchemeObject @LambdaFunction.5(ptr %variable)
  store %SchemeObject %162, ptr %function_returned46, align 8
  call void @llvm.stackrestore(ptr %161)
  %163 = getelementptr %SchemeObject, ptr %function_returned46, i32 0, i32 0
  %164 = load i64, ptr %163, align 4
  %165 = icmp eq i64 %164, 0
  call void @__GLAssert(i1 %165)
  %166 = getelementptr %SchemeObject, ptr %number45, i32 0, i32 1
  %167 = load i64, ptr %166, align 4
  %168 = getelementptr %SchemeObject, ptr %function_returned46, i32 0, i32 1
  %169 = load i64, ptr %168, align 4
  %is_zero_then_one_check49 = icmp ne i64 %169, 0
  br i1 %is_zero_then_one_check49, label %continue_branch48, label %modify_branch47

modify_branch47:                                  ; preds = %continue_branch43
  br label %continue_branch48

continue_branch48:                                ; preds = %modify_branch47, %continue_branch43
  %170 = phi i64 [ 1, %modify_branch47 ], [ %169, %continue_branch43 ]
  %171 = mul i64 %167, 100
  %172 = sdiv i64 %171, %170
  %173 = getelementptr %SchemeObject, ptr %number45, i32 0, i32 1
  store i64 %169, ptr %173, align 4
  %174 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 0
  %175 = load i64, ptr %174, align 4
  %176 = icmp eq i64 %175, 0
  call void @__GLAssert(i1 %176)
  %177 = getelementptr %SchemeObject, ptr %number45, i32 0, i32 1
  %178 = load i64, ptr %177, align 4
  %179 = getelementptr %SchemeObject, ptr %variable1, i32 0, i32 1
  %180 = load i64, ptr %179, align 4
  %is_zero_then_one_check52 = icmp ne i64 %180, 0
  br i1 %is_zero_then_one_check52, label %continue_branch51, label %modify_branch50

modify_branch50:                                  ; preds = %continue_branch48
  br label %continue_branch51

continue_branch51:                                ; preds = %modify_branch50, %continue_branch48
  %181 = phi i64 [ 1, %modify_branch50 ], [ %180, %continue_branch48 ]
  %182 = mul i64 %178, 100
  %183 = sdiv i64 %182, %181
  %184 = getelementptr %SchemeObject, ptr %number45, i32 0, i32 1
  store i64 %183, ptr %184, align 4
  %function_returned53 = alloca %SchemeObject, align 8
  %185 = call ptr @llvm.stacksave()
  %186 = call %SchemeObject @LambdaFunction.2(ptr %number29, ptr %number37, ptr %number45)
  store %SchemeObject %186, ptr %function_returned53, align 8
  call void @llvm.stackrestore(ptr %185)
  br label %merge_branch
}

define %SchemeObject @LambdaFunction.10(ptr %0, ptr %1) {
entry:
  %variable = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %0, i32 0
  %3 = load %SchemeObject, ptr %2, align 8
  store %SchemeObject %3, ptr %variable, align 8
  %variable1 = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %1, i32 0
  %5 = load %SchemeObject, ptr %4, align 8
  store %SchemeObject %5, ptr %variable1, align 8
  %function_returned = alloca %SchemeObject, align 8
  %6 = call ptr @llvm.stacksave()
  %7 = call %SchemeObject @LambdaFunction.8(ptr %variable, ptr %variable1)
  store %SchemeObject %7, ptr %function_returned, align 8
  call void @llvm.stackrestore(ptr %6)
  %function_returned2 = alloca %SchemeObject, align 8
  %8 = call ptr @llvm.stacksave()
  %9 = call %SchemeObject @LambdaFunction(ptr %function_returned)
  store %SchemeObject %9, ptr %function_returned2, align 8
  call void @llvm.stackrestore(ptr %8)
  %10 = getelementptr %SchemeObject, ptr %function_returned2, i32 0
  %11 = load %SchemeObject, ptr %10, align 8
  ret %SchemeObject %11
}

define %SchemeObject @LambdaFunction.11(ptr %0) {
entry:
  %variable = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0
  %2 = load %SchemeObject, ptr %1, align 8
  store %SchemeObject %2, ptr %variable, align 8
  %function_returned = alloca %SchemeObject, align 8
  %3 = call ptr @llvm.stacksave()
  %4 = call %SchemeObject @LambdaFunction.10(ptr %variable, ptr %variable)
  store %SchemeObject %4, ptr %function_returned, align 8
  call void @llvm.stackrestore(ptr %3)
  %sqrt = alloca %SchemeObject, align 8
  %5 = call %SchemeObject @__GLSqrt(ptr %function_returned)
  store %SchemeObject %5, ptr %sqrt, align 8
  %6 = getelementptr %SchemeObject, ptr %sqrt, i32 0
  %7 = load %SchemeObject, ptr %6, align 8
  ret %SchemeObject %7
}

define %SchemeObject @LambdaFunction.12(ptr %0) {
entry:
  %variable = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0
  %2 = load %SchemeObject, ptr %1, align 8
  store %SchemeObject %2, ptr %variable, align 8
  %function_returned = alloca %SchemeObject, align 8
  %3 = call ptr @llvm.stacksave()
  %4 = call %SchemeObject @LambdaFunction.11(ptr %variable)
  store %SchemeObject %4, ptr %function_returned, align 8
  call void @llvm.stackrestore(ptr %3)
  %function_returned1 = alloca %SchemeObject, align 8
  %5 = call ptr @llvm.stacksave()
  %6 = call %SchemeObject @LambdaFunction.9(ptr %variable, ptr %function_returned)
  store %SchemeObject %6, ptr %function_returned1, align 8
  call void @llvm.stackrestore(ptr %5)
  %7 = getelementptr %SchemeObject, ptr %function_returned1, i32 0
  %8 = load %SchemeObject, ptr %7, align 8
  ret %SchemeObject %8
}

define %SchemeObject @LambdaFunction.13(ptr %0, ptr %1) {
entry:
  %variable = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %0, i32 0
  %3 = load %SchemeObject, ptr %2, align 8
  store %SchemeObject %3, ptr %variable, align 8
  %variable1 = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %1, i32 0
  %5 = load %SchemeObject, ptr %4, align 8
  store %SchemeObject %5, ptr %variable1, align 8
  %6 = alloca %SchemeObject, align 8
  %7 = getelementptr %SchemeObject, ptr %6, i32 0, i32 0
  store i64 3, ptr %7, align 4
  %8 = getelementptr %SchemeObject, ptr %6, i32 0, i32 4
  store ptr null, ptr %8, align 8
  %9 = getelementptr %SchemeObject, ptr %6, i32 0, i32 5
  store ptr null, ptr %9, align 8
  %10 = getelementptr %SchemeObject, ptr %6, i32 0, i32 4
  store ptr %variable, ptr %10, align 8
  %11 = alloca %SchemeObject, align 8
  %12 = getelementptr %SchemeObject, ptr %11, i32 0, i32 0
  store i64 3, ptr %12, align 4
  %13 = getelementptr %SchemeObject, ptr %11, i32 0, i32 4
  store ptr null, ptr %13, align 8
  %14 = getelementptr %SchemeObject, ptr %11, i32 0, i32 5
  store ptr null, ptr %14, align 8
  %15 = getelementptr %SchemeObject, ptr %6, i32 0, i32 5
  store ptr %11, ptr %15, align 8
  %16 = getelementptr %SchemeObject, ptr %11, i32 0, i32 4
  store ptr %variable1, ptr %16, align 8
  %17 = alloca %SchemeObject, align 8
  %18 = getelementptr %SchemeObject, ptr %17, i32 0, i32 0
  store i64 3, ptr %18, align 4
  %19 = getelementptr %SchemeObject, ptr %17, i32 0, i32 4
  store ptr null, ptr %19, align 8
  %20 = getelementptr %SchemeObject, ptr %17, i32 0, i32 5
  store ptr null, ptr %20, align 8
  %21 = getelementptr %SchemeObject, ptr %11, i32 0, i32 5
  store ptr %17, ptr %21, align 8
  %22 = getelementptr %SchemeObject, ptr %11, i32 0, i32 5
  store ptr null, ptr %22, align 8
  %23 = getelementptr %SchemeObject, ptr %6, i32 0
  %24 = load %SchemeObject, ptr %23, align 8
  ret %SchemeObject %24
}

define %SchemeObject @LambdaFunction.14(ptr %0) {
entry:
  %variable = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0
  %2 = load %SchemeObject, ptr %1, align 8
  store %SchemeObject %2, ptr %variable, align 8
  %3 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %4 = load i64, ptr %3, align 4
  %is_type_check = icmp eq i64 %4, 3
  br i1 %is_type_check, label %true_branch, label %false_branch

true_branch:                                      ; preds = %entry
  %5 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 4
  %6 = load ptr, ptr %5, align 8
  br label %merge_branch

false_branch:                                     ; preds = %entry
  %7 = phi ptr [ %variable, %entry ]
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %8 = phi ptr [ %6, %true_branch ], [ %7, %false_branch ]
  %9 = getelementptr %SchemeObject, ptr %8, i32 0
  %10 = load %SchemeObject, ptr %9, align 8
  ret %SchemeObject %10
}

define %SchemeObject @LambdaFunction.15(ptr %0) {
entry:
  %variable = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0
  %2 = load %SchemeObject, ptr %1, align 8
  store %SchemeObject %2, ptr %variable, align 8
  %3 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %4 = load i64, ptr %3, align 4
  %is_type_check = icmp eq i64 %4, 3
  br i1 %is_type_check, label %true_branch1, label %false_branch2

true_branch:                                      ; preds = %merge_branch3
  %5 = getelementptr %SchemeObject, ptr %17, i32 0, i32 4
  %6 = load ptr, ptr %5, align 8
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch3
  %7 = phi ptr [ %17, %merge_branch3 ]
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %8 = phi ptr [ %6, %true_branch ], [ %7, %false_branch ]
  %9 = getelementptr %SchemeObject, ptr %8, i32 0
  %10 = load %SchemeObject, ptr %9, align 8
  ret %SchemeObject %10

true_branch1:                                     ; preds = %entry
  %11 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %12 = load ptr, ptr %11, align 8
  br label %merge_branch3

false_branch2:                                    ; preds = %entry
  %13 = alloca %SchemeObject, align 8
  %14 = getelementptr %SchemeObject, ptr %13, i32 0, i32 0
  store i64 3, ptr %14, align 4
  %15 = getelementptr %SchemeObject, ptr %13, i32 0, i32 4
  store ptr null, ptr %15, align 8
  %16 = getelementptr %SchemeObject, ptr %13, i32 0, i32 5
  store ptr null, ptr %16, align 8
  br label %merge_branch3

merge_branch3:                                    ; preds = %false_branch2, %true_branch1
  %17 = phi ptr [ %12, %true_branch1 ], [ %13, %false_branch2 ]
  %18 = getelementptr %SchemeObject, ptr %17, i32 0, i32 0
  %19 = load i64, ptr %18, align 4
  %is_type_check4 = icmp eq i64 %19, 3
  br i1 %is_type_check4, label %true_branch, label %false_branch
}

define %SchemeObject @LambdaFunction.16(ptr %0, ptr %1) {
entry:
  %variable = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %0, i32 0
  %3 = load %SchemeObject, ptr %2, align 8
  store %SchemeObject %3, ptr %variable, align 8
  %variable1 = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %1, i32 0
  %5 = load %SchemeObject, ptr %4, align 8
  store %SchemeObject %5, ptr %variable1, align 8
  %function_returned = alloca %SchemeObject, align 8
  %6 = call ptr @llvm.stacksave()
  %7 = call %SchemeObject @LambdaFunction.14(ptr %variable)
  store %SchemeObject %7, ptr %function_returned, align 8
  call void @llvm.stackrestore(ptr %6)
  %function_returned2 = alloca %SchemeObject, align 8
  %8 = call ptr @llvm.stacksave()
  %9 = call %SchemeObject @LambdaFunction.15(ptr %variable)
  store %SchemeObject %9, ptr %function_returned2, align 8
  call void @llvm.stackrestore(ptr %8)
  %function_returned3 = alloca %SchemeObject, align 8
  %10 = call ptr @llvm.stacksave()
  %11 = call %SchemeObject @LambdaFunction.8(ptr %function_returned2, ptr %variable1)
  store %SchemeObject %11, ptr %function_returned3, align 8
  call void @llvm.stackrestore(ptr %10)
  %function_returned4 = alloca %SchemeObject, align 8
  %12 = call ptr @llvm.stacksave()
  %13 = call %SchemeObject @LambdaFunction.6(ptr %function_returned, ptr %function_returned3)
  store %SchemeObject %13, ptr %function_returned4, align 8
  call void @llvm.stackrestore(ptr %12)
  %14 = getelementptr %SchemeObject, ptr %function_returned4, i32 0
  %15 = load %SchemeObject, ptr %14, align 8
  ret %SchemeObject %15
}

define %SchemeObject @LambdaFunction.17(ptr %0, ptr %1, ptr %2, ptr %3) {
entry:
  %variable = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %0, i32 0
  %5 = load %SchemeObject, ptr %4, align 8
  store %SchemeObject %5, ptr %variable, align 8
  %variable1 = alloca %SchemeObject, align 8
  %6 = getelementptr %SchemeObject, ptr %1, i32 0
  %7 = load %SchemeObject, ptr %6, align 8
  store %SchemeObject %7, ptr %variable1, align 8
  %variable2 = alloca %SchemeObject, align 8
  %8 = getelementptr %SchemeObject, ptr %2, i32 0
  %9 = load %SchemeObject, ptr %8, align 8
  store %SchemeObject %9, ptr %variable2, align 8
  %variable3 = alloca %SchemeObject, align 8
  %10 = getelementptr %SchemeObject, ptr %3, i32 0
  %11 = load %SchemeObject, ptr %10, align 8
  store %SchemeObject %11, ptr %variable3, align 8
  %12 = alloca %SchemeObject, align 8
  %13 = getelementptr %SchemeObject, ptr %12, i32 0, i32 0
  store i64 3, ptr %13, align 4
  %14 = getelementptr %SchemeObject, ptr %12, i32 0, i32 4
  store ptr null, ptr %14, align 8
  %15 = getelementptr %SchemeObject, ptr %12, i32 0, i32 5
  store ptr null, ptr %15, align 8
  %16 = getelementptr %SchemeObject, ptr %12, i32 0, i32 4
  store ptr %variable, ptr %16, align 8
  %17 = alloca %SchemeObject, align 8
  %18 = getelementptr %SchemeObject, ptr %17, i32 0, i32 0
  store i64 3, ptr %18, align 4
  %19 = getelementptr %SchemeObject, ptr %17, i32 0, i32 4
  store ptr null, ptr %19, align 8
  %20 = getelementptr %SchemeObject, ptr %17, i32 0, i32 5
  store ptr null, ptr %20, align 8
  %21 = getelementptr %SchemeObject, ptr %12, i32 0, i32 5
  store ptr %17, ptr %21, align 8
  %22 = getelementptr %SchemeObject, ptr %17, i32 0, i32 4
  store ptr %variable1, ptr %22, align 8
  %23 = alloca %SchemeObject, align 8
  %24 = getelementptr %SchemeObject, ptr %23, i32 0, i32 0
  store i64 3, ptr %24, align 4
  %25 = getelementptr %SchemeObject, ptr %23, i32 0, i32 4
  store ptr null, ptr %25, align 8
  %26 = getelementptr %SchemeObject, ptr %23, i32 0, i32 5
  store ptr null, ptr %26, align 8
  %27 = getelementptr %SchemeObject, ptr %17, i32 0, i32 5
  store ptr %23, ptr %27, align 8
  %28 = getelementptr %SchemeObject, ptr %23, i32 0, i32 4
  store ptr %variable2, ptr %28, align 8
  %29 = alloca %SchemeObject, align 8
  %30 = getelementptr %SchemeObject, ptr %29, i32 0, i32 0
  store i64 3, ptr %30, align 4
  %31 = getelementptr %SchemeObject, ptr %29, i32 0, i32 4
  store ptr null, ptr %31, align 8
  %32 = getelementptr %SchemeObject, ptr %29, i32 0, i32 5
  store ptr null, ptr %32, align 8
  %33 = getelementptr %SchemeObject, ptr %23, i32 0, i32 5
  store ptr %29, ptr %33, align 8
  %34 = getelementptr %SchemeObject, ptr %29, i32 0, i32 4
  store ptr %variable3, ptr %34, align 8
  %35 = alloca %SchemeObject, align 8
  %36 = getelementptr %SchemeObject, ptr %35, i32 0, i32 0
  store i64 3, ptr %36, align 4
  %37 = getelementptr %SchemeObject, ptr %35, i32 0, i32 4
  store ptr null, ptr %37, align 8
  %38 = getelementptr %SchemeObject, ptr %35, i32 0, i32 5
  store ptr null, ptr %38, align 8
  %39 = getelementptr %SchemeObject, ptr %29, i32 0, i32 5
  store ptr %35, ptr %39, align 8
  %40 = getelementptr %SchemeObject, ptr %29, i32 0, i32 5
  store ptr null, ptr %40, align 8
  %41 = getelementptr %SchemeObject, ptr %12, i32 0
  %42 = load %SchemeObject, ptr %41, align 8
  ret %SchemeObject %42
}

define %SchemeObject @LambdaFunction.18(ptr %0) {
entry:
  %variable = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0
  %2 = load %SchemeObject, ptr %1, align 8
  store %SchemeObject %2, ptr %variable, align 8
  %3 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %4 = load i64, ptr %3, align 4
  %is_type_check = icmp eq i64 %4, 3
  br i1 %is_type_check, label %true_branch, label %false_branch

true_branch:                                      ; preds = %entry
  %5 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 4
  %6 = load ptr, ptr %5, align 8
  br label %merge_branch

false_branch:                                     ; preds = %entry
  %7 = phi ptr [ %variable, %entry ]
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %8 = phi ptr [ %6, %true_branch ], [ %7, %false_branch ]
  %9 = getelementptr %SchemeObject, ptr %8, i32 0
  %10 = load %SchemeObject, ptr %9, align 8
  ret %SchemeObject %10
}

define %SchemeObject @LambdaFunction.19(ptr %0) {
entry:
  %variable = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0
  %2 = load %SchemeObject, ptr %1, align 8
  store %SchemeObject %2, ptr %variable, align 8
  %3 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %4 = load i64, ptr %3, align 4
  %is_type_check = icmp eq i64 %4, 3
  br i1 %is_type_check, label %true_branch1, label %false_branch2

true_branch:                                      ; preds = %merge_branch3
  %5 = getelementptr %SchemeObject, ptr %17, i32 0, i32 4
  %6 = load ptr, ptr %5, align 8
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch3
  %7 = phi ptr [ %17, %merge_branch3 ]
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %8 = phi ptr [ %6, %true_branch ], [ %7, %false_branch ]
  %9 = getelementptr %SchemeObject, ptr %8, i32 0
  %10 = load %SchemeObject, ptr %9, align 8
  ret %SchemeObject %10

true_branch1:                                     ; preds = %entry
  %11 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %12 = load ptr, ptr %11, align 8
  br label %merge_branch3

false_branch2:                                    ; preds = %entry
  %13 = alloca %SchemeObject, align 8
  %14 = getelementptr %SchemeObject, ptr %13, i32 0, i32 0
  store i64 3, ptr %14, align 4
  %15 = getelementptr %SchemeObject, ptr %13, i32 0, i32 4
  store ptr null, ptr %15, align 8
  %16 = getelementptr %SchemeObject, ptr %13, i32 0, i32 5
  store ptr null, ptr %16, align 8
  br label %merge_branch3

merge_branch3:                                    ; preds = %false_branch2, %true_branch1
  %17 = phi ptr [ %12, %true_branch1 ], [ %13, %false_branch2 ]
  %18 = getelementptr %SchemeObject, ptr %17, i32 0, i32 0
  %19 = load i64, ptr %18, align 4
  %is_type_check4 = icmp eq i64 %19, 3
  br i1 %is_type_check4, label %true_branch, label %false_branch
}

define %SchemeObject @LambdaFunction.20(ptr %0) {
entry:
  %variable = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0
  %2 = load %SchemeObject, ptr %1, align 8
  store %SchemeObject %2, ptr %variable, align 8
  %3 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %4 = load i64, ptr %3, align 4
  %is_type_check = icmp eq i64 %4, 3
  br i1 %is_type_check, label %true_branch4, label %false_branch5

true_branch:                                      ; preds = %merge_branch3
  %5 = getelementptr %SchemeObject, ptr %17, i32 0, i32 4
  %6 = load ptr, ptr %5, align 8
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch3
  %7 = phi ptr [ %17, %merge_branch3 ]
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %8 = phi ptr [ %6, %true_branch ], [ %7, %false_branch ]
  %9 = getelementptr %SchemeObject, ptr %8, i32 0
  %10 = load %SchemeObject, ptr %9, align 8
  ret %SchemeObject %10

true_branch1:                                     ; preds = %merge_branch6
  %11 = getelementptr %SchemeObject, ptr %26, i32 0, i32 5
  %12 = load ptr, ptr %11, align 8
  br label %merge_branch3

false_branch2:                                    ; preds = %merge_branch6
  %13 = alloca %SchemeObject, align 8
  %14 = getelementptr %SchemeObject, ptr %13, i32 0, i32 0
  store i64 3, ptr %14, align 4
  %15 = getelementptr %SchemeObject, ptr %13, i32 0, i32 4
  store ptr null, ptr %15, align 8
  %16 = getelementptr %SchemeObject, ptr %13, i32 0, i32 5
  store ptr null, ptr %16, align 8
  br label %merge_branch3

merge_branch3:                                    ; preds = %false_branch2, %true_branch1
  %17 = phi ptr [ %12, %true_branch1 ], [ %13, %false_branch2 ]
  %18 = getelementptr %SchemeObject, ptr %17, i32 0, i32 0
  %19 = load i64, ptr %18, align 4
  %is_type_check8 = icmp eq i64 %19, 3
  br i1 %is_type_check8, label %true_branch, label %false_branch

true_branch4:                                     ; preds = %entry
  %20 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %21 = load ptr, ptr %20, align 8
  br label %merge_branch6

false_branch5:                                    ; preds = %entry
  %22 = alloca %SchemeObject, align 8
  %23 = getelementptr %SchemeObject, ptr %22, i32 0, i32 0
  store i64 3, ptr %23, align 4
  %24 = getelementptr %SchemeObject, ptr %22, i32 0, i32 4
  store ptr null, ptr %24, align 8
  %25 = getelementptr %SchemeObject, ptr %22, i32 0, i32 5
  store ptr null, ptr %25, align 8
  br label %merge_branch6

merge_branch6:                                    ; preds = %false_branch5, %true_branch4
  %26 = phi ptr [ %21, %true_branch4 ], [ %22, %false_branch5 ]
  %27 = getelementptr %SchemeObject, ptr %26, i32 0, i32 0
  %28 = load i64, ptr %27, align 4
  %is_type_check7 = icmp eq i64 %28, 3
  br i1 %is_type_check7, label %true_branch1, label %false_branch2
}

define %SchemeObject @LambdaFunction.21(ptr %0) {
entry:
  %variable = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0
  %2 = load %SchemeObject, ptr %1, align 8
  store %SchemeObject %2, ptr %variable, align 8
  %3 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %4 = load i64, ptr %3, align 4
  %is_type_check = icmp eq i64 %4, 3
  br i1 %is_type_check, label %true_branch7, label %false_branch8

true_branch:                                      ; preds = %merge_branch3
  %5 = getelementptr %SchemeObject, ptr %17, i32 0, i32 4
  %6 = load ptr, ptr %5, align 8
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch3
  %7 = phi ptr [ %17, %merge_branch3 ]
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %8 = phi ptr [ %6, %true_branch ], [ %7, %false_branch ]
  %9 = getelementptr %SchemeObject, ptr %8, i32 0
  %10 = load %SchemeObject, ptr %9, align 8
  ret %SchemeObject %10

true_branch1:                                     ; preds = %merge_branch6
  %11 = getelementptr %SchemeObject, ptr %26, i32 0, i32 5
  %12 = load ptr, ptr %11, align 8
  br label %merge_branch3

false_branch2:                                    ; preds = %merge_branch6
  %13 = alloca %SchemeObject, align 8
  %14 = getelementptr %SchemeObject, ptr %13, i32 0, i32 0
  store i64 3, ptr %14, align 4
  %15 = getelementptr %SchemeObject, ptr %13, i32 0, i32 4
  store ptr null, ptr %15, align 8
  %16 = getelementptr %SchemeObject, ptr %13, i32 0, i32 5
  store ptr null, ptr %16, align 8
  br label %merge_branch3

merge_branch3:                                    ; preds = %false_branch2, %true_branch1
  %17 = phi ptr [ %12, %true_branch1 ], [ %13, %false_branch2 ]
  %18 = getelementptr %SchemeObject, ptr %17, i32 0, i32 0
  %19 = load i64, ptr %18, align 4
  %is_type_check12 = icmp eq i64 %19, 3
  br i1 %is_type_check12, label %true_branch, label %false_branch

true_branch4:                                     ; preds = %merge_branch9
  %20 = getelementptr %SchemeObject, ptr %35, i32 0, i32 5
  %21 = load ptr, ptr %20, align 8
  br label %merge_branch6

false_branch5:                                    ; preds = %merge_branch9
  %22 = alloca %SchemeObject, align 8
  %23 = getelementptr %SchemeObject, ptr %22, i32 0, i32 0
  store i64 3, ptr %23, align 4
  %24 = getelementptr %SchemeObject, ptr %22, i32 0, i32 4
  store ptr null, ptr %24, align 8
  %25 = getelementptr %SchemeObject, ptr %22, i32 0, i32 5
  store ptr null, ptr %25, align 8
  br label %merge_branch6

merge_branch6:                                    ; preds = %false_branch5, %true_branch4
  %26 = phi ptr [ %21, %true_branch4 ], [ %22, %false_branch5 ]
  %27 = getelementptr %SchemeObject, ptr %26, i32 0, i32 0
  %28 = load i64, ptr %27, align 4
  %is_type_check11 = icmp eq i64 %28, 3
  br i1 %is_type_check11, label %true_branch1, label %false_branch2

true_branch7:                                     ; preds = %entry
  %29 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %30 = load ptr, ptr %29, align 8
  br label %merge_branch9

false_branch8:                                    ; preds = %entry
  %31 = alloca %SchemeObject, align 8
  %32 = getelementptr %SchemeObject, ptr %31, i32 0, i32 0
  store i64 3, ptr %32, align 4
  %33 = getelementptr %SchemeObject, ptr %31, i32 0, i32 4
  store ptr null, ptr %33, align 8
  %34 = getelementptr %SchemeObject, ptr %31, i32 0, i32 5
  store ptr null, ptr %34, align 8
  br label %merge_branch9

merge_branch9:                                    ; preds = %false_branch8, %true_branch7
  %35 = phi ptr [ %30, %true_branch7 ], [ %31, %false_branch8 ]
  %36 = getelementptr %SchemeObject, ptr %35, i32 0, i32 0
  %37 = load i64, ptr %36, align 4
  %is_type_check10 = icmp eq i64 %37, 3
  br i1 %is_type_check10, label %true_branch4, label %false_branch5
}

define %SchemeObject @LambdaFunction.22(ptr %0, ptr %1) {
entry:
  %variable = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %0, i32 0
  %3 = load %SchemeObject, ptr %2, align 8
  store %SchemeObject %3, ptr %variable, align 8
  %variable1 = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %1, i32 0
  %5 = load %SchemeObject, ptr %4, align 8
  store %SchemeObject %5, ptr %variable1, align 8
  %function_returned = alloca %SchemeObject, align 8
  %6 = call ptr @llvm.stacksave()
  %7 = call %SchemeObject @LambdaFunction.18(ptr %variable)
  store %SchemeObject %7, ptr %function_returned, align 8
  call void @llvm.stackrestore(ptr %6)
  %function_returned2 = alloca %SchemeObject, align 8
  %8 = call ptr @llvm.stacksave()
  %9 = call %SchemeObject @LambdaFunction.14(ptr %variable1)
  store %SchemeObject %9, ptr %function_returned2, align 8
  call void @llvm.stackrestore(ptr %8)
  %function_returned3 = alloca %SchemeObject, align 8
  %10 = call ptr @llvm.stacksave()
  %11 = call %SchemeObject @LambdaFunction.7(ptr %function_returned, ptr %function_returned2)
  store %SchemeObject %11, ptr %function_returned3, align 8
  call void @llvm.stackrestore(ptr %10)
  %variable4 = alloca %SchemeObject, align 8
  %12 = getelementptr %SchemeObject, ptr %function_returned3, i32 0
  %13 = load %SchemeObject, ptr %12, align 8
  store %SchemeObject %13, ptr %variable4, align 8
  %function_returned5 = alloca %SchemeObject, align 8
  %14 = call ptr @llvm.stacksave()
  %15 = call %SchemeObject @LambdaFunction.15(ptr %variable1)
  store %SchemeObject %15, ptr %function_returned5, align 8
  call void @llvm.stackrestore(ptr %14)
  %function_returned6 = alloca %SchemeObject, align 8
  %16 = call ptr @llvm.stacksave()
  %17 = call %SchemeObject @LambdaFunction.10(ptr %variable4, ptr %function_returned5)
  store %SchemeObject %17, ptr %function_returned6, align 8
  call void @llvm.stackrestore(ptr %16)
  %variable7 = alloca %SchemeObject, align 8
  %18 = getelementptr %SchemeObject, ptr %function_returned6, i32 0
  %19 = load %SchemeObject, ptr %18, align 8
  store %SchemeObject %19, ptr %variable7, align 8
  %number = alloca %SchemeObject, align 8
  %20 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %20, align 4
  %21 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 0, ptr %21, align 4
  %function_returned8 = alloca %SchemeObject, align 8
  %22 = call ptr @llvm.stacksave()
  %23 = call %SchemeObject @LambdaFunction.19(ptr %variable)
  store %SchemeObject %23, ptr %function_returned8, align 8
  call void @llvm.stackrestore(ptr %22)
  %number9 = alloca %SchemeObject, align 8
  %24 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 0
  store i64 0, ptr %24, align 4
  %25 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 1
  store i64 200, ptr %25, align 4
  %expt = alloca %SchemeObject, align 8
  %26 = call %SchemeObject @__GLExpt(ptr %function_returned8, ptr %number9)
  store %SchemeObject %26, ptr %expt, align 8
  %27 = getelementptr %SchemeObject, ptr %expt, i32 0, i32 0
  %28 = load i64, ptr %27, align 4
  %29 = icmp eq i64 %28, 0
  call void @__GLAssert(i1 %29)
  %30 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %31 = load i64, ptr %30, align 4
  %32 = getelementptr %SchemeObject, ptr %expt, i32 0, i32 1
  %33 = load i64, ptr %32, align 4
  %34 = sub i64 %31, %33
  %35 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 %33, ptr %35, align 4
  %number10 = alloca %SchemeObject, align 8
  %36 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 0
  store i64 0, ptr %36, align 4
  %37 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 0, ptr %37, align 4
  %function_returned11 = alloca %SchemeObject, align 8
  %38 = call ptr @llvm.stacksave()
  %39 = call %SchemeObject @LambdaFunction.10(ptr %variable4, ptr %variable4)
  store %SchemeObject %39, ptr %function_returned11, align 8
  call void @llvm.stackrestore(ptr %38)
  %40 = getelementptr %SchemeObject, ptr %function_returned11, i32 0, i32 0
  %41 = load i64, ptr %40, align 4
  %42 = icmp eq i64 %41, 0
  call void @__GLAssert(i1 %42)
  %43 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  %44 = load i64, ptr %43, align 4
  %45 = getelementptr %SchemeObject, ptr %function_returned11, i32 0, i32 1
  %46 = load i64, ptr %45, align 4
  %47 = sub i64 %44, %46
  %48 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 %46, ptr %48, align 4
  %number12 = alloca %SchemeObject, align 8
  %49 = getelementptr %SchemeObject, ptr %number12, i32 0, i32 0
  store i64 0, ptr %49, align 4
  %50 = getelementptr %SchemeObject, ptr %number12, i32 0, i32 1
  store i64 100, ptr %50, align 4
  %51 = getelementptr %SchemeObject, ptr %variable7, i32 0, i32 0
  %52 = load i64, ptr %51, align 4
  %53 = icmp eq i64 %52, 0
  call void @__GLAssert(i1 %53)
  %54 = getelementptr %SchemeObject, ptr %number12, i32 0, i32 1
  %55 = load i64, ptr %54, align 4
  %56 = getelementptr %SchemeObject, ptr %variable7, i32 0, i32 1
  %57 = load i64, ptr %56, align 4
  %58 = mul i64 %55, %57
  %59 = sdiv i64 %58, 100
  %60 = getelementptr %SchemeObject, ptr %number12, i32 0, i32 1
  store i64 %59, ptr %60, align 4
  %61 = getelementptr %SchemeObject, ptr %variable7, i32 0, i32 0
  %62 = load i64, ptr %61, align 4
  %63 = icmp eq i64 %62, 0
  call void @__GLAssert(i1 %63)
  %64 = getelementptr %SchemeObject, ptr %number12, i32 0, i32 1
  %65 = load i64, ptr %64, align 4
  %66 = getelementptr %SchemeObject, ptr %variable7, i32 0, i32 1
  %67 = load i64, ptr %66, align 4
  %68 = mul i64 %65, %67
  %69 = sdiv i64 %68, 100
  %70 = getelementptr %SchemeObject, ptr %number12, i32 0, i32 1
  store i64 %69, ptr %70, align 4
  %71 = getelementptr %SchemeObject, ptr %number12, i32 0, i32 0
  %72 = load i64, ptr %71, align 4
  %73 = icmp eq i64 %72, 0
  call void @__GLAssert(i1 %73)
  %74 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  %75 = load i64, ptr %74, align 4
  %76 = getelementptr %SchemeObject, ptr %number12, i32 0, i32 1
  %77 = load i64, ptr %76, align 4
  %78 = sub i64 %75, %77
  %79 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 %78, ptr %79, align 4
  %80 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 0
  %81 = load i64, ptr %80, align 4
  %82 = icmp eq i64 %81, 0
  call void @__GLAssert(i1 %82)
  %83 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %84 = load i64, ptr %83, align 4
  %85 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  %86 = load i64, ptr %85, align 4
  %87 = sub i64 %84, %86
  %88 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 %87, ptr %88, align 4
  %variable13 = alloca %SchemeObject, align 8
  %89 = getelementptr %SchemeObject, ptr %number, i32 0
  %90 = load %SchemeObject, ptr %89, align 8
  store %SchemeObject %90, ptr %variable13, align 8
  br label %comparison_branch

true_branch:                                      ; preds = %merge_branch16
  %number19 = alloca %SchemeObject, align 8
  %91 = getelementptr %SchemeObject, ptr %number19, i32 0, i32 0
  store i64 0, ptr %91, align 4
  %92 = getelementptr %SchemeObject, ptr %number19, i32 0, i32 1
  store i64 -100, ptr %92, align 4
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch16
  %number20 = alloca %SchemeObject, align 8
  %93 = getelementptr %SchemeObject, ptr %number20, i32 0, i32 0
  store i64 0, ptr %93, align 4
  %94 = getelementptr %SchemeObject, ptr %number20, i32 0, i32 1
  store i64 0, ptr %94, align 4
  %95 = getelementptr %SchemeObject, ptr %variable7, i32 0, i32 0
  %96 = load i64, ptr %95, align 4
  %97 = icmp eq i64 %96, 0
  call void @__GLAssert(i1 %97)
  %98 = getelementptr %SchemeObject, ptr %number20, i32 0, i32 1
  %99 = load i64, ptr %98, align 4
  %100 = getelementptr %SchemeObject, ptr %variable7, i32 0, i32 1
  %101 = load i64, ptr %100, align 4
  %102 = sub i64 %99, %101
  %103 = getelementptr %SchemeObject, ptr %number20, i32 0, i32 1
  store i64 %101, ptr %103, align 4
  %sqrt = alloca %SchemeObject, align 8
  %104 = call %SchemeObject @__GLSqrt(ptr %variable13)
  store %SchemeObject %104, ptr %sqrt, align 8
  %105 = getelementptr %SchemeObject, ptr %sqrt, i32 0, i32 0
  %106 = load i64, ptr %105, align 4
  %107 = icmp eq i64 %106, 0
  call void @__GLAssert(i1 %107)
  %108 = getelementptr %SchemeObject, ptr %number20, i32 0, i32 1
  %109 = load i64, ptr %108, align 4
  %110 = getelementptr %SchemeObject, ptr %sqrt, i32 0, i32 1
  %111 = load i64, ptr %110, align 4
  %112 = sub i64 %109, %111
  %113 = getelementptr %SchemeObject, ptr %number20, i32 0, i32 1
  store i64 %112, ptr %113, align 4
  %variable21 = alloca %SchemeObject, align 8
  %114 = getelementptr %SchemeObject, ptr %number20, i32 0
  %115 = load %SchemeObject, ptr %114, align 8
  store %SchemeObject %115, ptr %variable21, align 8
  br label %comparison_branch24

merge_branch:                                     ; preds = %merge_branch23, %true_branch
  %116 = phi ptr [ %number19, %true_branch ], [ %variable33, %merge_branch23 ]
  %117 = getelementptr %SchemeObject, ptr %116, i32 0
  %118 = load %SchemeObject, ptr %117, align 8
  ret %SchemeObject %118

comparison_branch:                                ; preds = %entry
  %119 = getelementptr %SchemeObject, ptr %variable13, i32 0, i32 0
  %120 = load i64, ptr %119, align 4
  %121 = icmp eq i64 %120, 0
  call void @__GLAssert(i1 %121)
  %number17 = alloca %SchemeObject, align 8
  %122 = getelementptr %SchemeObject, ptr %number17, i32 0, i32 0
  store i64 0, ptr %122, align 4
  %123 = getelementptr %SchemeObject, ptr %number17, i32 0, i32 1
  store i64 0, ptr %123, align 4
  %124 = getelementptr %SchemeObject, ptr %number17, i32 0, i32 0
  %125 = load i64, ptr %124, align 4
  %126 = icmp eq i64 %125, 0
  call void @__GLAssert(i1 %126)
  %127 = getelementptr %SchemeObject, ptr %variable13, i32 0, i32 1
  %128 = load i64, ptr %127, align 4
  %129 = getelementptr %SchemeObject, ptr %number17, i32 0, i32 1
  %130 = load i64, ptr %129, align 4
  %131 = icmp sge i64 %128, %130
  br i1 %131, label %false_branch15, label %true_branch14

true_branch14:                                    ; preds = %comparison_branch
  %boolean = alloca %SchemeObject, align 8
  %132 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %132, align 4
  %133 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %133, align 1
  br label %merge_branch16

false_branch15:                                   ; preds = %comparison_branch
  %boolean18 = alloca %SchemeObject, align 8
  %134 = getelementptr %SchemeObject, ptr %boolean18, i32 0, i32 0
  store i64 1, ptr %134, align 4
  %135 = getelementptr %SchemeObject, ptr %boolean18, i32 0, i32 2
  store i1 false, ptr %135, align 1
  br label %merge_branch16

merge_branch16:                                   ; preds = %false_branch15, %true_branch14
  %136 = phi ptr [ %boolean, %true_branch14 ], [ %boolean18, %false_branch15 ]
  %137 = getelementptr %SchemeObject, ptr %136, i32 0, i32 0
  %138 = load i64, ptr %137, align 4
  %139 = icmp eq i64 %138, 1
  call void @__GLAssert(i1 %139)
  %140 = getelementptr %SchemeObject, ptr %136, i32 0, i32 2
  %141 = load i1, ptr %140, align 1
  br i1 %141, label %true_branch, label %false_branch

true_branch22:                                    ; preds = %merge_branch27
  %number31 = alloca %SchemeObject, align 8
  %142 = getelementptr %SchemeObject, ptr %number31, i32 0, i32 0
  store i64 0, ptr %142, align 4
  %143 = getelementptr %SchemeObject, ptr %number31, i32 0, i32 1
  store i64 0, ptr %143, align 4
  %144 = getelementptr %SchemeObject, ptr %variable7, i32 0, i32 0
  %145 = load i64, ptr %144, align 4
  %146 = icmp eq i64 %145, 0
  call void @__GLAssert(i1 %146)
  %147 = getelementptr %SchemeObject, ptr %number31, i32 0, i32 1
  %148 = load i64, ptr %147, align 4
  %149 = getelementptr %SchemeObject, ptr %variable7, i32 0, i32 1
  %150 = load i64, ptr %149, align 4
  %151 = add i64 %148, %150
  %152 = getelementptr %SchemeObject, ptr %number31, i32 0, i32 1
  store i64 %151, ptr %152, align 4
  %sqrt32 = alloca %SchemeObject, align 8
  %153 = call %SchemeObject @__GLSqrt(ptr %variable13)
  store %SchemeObject %153, ptr %sqrt32, align 8
  %154 = getelementptr %SchemeObject, ptr %sqrt32, i32 0, i32 0
  %155 = load i64, ptr %154, align 4
  %156 = icmp eq i64 %155, 0
  call void @__GLAssert(i1 %156)
  %157 = getelementptr %SchemeObject, ptr %number31, i32 0, i32 1
  %158 = load i64, ptr %157, align 4
  %159 = getelementptr %SchemeObject, ptr %sqrt32, i32 0, i32 1
  %160 = load i64, ptr %159, align 4
  %161 = add i64 %158, %160
  %162 = getelementptr %SchemeObject, ptr %number31, i32 0, i32 1
  store i64 %161, ptr %162, align 4
  %variable33 = alloca %SchemeObject, align 8
  %163 = getelementptr %SchemeObject, ptr %number31, i32 0
  %164 = load %SchemeObject, ptr %163, align 8
  store %SchemeObject %164, ptr %variable33, align 8
  br label %merge_branch23

merge_branch23:                                   ; preds = %true_branch22, %merge_branch27
  %165 = phi ptr [ null, %true_branch22 ]
  br label %merge_branch

comparison_branch24:                              ; preds = %false_branch
  %166 = getelementptr %SchemeObject, ptr %variable21, i32 0, i32 0
  %167 = load i64, ptr %166, align 4
  %168 = icmp eq i64 %167, 0
  call void @__GLAssert(i1 %168)
  %number28 = alloca %SchemeObject, align 8
  %169 = getelementptr %SchemeObject, ptr %number28, i32 0, i32 0
  store i64 0, ptr %169, align 4
  %170 = getelementptr %SchemeObject, ptr %number28, i32 0, i32 1
  store i64 0, ptr %170, align 4
  %171 = getelementptr %SchemeObject, ptr %number28, i32 0, i32 0
  %172 = load i64, ptr %171, align 4
  %173 = icmp eq i64 %172, 0
  call void @__GLAssert(i1 %173)
  %174 = getelementptr %SchemeObject, ptr %variable21, i32 0, i32 1
  %175 = load i64, ptr %174, align 4
  %176 = getelementptr %SchemeObject, ptr %number28, i32 0, i32 1
  %177 = load i64, ptr %176, align 4
  %178 = icmp sge i64 %175, %177
  br i1 %178, label %false_branch26, label %true_branch25

true_branch25:                                    ; preds = %comparison_branch24
  %boolean29 = alloca %SchemeObject, align 8
  %179 = getelementptr %SchemeObject, ptr %boolean29, i32 0, i32 0
  store i64 1, ptr %179, align 4
  %180 = getelementptr %SchemeObject, ptr %boolean29, i32 0, i32 2
  store i1 true, ptr %180, align 1
  br label %merge_branch27

false_branch26:                                   ; preds = %comparison_branch24
  %boolean30 = alloca %SchemeObject, align 8
  %181 = getelementptr %SchemeObject, ptr %boolean30, i32 0, i32 0
  store i64 1, ptr %181, align 4
  %182 = getelementptr %SchemeObject, ptr %boolean30, i32 0, i32 2
  store i1 false, ptr %182, align 1
  br label %merge_branch27

merge_branch27:                                   ; preds = %false_branch26, %true_branch25
  %183 = phi ptr [ %boolean29, %true_branch25 ], [ %boolean30, %false_branch26 ]
  %184 = getelementptr %SchemeObject, ptr %183, i32 0, i32 0
  %185 = load i64, ptr %184, align 4
  %186 = icmp eq i64 %185, 1
  call void @__GLAssert(i1 %186)
  %187 = getelementptr %SchemeObject, ptr %183, i32 0, i32 2
  %188 = load i1, ptr %187, align 1
  br i1 %188, label %true_branch22, label %merge_branch23
}

define %SchemeObject @LambdaFunction.23(ptr %0, ptr %1) {
entry:
  %variable = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %0, i32 0
  %3 = load %SchemeObject, ptr %2, align 8
  store %SchemeObject %3, ptr %variable, align 8
  %variable1 = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %1, i32 0
  %5 = load %SchemeObject, ptr %4, align 8
  store %SchemeObject %5, ptr %variable1, align 8
  %6 = icmp eq ptr %variable, null
  br i1 %6, label %true_branch2, label %continue_branch

true_branch:                                      ; preds = %merge_branch4
  %7 = alloca %SchemeObject, align 8
  %8 = getelementptr %SchemeObject, ptr %7, i32 0, i32 0
  store i64 3, ptr %8, align 4
  %9 = getelementptr %SchemeObject, ptr %7, i32 0, i32 4
  store ptr null, ptr %9, align 8
  %10 = getelementptr %SchemeObject, ptr %7, i32 0, i32 5
  store ptr null, ptr %10, align 8
  %number = alloca %SchemeObject, align 8
  %11 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %11, align 4
  %12 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 -100, ptr %12, align 4
  %13 = getelementptr %SchemeObject, ptr %7, i32 0, i32 4
  store ptr %number, ptr %13, align 8
  %14 = alloca %SchemeObject, align 8
  %15 = getelementptr %SchemeObject, ptr %14, i32 0, i32 0
  store i64 3, ptr %15, align 4
  %16 = getelementptr %SchemeObject, ptr %14, i32 0, i32 4
  store ptr null, ptr %16, align 8
  %17 = getelementptr %SchemeObject, ptr %14, i32 0, i32 5
  store ptr null, ptr %17, align 8
  %18 = getelementptr %SchemeObject, ptr %7, i32 0, i32 5
  store ptr %14, ptr %18, align 8
  %number6 = alloca %SchemeObject, align 8
  %19 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 0
  store i64 0, ptr %19, align 4
  %20 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 1
  store i64 200, ptr %20, align 4
  %number7 = alloca %SchemeObject, align 8
  %21 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 0
  store i64 0, ptr %21, align 4
  %22 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 1600, ptr %22, align 4
  %expt = alloca %SchemeObject, align 8
  %23 = call %SchemeObject @__GLExpt(ptr %number6, ptr %number7)
  store %SchemeObject %23, ptr %expt, align 8
  %24 = getelementptr %SchemeObject, ptr %14, i32 0, i32 4
  store ptr %expt, ptr %24, align 8
  %25 = alloca %SchemeObject, align 8
  %26 = getelementptr %SchemeObject, ptr %25, i32 0, i32 0
  store i64 3, ptr %26, align 4
  %27 = getelementptr %SchemeObject, ptr %25, i32 0, i32 4
  store ptr null, ptr %27, align 8
  %28 = getelementptr %SchemeObject, ptr %25, i32 0, i32 5
  store ptr null, ptr %28, align 8
  %29 = getelementptr %SchemeObject, ptr %14, i32 0, i32 5
  store ptr %25, ptr %29, align 8
  %30 = getelementptr %SchemeObject, ptr %14, i32 0, i32 5
  store ptr null, ptr %30, align 8
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch4
  %31 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %32 = load i64, ptr %31, align 4
  %is_type_check11 = icmp eq i64 %32, 3
  br i1 %is_type_check11, label %true_branch8, label %false_branch9

merge_branch:                                     ; preds = %merge_branch21, %true_branch
  %33 = phi ptr [ %7, %true_branch ], [ %75, %merge_branch21 ]
  %34 = getelementptr %SchemeObject, ptr %33, i32 0
  %35 = load %SchemeObject, ptr %34, align 8
  ret %SchemeObject %35

continue_branch:                                  ; preds = %entry
  %36 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %37 = load i64, ptr %36, align 4
  %is_type_check = icmp eq i64 %37, 3
  br i1 %is_type_check, label %is_cell_branch, label %false_branch3

is_cell_branch:                                   ; preds = %continue_branch
  %38 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 4
  %39 = load ptr, ptr %38, align 8
  %40 = icmp eq ptr %39, null
  br i1 %40, label %is_cell_first_null_branch, label %false_branch3

is_cell_first_null_branch:                        ; preds = %is_cell_branch
  %41 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %42 = load ptr, ptr %41, align 8
  %43 = icmp eq ptr %42, null
  br i1 %43, label %true_branch2, label %false_branch3

true_branch2:                                     ; preds = %is_cell_first_null_branch, %entry
  %boolean = alloca %SchemeObject, align 8
  %44 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %44, align 4
  %45 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %45, align 1
  br label %merge_branch4

false_branch3:                                    ; preds = %is_cell_first_null_branch, %is_cell_branch, %continue_branch
  %boolean5 = alloca %SchemeObject, align 8
  %46 = getelementptr %SchemeObject, ptr %boolean5, i32 0, i32 0
  store i64 1, ptr %46, align 4
  %47 = getelementptr %SchemeObject, ptr %boolean5, i32 0, i32 2
  store i1 false, ptr %47, align 1
  br label %merge_branch4

merge_branch4:                                    ; preds = %false_branch3, %true_branch2
  %48 = phi ptr [ %boolean, %true_branch2 ], [ %boolean5, %false_branch3 ]
  %49 = getelementptr %SchemeObject, ptr %48, i32 0, i32 0
  %50 = load i64, ptr %49, align 4
  %51 = icmp eq i64 %50, 1
  call void @__GLAssert(i1 %51)
  %52 = getelementptr %SchemeObject, ptr %48, i32 0, i32 2
  %53 = load i1, ptr %52, align 1
  br i1 %53, label %true_branch, label %false_branch

true_branch8:                                     ; preds = %false_branch
  %54 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %55 = load ptr, ptr %54, align 8
  br label %merge_branch10

false_branch9:                                    ; preds = %false_branch
  %56 = alloca %SchemeObject, align 8
  %57 = getelementptr %SchemeObject, ptr %56, i32 0, i32 0
  store i64 3, ptr %57, align 4
  %58 = getelementptr %SchemeObject, ptr %56, i32 0, i32 4
  store ptr null, ptr %58, align 8
  %59 = getelementptr %SchemeObject, ptr %56, i32 0, i32 5
  store ptr null, ptr %59, align 8
  br label %merge_branch10

merge_branch10:                                   ; preds = %false_branch9, %true_branch8
  %60 = phi ptr [ %55, %true_branch8 ], [ %56, %false_branch9 ]
  %function_returned = alloca %SchemeObject, align 8
  %61 = call ptr @llvm.stacksave()
  %62 = call %SchemeObject @LambdaFunction.23(ptr %60, ptr %variable1)
  store %SchemeObject %62, ptr %function_returned, align 8
  call void @llvm.stackrestore(ptr %61)
  %variable12 = alloca %SchemeObject, align 8
  %63 = getelementptr %SchemeObject, ptr %function_returned, i32 0
  %64 = load %SchemeObject, ptr %63, align 8
  store %SchemeObject %64, ptr %variable12, align 8
  %65 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %66 = load i64, ptr %65, align 4
  %is_type_check16 = icmp eq i64 %66, 3
  br i1 %is_type_check16, label %true_branch13, label %false_branch14

true_branch13:                                    ; preds = %merge_branch10
  %67 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 4
  %68 = load ptr, ptr %67, align 8
  br label %merge_branch15

false_branch14:                                   ; preds = %merge_branch10
  %69 = phi ptr [ %variable, %merge_branch10 ]
  br label %merge_branch15

merge_branch15:                                   ; preds = %false_branch14, %true_branch13
  %70 = phi ptr [ %68, %true_branch13 ], [ %69, %false_branch14 ]
  %function_returned17 = alloca %SchemeObject, align 8
  %71 = call ptr @llvm.stacksave()
  %72 = call %SchemeObject @LambdaFunction.22(ptr %70, ptr %variable1)
  store %SchemeObject %72, ptr %function_returned17, align 8
  call void @llvm.stackrestore(ptr %71)
  %variable18 = alloca %SchemeObject, align 8
  %73 = getelementptr %SchemeObject, ptr %function_returned17, i32 0
  %74 = load %SchemeObject, ptr %73, align 8
  store %SchemeObject %74, ptr %variable18, align 8
  br label %comparison_branch

true_branch19:                                    ; preds = %merge_branch24
  br label %comparison_branch38

false_branch20:                                   ; preds = %merge_branch24
  br label %merge_branch21

merge_branch21:                                   ; preds = %false_branch20, %merge_branch37
  %75 = phi ptr [ %118, %merge_branch37 ], [ %variable12, %false_branch20 ]
  br label %merge_branch

comparison_branch:                                ; preds = %merge_branch15
  %76 = getelementptr %SchemeObject, ptr %variable12, i32 0, i32 0
  %77 = load i64, ptr %76, align 4
  %is_type_check31 = icmp eq i64 %77, 3
  br i1 %is_type_check31, label %true_branch28, label %false_branch29

true_branch22:                                    ; preds = %merge_branch27
  %boolean33 = alloca %SchemeObject, align 8
  %78 = getelementptr %SchemeObject, ptr %boolean33, i32 0, i32 0
  store i64 1, ptr %78, align 4
  %79 = getelementptr %SchemeObject, ptr %boolean33, i32 0, i32 2
  store i1 true, ptr %79, align 1
  br label %merge_branch24

false_branch23:                                   ; preds = %merge_branch27
  %boolean34 = alloca %SchemeObject, align 8
  %80 = getelementptr %SchemeObject, ptr %boolean34, i32 0, i32 0
  store i64 1, ptr %80, align 4
  %81 = getelementptr %SchemeObject, ptr %boolean34, i32 0, i32 2
  store i1 false, ptr %81, align 1
  br label %merge_branch24

merge_branch24:                                   ; preds = %false_branch23, %true_branch22
  %82 = phi ptr [ %boolean33, %true_branch22 ], [ %boolean34, %false_branch23 ]
  %83 = getelementptr %SchemeObject, ptr %82, i32 0, i32 0
  %84 = load i64, ptr %83, align 4
  %85 = icmp eq i64 %84, 1
  call void @__GLAssert(i1 %85)
  %86 = getelementptr %SchemeObject, ptr %82, i32 0, i32 2
  %87 = load i1, ptr %86, align 1
  br i1 %87, label %true_branch19, label %false_branch20

true_branch25:                                    ; preds = %merge_branch30
  %88 = getelementptr %SchemeObject, ptr %109, i32 0, i32 4
  %89 = load ptr, ptr %88, align 8
  br label %merge_branch27

false_branch26:                                   ; preds = %merge_branch30
  %90 = phi ptr [ %109, %merge_branch30 ]
  br label %merge_branch27

merge_branch27:                                   ; preds = %false_branch26, %true_branch25
  %91 = phi ptr [ %89, %true_branch25 ], [ %90, %false_branch26 ]
  %92 = getelementptr %SchemeObject, ptr %91, i32 0, i32 0
  %93 = load i64, ptr %92, align 4
  %94 = icmp eq i64 %93, 0
  call void @__GLAssert(i1 %94)
  %95 = getelementptr %SchemeObject, ptr %variable18, i32 0, i32 0
  %96 = load i64, ptr %95, align 4
  %97 = icmp eq i64 %96, 0
  call void @__GLAssert(i1 %97)
  %98 = getelementptr %SchemeObject, ptr %91, i32 0, i32 1
  %99 = load i64, ptr %98, align 4
  %100 = getelementptr %SchemeObject, ptr %variable18, i32 0, i32 1
  %101 = load i64, ptr %100, align 4
  %102 = icmp sle i64 %99, %101
  br i1 %102, label %false_branch23, label %true_branch22

true_branch28:                                    ; preds = %comparison_branch
  %103 = getelementptr %SchemeObject, ptr %variable12, i32 0, i32 5
  %104 = load ptr, ptr %103, align 8
  br label %merge_branch30

false_branch29:                                   ; preds = %comparison_branch
  %105 = alloca %SchemeObject, align 8
  %106 = getelementptr %SchemeObject, ptr %105, i32 0, i32 0
  store i64 3, ptr %106, align 4
  %107 = getelementptr %SchemeObject, ptr %105, i32 0, i32 4
  store ptr null, ptr %107, align 8
  %108 = getelementptr %SchemeObject, ptr %105, i32 0, i32 5
  store ptr null, ptr %108, align 8
  br label %merge_branch30

merge_branch30:                                   ; preds = %false_branch29, %true_branch28
  %109 = phi ptr [ %104, %true_branch28 ], [ %105, %false_branch29 ]
  %110 = getelementptr %SchemeObject, ptr %109, i32 0, i32 0
  %111 = load i64, ptr %110, align 4
  %is_type_check32 = icmp eq i64 %111, 3
  br i1 %is_type_check32, label %true_branch25, label %false_branch26

true_branch35:                                    ; preds = %merge_branch41
  br label %merge_branch37

false_branch36:                                   ; preds = %merge_branch41
  %112 = alloca %SchemeObject, align 8
  %113 = getelementptr %SchemeObject, ptr %112, i32 0, i32 0
  store i64 3, ptr %113, align 4
  %114 = getelementptr %SchemeObject, ptr %112, i32 0, i32 4
  store ptr null, ptr %114, align 8
  %115 = getelementptr %SchemeObject, ptr %112, i32 0, i32 5
  store ptr null, ptr %115, align 8
  %116 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %117 = load i64, ptr %116, align 4
  %is_type_check48 = icmp eq i64 %117, 3
  br i1 %is_type_check48, label %true_branch45, label %false_branch46

merge_branch37:                                   ; preds = %merge_branch47, %true_branch35
  %118 = phi ptr [ %variable12, %true_branch35 ], [ %112, %merge_branch47 ]
  br label %merge_branch21

comparison_branch38:                              ; preds = %true_branch19
  %119 = getelementptr %SchemeObject, ptr %variable18, i32 0, i32 0
  %120 = load i64, ptr %119, align 4
  %121 = icmp eq i64 %120, 0
  call void @__GLAssert(i1 %121)
  %number42 = alloca %SchemeObject, align 8
  %122 = getelementptr %SchemeObject, ptr %number42, i32 0, i32 0
  store i64 0, ptr %122, align 4
  %123 = getelementptr %SchemeObject, ptr %number42, i32 0, i32 1
  store i64 0, ptr %123, align 4
  %124 = getelementptr %SchemeObject, ptr %number42, i32 0, i32 0
  %125 = load i64, ptr %124, align 4
  %126 = icmp eq i64 %125, 0
  call void @__GLAssert(i1 %126)
  %127 = getelementptr %SchemeObject, ptr %variable18, i32 0, i32 1
  %128 = load i64, ptr %127, align 4
  %129 = getelementptr %SchemeObject, ptr %number42, i32 0, i32 1
  %130 = load i64, ptr %129, align 4
  %131 = icmp sge i64 %128, %130
  br i1 %131, label %false_branch40, label %true_branch39

true_branch39:                                    ; preds = %comparison_branch38
  %boolean43 = alloca %SchemeObject, align 8
  %132 = getelementptr %SchemeObject, ptr %boolean43, i32 0, i32 0
  store i64 1, ptr %132, align 4
  %133 = getelementptr %SchemeObject, ptr %boolean43, i32 0, i32 2
  store i1 true, ptr %133, align 1
  br label %merge_branch41

false_branch40:                                   ; preds = %comparison_branch38
  %boolean44 = alloca %SchemeObject, align 8
  %134 = getelementptr %SchemeObject, ptr %boolean44, i32 0, i32 0
  store i64 1, ptr %134, align 4
  %135 = getelementptr %SchemeObject, ptr %boolean44, i32 0, i32 2
  store i1 false, ptr %135, align 1
  br label %merge_branch41

merge_branch41:                                   ; preds = %false_branch40, %true_branch39
  %136 = phi ptr [ %boolean43, %true_branch39 ], [ %boolean44, %false_branch40 ]
  %137 = getelementptr %SchemeObject, ptr %136, i32 0, i32 0
  %138 = load i64, ptr %137, align 4
  %139 = icmp eq i64 %138, 1
  call void @__GLAssert(i1 %139)
  %140 = getelementptr %SchemeObject, ptr %136, i32 0, i32 2
  %141 = load i1, ptr %140, align 1
  br i1 %141, label %true_branch35, label %false_branch36

true_branch45:                                    ; preds = %false_branch36
  %142 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 4
  %143 = load ptr, ptr %142, align 8
  br label %merge_branch47

false_branch46:                                   ; preds = %false_branch36
  %144 = phi ptr [ %variable, %false_branch36 ]
  br label %merge_branch47

merge_branch47:                                   ; preds = %false_branch46, %true_branch45
  %145 = phi ptr [ %143, %true_branch45 ], [ %144, %false_branch46 ]
  %146 = getelementptr %SchemeObject, ptr %112, i32 0, i32 4
  store ptr %145, ptr %146, align 8
  %147 = alloca %SchemeObject, align 8
  %148 = getelementptr %SchemeObject, ptr %147, i32 0, i32 0
  store i64 3, ptr %148, align 4
  %149 = getelementptr %SchemeObject, ptr %147, i32 0, i32 4
  store ptr null, ptr %149, align 8
  %150 = getelementptr %SchemeObject, ptr %147, i32 0, i32 5
  store ptr null, ptr %150, align 8
  %151 = getelementptr %SchemeObject, ptr %112, i32 0, i32 5
  store ptr %147, ptr %151, align 8
  %152 = getelementptr %SchemeObject, ptr %147, i32 0, i32 4
  store ptr %variable18, ptr %152, align 8
  %153 = alloca %SchemeObject, align 8
  %154 = getelementptr %SchemeObject, ptr %153, i32 0, i32 0
  store i64 3, ptr %154, align 4
  %155 = getelementptr %SchemeObject, ptr %153, i32 0, i32 4
  store ptr null, ptr %155, align 8
  %156 = getelementptr %SchemeObject, ptr %153, i32 0, i32 5
  store ptr null, ptr %156, align 8
  %157 = getelementptr %SchemeObject, ptr %147, i32 0, i32 5
  store ptr %153, ptr %157, align 8
  %158 = getelementptr %SchemeObject, ptr %147, i32 0, i32 5
  store ptr null, ptr %158, align 8
  br label %merge_branch37
}

define %SchemeObject @LambdaFunction.24(ptr %0, ptr %1, ptr %2, ptr %3) {
entry:
  %variable = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %0, i32 0
  %5 = load %SchemeObject, ptr %4, align 8
  store %SchemeObject %5, ptr %variable, align 8
  %variable1 = alloca %SchemeObject, align 8
  %6 = getelementptr %SchemeObject, ptr %1, i32 0
  %7 = load %SchemeObject, ptr %6, align 8
  store %SchemeObject %7, ptr %variable1, align 8
  %variable2 = alloca %SchemeObject, align 8
  %8 = getelementptr %SchemeObject, ptr %2, i32 0
  %9 = load %SchemeObject, ptr %8, align 8
  store %SchemeObject %9, ptr %variable2, align 8
  %variable3 = alloca %SchemeObject, align 8
  %10 = getelementptr %SchemeObject, ptr %3, i32 0
  %11 = load %SchemeObject, ptr %10, align 8
  store %SchemeObject %11, ptr %variable3, align 8
  br label %comparison_branch

true_branch:                                      ; preds = %merge_branch6
  %number8 = alloca %SchemeObject, align 8
  %12 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 0
  store i64 0, ptr %12, align 4
  %13 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 1
  store i64 100, ptr %13, align 4
  %number9 = alloca %SchemeObject, align 8
  %14 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 0
  store i64 0, ptr %14, align 4
  %15 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 1
  store i64 100, ptr %15, align 4
  %number10 = alloca %SchemeObject, align 8
  %16 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 0
  store i64 0, ptr %16, align 4
  %17 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 100, ptr %17, align 4
  %function_returned = alloca %SchemeObject, align 8
  %18 = call ptr @llvm.stacksave()
  %19 = call %SchemeObject @LambdaFunction.2(ptr %number8, ptr %number9, ptr %number10)
  store %SchemeObject %19, ptr %function_returned, align 8
  call void @llvm.stackrestore(ptr %18)
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch6
  %function_returned11 = alloca %SchemeObject, align 8
  %20 = call ptr @llvm.stacksave()
  %21 = call %SchemeObject @LambdaFunction.23(ptr %variable1, ptr %variable)
  store %SchemeObject %21, ptr %function_returned11, align 8
  call void @llvm.stackrestore(ptr %20)
  %variable12 = alloca %SchemeObject, align 8
  %22 = getelementptr %SchemeObject, ptr %function_returned11, i32 0
  %23 = load %SchemeObject, ptr %22, align 8
  store %SchemeObject %23, ptr %variable12, align 8
  %24 = getelementptr %SchemeObject, ptr %variable12, i32 0, i32 0
  %25 = load i64, ptr %24, align 4
  %is_type_check = icmp eq i64 %25, 3
  br i1 %is_type_check, label %true_branch19, label %false_branch20

merge_branch:                                     ; preds = %merge_branch15, %true_branch
  %26 = phi ptr [ %function_returned, %true_branch ], [ %62, %merge_branch15 ]
  %27 = getelementptr %SchemeObject, ptr %26, i32 0
  %28 = load %SchemeObject, ptr %27, align 8
  ret %SchemeObject %28

comparison_branch:                                ; preds = %entry
  %29 = getelementptr %SchemeObject, ptr %variable2, i32 0, i32 0
  %30 = load i64, ptr %29, align 4
  %31 = icmp eq i64 %30, 0
  call void @__GLAssert(i1 %31)
  %number = alloca %SchemeObject, align 8
  %32 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %32, align 4
  %33 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 300, ptr %33, align 4
  %34 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  %35 = load i64, ptr %34, align 4
  %36 = icmp eq i64 %35, 0
  call void @__GLAssert(i1 %36)
  %37 = getelementptr %SchemeObject, ptr %variable2, i32 0, i32 1
  %38 = load i64, ptr %37, align 4
  %39 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %40 = load i64, ptr %39, align 4
  %41 = icmp ne i64 %38, %40
  br i1 %41, label %false_branch5, label %true_branch4

true_branch4:                                     ; preds = %comparison_branch
  %boolean = alloca %SchemeObject, align 8
  %42 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %42, align 4
  %43 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %43, align 1
  br label %merge_branch6

false_branch5:                                    ; preds = %comparison_branch
  %boolean7 = alloca %SchemeObject, align 8
  %44 = getelementptr %SchemeObject, ptr %boolean7, i32 0, i32 0
  store i64 1, ptr %44, align 4
  %45 = getelementptr %SchemeObject, ptr %boolean7, i32 0, i32 2
  store i1 false, ptr %45, align 1
  br label %merge_branch6

merge_branch6:                                    ; preds = %false_branch5, %true_branch4
  %46 = phi ptr [ %boolean, %true_branch4 ], [ %boolean7, %false_branch5 ]
  %47 = getelementptr %SchemeObject, ptr %46, i32 0, i32 0
  %48 = load i64, ptr %47, align 4
  %49 = icmp eq i64 %48, 1
  call void @__GLAssert(i1 %49)
  %50 = getelementptr %SchemeObject, ptr %46, i32 0, i32 2
  %51 = load i1, ptr %50, align 1
  br i1 %51, label %true_branch, label %false_branch

true_branch13:                                    ; preds = %end_branch
  %number42 = alloca %SchemeObject, align 8
  %52 = getelementptr %SchemeObject, ptr %number42, i32 0, i32 0
  store i64 0, ptr %52, align 4
  %53 = getelementptr %SchemeObject, ptr %number42, i32 0, i32 1
  store i64 100, ptr %53, align 4
  %number43 = alloca %SchemeObject, align 8
  %54 = getelementptr %SchemeObject, ptr %number43, i32 0, i32 0
  store i64 0, ptr %54, align 4
  %55 = getelementptr %SchemeObject, ptr %number43, i32 0, i32 1
  store i64 100, ptr %55, align 4
  %number44 = alloca %SchemeObject, align 8
  %56 = getelementptr %SchemeObject, ptr %number44, i32 0, i32 0
  store i64 0, ptr %56, align 4
  %57 = getelementptr %SchemeObject, ptr %number44, i32 0, i32 1
  store i64 100, ptr %57, align 4
  %function_returned45 = alloca %SchemeObject, align 8
  %58 = call ptr @llvm.stacksave()
  %59 = call %SchemeObject @LambdaFunction.2(ptr %number42, ptr %number43, ptr %number44)
  store %SchemeObject %59, ptr %function_returned45, align 8
  call void @llvm.stackrestore(ptr %58)
  br label %merge_branch15

false_branch14:                                   ; preds = %end_branch
  %60 = getelementptr %SchemeObject, ptr %variable12, i32 0, i32 0
  %61 = load i64, ptr %60, align 4
  %is_type_check49 = icmp eq i64 %61, 3
  br i1 %is_type_check49, label %true_branch46, label %false_branch47

merge_branch15:                                   ; preds = %merge_branch48, %true_branch13
  %62 = phi ptr [ %function_returned45, %true_branch13 ], [ %function_returned50, %merge_branch48 ]
  br label %merge_branch

end_branch:                                       ; preds = %continue_branch37, %is_boolean_smth_branch39, %is_boolean_smth_branch
  %63 = phi ptr [ %86, %is_boolean_smth_branch ], [ %117, %is_boolean_smth_branch39 ], [ %113, %continue_branch37 ]
  %64 = getelementptr %SchemeObject, ptr %63, i32 0, i32 0
  %65 = load i64, ptr %64, align 4
  %66 = icmp eq i64 %65, 1
  call void @__GLAssert(i1 %66)
  %67 = getelementptr %SchemeObject, ptr %63, i32 0, i32 2
  %68 = load i1, ptr %67, align 1
  br i1 %68, label %true_branch13, label %false_branch14

true_branch16:                                    ; preds = %merge_branch21
  %boolean23 = alloca %SchemeObject, align 8
  %69 = getelementptr %SchemeObject, ptr %boolean23, i32 0, i32 0
  store i64 1, ptr %69, align 4
  %70 = getelementptr %SchemeObject, ptr %boolean23, i32 0, i32 2
  store i1 true, ptr %70, align 1
  br label %merge_branch18

false_branch17:                                   ; preds = %merge_branch21
  %boolean24 = alloca %SchemeObject, align 8
  %71 = getelementptr %SchemeObject, ptr %boolean24, i32 0, i32 0
  store i64 1, ptr %71, align 4
  %72 = getelementptr %SchemeObject, ptr %boolean24, i32 0, i32 2
  store i1 false, ptr %72, align 1
  br label %merge_branch18

merge_branch18:                                   ; preds = %false_branch17, %true_branch16
  %73 = phi ptr [ %boolean23, %true_branch16 ], [ %boolean24, %false_branch17 ]
  %74 = getelementptr %SchemeObject, ptr %73, i32 0, i32 0
  %75 = load i64, ptr %74, align 4
  %is_type_check25 = icmp eq i64 %75, 1
  br i1 %is_type_check25, label %is_boolean_branch, label %continue_branch

true_branch19:                                    ; preds = %false_branch
  %76 = getelementptr %SchemeObject, ptr %variable12, i32 0, i32 4
  %77 = load ptr, ptr %76, align 8
  br label %merge_branch21

false_branch20:                                   ; preds = %false_branch
  %78 = phi ptr [ %variable12, %false_branch ]
  br label %merge_branch21

merge_branch21:                                   ; preds = %false_branch20, %true_branch19
  %79 = phi ptr [ %77, %true_branch19 ], [ %78, %false_branch20 ]
  %80 = getelementptr %SchemeObject, ptr %79, i32 0, i32 0
  %81 = load i64, ptr %80, align 4
  %is_type_check22 = icmp eq i64 %81, 0
  br i1 %is_type_check22, label %true_branch16, label %false_branch17

continue_branch:                                  ; preds = %is_boolean_branch, %merge_branch18
  %82 = phi ptr [ %73, %merge_branch18 ], [ %85, %is_boolean_branch ]
  br label %comparison_branch26

is_boolean_branch:                                ; preds = %merge_branch18
  %83 = getelementptr %SchemeObject, ptr %73, i32 0, i32 2
  %84 = load i1, ptr %83, align 1
  %is_boolean_smth_check = icmp eq i1 %84, false
  %85 = phi ptr [ %73, %merge_branch18 ]
  br i1 %is_boolean_smth_check, label %is_boolean_smth_branch, label %continue_branch

is_boolean_smth_branch:                           ; preds = %is_boolean_branch
  %86 = phi ptr [ %85, %is_boolean_branch ]
  br label %end_branch

comparison_branch26:                              ; preds = %continue_branch
  %87 = getelementptr %SchemeObject, ptr %variable12, i32 0, i32 0
  %88 = load i64, ptr %87, align 4
  %is_type_check33 = icmp eq i64 %88, 3
  br i1 %is_type_check33, label %true_branch30, label %false_branch31

true_branch27:                                    ; preds = %merge_branch32
  %boolean35 = alloca %SchemeObject, align 8
  %89 = getelementptr %SchemeObject, ptr %boolean35, i32 0, i32 0
  store i64 1, ptr %89, align 4
  %90 = getelementptr %SchemeObject, ptr %boolean35, i32 0, i32 2
  store i1 true, ptr %90, align 1
  br label %merge_branch29

false_branch28:                                   ; preds = %merge_branch32
  %boolean36 = alloca %SchemeObject, align 8
  %91 = getelementptr %SchemeObject, ptr %boolean36, i32 0, i32 0
  store i64 1, ptr %91, align 4
  %92 = getelementptr %SchemeObject, ptr %boolean36, i32 0, i32 2
  store i1 false, ptr %92, align 1
  br label %merge_branch29

merge_branch29:                                   ; preds = %false_branch28, %true_branch27
  %93 = phi ptr [ %boolean35, %true_branch27 ], [ %boolean36, %false_branch28 ]
  %94 = getelementptr %SchemeObject, ptr %93, i32 0, i32 0
  %95 = load i64, ptr %94, align 4
  %is_type_check40 = icmp eq i64 %95, 1
  br i1 %is_type_check40, label %is_boolean_branch38, label %continue_branch37

true_branch30:                                    ; preds = %comparison_branch26
  %96 = getelementptr %SchemeObject, ptr %variable12, i32 0, i32 4
  %97 = load ptr, ptr %96, align 8
  br label %merge_branch32

false_branch31:                                   ; preds = %comparison_branch26
  %98 = phi ptr [ %variable12, %comparison_branch26 ]
  br label %merge_branch32

merge_branch32:                                   ; preds = %false_branch31, %true_branch30
  %99 = phi ptr [ %97, %true_branch30 ], [ %98, %false_branch31 ]
  %100 = getelementptr %SchemeObject, ptr %99, i32 0, i32 0
  %101 = load i64, ptr %100, align 4
  %102 = icmp eq i64 %101, 0
  call void @__GLAssert(i1 %102)
  %number34 = alloca %SchemeObject, align 8
  %103 = getelementptr %SchemeObject, ptr %number34, i32 0, i32 0
  store i64 0, ptr %103, align 4
  %104 = getelementptr %SchemeObject, ptr %number34, i32 0, i32 1
  store i64 -100, ptr %104, align 4
  %105 = getelementptr %SchemeObject, ptr %number34, i32 0, i32 0
  %106 = load i64, ptr %105, align 4
  %107 = icmp eq i64 %106, 0
  call void @__GLAssert(i1 %107)
  %108 = getelementptr %SchemeObject, ptr %99, i32 0, i32 1
  %109 = load i64, ptr %108, align 4
  %110 = getelementptr %SchemeObject, ptr %number34, i32 0, i32 1
  %111 = load i64, ptr %110, align 4
  %112 = icmp ne i64 %109, %111
  br i1 %112, label %false_branch28, label %true_branch27

continue_branch37:                                ; preds = %is_boolean_branch38, %merge_branch29
  %113 = phi ptr [ %93, %merge_branch29 ], [ %116, %is_boolean_branch38 ]
  br label %end_branch

is_boolean_branch38:                              ; preds = %merge_branch29
  %114 = getelementptr %SchemeObject, ptr %93, i32 0, i32 2
  %115 = load i1, ptr %114, align 1
  %is_boolean_smth_check41 = icmp eq i1 %115, false
  %116 = phi ptr [ %93, %merge_branch29 ]
  br i1 %is_boolean_smth_check41, label %is_boolean_smth_branch39, label %continue_branch37

is_boolean_smth_branch39:                         ; preds = %is_boolean_branch38
  %117 = phi ptr [ %116, %is_boolean_branch38 ]
  br label %end_branch

true_branch46:                                    ; preds = %false_branch14
  %118 = getelementptr %SchemeObject, ptr %variable12, i32 0, i32 4
  %119 = load ptr, ptr %118, align 8
  br label %merge_branch48

false_branch47:                                   ; preds = %false_branch14
  %120 = phi ptr [ %variable12, %false_branch14 ]
  br label %merge_branch48

merge_branch48:                                   ; preds = %false_branch47, %true_branch46
  %121 = phi ptr [ %119, %true_branch46 ], [ %120, %false_branch47 ]
  %function_returned50 = alloca %SchemeObject, align 8
  %122 = call ptr @llvm.stacksave()
  %123 = call %SchemeObject @LambdaFunction.20(ptr %121)
  store %SchemeObject %123, ptr %function_returned50, align 8
  call void @llvm.stackrestore(ptr %122)
  br label %merge_branch15
}

attributes #0 = { nocallback nofree nosync nounwind willreturn }
