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
  %8 = call ptr @llvm.stacksave()
  call void @__GLClear()
  %9 = alloca %SchemeObject, align 8
  %10 = getelementptr %SchemeObject, ptr %9, i32 0, i32 0
  store i64 3, ptr %10, align 4
  %number = alloca %SchemeObject, align 8
  %11 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %11, align 4
  %12 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 0, ptr %12, align 4
  %variable = alloca %SchemeObject, align 8
  %13 = getelementptr %SchemeObject, ptr %number, i32 0
  %14 = load %SchemeObject, ptr %13, align 8
  store %SchemeObject %14, ptr %variable, align 8
  br label %condition_branch1

merge_branch:                                     ; preds = %condition_branch
  call void @__GLFinish()
  %15 = alloca %SchemeObject, align 8
  %16 = getelementptr %SchemeObject, ptr %15, i32 0, i32 0
  store i64 3, ptr %16, align 4
  ret i32 0

condition_branch1:                                ; preds = %merge_branch17, %loop_branch
  br label %comparison_branch

loop_branch2:                                     ; preds = %end_branch
  %17 = call ptr @llvm.stacksave()
  %number13 = alloca %SchemeObject, align 8
  %18 = getelementptr %SchemeObject, ptr %number13, i32 0, i32 0
  store i64 0, ptr %18, align 4
  %19 = getelementptr %SchemeObject, ptr %number13, i32 0, i32 1
  store i64 0, ptr %19, align 4
  %variable14 = alloca %SchemeObject, align 8
  %20 = getelementptr %SchemeObject, ptr %number13, i32 0
  %21 = load %SchemeObject, ptr %20, align 8
  store %SchemeObject %21, ptr %variable14, align 8
  br label %condition_branch15

merge_branch3:                                    ; preds = %end_branch
  call void @__GLDraw()
  %22 = alloca %SchemeObject, align 8
  %23 = getelementptr %SchemeObject, ptr %22, i32 0, i32 0
  store i64 3, ptr %23, align 4
  call void @llvm.stackrestore(ptr %8)
  br label %condition_branch

end_branch:                                       ; preds = %continue_branch8, %is_boolean_smth_branch10, %is_boolean_smth_branch
  %24 = phi ptr [ %57, %is_boolean_smth_branch ], [ %62, %is_boolean_smth_branch10 ], [ %58, %continue_branch8 ]
  %25 = getelementptr %SchemeObject, ptr %24, i32 0, i32 0
  %26 = load i64, ptr %25, align 4
  %27 = icmp eq i64 %26, 1
  call void @__GLAssert(i1 %27)
  %28 = getelementptr %SchemeObject, ptr %24, i32 0, i32 2
  %29 = load i1, ptr %28, align 1
  br i1 %29, label %loop_branch2, label %merge_branch3

comparison_branch:                                ; preds = %condition_branch1
  %30 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %31 = load i64, ptr %30, align 4
  %32 = icmp eq i64 %31, 0
  call void @__GLAssert(i1 %32)
  %number5 = alloca %SchemeObject, align 8
  %33 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  store i64 0, ptr %33, align 4
  %34 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 10000, ptr %34, align 4
  %35 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  %36 = load i64, ptr %35, align 4
  %37 = icmp eq i64 %36, 0
  call void @__GLAssert(i1 %37)
  %38 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 1
  %39 = load i64, ptr %38, align 4
  %40 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  %41 = load i64, ptr %40, align 4
  %42 = icmp sge i64 %39, %41
  br i1 %42, label %false_branch, label %true_branch

true_branch:                                      ; preds = %comparison_branch
  %boolean = alloca %SchemeObject, align 8
  %43 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %43, align 4
  %44 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %44, align 1
  br label %merge_branch4

