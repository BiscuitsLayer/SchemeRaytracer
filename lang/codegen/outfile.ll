; ModuleID = 'outfile.ll'
source_filename = "outfile.ll"

%SchemeObject = type { i64, i64, i1, ptr, ptr, ptr }

define i32 @main() {
entry:
  call void @__GLInit()
  %0 = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0, i32 0
  store i64 3, ptr %1, align 4
  br label %condition_branch

condition_branch:                                 ; preds = %merge_branch3, %entry
  %is-open = alloca %SchemeObject, align 8
  %2 = call %SchemeObject @__GLIsOpen()
  store %SchemeObject %2, ptr %is-open, align 8
  %3 = getelementptr %SchemeObject, ptr %is-open, i32 0, i32 0
  %4 = load i64, ptr %3, align 4
  %5 = icmp eq i64 %4, 1
  call void @__GLAssert(i1 %5)
  %6 = getelementptr %SchemeObject, ptr %is-open, i32 0, i32 2
  %7 = load i1, ptr %6, align 1
  br i1 %7, label %loop_branch, label %merge_branch

loop_branch:                                      ; preds = %condition_branch
  call void @__GLClear()
  %8 = alloca %SchemeObject, align 8
  %9 = getelementptr %SchemeObject, ptr %8, i32 0, i32 0
  store i64 3, ptr %9, align 4
  %number = alloca %SchemeObject, align 8
  %10 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %10, align 4
  %11 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 0, ptr %11, align 4
  %variable = alloca %SchemeObject, align 8
  %12 = getelementptr %SchemeObject, ptr %number, i32 0
  %13 = load %SchemeObject, ptr %12, align 8
  store %SchemeObject %13, ptr %variable, align 8
  br label %condition_branch1

merge_branch:                                     ; preds = %condition_branch
  call void @__GLFinish()
  %14 = alloca %SchemeObject, align 8
  %15 = getelementptr %SchemeObject, ptr %14, i32 0, i32 0
  store i64 3, ptr %15, align 4
  ret i32 0

condition_branch1:                                ; preds = %merge_branch11, %loop_branch
  br label %comparison_branch

loop_branch2:                                     ; preds = %merge_branch4
  %number7 = alloca %SchemeObject, align 8
  %16 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 0
  store i64 0, ptr %16, align 4
  %17 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 0, ptr %17, align 4
  %variable8 = alloca %SchemeObject, align 8
  %18 = getelementptr %SchemeObject, ptr %number7, i32 0
  %19 = load %SchemeObject, ptr %18, align 8
  store %SchemeObject %19, ptr %variable8, align 8
  br label %condition_branch9

merge_branch3:                                    ; preds = %merge_branch4
  call void @__GLDraw()
  %20 = alloca %SchemeObject, align 8
  %21 = getelementptr %SchemeObject, ptr %20, i32 0, i32 0
  store i64 3, ptr %21, align 4
  br label %condition_branch

comparison_branch:                                ; preds = %condition_branch1
  %22 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %23 = load i64, ptr %22, align 4
  %24 = icmp eq i64 %23, 0
  call void @__GLAssert(i1 %24)
  %number5 = alloca %SchemeObject, align 8
  %25 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  store i64 0, ptr %25, align 4
  %26 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 10000, ptr %26, align 4
  %27 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  %28 = load i64, ptr %27, align 4
  %29 = icmp eq i64 %28, 0
  call void @__GLAssert(i1 %29)
  %30 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 1
  %31 = load i64, ptr %30, align 4
  %32 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  %33 = load i64, ptr %32, align 4
  %34 = icmp sge i64 %31, %33
  br i1 %34, label %false_branch, label %true_branch

true_branch:                                      ; preds = %comparison_branch
  %boolean = alloca %SchemeObject, align 8
  %35 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %35, align 4
  %36 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %36, align 1
  br label %merge_branch4

false_branch:                                     ; preds = %comparison_branch
  %boolean6 = alloca %SchemeObject, align 8
  %37 = getelementptr %SchemeObject, ptr %boolean6, i32 0, i32 0
  store i64 1, ptr %37, align 4
  %38 = getelementptr %SchemeObject, ptr %boolean6, i32 0, i32 2
  store i1 false, ptr %38, align 1
  br label %merge_branch4

merge_branch4:                                    ; preds = %false_branch, %true_branch
  %39 = phi ptr [ %boolean, %true_branch ], [ %boolean6, %false_branch ]
  %40 = getelementptr %SchemeObject, ptr %39, i32 0, i32 0
  %41 = load i64, ptr %40, align 4
  %42 = icmp eq i64 %41, 1
  call void @__GLAssert(i1 %42)
  %43 = getelementptr %SchemeObject, ptr %39, i32 0, i32 2
  %44 = load i1, ptr %43, align 1
  br i1 %44, label %loop_branch2, label %merge_branch3

condition_branch9:                                ; preds = %merge_branch20, %loop_branch2
  br label %comparison_branch12

loop_branch10:                                    ; preds = %merge_branch15
  br label %comparison_branch21

merge_branch11:                                   ; preds = %merge_branch15
  %number35 = alloca %SchemeObject, align 8
  %45 = getelementptr %SchemeObject, ptr %number35, i32 0, i32 0
  store i64 0, ptr %45, align 4
  %46 = getelementptr %SchemeObject, ptr %number35, i32 0, i32 1
  store i64 0, ptr %46, align 4
  %47 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %48 = load i64, ptr %47, align 4
  %49 = icmp eq i64 %48, 0
  call void @__GLAssert(i1 %49)
  %50 = getelementptr %SchemeObject, ptr %number35, i32 0, i32 1
  %51 = load i64, ptr %50, align 4
  %52 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 1
  %53 = load i64, ptr %52, align 4
  %54 = add i64 %51, %53
  %55 = getelementptr %SchemeObject, ptr %number35, i32 0, i32 1
  store i64 %54, ptr %55, align 4
  %number36 = alloca %SchemeObject, align 8
  %56 = getelementptr %SchemeObject, ptr %number36, i32 0, i32 0
  store i64 0, ptr %56, align 4
  %57 = getelementptr %SchemeObject, ptr %number36, i32 0, i32 1
  store i64 100, ptr %57, align 4
  %58 = getelementptr %SchemeObject, ptr %number36, i32 0, i32 0
  %59 = load i64, ptr %58, align 4
  %60 = icmp eq i64 %59, 0
  call void @__GLAssert(i1 %60)
  %61 = getelementptr %SchemeObject, ptr %number35, i32 0, i32 1
  %62 = load i64, ptr %61, align 4
  %63 = getelementptr %SchemeObject, ptr %number36, i32 0, i32 1
  %64 = load i64, ptr %63, align 4
  %65 = add i64 %62, %64
  %66 = getelementptr %SchemeObject, ptr %number35, i32 0, i32 1
  store i64 %65, ptr %66, align 4
  %67 = getelementptr %SchemeObject, ptr %number35, i32 0
  %68 = load %SchemeObject, ptr %67, align 8
  store %SchemeObject %68, ptr %variable, align 8
  br label %condition_branch1

comparison_branch12:                              ; preds = %condition_branch9
  %69 = getelementptr %SchemeObject, ptr %variable8, i32 0, i32 0
  %70 = load i64, ptr %69, align 4
  %71 = icmp eq i64 %70, 0
  call void @__GLAssert(i1 %71)
  %number16 = alloca %SchemeObject, align 8
  %72 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 0
  store i64 0, ptr %72, align 4
  %73 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  store i64 10000, ptr %73, align 4
  %74 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 0
  %75 = load i64, ptr %74, align 4
  %76 = icmp eq i64 %75, 0
  call void @__GLAssert(i1 %76)
  %77 = getelementptr %SchemeObject, ptr %variable8, i32 0, i32 1
  %78 = load i64, ptr %77, align 4
  %79 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  %80 = load i64, ptr %79, align 4
  %81 = icmp sge i64 %78, %80
  br i1 %81, label %false_branch14, label %true_branch13

true_branch13:                                    ; preds = %comparison_branch12
  %boolean17 = alloca %SchemeObject, align 8
  %82 = getelementptr %SchemeObject, ptr %boolean17, i32 0, i32 0
  store i64 1, ptr %82, align 4
  %83 = getelementptr %SchemeObject, ptr %boolean17, i32 0, i32 2
  store i1 true, ptr %83, align 1
  br label %merge_branch15

false_branch14:                                   ; preds = %comparison_branch12
  %boolean18 = alloca %SchemeObject, align 8
  %84 = getelementptr %SchemeObject, ptr %boolean18, i32 0, i32 0
  store i64 1, ptr %84, align 4
  %85 = getelementptr %SchemeObject, ptr %boolean18, i32 0, i32 2
  store i1 false, ptr %85, align 1
  br label %merge_branch15

merge_branch15:                                   ; preds = %false_branch14, %true_branch13
  %86 = phi ptr [ %boolean17, %true_branch13 ], [ %boolean18, %false_branch14 ]
  %87 = getelementptr %SchemeObject, ptr %86, i32 0, i32 0
  %88 = load i64, ptr %87, align 4
  %89 = icmp eq i64 %88, 1
  call void @__GLAssert(i1 %89)
  %90 = getelementptr %SchemeObject, ptr %86, i32 0, i32 2
  %91 = load i1, ptr %90, align 1
  br i1 %91, label %loop_branch10, label %merge_branch11

true_branch19:                                    ; preds = %merge_branch24
  call void @__GLDraw()
  %92 = alloca %SchemeObject, align 8
  %93 = getelementptr %SchemeObject, ptr %92, i32 0, i32 0
  store i64 3, ptr %93, align 4
  br label %merge_branch20

merge_branch20:                                   ; preds = %true_branch19, %merge_branch24
  %94 = phi ptr [ %92, %true_branch19 ]
  %number30 = alloca %SchemeObject, align 8
  %95 = getelementptr %SchemeObject, ptr %number30, i32 0, i32 0
  store i64 0, ptr %95, align 4
  %96 = getelementptr %SchemeObject, ptr %number30, i32 0, i32 1
  store i64 25500, ptr %96, align 4
  %number31 = alloca %SchemeObject, align 8
  %97 = getelementptr %SchemeObject, ptr %number31, i32 0, i32 0
  store i64 0, ptr %97, align 4
  %98 = getelementptr %SchemeObject, ptr %number31, i32 0, i32 1
  store i64 25500, ptr %98, align 4
  %number32 = alloca %SchemeObject, align 8
  %99 = getelementptr %SchemeObject, ptr %number32, i32 0, i32 0
  store i64 0, ptr %99, align 4
  %100 = getelementptr %SchemeObject, ptr %number32, i32 0, i32 1
  store i64 25500, ptr %100, align 4
  call void @__GLPutPixel(ptr %variable, ptr %variable8, ptr %number30, ptr %number31, ptr %number32)
  %101 = alloca %SchemeObject, align 8
  %102 = getelementptr %SchemeObject, ptr %101, i32 0, i32 0
  store i64 3, ptr %102, align 4
  %number33 = alloca %SchemeObject, align 8
  %103 = getelementptr %SchemeObject, ptr %number33, i32 0, i32 0
  store i64 0, ptr %103, align 4
  %104 = getelementptr %SchemeObject, ptr %number33, i32 0, i32 1
  store i64 0, ptr %104, align 4
  %105 = getelementptr %SchemeObject, ptr %variable8, i32 0, i32 0
  %106 = load i64, ptr %105, align 4
  %107 = icmp eq i64 %106, 0
  call void @__GLAssert(i1 %107)
  %108 = getelementptr %SchemeObject, ptr %number33, i32 0, i32 1
  %109 = load i64, ptr %108, align 4
  %110 = getelementptr %SchemeObject, ptr %variable8, i32 0, i32 1
  %111 = load i64, ptr %110, align 4
  %112 = add i64 %109, %111
  %113 = getelementptr %SchemeObject, ptr %number33, i32 0, i32 1
  store i64 %112, ptr %113, align 4
  %number34 = alloca %SchemeObject, align 8
  %114 = getelementptr %SchemeObject, ptr %number34, i32 0, i32 0
  store i64 0, ptr %114, align 4
  %115 = getelementptr %SchemeObject, ptr %number34, i32 0, i32 1
  store i64 100, ptr %115, align 4
  %116 = getelementptr %SchemeObject, ptr %number34, i32 0, i32 0
  %117 = load i64, ptr %116, align 4
  %118 = icmp eq i64 %117, 0
  call void @__GLAssert(i1 %118)
  %119 = getelementptr %SchemeObject, ptr %number33, i32 0, i32 1
  %120 = load i64, ptr %119, align 4
  %121 = getelementptr %SchemeObject, ptr %number34, i32 0, i32 1
  %122 = load i64, ptr %121, align 4
  %123 = add i64 %120, %122
  %124 = getelementptr %SchemeObject, ptr %number33, i32 0, i32 1
  store i64 %123, ptr %124, align 4
  %125 = getelementptr %SchemeObject, ptr %number33, i32 0
  %126 = load %SchemeObject, ptr %125, align 8
  store %SchemeObject %126, ptr %variable8, align 8
  br label %condition_branch9

comparison_branch21:                              ; preds = %loop_branch10
  %127 = getelementptr %SchemeObject, ptr %variable8, i32 0, i32 0
  %128 = load i64, ptr %127, align 4
  %129 = icmp eq i64 %128, 0
  call void @__GLAssert(i1 %129)
  %130 = getelementptr %SchemeObject, ptr %variable8, i32 0, i32 1
  %131 = load i64, ptr %130, align 4
  %132 = srem i64 %131, 100
  %133 = icmp eq i64 %132, 0
  call void @__GLAssert(i1 %133)
  %number25 = alloca %SchemeObject, align 8
  %134 = getelementptr %SchemeObject, ptr %number25, i32 0, i32 0
  store i64 0, ptr %134, align 4
  %135 = getelementptr %SchemeObject, ptr %number25, i32 0, i32 1
  store i64 100, ptr %135, align 4
  %136 = getelementptr %SchemeObject, ptr %number25, i32 0, i32 0
  %137 = load i64, ptr %136, align 4
  %138 = icmp eq i64 %137, 0
  call void @__GLAssert(i1 %138)
  %139 = getelementptr %SchemeObject, ptr %number25, i32 0, i32 1
  %140 = load i64, ptr %139, align 4
  %141 = srem i64 %140, 100
  %142 = icmp eq i64 %141, 0
  call void @__GLAssert(i1 %142)
  %is_zero_then_one_check = icmp ne i64 %140, 0
  br i1 %is_zero_then_one_check, label %continue_branch, label %modify_branch

true_branch22:                                    ; preds = %continue_branch
  %boolean28 = alloca %SchemeObject, align 8
  %143 = getelementptr %SchemeObject, ptr %boolean28, i32 0, i32 0
  store i64 1, ptr %143, align 4
  %144 = getelementptr %SchemeObject, ptr %boolean28, i32 0, i32 2
  store i1 true, ptr %144, align 1
  br label %merge_branch24

false_branch23:                                   ; preds = %continue_branch
  %boolean29 = alloca %SchemeObject, align 8
  %145 = getelementptr %SchemeObject, ptr %boolean29, i32 0, i32 0
  store i64 1, ptr %145, align 4
  %146 = getelementptr %SchemeObject, ptr %boolean29, i32 0, i32 2
  store i1 false, ptr %146, align 1
  br label %merge_branch24

merge_branch24:                                   ; preds = %false_branch23, %true_branch22
  %147 = phi ptr [ %boolean28, %true_branch22 ], [ %boolean29, %false_branch23 ]
  %148 = getelementptr %SchemeObject, ptr %147, i32 0, i32 0
  %149 = load i64, ptr %148, align 4
  %150 = icmp eq i64 %149, 1
  call void @__GLAssert(i1 %150)
  %151 = getelementptr %SchemeObject, ptr %147, i32 0, i32 2
  %152 = load i1, ptr %151, align 1
  br i1 %152, label %true_branch19, label %merge_branch20

modify_branch:                                    ; preds = %comparison_branch21
  br label %continue_branch

continue_branch:                                  ; preds = %modify_branch, %comparison_branch21
  %153 = phi i64 [ 1, %modify_branch ], [ %140, %comparison_branch21 ]
  %154 = srem i64 %131, %153
  %number26 = alloca %SchemeObject, align 8
  %155 = getelementptr %SchemeObject, ptr %number26, i32 0, i32 0
  store i64 0, ptr %155, align 4
  %156 = getelementptr %SchemeObject, ptr %number26, i32 0, i32 1
  store i64 %154, ptr %156, align 4
  %157 = getelementptr %SchemeObject, ptr %number26, i32 0, i32 0
  %158 = load i64, ptr %157, align 4
  %159 = icmp eq i64 %158, 0
  call void @__GLAssert(i1 %159)
  %number27 = alloca %SchemeObject, align 8
  %160 = getelementptr %SchemeObject, ptr %number27, i32 0, i32 0
  store i64 0, ptr %160, align 4
  %161 = getelementptr %SchemeObject, ptr %number27, i32 0, i32 1
  store i64 0, ptr %161, align 4
  %162 = getelementptr %SchemeObject, ptr %number27, i32 0, i32 0
  %163 = load i64, ptr %162, align 4
  %164 = icmp eq i64 %163, 0
  call void @__GLAssert(i1 %164)
  %165 = getelementptr %SchemeObject, ptr %number26, i32 0, i32 1
  %166 = load i64, ptr %165, align 4
  %167 = getelementptr %SchemeObject, ptr %number27, i32 0, i32 1
  %168 = load i64, ptr %167, align 4
  %169 = icmp ne i64 %166, %168
  br i1 %169, label %false_branch23, label %true_branch22
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
