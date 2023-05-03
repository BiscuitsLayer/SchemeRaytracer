; ModuleID = 'outfile.ll'
source_filename = "outfile.ll"

%SchemeObject = type { i64, i64, i1, ptr, ptr, ptr }

define i32 @main() {
entry:
  %number = alloca %SchemeObject, align 8
  %0 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %0, align 4
  %1 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 500, ptr %1, align 4
  %variable = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %number, i32 0
  %3 = load %SchemeObject, ptr %2, align 8
  store %SchemeObject %3, ptr %variable, align 8
  br label %condition_branch

condition_branch:                                 ; preds = %loop_branch, %entry
  br label %comparison_branch

loop_branch:                                      ; preds = %merge_branch1
  call void @__GLPrint(ptr %variable)
  %number4 = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 0
  store i64 0, ptr %4, align 4
  %5 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 1
  store i64 0, ptr %5, align 4
  %6 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %7 = load i64, ptr %6, align 4
  %8 = icmp eq i64 %7, 0
  call void @__GLAssert(i1 %8)
  %9 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 1
  %10 = load i64, ptr %9, align 4
  %11 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 1
  %12 = load i64, ptr %11, align 4
  %13 = sub i64 %10, %12
  %14 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 1
  store i64 %12, ptr %14, align 4
  %number5 = alloca %SchemeObject, align 8
  %15 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  store i64 0, ptr %15, align 4
  %16 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 100, ptr %16, align 4
  %17 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  %18 = load i64, ptr %17, align 4
  %19 = icmp eq i64 %18, 0
  call void @__GLAssert(i1 %19)
  %20 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 1
  %21 = load i64, ptr %20, align 4
  %22 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  %23 = load i64, ptr %22, align 4
  %24 = sub i64 %21, %23
  %25 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 1
  store i64 %24, ptr %25, align 4
  %26 = getelementptr %SchemeObject, ptr %number4, i32 0
  %27 = load %SchemeObject, ptr %26, align 8
  store %SchemeObject %27, ptr %variable, align 8
  br label %condition_branch

merge_branch:                                     ; preds = %merge_branch1
  ret i32 0

comparison_branch:                                ; preds = %condition_branch
  %28 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %29 = load i64, ptr %28, align 4
  %30 = icmp eq i64 %29, 0
  call void @__GLAssert(i1 %30)
  %number2 = alloca %SchemeObject, align 8
  %31 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  store i64 0, ptr %31, align 4
  %32 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  store i64 0, ptr %32, align 4
  %33 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  %34 = load i64, ptr %33, align 4
  %35 = icmp eq i64 %34, 0
  call void @__GLAssert(i1 %35)
  %36 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 1
  %37 = load i64, ptr %36, align 4
  %38 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  %39 = load i64, ptr %38, align 4
  %40 = icmp slt i64 %37, %39
  br i1 %40, label %false_branch, label %true_branch

true_branch:                                      ; preds = %comparison_branch
  %boolean = alloca %SchemeObject, align 8
  %41 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %41, align 4
  %42 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %42, align 1
  br label %merge_branch1

false_branch:                                     ; preds = %comparison_branch
  %boolean3 = alloca %SchemeObject, align 8
  %43 = getelementptr %SchemeObject, ptr %boolean3, i32 0, i32 0
  store i64 1, ptr %43, align 4
  %44 = getelementptr %SchemeObject, ptr %boolean3, i32 0, i32 2
  store i1 false, ptr %44, align 1
  br label %merge_branch1

merge_branch1:                                    ; preds = %false_branch, %true_branch
  %45 = phi ptr [ %boolean, %true_branch ], [ %boolean3, %false_branch ]
  %46 = getelementptr %SchemeObject, ptr %45, i32 0, i32 0
  %47 = load i64, ptr %46, align 4
  %48 = icmp eq i64 %47, 1
  call void @__GLAssert(i1 %48)
  %49 = getelementptr %SchemeObject, ptr %45, i32 0, i32 2
  %50 = load i1, ptr %49, align 1
  br i1 %50, label %loop_branch, label %merge_branch
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