false_branch:                                     ; preds = %comparison_branch
  %boolean6 = alloca %SchemeObject, align 8
  %45 = getelementptr %SchemeObject, ptr %boolean6, i32 0, i32 0
  store i64 1, ptr %45, align 4
  %46 = getelementptr %SchemeObject, ptr %boolean6, i32 0, i32 2
  store i1 false, ptr %46, align 1
  br label %merge_branch4

merge_branch4:                                    ; preds = %false_branch, %true_branch
  %47 = phi ptr [ %boolean, %true_branch ], [ %boolean6, %false_branch ]
  %48 = getelementptr %SchemeObject, ptr %47, i32 0, i32 0
  %49 = load i64, ptr %48, align 4
  %is_boolean_check = icmp eq i64 %49, 1
  br i1 %is_boolean_check, label %is_boolean_branch, label %continue_branch

continue_branch:                                  ; preds = %is_boolean_branch, %merge_branch4
  %50 = phi ptr [ %47, %merge_branch4 ], [ %56, %is_boolean_branch ]
  %is-open7 = alloca %SchemeObject, align 8
  %51 = call %SchemeObject @__GLIsOpen()
  store %SchemeObject %51, ptr %is-open7, align 8
  %52 = getelementptr %SchemeObject, ptr %is-open7, i32 0, i32 0
  %53 = load i64, ptr %52, align 4
  %is_boolean_check11 = icmp eq i64 %53, 1
  br i1 %is_boolean_check11, label %is_boolean_branch9, label %continue_branch8

is_boolean_branch:                                ; preds = %merge_branch4
  %54 = getelementptr %SchemeObject, ptr %47, i32 0, i32 2
  %55 = load i1, ptr %54, align 1
  %is_boolean_smth_check = icmp eq i1 %55, false
  %56 = phi ptr [ %47, %merge_branch4 ]
  br i1 %is_boolean_smth_check, label %is_boolean_smth_branch, label %continue_branch

is_boolean_smth_branch:                           ; preds = %is_boolean_branch
  %57 = phi ptr [ %56, %is_boolean_branch ]
  br label %end_branch

continue_branch8:                                 ; preds = %is_boolean_branch9, %continue_branch
  %58 = phi ptr [ %is-open7, %continue_branch ], [ %61, %is_boolean_branch9 ]
  br label %end_branch

is_boolean_branch9:                               ; preds = %continue_branch
  %59 = getelementptr %SchemeObject, ptr %is-open7, i32 0, i32 2
  %60 = load i1, ptr %59, align 1
  %is_boolean_smth_check12 = icmp eq i1 %60, false
  %61 = phi ptr [ %is-open7, %continue_branch ]
  br i1 %is_boolean_smth_check12, label %is_boolean_smth_branch10, label %continue_branch8

is_boolean_smth_branch10:                         ; preds = %is_boolean_branch9
  %62 = phi ptr [ %61, %is_boolean_branch9 ]
  br label %end_branch

condition_branch15:                               ; preds = %merge_branch38, %loop_branch2
  br label %comparison_branch19

loop_branch16:                                    ; preds = %end_branch18
  %63 = call ptr @llvm.stacksave()
  br label %comparison_branch39

