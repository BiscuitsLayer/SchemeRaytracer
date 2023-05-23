; ModuleID = 'outfile.ll'
source_filename = "outfile.ll"

%SchemeObject = type { i32, i32, i1, i8*, %SchemeObject*, %SchemeObject* }

@type_check_symbol_global = private unnamed_addr constant [18 x i8] c"Type check failed\00", align 1
@integer_check_symbol_global = private unnamed_addr constant [21 x i8] c"Integer check failed\00", align 1

define i32 @main() {
entry:
  call void @__GLInit()
  br label %condition_branch

condition_branch:                                 ; preds = %merge_branch3, %entry
  %is-open = alloca %SchemeObject, align 8
  %0 = call %SchemeObject @__GLIsOpen()
  store %SchemeObject %0, %SchemeObject* %is-open, align 8
  %1 = getelementptr %SchemeObject, %SchemeObject* %is-open, i32 0, i32 0
  %2 = load i32, i32* %1, align 4
  %3 = icmp eq i32 %2, 1
  call void @__GLAssert(i1 %3, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %is-open)
  %4 = getelementptr %SchemeObject, %SchemeObject* %is-open, i32 0, i32 2
  %5 = load i1, i1* %4, align 1
  br i1 %5, label %loop_branch, label %merge_branch

loop_branch:                                      ; preds = %condition_branch
  %6 = call i8* @llvm.stacksave()
  call void @__GLClear()
  %number = alloca %SchemeObject, align 8
  %7 = getelementptr %SchemeObject, %SchemeObject* %number, i32 0, i32 0
  store i32 0, i32* %7, align 4
  %8 = getelementptr %SchemeObject, %SchemeObject* %number, i32 0, i32 1
  store i32 0, i32* %8, align 4
  %variable = alloca %SchemeObject, align 8
  %9 = getelementptr %SchemeObject, %SchemeObject* %number, i32 0
  %10 = load %SchemeObject, %SchemeObject* %9, align 8
  store %SchemeObject %10, %SchemeObject* %variable, align 8
  br label %condition_branch1

merge_branch:                                     ; preds = %condition_branch
  call void @__GLFinish()
  ret i32 0

condition_branch1:                                ; preds = %merge_branch17, %loop_branch
  br label %comparison_branch

loop_branch2:                                     ; preds = %end_branch
  %11 = call i8* @llvm.stacksave()
  %number13 = alloca %SchemeObject, align 8
  %12 = getelementptr %SchemeObject, %SchemeObject* %number13, i32 0, i32 0
  store i32 0, i32* %12, align 4
  %13 = getelementptr %SchemeObject, %SchemeObject* %number13, i32 0, i32 1
  store i32 0, i32* %13, align 4
  %variable14 = alloca %SchemeObject, align 8
  %14 = getelementptr %SchemeObject, %SchemeObject* %number13, i32 0
  %15 = load %SchemeObject, %SchemeObject* %14, align 8
  store %SchemeObject %15, %SchemeObject* %variable14, align 8
  br label %condition_branch15

merge_branch3:                                    ; preds = %end_branch
  call void @__GLDraw()
  call void @llvm.stackrestore(i8* %6)
  br label %condition_branch

end_branch:                                       ; preds = %continue_branch8, %is_boolean_smth_branch10, %is_boolean_smth_branch
  %16 = phi %SchemeObject* [ %49, %is_boolean_smth_branch ], [ %54, %is_boolean_smth_branch10 ], [ %50, %continue_branch8 ]
  %17 = getelementptr %SchemeObject, %SchemeObject* %16, i32 0, i32 0
  %18 = load i32, i32* %17, align 4
  %19 = icmp eq i32 %18, 1
  call void @__GLAssert(i1 %19, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %16)
  %20 = getelementptr %SchemeObject, %SchemeObject* %16, i32 0, i32 2
  %21 = load i1, i1* %20, align 1
  br i1 %21, label %loop_branch2, label %merge_branch3

comparison_branch:                                ; preds = %condition_branch1
  %22 = getelementptr %SchemeObject, %SchemeObject* %variable, i32 0, i32 0
  %23 = load i32, i32* %22, align 4
  %24 = icmp eq i32 %23, 0
  call void @__GLAssert(i1 %24, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %variable)
  %number5 = alloca %SchemeObject, align 8
  %25 = getelementptr %SchemeObject, %SchemeObject* %number5, i32 0, i32 0
  store i32 0, i32* %25, align 4
  %26 = getelementptr %SchemeObject, %SchemeObject* %number5, i32 0, i32 1
  store i32 10000, i32* %26, align 4
  %27 = getelementptr %SchemeObject, %SchemeObject* %number5, i32 0, i32 0
  %28 = load i32, i32* %27, align 4
  %29 = icmp eq i32 %28, 0
  call void @__GLAssert(i1 %29, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %number5)
  %30 = getelementptr %SchemeObject, %SchemeObject* %variable, i32 0, i32 1
  %31 = load i32, i32* %30, align 4
  %32 = getelementptr %SchemeObject, %SchemeObject* %number5, i32 0, i32 1
  %33 = load i32, i32* %32, align 4
  %34 = icmp sge i32 %31, %33
  br i1 %34, label %false_branch, label %true_branch

true_branch:                                      ; preds = %comparison_branch
  %boolean = alloca %SchemeObject, align 8
  %35 = getelementptr %SchemeObject, %SchemeObject* %boolean, i32 0, i32 0
  store i32 1, i32* %35, align 4
  %36 = getelementptr %SchemeObject, %SchemeObject* %boolean, i32 0, i32 2
  store i1 true, i1* %36, align 1
  br label %merge_branch4

false_branch:                                     ; preds = %comparison_branch
  %boolean6 = alloca %SchemeObject, align 8
  %37 = getelementptr %SchemeObject, %SchemeObject* %boolean6, i32 0, i32 0
  store i32 1, i32* %37, align 4
  %38 = getelementptr %SchemeObject, %SchemeObject* %boolean6, i32 0, i32 2
  store i1 false, i1* %38, align 1
  br label %merge_branch4

merge_branch4:                                    ; preds = %false_branch, %true_branch
  %39 = phi %SchemeObject* [ %boolean, %true_branch ], [ %boolean6, %false_branch ]
  %40 = getelementptr %SchemeObject, %SchemeObject* %39, i32 0, i32 0
  %41 = load i32, i32* %40, align 4
  %is_type_check = icmp eq i32 %41, 1
  br i1 %is_type_check, label %is_boolean_branch, label %continue_branch

continue_branch:                                  ; preds = %is_boolean_branch, %merge_branch4
  %42 = phi %SchemeObject* [ %39, %merge_branch4 ], [ %46, %is_boolean_branch ]
  %is-open7 = alloca %SchemeObject, align 8
  %43 = call %SchemeObject @__GLIsOpen()
  store %SchemeObject %43, %SchemeObject* %is-open7, align 8
  %44 = getelementptr %SchemeObject, %SchemeObject* %is-open7, i32 0, i32 0
  %45 = load i32, i32* %44, align 4
  %is_type_check11 = icmp eq i32 %45, 1
  br i1 %is_type_check11, label %is_boolean_branch9, label %continue_branch8

is_boolean_branch:                                ; preds = %merge_branch4
  %46 = phi %SchemeObject* [ %39, %merge_branch4 ]
  %47 = getelementptr %SchemeObject, %SchemeObject* %39, i32 0, i32 2
  %48 = load i1, i1* %47, align 1
  %is_boolean_smth_check = icmp eq i1 %48, false
  br i1 %is_boolean_smth_check, label %is_boolean_smth_branch, label %continue_branch

is_boolean_smth_branch:                           ; preds = %is_boolean_branch
  %49 = phi %SchemeObject* [ %46, %is_boolean_branch ]
  br label %end_branch

continue_branch8:                                 ; preds = %is_boolean_branch9, %continue_branch
  %50 = phi %SchemeObject* [ %is-open7, %continue_branch ], [ %51, %is_boolean_branch9 ]
  br label %end_branch

is_boolean_branch9:                               ; preds = %continue_branch
  %51 = phi %SchemeObject* [ %is-open7, %continue_branch ]
  %52 = getelementptr %SchemeObject, %SchemeObject* %is-open7, i32 0, i32 2
  %53 = load i1, i1* %52, align 1
  %is_boolean_smth_check12 = icmp eq i1 %53, false
  br i1 %is_boolean_smth_check12, label %is_boolean_smth_branch10, label %continue_branch8

is_boolean_smth_branch10:                         ; preds = %is_boolean_branch9
  %54 = phi %SchemeObject* [ %51, %is_boolean_branch9 ]
  br label %end_branch

condition_branch15:                               ; preds = %merge_branch38, %loop_branch2
  br label %comparison_branch19

loop_branch16:                                    ; preds = %end_branch18
  %55 = call i8* @llvm.stacksave()
  br label %comparison_branch39

merge_branch17:                                   ; preds = %end_branch18
  %number56 = alloca %SchemeObject, align 8
  %56 = getelementptr %SchemeObject, %SchemeObject* %number56, i32 0, i32 0
  store i32 0, i32* %56, align 4
  %57 = getelementptr %SchemeObject, %SchemeObject* %number56, i32 0, i32 1
  store i32 0, i32* %57, align 4
  %58 = getelementptr %SchemeObject, %SchemeObject* %variable, i32 0, i32 0
  %59 = load i32, i32* %58, align 4
  %60 = icmp eq i32 %59, 0
  call void @__GLAssert(i1 %60, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %variable)
  %61 = getelementptr %SchemeObject, %SchemeObject* %number56, i32 0, i32 1
  %62 = load i32, i32* %61, align 4
  %63 = getelementptr %SchemeObject, %SchemeObject* %variable, i32 0, i32 1
  %64 = load i32, i32* %63, align 4
  %65 = add i32 %62, %64
  %66 = getelementptr %SchemeObject, %SchemeObject* %number56, i32 0, i32 1
  store i32 %65, i32* %66, align 4
  %number57 = alloca %SchemeObject, align 8
  %67 = getelementptr %SchemeObject, %SchemeObject* %number57, i32 0, i32 0
  store i32 0, i32* %67, align 4
  %68 = getelementptr %SchemeObject, %SchemeObject* %number57, i32 0, i32 1
  store i32 100, i32* %68, align 4
  %69 = getelementptr %SchemeObject, %SchemeObject* %number57, i32 0, i32 0
  %70 = load i32, i32* %69, align 4
  %71 = icmp eq i32 %70, 0
  call void @__GLAssert(i1 %71, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %number57)
  %72 = getelementptr %SchemeObject, %SchemeObject* %number56, i32 0, i32 1
  %73 = load i32, i32* %72, align 4
  %74 = getelementptr %SchemeObject, %SchemeObject* %number57, i32 0, i32 1
  %75 = load i32, i32* %74, align 4
  %76 = add i32 %73, %75
  %77 = getelementptr %SchemeObject, %SchemeObject* %number56, i32 0, i32 1
  store i32 %76, i32* %77, align 4
  %78 = getelementptr %SchemeObject, %SchemeObject* %number56, i32 0
  %79 = load %SchemeObject, %SchemeObject* %78, align 8
  store %SchemeObject %79, %SchemeObject* %variable, align 8
  call void @llvm.stackrestore(i8* %11)
  br label %condition_branch1

end_branch18:                                     ; preds = %continue_branch32, %is_boolean_smth_branch34, %is_boolean_smth_branch28
  %80 = phi %SchemeObject* [ %113, %is_boolean_smth_branch28 ], [ %118, %is_boolean_smth_branch34 ], [ %114, %continue_branch32 ]
  %81 = getelementptr %SchemeObject, %SchemeObject* %80, i32 0, i32 0
  %82 = load i32, i32* %81, align 4
  %83 = icmp eq i32 %82, 1
  call void @__GLAssert(i1 %83, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %80)
  %84 = getelementptr %SchemeObject, %SchemeObject* %80, i32 0, i32 2
  %85 = load i1, i1* %84, align 1
  br i1 %85, label %loop_branch16, label %merge_branch17

comparison_branch19:                              ; preds = %condition_branch15
  %86 = getelementptr %SchemeObject, %SchemeObject* %variable14, i32 0, i32 0
  %87 = load i32, i32* %86, align 4
  %88 = icmp eq i32 %87, 0
  call void @__GLAssert(i1 %88, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %variable14)
  %number23 = alloca %SchemeObject, align 8
  %89 = getelementptr %SchemeObject, %SchemeObject* %number23, i32 0, i32 0
  store i32 0, i32* %89, align 4
  %90 = getelementptr %SchemeObject, %SchemeObject* %number23, i32 0, i32 1
  store i32 10000, i32* %90, align 4
  %91 = getelementptr %SchemeObject, %SchemeObject* %number23, i32 0, i32 0
  %92 = load i32, i32* %91, align 4
  %93 = icmp eq i32 %92, 0
  call void @__GLAssert(i1 %93, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %number23)
  %94 = getelementptr %SchemeObject, %SchemeObject* %variable14, i32 0, i32 1
  %95 = load i32, i32* %94, align 4
  %96 = getelementptr %SchemeObject, %SchemeObject* %number23, i32 0, i32 1
  %97 = load i32, i32* %96, align 4
  %98 = icmp sge i32 %95, %97
  br i1 %98, label %false_branch21, label %true_branch20

true_branch20:                                    ; preds = %comparison_branch19
  %boolean24 = alloca %SchemeObject, align 8
  %99 = getelementptr %SchemeObject, %SchemeObject* %boolean24, i32 0, i32 0
  store i32 1, i32* %99, align 4
  %100 = getelementptr %SchemeObject, %SchemeObject* %boolean24, i32 0, i32 2
  store i1 true, i1* %100, align 1
  br label %merge_branch22

false_branch21:                                   ; preds = %comparison_branch19
  %boolean25 = alloca %SchemeObject, align 8
  %101 = getelementptr %SchemeObject, %SchemeObject* %boolean25, i32 0, i32 0
  store i32 1, i32* %101, align 4
  %102 = getelementptr %SchemeObject, %SchemeObject* %boolean25, i32 0, i32 2
  store i1 false, i1* %102, align 1
  br label %merge_branch22

merge_branch22:                                   ; preds = %false_branch21, %true_branch20
  %103 = phi %SchemeObject* [ %boolean24, %true_branch20 ], [ %boolean25, %false_branch21 ]
  %104 = getelementptr %SchemeObject, %SchemeObject* %103, i32 0, i32 0
  %105 = load i32, i32* %104, align 4
  %is_type_check29 = icmp eq i32 %105, 1
  br i1 %is_type_check29, label %is_boolean_branch27, label %continue_branch26

continue_branch26:                                ; preds = %is_boolean_branch27, %merge_branch22
  %106 = phi %SchemeObject* [ %103, %merge_branch22 ], [ %110, %is_boolean_branch27 ]
  %is-open31 = alloca %SchemeObject, align 8
  %107 = call %SchemeObject @__GLIsOpen()
  store %SchemeObject %107, %SchemeObject* %is-open31, align 8
  %108 = getelementptr %SchemeObject, %SchemeObject* %is-open31, i32 0, i32 0
  %109 = load i32, i32* %108, align 4
  %is_type_check35 = icmp eq i32 %109, 1
  br i1 %is_type_check35, label %is_boolean_branch33, label %continue_branch32

is_boolean_branch27:                              ; preds = %merge_branch22
  %110 = phi %SchemeObject* [ %103, %merge_branch22 ]
  %111 = getelementptr %SchemeObject, %SchemeObject* %103, i32 0, i32 2
  %112 = load i1, i1* %111, align 1
  %is_boolean_smth_check30 = icmp eq i1 %112, false
  br i1 %is_boolean_smth_check30, label %is_boolean_smth_branch28, label %continue_branch26

is_boolean_smth_branch28:                         ; preds = %is_boolean_branch27
  %113 = phi %SchemeObject* [ %110, %is_boolean_branch27 ]
  br label %end_branch18

continue_branch32:                                ; preds = %is_boolean_branch33, %continue_branch26
  %114 = phi %SchemeObject* [ %is-open31, %continue_branch26 ], [ %115, %is_boolean_branch33 ]
  br label %end_branch18

is_boolean_branch33:                              ; preds = %continue_branch26
  %115 = phi %SchemeObject* [ %is-open31, %continue_branch26 ]
  %116 = getelementptr %SchemeObject, %SchemeObject* %is-open31, i32 0, i32 2
  %117 = load i1, i1* %116, align 1
  %is_boolean_smth_check36 = icmp eq i1 %117, false
  br i1 %is_boolean_smth_check36, label %is_boolean_smth_branch34, label %continue_branch32

is_boolean_smth_branch34:                         ; preds = %is_boolean_branch33
  %118 = phi %SchemeObject* [ %115, %is_boolean_branch33 ]
  br label %end_branch18

true_branch37:                                    ; preds = %merge_branch42
  call void @__GLDraw()
  br label %merge_branch38

merge_branch38:                                   ; preds = %true_branch37, %merge_branch42
  %119 = phi %SchemeObject* [ null, %true_branch37 ], [ null, %merge_branch42 ]
  %number49 = alloca %SchemeObject, align 8
  %120 = getelementptr %SchemeObject, %SchemeObject* %number49, i32 0, i32 0
  store i32 0, i32* %120, align 4
  %121 = getelementptr %SchemeObject, %SchemeObject* %number49, i32 0, i32 1
  store i32 100, i32* %121, align 4
  %122 = getelementptr %SchemeObject, %SchemeObject* %variable, i32 0, i32 0
  %123 = load i32, i32* %122, align 4
  %124 = icmp eq i32 %123, 0
  call void @__GLAssert(i1 %124, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %variable)
  %125 = getelementptr %SchemeObject, %SchemeObject* %number49, i32 0, i32 1
  %126 = load i32, i32* %125, align 4
  %127 = getelementptr %SchemeObject, %SchemeObject* %variable, i32 0, i32 1
  %128 = load i32, i32* %127, align 4
  %129 = mul i32 %126, %128
  %130 = sdiv i32 %129, 100
  %131 = getelementptr %SchemeObject, %SchemeObject* %number49, i32 0, i32 1
  store i32 %130, i32* %131, align 4
  %number50 = alloca %SchemeObject, align 8
  %132 = getelementptr %SchemeObject, %SchemeObject* %number50, i32 0, i32 0
  store i32 0, i32* %132, align 4
  %133 = getelementptr %SchemeObject, %SchemeObject* %number50, i32 0, i32 1
  store i32 255, i32* %133, align 4
  %134 = getelementptr %SchemeObject, %SchemeObject* %number50, i32 0, i32 0
  %135 = load i32, i32* %134, align 4
  %136 = icmp eq i32 %135, 0
  call void @__GLAssert(i1 %136, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %number50)
  %137 = getelementptr %SchemeObject, %SchemeObject* %number49, i32 0, i32 1
  %138 = load i32, i32* %137, align 4
  %139 = getelementptr %SchemeObject, %SchemeObject* %number50, i32 0, i32 1
  %140 = load i32, i32* %139, align 4
  %141 = mul i32 %138, %140
  %142 = sdiv i32 %141, 100
  %143 = getelementptr %SchemeObject, %SchemeObject* %number49, i32 0, i32 1
  store i32 %142, i32* %143, align 4
  %number51 = alloca %SchemeObject, align 8
  %144 = getelementptr %SchemeObject, %SchemeObject* %number51, i32 0, i32 0
  store i32 0, i32* %144, align 4
  %145 = getelementptr %SchemeObject, %SchemeObject* %number51, i32 0, i32 1
  store i32 100, i32* %145, align 4
  %146 = getelementptr %SchemeObject, %SchemeObject* %variable14, i32 0, i32 0
  %147 = load i32, i32* %146, align 4
  %148 = icmp eq i32 %147, 0
  call void @__GLAssert(i1 %148, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %variable14)
  %149 = getelementptr %SchemeObject, %SchemeObject* %number51, i32 0, i32 1
  %150 = load i32, i32* %149, align 4
  %151 = getelementptr %SchemeObject, %SchemeObject* %variable14, i32 0, i32 1
  %152 = load i32, i32* %151, align 4
  %153 = mul i32 %150, %152
  %154 = sdiv i32 %153, 100
  %155 = getelementptr %SchemeObject, %SchemeObject* %number51, i32 0, i32 1
  store i32 %154, i32* %155, align 4
  %number52 = alloca %SchemeObject, align 8
  %156 = getelementptr %SchemeObject, %SchemeObject* %number52, i32 0, i32 0
  store i32 0, i32* %156, align 4
  %157 = getelementptr %SchemeObject, %SchemeObject* %number52, i32 0, i32 1
  store i32 255, i32* %157, align 4
  %158 = getelementptr %SchemeObject, %SchemeObject* %number52, i32 0, i32 0
  %159 = load i32, i32* %158, align 4
  %160 = icmp eq i32 %159, 0
  call void @__GLAssert(i1 %160, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %number52)
  %161 = getelementptr %SchemeObject, %SchemeObject* %number51, i32 0, i32 1
  %162 = load i32, i32* %161, align 4
  %163 = getelementptr %SchemeObject, %SchemeObject* %number52, i32 0, i32 1
  %164 = load i32, i32* %163, align 4
  %165 = mul i32 %162, %164
  %166 = sdiv i32 %165, 100
  %167 = getelementptr %SchemeObject, %SchemeObject* %number51, i32 0, i32 1
  store i32 %166, i32* %167, align 4
  %number53 = alloca %SchemeObject, align 8
  %168 = getelementptr %SchemeObject, %SchemeObject* %number53, i32 0, i32 0
  store i32 0, i32* %168, align 4
  %169 = getelementptr %SchemeObject, %SchemeObject* %number53, i32 0, i32 1
  store i32 25500, i32* %169, align 4
  call void @__GLPutPixel(%SchemeObject* %variable, %SchemeObject* %variable14, %SchemeObject* %number49, %SchemeObject* %number51, %SchemeObject* %number53)
  %number54 = alloca %SchemeObject, align 8
  %170 = getelementptr %SchemeObject, %SchemeObject* %number54, i32 0, i32 0
  store i32 0, i32* %170, align 4
  %171 = getelementptr %SchemeObject, %SchemeObject* %number54, i32 0, i32 1
  store i32 0, i32* %171, align 4
  %172 = getelementptr %SchemeObject, %SchemeObject* %variable14, i32 0, i32 0
  %173 = load i32, i32* %172, align 4
  %174 = icmp eq i32 %173, 0
  call void @__GLAssert(i1 %174, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %variable14)
  %175 = getelementptr %SchemeObject, %SchemeObject* %number54, i32 0, i32 1
  %176 = load i32, i32* %175, align 4
  %177 = getelementptr %SchemeObject, %SchemeObject* %variable14, i32 0, i32 1
  %178 = load i32, i32* %177, align 4
  %179 = add i32 %176, %178
  %180 = getelementptr %SchemeObject, %SchemeObject* %number54, i32 0, i32 1
  store i32 %179, i32* %180, align 4
  %number55 = alloca %SchemeObject, align 8
  %181 = getelementptr %SchemeObject, %SchemeObject* %number55, i32 0, i32 0
  store i32 0, i32* %181, align 4
  %182 = getelementptr %SchemeObject, %SchemeObject* %number55, i32 0, i32 1
  store i32 100, i32* %182, align 4
  %183 = getelementptr %SchemeObject, %SchemeObject* %number55, i32 0, i32 0
  %184 = load i32, i32* %183, align 4
  %185 = icmp eq i32 %184, 0
  call void @__GLAssert(i1 %185, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %number55)
  %186 = getelementptr %SchemeObject, %SchemeObject* %number54, i32 0, i32 1
  %187 = load i32, i32* %186, align 4
  %188 = getelementptr %SchemeObject, %SchemeObject* %number55, i32 0, i32 1
  %189 = load i32, i32* %188, align 4
  %190 = add i32 %187, %189
  %191 = getelementptr %SchemeObject, %SchemeObject* %number54, i32 0, i32 1
  store i32 %190, i32* %191, align 4
  %192 = getelementptr %SchemeObject, %SchemeObject* %number54, i32 0
  %193 = load %SchemeObject, %SchemeObject* %192, align 8
  store %SchemeObject %193, %SchemeObject* %variable14, align 8
  call void @llvm.stackrestore(i8* %55)
  br label %condition_branch15

comparison_branch39:                              ; preds = %loop_branch16
  %194 = getelementptr %SchemeObject, %SchemeObject* %variable14, i32 0, i32 0
  %195 = load i32, i32* %194, align 4
  %196 = icmp eq i32 %195, 0
  call void @__GLAssert(i1 %196, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %variable14)
  %197 = getelementptr %SchemeObject, %SchemeObject* %variable14, i32 0, i32 1
  %198 = load i32, i32* %197, align 4
  %199 = getelementptr %SchemeObject, %SchemeObject* %variable14, i32 0, i32 1
  %200 = load i32, i32* %199, align 4
  %201 = srem i32 %200, 100
  %202 = icmp eq i32 %201, 0
  call void @__GLAssert(i1 %202, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @integer_check_symbol_global, i32 0, i32 0), %SchemeObject* %variable14)
  %number43 = alloca %SchemeObject, align 8
  %203 = getelementptr %SchemeObject, %SchemeObject* %number43, i32 0, i32 0
  store i32 0, i32* %203, align 4
  %204 = getelementptr %SchemeObject, %SchemeObject* %number43, i32 0, i32 1
  store i32 100, i32* %204, align 4
  %205 = getelementptr %SchemeObject, %SchemeObject* %number43, i32 0, i32 0
  %206 = load i32, i32* %205, align 4
  %207 = icmp eq i32 %206, 0
  call void @__GLAssert(i1 %207, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %number43)
  %208 = getelementptr %SchemeObject, %SchemeObject* %number43, i32 0, i32 1
  %209 = load i32, i32* %208, align 4
  %210 = getelementptr %SchemeObject, %SchemeObject* %number43, i32 0, i32 1
  %211 = load i32, i32* %210, align 4
  %212 = srem i32 %211, 100
  %213 = icmp eq i32 %212, 0
  call void @__GLAssert(i1 %213, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @integer_check_symbol_global, i32 0, i32 0), %SchemeObject* %number43)
  %is_zero_then_one_check = icmp ne i32 %209, 0
  br i1 %is_zero_then_one_check, label %continue_branch44, label %modify_branch

