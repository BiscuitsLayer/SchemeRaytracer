; ModuleID = 'outfile.ll'
source_filename = "outfile.ll"

%SchemeObject = type { i64, i64, i1, ptr, ptr, ptr }

define i32 @main() {
entry:
  %0 = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0, i32 0
  store i64 3, ptr %1, align 4
  %number = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %2, align 4
  %3 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 100, ptr %3, align 4
  %4 = getelementptr %SchemeObject, ptr %0, i32 0, i32 4
  store ptr %number, ptr %4, align 8
  %5 = alloca %SchemeObject, align 8
  %6 = getelementptr %SchemeObject, ptr %5, i32 0, i32 0
  store i64 3, ptr %6, align 4
  %7 = getelementptr %SchemeObject, ptr %0, i32 0, i32 5
  store ptr %5, ptr %7, align 8
  %number1 = alloca %SchemeObject, align 8
  %8 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 0
  store i64 0, ptr %8, align 4
  %9 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 1
  store i64 200, ptr %9, align 4
  %10 = getelementptr %SchemeObject, ptr %5, i32 0, i32 4
  store ptr %number1, ptr %10, align 8
  %11 = alloca %SchemeObject, align 8
  %12 = getelementptr %SchemeObject, ptr %11, i32 0, i32 0
  store i64 3, ptr %12, align 4
  %13 = getelementptr %SchemeObject, ptr %5, i32 0, i32 5
  store ptr %11, ptr %13, align 8
  %number2 = alloca %SchemeObject, align 8
  %14 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  store i64 0, ptr %14, align 4
  %15 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  store i64 300, ptr %15, align 4
  %16 = getelementptr %SchemeObject, ptr %11, i32 0, i32 4
  store ptr %number2, ptr %16, align 8
  %17 = alloca %SchemeObject, align 8
  %18 = getelementptr %SchemeObject, ptr %17, i32 0, i32 0
  store i64 3, ptr %18, align 4
  %19 = getelementptr %SchemeObject, ptr %11, i32 0, i32 5
  store ptr %17, ptr %19, align 8
  %20 = getelementptr %SchemeObject, ptr %11, i32 0, i32 5
  store i64 0, ptr %20, align 4
  %variable = alloca %SchemeObject, align 8
  %21 = getelementptr %SchemeObject, ptr %0, i32 0
  %22 = load %SchemeObject, ptr %21, align 8
  store %SchemeObject %22, ptr %variable, align 8
  %23 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %24 = load i64, ptr %23, align 4
  %is_type_check = icmp eq i64 %24, 3
  br i1 %is_type_check, label %true_branch3, label %false_branch4

true_branch:                                      ; preds = %merge_branch5
  %25 = getelementptr %SchemeObject, ptr %35, i32 0, i32 4
  %26 = load ptr, ptr %25, align 8
  br label %merge_branch

false_branch:                                     ; preds = %merge_branch5
  %27 = phi ptr [ %35, %merge_branch5 ]
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %28 = phi ptr [ %26, %true_branch ], [ %27, %false_branch ]
  call void @__GLPrint(ptr %28)
  %29 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %30 = load i64, ptr %29, align 4
  %is_type_check10 = icmp eq i64 %30, 3
  br i1 %is_type_check10, label %true_branch7, label %false_branch8

true_branch3:                                     ; preds = %entry
  %31 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %32 = load ptr, ptr %31, align 8
  br label %merge_branch5

false_branch4:                                    ; preds = %entry
  %33 = alloca %SchemeObject, align 8
  %34 = getelementptr %SchemeObject, ptr %33, i32 0, i32 0
  store i64 3, ptr %34, align 4
  br label %merge_branch5

merge_branch5:                                    ; preds = %false_branch4, %true_branch3
  %35 = phi ptr [ %32, %true_branch3 ], [ %33, %false_branch4 ]
  %36 = getelementptr %SchemeObject, ptr %35, i32 0, i32 0
  %37 = load i64, ptr %36, align 4
  %is_type_check6 = icmp eq i64 %37, 3
  br i1 %is_type_check6, label %true_branch, label %false_branch

true_branch7:                                     ; preds = %merge_branch
  %38 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 4
  %39 = load ptr, ptr %38, align 8
  br label %merge_branch9

false_branch8:                                    ; preds = %merge_branch
  %40 = phi ptr [ %variable, %merge_branch ]
  br label %merge_branch9

merge_branch9:                                    ; preds = %false_branch8, %true_branch7
  %41 = phi ptr [ %39, %true_branch7 ], [ %40, %false_branch8 ]
  call void @__GLPrint(ptr %41)
  %42 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %43 = load i64, ptr %42, align 4
  %is_type_check14 = icmp eq i64 %43, 3
  br i1 %is_type_check14, label %true_branch11, label %false_branch12

true_branch11:                                    ; preds = %merge_branch9
  %44 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %45 = load ptr, ptr %44, align 8
  br label %merge_branch13

false_branch12:                                   ; preds = %merge_branch9
  %46 = alloca %SchemeObject, align 8
  %47 = getelementptr %SchemeObject, ptr %46, i32 0, i32 0
  store i64 3, ptr %47, align 4
  br label %merge_branch13

merge_branch13:                                   ; preds = %false_branch12, %true_branch11
  %48 = phi ptr [ %45, %true_branch11 ], [ %46, %false_branch12 ]
  call void @__GLPrint(ptr %48)
  %49 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %50 = load i64, ptr %49, align 4
  %is_type_check18 = icmp eq i64 %50, 3
  br i1 %is_type_check18, label %true_branch15, label %false_branch16

true_branch15:                                    ; preds = %merge_branch13
  %51 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %52 = load ptr, ptr %51, align 8
  br label %merge_branch17

false_branch16:                                   ; preds = %merge_branch13
  %53 = alloca %SchemeObject, align 8
  %54 = getelementptr %SchemeObject, ptr %53, i32 0, i32 0
  store i64 3, ptr %54, align 4
  br label %merge_branch17

merge_branch17:                                   ; preds = %false_branch16, %true_branch15
  %55 = phi ptr [ %52, %true_branch15 ], [ %53, %false_branch16 ]
  call void @__GLPrint(ptr %55)
  %56 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %57 = load i64, ptr %56, align 4
  %is_type_check22 = icmp eq i64 %57, 3
  br i1 %is_type_check22, label %true_branch19, label %false_branch20

true_branch19:                                    ; preds = %merge_branch17
  %58 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 4
  %59 = load ptr, ptr %58, align 8
  br label %merge_branch21

false_branch20:                                   ; preds = %merge_branch17
  %60 = phi ptr [ %variable, %merge_branch17 ]
  br label %merge_branch21

merge_branch21:                                   ; preds = %false_branch20, %true_branch19
  %61 = phi ptr [ %59, %true_branch19 ], [ %60, %false_branch20 ]
  call void @__GLPrint(ptr %61)
  %62 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %63 = load i64, ptr %62, align 4
  %is_type_check29 = icmp eq i64 %63, 3
  br i1 %is_type_check29, label %true_branch26, label %false_branch27

true_branch23:                                    ; preds = %merge_branch28
  %64 = getelementptr %SchemeObject, ptr %73, i32 0, i32 4
  %65 = load ptr, ptr %64, align 8
  br label %merge_branch25

false_branch24:                                   ; preds = %merge_branch28
  %66 = phi ptr [ %73, %merge_branch28 ]
  br label %merge_branch25

merge_branch25:                                   ; preds = %false_branch24, %true_branch23
  %67 = phi ptr [ %65, %true_branch23 ], [ %66, %false_branch24 ]
  call void @__GLPrint(ptr %67)
  %68 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %69 = load i64, ptr %68, align 4
  %is_type_check37 = icmp eq i64 %69, 3
  br i1 %is_type_check37, label %true_branch34, label %false_branch35

true_branch26:                                    ; preds = %merge_branch21
  %70 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 4
  %71 = load ptr, ptr %70, align 8
  br label %merge_branch28

false_branch27:                                   ; preds = %merge_branch21
  %72 = phi ptr [ %variable, %merge_branch21 ]
  br label %merge_branch28

merge_branch28:                                   ; preds = %false_branch27, %true_branch26
  %73 = phi ptr [ %71, %true_branch26 ], [ %72, %false_branch27 ]
  %74 = getelementptr %SchemeObject, ptr %73, i32 0, i32 0
  %75 = load i64, ptr %74, align 4
  %is_type_check30 = icmp eq i64 %75, 3
  br i1 %is_type_check30, label %true_branch23, label %false_branch24

true_branch31:                                    ; preds = %merge_branch36
  %76 = getelementptr %SchemeObject, ptr %87, i32 0, i32 5
  %77 = load ptr, ptr %76, align 8
  br label %merge_branch33

false_branch32:                                   ; preds = %merge_branch36
  %78 = alloca %SchemeObject, align 8
  %79 = getelementptr %SchemeObject, ptr %78, i32 0, i32 0
  store i64 3, ptr %79, align 4
  br label %merge_branch33

merge_branch33:                                   ; preds = %false_branch32, %true_branch31
  %80 = phi ptr [ %77, %true_branch31 ], [ %78, %false_branch32 ]
  call void @__GLPrint(ptr %80)
  %81 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %82 = load i64, ptr %81, align 4
  %is_type_check48 = icmp eq i64 %82, 3
  br i1 %is_type_check48, label %true_branch45, label %false_branch46

true_branch34:                                    ; preds = %merge_branch25
  %83 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %84 = load ptr, ptr %83, align 8
  br label %merge_branch36

false_branch35:                                   ; preds = %merge_branch25
  %85 = alloca %SchemeObject, align 8
  %86 = getelementptr %SchemeObject, ptr %85, i32 0, i32 0
  store i64 3, ptr %86, align 4
  br label %merge_branch36

merge_branch36:                                   ; preds = %false_branch35, %true_branch34
  %87 = phi ptr [ %84, %true_branch34 ], [ %85, %false_branch35 ]
  %88 = getelementptr %SchemeObject, ptr %87, i32 0, i32 0
  %89 = load i64, ptr %88, align 4
  %is_type_check38 = icmp eq i64 %89, 3
  br i1 %is_type_check38, label %true_branch31, label %false_branch32

true_branch39:                                    ; preds = %merge_branch44
  %90 = getelementptr %SchemeObject, ptr %98, i32 0, i32 4
  %91 = load ptr, ptr %90, align 8
  br label %merge_branch41

false_branch40:                                   ; preds = %merge_branch44
  %92 = phi ptr [ %98, %merge_branch44 ]
  br label %merge_branch41

merge_branch41:                                   ; preds = %false_branch40, %true_branch39
  %93 = phi ptr [ %91, %true_branch39 ], [ %92, %false_branch40 ]
  call void @__GLPrint(ptr %93)
  ret i32 0

true_branch42:                                    ; preds = %merge_branch47
  %94 = getelementptr %SchemeObject, ptr %105, i32 0, i32 5
  %95 = load ptr, ptr %94, align 8
  br label %merge_branch44

false_branch43:                                   ; preds = %merge_branch47
  %96 = alloca %SchemeObject, align 8
  %97 = getelementptr %SchemeObject, ptr %96, i32 0, i32 0
  store i64 3, ptr %97, align 4
  br label %merge_branch44

merge_branch44:                                   ; preds = %false_branch43, %true_branch42
  %98 = phi ptr [ %95, %true_branch42 ], [ %96, %false_branch43 ]
  %99 = getelementptr %SchemeObject, ptr %98, i32 0, i32 0
  %100 = load i64, ptr %99, align 4
  %is_type_check50 = icmp eq i64 %100, 3
  br i1 %is_type_check50, label %true_branch39, label %false_branch40

true_branch45:                                    ; preds = %merge_branch33
  %101 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 5
  %102 = load ptr, ptr %101, align 8
  br label %merge_branch47

false_branch46:                                   ; preds = %merge_branch33
  %103 = alloca %SchemeObject, align 8
  %104 = getelementptr %SchemeObject, ptr %103, i32 0, i32 0
  store i64 3, ptr %104, align 4
  br label %merge_branch47

merge_branch47:                                   ; preds = %false_branch46, %true_branch45
  %105 = phi ptr [ %102, %true_branch45 ], [ %103, %false_branch46 ]
  %106 = getelementptr %SchemeObject, ptr %105, i32 0, i32 0
  %107 = load i64, ptr %106, align 4
  %is_type_check49 = icmp eq i64 %107, 3
  br i1 %is_type_check49, label %true_branch42, label %false_branch43
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