merge_branch17:                                   ; preds = %end_branch18
  %number54 = alloca %SchemeObject, align 8
  %64 = getelementptr %SchemeObject, ptr %number54, i32 0, i32 0
  store i64 0, ptr %64, align 4
  %65 = getelementptr %SchemeObject, ptr %number54, i32 0, i32 1
  store i64 0, ptr %65, align 4
  %66 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %67 = load i64, ptr %66, align 4
  %68 = icmp eq i64 %67, 0
  call void @__GLAssert(i1 %68)
  %69 = getelementptr %SchemeObject, ptr %number54, i32 0, i32 1
  %70 = load i64, ptr %69, align 4
  %71 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 1
  %72 = load i64, ptr %71, align 4
  %73 = add i64 %70, %72
  %74 = getelementptr %SchemeObject, ptr %number54, i32 0, i32 1
  store i64 %73, ptr %74, align 4
  %number55 = alloca %SchemeObject, align 8
  %75 = getelementptr %SchemeObject, ptr %number55, i32 0, i32 0
  store i64 0, ptr %75, align 4
  %76 = getelementptr %SchemeObject, ptr %number55, i32 0, i32 1
  store i64 100, ptr %76, align 4
  %77 = getelementptr %SchemeObject, ptr %number55, i32 0, i32 0
  %78 = load i64, ptr %77, align 4
  %79 = icmp eq i64 %78, 0
  call void @__GLAssert(i1 %79)
  %80 = getelementptr %SchemeObject, ptr %number54, i32 0, i32 1
  %81 = load i64, ptr %80, align 4
  %82 = getelementptr %SchemeObject, ptr %number55, i32 0, i32 1
  %83 = load i64, ptr %82, align 4
  %84 = add i64 %81, %83
  %85 = getelementptr %SchemeObject, ptr %number54, i32 0, i32 1
  store i64 %84, ptr %85, align 4
  %86 = getelementptr %SchemeObject, ptr %number54, i32 0
  %87 = load %SchemeObject, ptr %86, align 8
  store %SchemeObject %87, ptr %variable, align 8
  call void @llvm.stackrestore(ptr %17)
  br label %condition_branch1

end_branch18:                                     ; preds = %continue_branch32, %is_boolean_smth_branch34, %is_boolean_smth_branch28
  %88 = phi ptr [ %121, %is_boolean_smth_branch28 ], [ %126, %is_boolean_smth_branch34 ], [ %122, %continue_branch32 ]
  %89 = getelementptr %SchemeObject, ptr %88, i32 0, i32 0
  %90 = load i64, ptr %89, align 4
  %91 = icmp eq i64 %90, 1
  call void @__GLAssert(i1 %91)
  %92 = getelementptr %SchemeObject, ptr %88, i32 0, i32 2
  %93 = load i1, ptr %92, align 1
  br i1 %93, label %loop_branch16, label %merge_branch17

comparison_branch19:                              ; preds = %condition_branch15
  %94 = getelementptr %SchemeObject, ptr %variable14, i32 0, i32 0
  %95 = load i64, ptr %94, align 4
  %96 = icmp eq i64 %95, 0
  call void @__GLAssert(i1 %96)
  %number23 = alloca %SchemeObject, align 8
  %97 = getelementptr %SchemeObject, ptr %number23, i32 0, i32 0
  store i64 0, ptr %97, align 4
  %98 = getelementptr %SchemeObject, ptr %number23, i32 0, i32 1
  store i64 10000, ptr %98, align 4
  %99 = getelementptr %SchemeObject, ptr %number23, i32 0, i32 0
  %100 = load i64, ptr %99, align 4
  %101 = icmp eq i64 %100, 0
  call void @__GLAssert(i1 %101)
  %102 = getelementptr %SchemeObject, ptr %variable14, i32 0, i32 1
  %103 = load i64, ptr %102, align 4
  %104 = getelementptr %SchemeObject, ptr %number23, i32 0, i32 1
  %105 = load i64, ptr %104, align 4
  %106 = icmp sge i64 %103, %105
  br i1 %106, label %false_branch21, label %true_branch20

true_branch20:                                    ; preds = %comparison_branch19
  %boolean24 = alloca %SchemeObject, align 8
  %107 = getelementptr %SchemeObject, ptr %boolean24, i32 0, i32 0
  store i64 1, ptr %107, align 4
  %108 = getelementptr %SchemeObject, ptr %boolean24, i32 0, i32 2
  store i1 true, ptr %108, align 1
  br label %merge_branch22