true_branch40:                                    ; preds = %continue_branch44
  %boolean47 = alloca %SchemeObject, align 8
  %214 = getelementptr %SchemeObject, %SchemeObject* %boolean47, i32 0, i32 0
  store i32 1, i32* %214, align 4
  %215 = getelementptr %SchemeObject, %SchemeObject* %boolean47, i32 0, i32 2
  store i1 true, i1* %215, align 1
  br label %merge_branch42

false_branch41:                                   ; preds = %continue_branch44
  %boolean48 = alloca %SchemeObject, align 8
  %216 = getelementptr %SchemeObject, %SchemeObject* %boolean48, i32 0, i32 0
  store i32 1, i32* %216, align 4
  %217 = getelementptr %SchemeObject, %SchemeObject* %boolean48, i32 0, i32 2
  store i1 false, i1* %217, align 1
  br label %merge_branch42

merge_branch42:                                   ; preds = %false_branch41, %true_branch40
  %218 = phi %SchemeObject* [ %boolean47, %true_branch40 ], [ %boolean48, %false_branch41 ]
  %219 = getelementptr %SchemeObject, %SchemeObject* %218, i32 0, i32 0
  %220 = load i32, i32* %219, align 4
  %221 = icmp eq i32 %220, 1
  call void @__GLAssert(i1 %221, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %218)
  %222 = getelementptr %SchemeObject, %SchemeObject* %218, i32 0, i32 2
  %223 = load i1, i1* %222, align 1
  br i1 %223, label %true_branch37, label %merge_branch38