false_branch21:                                   ; preds = %comparison_branch19
  %boolean25 = alloca %SchemeObject, align 8
  %109 = getelementptr %SchemeObject, ptr %boolean25, i32 0, i32 0
  store i64 1, ptr %109, align 4
  %110 = getelementptr %SchemeObject, ptr %boolean25, i32 0, i32 2
  store i1 false, ptr %110, align 1
  br label %merge_branch22

merge_branch22:                                   ; preds = %false_branch21, %true_branch20
  %111 = phi ptr [ %boolean24, %true_branch20 ], [ %boolean25, %false_branch21 ]
  %112 = getelementptr %SchemeObject, ptr %111, i32 0, i32 0
  %113 = load i64, ptr %112, align 4
  %is_boolean_check29 = icmp eq i64 %113, 1
  br i1 %is_boolean_check29, label %is_boolean_branch27, label %continue_branch26

continue_branch26:                                ; preds = %is_boolean_branch27, %merge_branch22
  %114 = phi ptr [ %111, %merge_branch22 ], [ %120, %is_boolean_branch27 ]
  %is-open31 = alloca %SchemeObject, align 8
  %115 = call %SchemeObject @__GLIsOpen()
  store %SchemeObject %115, ptr %is-open31, align 8
  %116 = getelementptr %SchemeObject, ptr %is-open31, i32 0, i32 0
  %117 = load i64, ptr %116, align 4
  %is_boolean_check35 = icmp eq i64 %117, 1
  br i1 %is_boolean_check35, label %is_boolean_branch33, label %continue_branch32

is_boolean_branch27:                              ; preds = %merge_branch22
  %118 = getelementptr %SchemeObject, ptr %111, i32 0, i32 2
  %119 = load i1, ptr %118, align 1
  %is_boolean_smth_check30 = icmp eq i1 %119, false
  %120 = phi ptr [ %111, %merge_branch22 ]
  br i1 %is_boolean_smth_check30, label %is_boolean_smth_branch28, label %continue_branch26

is_boolean_smth_branch28:                         ; preds = %is_boolean_branch27
  %121 = phi ptr [ %120, %is_boolean_branch27 ]
  br label %end_branch18

continue_branch32:                                ; preds = %is_boolean_branch33, %continue_branch26
  %122 = phi ptr [ %is-open31, %continue_branch26 ], [ %125, %is_boolean_branch33 ]
  br label %end_branch18

is_boolean_branch33:                              ; preds = %continue_branch26
  %123 = getelementptr %SchemeObject, ptr %is-open31, i32 0, i32 2
  %124 = load i1, ptr %123, align 1
  %is_boolean_smth_check36 = icmp eq i1 %124, false
  %125 = phi ptr [ %is-open31, %continue_branch26 ]
  br i1 %is_boolean_smth_check36, label %is_boolean_smth_branch34, label %continue_branch32

is_boolean_smth_branch34:                         ; preds = %is_boolean_branch33
  %126 = phi ptr [ %125, %is_boolean_branch33 ]
  br label %end_branch18

true_branch37:                                    ; preds = %merge_branch42
  call void @__GLDraw()
  %127 = alloca %SchemeObject, align 8
  %128 = getelementptr %SchemeObject, ptr %127, i32 0, i32 0
  store i64 3, ptr %128, align 4
  br label %merge_branch38

merge_branch38:                                   ; preds = %true_branch37, %merge_branch42
  %129 = phi ptr [ %127, %true_branch37 ]
  %number49 = alloca %SchemeObject, align 8
  %130 = getelementptr %SchemeObject, ptr %number49, i32 0, i32 0
  store i64 0, ptr %130, align 4
  %131 = getelementptr %SchemeObject, ptr %number49, i32 0, i32 1
  store i64 25500, ptr %131, align 4
  %number50 = alloca %SchemeObject, align 8
  %132 = getelementptr %SchemeObject, ptr %number50, i32 0, i32 0
  store i64 0, ptr %132, align 4
  %133 = getelementptr %SchemeObject, ptr %number50, i32 0, i32 1
  store i64 25500, ptr %133, align 4
  %number51 = alloca %SchemeObject, align 8
  %134 = getelementptr %SchemeObject, ptr %number51, i32 0, i32 0
  store i64 0, ptr %134, align 4
  %135 = getelementptr %SchemeObject, ptr %number51, i32 0, i32 1
  store i64 25500, ptr %135, align 4
  call void @__GLPutPixel(ptr %variable, ptr %variable14, ptr %number49, ptr %number50, ptr %number51)
  %136 = alloca %SchemeObject, align 8
  %137 = getelementptr %SchemeObject, ptr %136, i32 0, i32 0
  store i64 3, ptr %137, align 4
  %number52 = alloca %SchemeObject, align 8
  %138 = getelementptr %SchemeObject, ptr %number52, i32 0, i32 0
  store i64 0, ptr %138, align 4
  %139 = getelementptr %SchemeObject, ptr %number52, i32 0, i32 1
  store i64 0, ptr %139, align 4
  %140 = getelementptr %SchemeObject, ptr %variable14, i32 0, i32 0
  %141 = load i64, ptr %140, align 4
  %142 = icmp eq i64 %141, 0
  call void @__GLAssert(i1 %142)
  %143 = getelementptr %SchemeObject, ptr %number52, i32 0, i32 1
  %144 = load i64, ptr %143, align 4
  %145 = getelementptr %SchemeObject, ptr %variable14, i32 0, i32 1
  %146 = load i64, ptr %145, align 4
  %147 = add i64 %144, %146
  %148 = getelementptr %SchemeObject, ptr %number52, i32 0, i32 1
  store i64 %147, ptr %148, align 4
  %number53 = alloca %SchemeObject, align 8
  %149 = getelementptr %SchemeObject, ptr %number53, i32 0, i32 0
  store i64 0, ptr %149, align 4
  %150 = getelementptr %SchemeObject, ptr %number53, i32 0, i32 1
  store i64 100, ptr %150, align 4
  %151 = getelementptr %SchemeObject, ptr %number53, i32 0, i32 0
  %152 = load i64, ptr %151, align 4
  %153 = icmp eq i64 %152, 0
  call void @__GLAssert(i1 %153)
  %154 = getelementptr %SchemeObject, ptr %number52, i32 0, i32 1
  %155 = load i64, ptr %154, align 4
  %156 = getelementptr %SchemeObject, ptr %number53, i32 0, i32 1
  %157 = load i64, ptr %156, align 4
  %158 = add i64 %155, %157
  %159 = getelementptr %SchemeObject, ptr %number52, i32 0, i32 1
  store i64 %158, ptr %159, align 4
  %160 = getelementptr %SchemeObject, ptr %number52, i32 0
  %161 = load %SchemeObject, ptr %160, align 8
  store %SchemeObject %161, ptr %variable14, align 8
  call void @llvm.stackrestore(ptr %63)
  br label %condition_branch15

comparison_branch39:                              ; preds = %loop_branch16
  %162 = getelementptr %SchemeObject, ptr %variable14, i32 0, i32 0
  %163 = load i64, ptr %162, align 4
  %164 = icmp eq i64 %163, 0
  call void @__GLAssert(i1 %164)
  %165 = getelementptr %SchemeObject, ptr %variable14, i32 0, i32 1
  %166 = load i64, ptr %165, align 4
  %167 = srem i64 %166, 100
  %168 = icmp eq i64 %167, 0
  call void @__GLAssert(i1 %168)
  %number43 = alloca %SchemeObject, align 8
  %169 = getelementptr %SchemeObject, ptr %number43, i32 0, i32 0
  store i64 0, ptr %169, align 4
  %170 = getelementptr %SchemeObject, ptr %number43, i32 0, i32 1
  store i64 100, ptr %170, align 4
  %171 = getelementptr %SchemeObject, ptr %number43, i32 0, i32 0
  %172 = load i64, ptr %171, align 4
  %173 = icmp eq i64 %172, 0
  call void @__GLAssert(i1 %173)
  %174 = getelementptr %SchemeObject, ptr %number43, i32 0, i32 1
  %175 = load i64, ptr %174, align 4
  %176 = srem i64 %175, 100
  %177 = icmp eq i64 %176, 0
  call void @__GLAssert(i1 %177)
  %is_zero_then_one_check = icmp ne i64 %175, 0
  br i1 %is_zero_then_one_check, label %continue_branch44, label %modify_branch