modify_branch:                                    ; preds = %comparison_branch39
  br label %continue_branch44

continue_branch44:                                ; preds = %modify_branch, %comparison_branch39
  %224 = phi i32 [ 1, %modify_branch ], [ %209, %comparison_branch39 ]
  %225 = srem i32 %198, %224
  %number45 = alloca %SchemeObject, align 8
  %226 = getelementptr %SchemeObject, %SchemeObject* %number45, i32 0, i32 0
  store i32 0, i32* %226, align 4
  %227 = getelementptr %SchemeObject, %SchemeObject* %number45, i32 0, i32 1
  store i32 %225, i32* %227, align 4
  %228 = getelementptr %SchemeObject, %SchemeObject* %number45, i32 0, i32 0
  %229 = load i32, i32* %228, align 4
  %230 = icmp eq i32 %229, 0
  call void @__GLAssert(i1 %230, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %number45)
  %number46 = alloca %SchemeObject, align 8
  %231 = getelementptr %SchemeObject, %SchemeObject* %number46, i32 0, i32 0
  store i32 0, i32* %231, align 4
  %232 = getelementptr %SchemeObject, %SchemeObject* %number46, i32 0, i32 1
  store i32 0, i32* %232, align 4
  %233 = getelementptr %SchemeObject, %SchemeObject* %number46, i32 0, i32 0
  %234 = load i32, i32* %233, align 4
  %235 = icmp eq i32 %234, 0
  call void @__GLAssert(i1 %235, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @type_check_symbol_global, i32 0, i32 0), %SchemeObject* %number46)
  %236 = getelementptr %SchemeObject, %SchemeObject* %number45, i32 0, i32 1
  %237 = load i32, i32* %236, align 4
  %238 = getelementptr %SchemeObject, %SchemeObject* %number46, i32 0, i32 1
  %239 = load i32, i32* %238, align 4
  %240 = icmp ne i32 %237, %239
  br i1 %240, label %false_branch41, label %true_branch40
}

declare void @__GLInit()

declare void @__GLClear()

declare void @__GLPutPixel(%SchemeObject*, %SchemeObject*, %SchemeObject*, %SchemeObject*, %SchemeObject*)

declare %SchemeObject @__GLIsOpen()

declare void @__GLDraw()

declare void @__GLFinish()

declare void @__GLPrint(%SchemeObject*)

declare void @__GLAssert(i1, i8*, %SchemeObject*)

declare %SchemeObject @__GLExpt(%SchemeObject*, %SchemeObject*)

declare %SchemeObject @__GLSqrt(%SchemeObject*)

declare %SchemeObject @__GLMax(%SchemeObject*, %SchemeObject*)

declare %SchemeObject @__GLMin(%SchemeObject*, %SchemeObject*)

; Function Attrs: nofree nosync nounwind willreturn
declare i8* @llvm.stacksave() #0

; Function Attrs: nofree nosync nounwind willreturn
declare void @llvm.stackrestore(i8*) #0

attributes #0 = { nofree nosync nounwind willreturn }