true_branch40:                                    ; preds = %continue_branch44
  %boolean47 = alloca %SchemeObject, align 8
  %178 = getelementptr %SchemeObject, ptr %boolean47, i32 0, i32 0
  store i64 1, ptr %178, align 4
  %179 = getelementptr %SchemeObject, ptr %boolean47, i32 0, i32 2
  store i1 true, ptr %179, align 1
  br label %merge_branch42

false_branch41:                                   ; preds = %continue_branch44
  %boolean48 = alloca %SchemeObject, align 8
  %180 = getelementptr %SchemeObject, ptr %boolean48, i32 0, i32 0
  store i64 1, ptr %180, align 4
  %181 = getelementptr %SchemeObject, ptr %boolean48, i32 0, i32 2
  store i1 false, ptr %181, align 1
  br label %merge_branch42

merge_branch42:                                   ; preds = %false_branch41, %true_branch40
  %182 = phi ptr [ %boolean47, %true_branch40 ], [ %boolean48, %false_branch41 ]
  %183 = getelementptr %SchemeObject, ptr %182, i32 0, i32 0
  %184 = load i64, ptr %183, align 4
  %185 = icmp eq i64 %184, 1
  call void @__GLAssert(i1 %185)
  %186 = getelementptr %SchemeObject, ptr %182, i32 0, i32 2
  %187 = load i1, ptr %186, align 1
  br i1 %187, label %true_branch37, label %merge_branch38

modify_branch:                                    ; preds = %comparison_branch39
  br label %continue_branch44

continue_branch44:                                ; preds = %modify_branch, %comparison_branch39
  %188 = phi i64 [ 1, %modify_branch ], [ %175, %comparison_branch39 ]
  %189 = srem i64 %166, %188
  %number45 = alloca %SchemeObject, align 8
  %190 = getelementptr %SchemeObject, ptr %number45, i32 0, i32 0
  store i64 0, ptr %190, align 4
  %191 = getelementptr %SchemeObject, ptr %number45, i32 0, i32 1
  store i64 %189, ptr %191, align 4
  %192 = getelementptr %SchemeObject, ptr %number45, i32 0, i32 0
  %193 = load i64, ptr %192, align 4
  %194 = icmp eq i64 %193, 0
  call void @__GLAssert(i1 %194)
  %number46 = alloca %SchemeObject, align 8
  %195 = getelementptr %SchemeObject, ptr %number46, i32 0, i32 0
  store i64 0, ptr %195, align 4
  %196 = getelementptr %SchemeObject, ptr %number46, i32 0, i32 1
  store i64 0, ptr %196, align 4
  %197 = getelementptr %SchemeObject, ptr %number46, i32 0, i32 0
  %198 = load i64, ptr %197, align 4
  %199 = icmp eq i64 %198, 0
  call void @__GLAssert(i1 %199)
  %200 = getelementptr %SchemeObject, ptr %number45, i32 0, i32 1
  %201 = load i64, ptr %200, align 4
  %202 = getelementptr %SchemeObject, ptr %number46, i32 0, i32 1
  %203 = load i64, ptr %202, align 4
  %204 = icmp ne i64 %201, %203
  br i1 %204, label %false_branch41, label %true_branch40
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

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare ptr @llvm.stacksave() #0

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.stackrestore(ptr) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn }
