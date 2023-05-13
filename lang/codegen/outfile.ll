; ModuleID = 'outfile.ll'
source_filename = "outfile.ll"

%SchemeObject = type { i64, i64, i1, ptr, ptr, ptr }

@symbol_global = private unnamed_addr constant [4 x i8] c"AND\00", align 1
@symbol_global.1 = private unnamed_addr constant [3 x i8] c"OR\00", align 1
@symbol_global.2 = private unnamed_addr constant [9 x i8] c"BOOLEAN?\00", align 1
@symbol_global.3 = private unnamed_addr constant [8 x i8] c"SYMBOL?\00", align 1
@symbol_global.4 = private unnamed_addr constant [2 x i8] c"x\00", align 1
@symbol_global.5 = private unnamed_addr constant [8 x i8] c"NUMBER?\00", align 1
@symbol_global.6 = private unnamed_addr constant [5 x i8] c"CONS\00", align 1
@symbol_global.7 = private unnamed_addr constant [5 x i8] c"NULL\00", align 1

define i32 @main() {
entry:
  call void @__GLInit()
  %0 = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0, i32 0
  store i64 3, ptr %1, align 4
  %2 = getelementptr %SchemeObject, ptr %0, i32 0, i32 4
  store ptr null, ptr %2, align 8
  %3 = getelementptr %SchemeObject, ptr %0, i32 0, i32 5
  store ptr null, ptr %3, align 8
  br label %condition_branch

condition_branch:                                 ; preds = %merge_branch3, %entry
  %is-open = alloca %SchemeObject, align 8
  %4 = call %SchemeObject @__GLIsOpen()
  store %SchemeObject %4, ptr %is-open, align 8
  %5 = getelementptr %SchemeObject, ptr %is-open, i32 0, i32 0
  %6 = load i64, ptr %5, align 4
  %7 = icmp eq i64 %6, 1
  call void @__GLAssert(i1 %7)
  %8 = getelementptr %SchemeObject, ptr %is-open, i32 0, i32 2
  %9 = load i1, ptr %8, align 1
  br i1 %9, label %loop_branch, label %merge_branch

loop_branch:                                      ; preds = %condition_branch
  %10 = call ptr @llvm.stacksave()
  call void @__GLClear()
  %11 = alloca %SchemeObject, align 8
  %12 = getelementptr %SchemeObject, ptr %11, i32 0, i32 0
  store i64 3, ptr %12, align 4
  %13 = getelementptr %SchemeObject, ptr %11, i32 0, i32 4
  store ptr null, ptr %13, align 8
  %14 = getelementptr %SchemeObject, ptr %11, i32 0, i32 5
  store ptr null, ptr %14, align 8
  %number = alloca %SchemeObject, align 8
  %15 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %15, align 4
  %16 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 0, ptr %16, align 4
  %variable = alloca %SchemeObject, align 8
  %17 = getelementptr %SchemeObject, ptr %number, i32 0
  %18 = load %SchemeObject, ptr %17, align 8
  store %SchemeObject %18, ptr %variable, align 8
  br label %condition_branch1

merge_branch:                                     ; preds = %condition_branch
  call void @__GLFinish()
  %19 = alloca %SchemeObject, align 8
  %20 = getelementptr %SchemeObject, ptr %19, i32 0, i32 0
  store i64 3, ptr %20, align 4
  %21 = getelementptr %SchemeObject, ptr %19, i32 0, i32 4
  store ptr null, ptr %21, align 8
  %22 = getelementptr %SchemeObject, ptr %19, i32 0, i32 5
  store ptr null, ptr %22, align 8
  %symbol = alloca %SchemeObject, align 8
  %23 = getelementptr %SchemeObject, ptr %symbol, i32 0, i32 0
  store i64 2, ptr %23, align 4
  %24 = getelementptr %SchemeObject, ptr %symbol, i32 0, i32 3
  store ptr @symbol_global, ptr %24, align 8
  call void @__GLPrint(ptr %symbol)
  br label %end_branch56

condition_branch1:                                ; preds = %merge_branch17, %loop_branch
  br label %comparison_branch

loop_branch2:                                     ; preds = %end_branch
  %25 = call ptr @llvm.stacksave()
  %number13 = alloca %SchemeObject, align 8
  %26 = getelementptr %SchemeObject, ptr %number13, i32 0, i32 0
  store i64 0, ptr %26, align 4
  %27 = getelementptr %SchemeObject, ptr %number13, i32 0, i32 1
  store i64 0, ptr %27, align 4
  %variable14 = alloca %SchemeObject, align 8
  %28 = getelementptr %SchemeObject, ptr %number13, i32 0
  %29 = load %SchemeObject, ptr %28, align 8
  store %SchemeObject %29, ptr %variable14, align 8
  br label %condition_branch15

merge_branch3:                                    ; preds = %end_branch
  call void @__GLDraw()
  %30 = alloca %SchemeObject, align 8
  %31 = getelementptr %SchemeObject, ptr %30, i32 0, i32 0
  store i64 3, ptr %31, align 4
  %32 = getelementptr %SchemeObject, ptr %30, i32 0, i32 4
  store ptr null, ptr %32, align 8
  %33 = getelementptr %SchemeObject, ptr %30, i32 0, i32 5
  store ptr null, ptr %33, align 8
  call void @llvm.stackrestore(ptr %10)
  br label %condition_branch

end_branch:                                       ; preds = %continue_branch8, %is_boolean_smth_branch10, %is_boolean_smth_branch
  %34 = phi ptr [ %67, %is_boolean_smth_branch ], [ %72, %is_boolean_smth_branch10 ], [ %68, %continue_branch8 ]
  %35 = getelementptr %SchemeObject, ptr %34, i32 0, i32 0
  %36 = load i64, ptr %35, align 4
  %37 = icmp eq i64 %36, 1
  call void @__GLAssert(i1 %37)
  %38 = getelementptr %SchemeObject, ptr %34, i32 0, i32 2
  %39 = load i1, ptr %38, align 1
  br i1 %39, label %loop_branch2, label %merge_branch3

comparison_branch:                                ; preds = %condition_branch1
  %40 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %41 = load i64, ptr %40, align 4
  %42 = icmp eq i64 %41, 0
  call void @__GLAssert(i1 %42)
  %number5 = alloca %SchemeObject, align 8
  %43 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  store i64 0, ptr %43, align 4
  %44 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 10000, ptr %44, align 4
  %45 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  %46 = load i64, ptr %45, align 4
  %47 = icmp eq i64 %46, 0
  call void @__GLAssert(i1 %47)
  %48 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 1
  %49 = load i64, ptr %48, align 4
  %50 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  %51 = load i64, ptr %50, align 4
  %52 = icmp sge i64 %49, %51
  br i1 %52, label %false_branch, label %true_branch

true_branch:                                      ; preds = %comparison_branch
  %boolean = alloca %SchemeObject, align 8
  %53 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %53, align 4
  %54 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %54, align 1
  br label %merge_branch4

false_branch:                                     ; preds = %comparison_branch
  %boolean6 = alloca %SchemeObject, align 8
  %55 = getelementptr %SchemeObject, ptr %boolean6, i32 0, i32 0
  store i64 1, ptr %55, align 4
  %56 = getelementptr %SchemeObject, ptr %boolean6, i32 0, i32 2
  store i1 false, ptr %56, align 1
  br label %merge_branch4

merge_branch4:                                    ; preds = %false_branch, %true_branch
  %57 = phi ptr [ %boolean, %true_branch ], [ %boolean6, %false_branch ]
  %58 = getelementptr %SchemeObject, ptr %57, i32 0, i32 0
  %59 = load i64, ptr %58, align 4
  %is_type_check = icmp eq i64 %59, 1
  br i1 %is_type_check, label %is_boolean_branch, label %continue_branch

continue_branch:                                  ; preds = %is_boolean_branch, %merge_branch4
  %60 = phi ptr [ %57, %merge_branch4 ], [ %66, %is_boolean_branch ]
  %is-open7 = alloca %SchemeObject, align 8
  %61 = call %SchemeObject @__GLIsOpen()
  store %SchemeObject %61, ptr %is-open7, align 8
  %62 = getelementptr %SchemeObject, ptr %is-open7, i32 0, i32 0
  %63 = load i64, ptr %62, align 4
  %is_type_check11 = icmp eq i64 %63, 1
  br i1 %is_type_check11, label %is_boolean_branch9, label %continue_branch8

is_boolean_branch:                                ; preds = %merge_branch4
  %64 = getelementptr %SchemeObject, ptr %57, i32 0, i32 2
  %65 = load i1, ptr %64, align 1
  %is_boolean_smth_check = icmp eq i1 %65, false
  %66 = phi ptr [ %57, %merge_branch4 ]
  br i1 %is_boolean_smth_check, label %is_boolean_smth_branch, label %continue_branch

is_boolean_smth_branch:                           ; preds = %is_boolean_branch
  %67 = phi ptr [ %66, %is_boolean_branch ]
  br label %end_branch

continue_branch8:                                 ; preds = %is_boolean_branch9, %continue_branch
  %68 = phi ptr [ %is-open7, %continue_branch ], [ %71, %is_boolean_branch9 ]
  br label %end_branch

is_boolean_branch9:                               ; preds = %continue_branch
  %69 = getelementptr %SchemeObject, ptr %is-open7, i32 0, i32 2
  %70 = load i1, ptr %69, align 1
  %is_boolean_smth_check12 = icmp eq i1 %70, false
  %71 = phi ptr [ %is-open7, %continue_branch ]
  br i1 %is_boolean_smth_check12, label %is_boolean_smth_branch10, label %continue_branch8

is_boolean_smth_branch10:                         ; preds = %is_boolean_branch9
  %72 = phi ptr [ %71, %is_boolean_branch9 ]
  br label %end_branch

condition_branch15:                               ; preds = %merge_branch38, %loop_branch2
  br label %comparison_branch19

loop_branch16:                                    ; preds = %end_branch18
  %73 = call ptr @llvm.stacksave()
  br label %comparison_branch39

merge_branch17:                                   ; preds = %end_branch18
  %number54 = alloca %SchemeObject, align 8
  %74 = getelementptr %SchemeObject, ptr %number54, i32 0, i32 0
  store i64 0, ptr %74, align 4
  %75 = getelementptr %SchemeObject, ptr %number54, i32 0, i32 1
  store i64 0, ptr %75, align 4
  %76 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 0
  %77 = load i64, ptr %76, align 4
  %78 = icmp eq i64 %77, 0
  call void @__GLAssert(i1 %78)
  %79 = getelementptr %SchemeObject, ptr %number54, i32 0, i32 1
  %80 = load i64, ptr %79, align 4
  %81 = getelementptr %SchemeObject, ptr %variable, i32 0, i32 1
  %82 = load i64, ptr %81, align 4
  %83 = add i64 %80, %82
  %84 = getelementptr %SchemeObject, ptr %number54, i32 0, i32 1
  store i64 %83, ptr %84, align 4
  %number55 = alloca %SchemeObject, align 8
  %85 = getelementptr %SchemeObject, ptr %number55, i32 0, i32 0
  store i64 0, ptr %85, align 4
  %86 = getelementptr %SchemeObject, ptr %number55, i32 0, i32 1
  store i64 100, ptr %86, align 4
  %87 = getelementptr %SchemeObject, ptr %number55, i32 0, i32 0
  %88 = load i64, ptr %87, align 4
  %89 = icmp eq i64 %88, 0
  call void @__GLAssert(i1 %89)
  %90 = getelementptr %SchemeObject, ptr %number54, i32 0, i32 1
  %91 = load i64, ptr %90, align 4
  %92 = getelementptr %SchemeObject, ptr %number55, i32 0, i32 1
  %93 = load i64, ptr %92, align 4
  %94 = add i64 %91, %93
  %95 = getelementptr %SchemeObject, ptr %number54, i32 0, i32 1
  store i64 %94, ptr %95, align 4
  %96 = getelementptr %SchemeObject, ptr %number54, i32 0
  %97 = load %SchemeObject, ptr %96, align 8
  store %SchemeObject %97, ptr %variable, align 8
  call void @llvm.stackrestore(ptr %25)
  br label %condition_branch1

end_branch18:                                     ; preds = %continue_branch32, %is_boolean_smth_branch34, %is_boolean_smth_branch28
  %98 = phi ptr [ %131, %is_boolean_smth_branch28 ], [ %136, %is_boolean_smth_branch34 ], [ %132, %continue_branch32 ]
  %99 = getelementptr %SchemeObject, ptr %98, i32 0, i32 0
  %100 = load i64, ptr %99, align 4
  %101 = icmp eq i64 %100, 1
  call void @__GLAssert(i1 %101)
  %102 = getelementptr %SchemeObject, ptr %98, i32 0, i32 2
  %103 = load i1, ptr %102, align 1
  br i1 %103, label %loop_branch16, label %merge_branch17

comparison_branch19:                              ; preds = %condition_branch15
  %104 = getelementptr %SchemeObject, ptr %variable14, i32 0, i32 0
  %105 = load i64, ptr %104, align 4
  %106 = icmp eq i64 %105, 0
  call void @__GLAssert(i1 %106)
  %number23 = alloca %SchemeObject, align 8
  %107 = getelementptr %SchemeObject, ptr %number23, i32 0, i32 0
  store i64 0, ptr %107, align 4
  %108 = getelementptr %SchemeObject, ptr %number23, i32 0, i32 1
  store i64 10000, ptr %108, align 4
  %109 = getelementptr %SchemeObject, ptr %number23, i32 0, i32 0
  %110 = load i64, ptr %109, align 4
  %111 = icmp eq i64 %110, 0
  call void @__GLAssert(i1 %111)
  %112 = getelementptr %SchemeObject, ptr %variable14, i32 0, i32 1
  %113 = load i64, ptr %112, align 4
  %114 = getelementptr %SchemeObject, ptr %number23, i32 0, i32 1
  %115 = load i64, ptr %114, align 4
  %116 = icmp sge i64 %113, %115
  br i1 %116, label %false_branch21, label %true_branch20

true_branch20:                                    ; preds = %comparison_branch19
  %boolean24 = alloca %SchemeObject, align 8
  %117 = getelementptr %SchemeObject, ptr %boolean24, i32 0, i32 0
  store i64 1, ptr %117, align 4
  %118 = getelementptr %SchemeObject, ptr %boolean24, i32 0, i32 2
  store i1 true, ptr %118, align 1
  br label %merge_branch22

false_branch21:                                   ; preds = %comparison_branch19
  %boolean25 = alloca %SchemeObject, align 8
  %119 = getelementptr %SchemeObject, ptr %boolean25, i32 0, i32 0
  store i64 1, ptr %119, align 4
  %120 = getelementptr %SchemeObject, ptr %boolean25, i32 0, i32 2
  store i1 false, ptr %120, align 1
  br label %merge_branch22

merge_branch22:                                   ; preds = %false_branch21, %true_branch20
  %121 = phi ptr [ %boolean24, %true_branch20 ], [ %boolean25, %false_branch21 ]
  %122 = getelementptr %SchemeObject, ptr %121, i32 0, i32 0
  %123 = load i64, ptr %122, align 4
  %is_type_check29 = icmp eq i64 %123, 1
  br i1 %is_type_check29, label %is_boolean_branch27, label %continue_branch26

continue_branch26:                                ; preds = %is_boolean_branch27, %merge_branch22
  %124 = phi ptr [ %121, %merge_branch22 ], [ %130, %is_boolean_branch27 ]
  %is-open31 = alloca %SchemeObject, align 8
  %125 = call %SchemeObject @__GLIsOpen()
  store %SchemeObject %125, ptr %is-open31, align 8
  %126 = getelementptr %SchemeObject, ptr %is-open31, i32 0, i32 0
  %127 = load i64, ptr %126, align 4
  %is_type_check35 = icmp eq i64 %127, 1
  br i1 %is_type_check35, label %is_boolean_branch33, label %continue_branch32

is_boolean_branch27:                              ; preds = %merge_branch22
  %128 = getelementptr %SchemeObject, ptr %121, i32 0, i32 2
  %129 = load i1, ptr %128, align 1
  %is_boolean_smth_check30 = icmp eq i1 %129, false
  %130 = phi ptr [ %121, %merge_branch22 ]
  br i1 %is_boolean_smth_check30, label %is_boolean_smth_branch28, label %continue_branch26

is_boolean_smth_branch28:                         ; preds = %is_boolean_branch27
  %131 = phi ptr [ %130, %is_boolean_branch27 ]
  br label %end_branch18

continue_branch32:                                ; preds = %is_boolean_branch33, %continue_branch26
  %132 = phi ptr [ %is-open31, %continue_branch26 ], [ %135, %is_boolean_branch33 ]
  br label %end_branch18

is_boolean_branch33:                              ; preds = %continue_branch26
  %133 = getelementptr %SchemeObject, ptr %is-open31, i32 0, i32 2
  %134 = load i1, ptr %133, align 1
  %is_boolean_smth_check36 = icmp eq i1 %134, false
  %135 = phi ptr [ %is-open31, %continue_branch26 ]
  br i1 %is_boolean_smth_check36, label %is_boolean_smth_branch34, label %continue_branch32

is_boolean_smth_branch34:                         ; preds = %is_boolean_branch33
  %136 = phi ptr [ %135, %is_boolean_branch33 ]
  br label %end_branch18

true_branch37:                                    ; preds = %merge_branch42
  call void @__GLDraw()
  %137 = alloca %SchemeObject, align 8
  %138 = getelementptr %SchemeObject, ptr %137, i32 0, i32 0
  store i64 3, ptr %138, align 4
  %139 = getelementptr %SchemeObject, ptr %137, i32 0, i32 4
  store ptr null, ptr %139, align 8
  %140 = getelementptr %SchemeObject, ptr %137, i32 0, i32 5
  store ptr null, ptr %140, align 8
  br label %merge_branch38

merge_branch38:                                   ; preds = %true_branch37, %merge_branch42
  %141 = phi ptr [ %137, %true_branch37 ]
  %number49 = alloca %SchemeObject, align 8
  %142 = getelementptr %SchemeObject, ptr %number49, i32 0, i32 0
  store i64 0, ptr %142, align 4
  %143 = getelementptr %SchemeObject, ptr %number49, i32 0, i32 1
  store i64 25500, ptr %143, align 4
  %number50 = alloca %SchemeObject, align 8
  %144 = getelementptr %SchemeObject, ptr %number50, i32 0, i32 0
  store i64 0, ptr %144, align 4
  %145 = getelementptr %SchemeObject, ptr %number50, i32 0, i32 1
  store i64 25500, ptr %145, align 4
  %number51 = alloca %SchemeObject, align 8
  %146 = getelementptr %SchemeObject, ptr %number51, i32 0, i32 0
  store i64 0, ptr %146, align 4
  %147 = getelementptr %SchemeObject, ptr %number51, i32 0, i32 1
  store i64 25500, ptr %147, align 4
  call void @__GLPutPixel(ptr %variable, ptr %variable14, ptr %number49, ptr %number50, ptr %number51)
  %148 = alloca %SchemeObject, align 8
  %149 = getelementptr %SchemeObject, ptr %148, i32 0, i32 0
  store i64 3, ptr %149, align 4
  %150 = getelementptr %SchemeObject, ptr %148, i32 0, i32 4
  store ptr null, ptr %150, align 8
  %151 = getelementptr %SchemeObject, ptr %148, i32 0, i32 5
  store ptr null, ptr %151, align 8
  %number52 = alloca %SchemeObject, align 8
  %152 = getelementptr %SchemeObject, ptr %number52, i32 0, i32 0
  store i64 0, ptr %152, align 4
  %153 = getelementptr %SchemeObject, ptr %number52, i32 0, i32 1
  store i64 0, ptr %153, align 4
  %154 = getelementptr %SchemeObject, ptr %variable14, i32 0, i32 0
  %155 = load i64, ptr %154, align 4
  %156 = icmp eq i64 %155, 0
  call void @__GLAssert(i1 %156)
  %157 = getelementptr %SchemeObject, ptr %number52, i32 0, i32 1
  %158 = load i64, ptr %157, align 4
  %159 = getelementptr %SchemeObject, ptr %variable14, i32 0, i32 1
  %160 = load i64, ptr %159, align 4
  %161 = add i64 %158, %160
  %162 = getelementptr %SchemeObject, ptr %number52, i32 0, i32 1
  store i64 %161, ptr %162, align 4
  %number53 = alloca %SchemeObject, align 8
  %163 = getelementptr %SchemeObject, ptr %number53, i32 0, i32 0
  store i64 0, ptr %163, align 4
  %164 = getelementptr %SchemeObject, ptr %number53, i32 0, i32 1
  store i64 100, ptr %164, align 4
  %165 = getelementptr %SchemeObject, ptr %number53, i32 0, i32 0
  %166 = load i64, ptr %165, align 4
  %167 = icmp eq i64 %166, 0
  call void @__GLAssert(i1 %167)
  %168 = getelementptr %SchemeObject, ptr %number52, i32 0, i32 1
  %169 = load i64, ptr %168, align 4
  %170 = getelementptr %SchemeObject, ptr %number53, i32 0, i32 1
  %171 = load i64, ptr %170, align 4
  %172 = add i64 %169, %171
  %173 = getelementptr %SchemeObject, ptr %number52, i32 0, i32 1
  store i64 %172, ptr %173, align 4
  %174 = getelementptr %SchemeObject, ptr %number52, i32 0
  %175 = load %SchemeObject, ptr %174, align 8
  store %SchemeObject %175, ptr %variable14, align 8
  call void @llvm.stackrestore(ptr %73)
  br label %condition_branch15

comparison_branch39:                              ; preds = %loop_branch16
  %176 = getelementptr %SchemeObject, ptr %variable14, i32 0, i32 0
  %177 = load i64, ptr %176, align 4
  %178 = icmp eq i64 %177, 0
  call void @__GLAssert(i1 %178)
  %179 = getelementptr %SchemeObject, ptr %variable14, i32 0, i32 1
  %180 = load i64, ptr %179, align 4
  %181 = srem i64 %180, 100
  %182 = icmp eq i64 %181, 0
  call void @__GLAssert(i1 %182)
  %number43 = alloca %SchemeObject, align 8
  %183 = getelementptr %SchemeObject, ptr %number43, i32 0, i32 0
  store i64 0, ptr %183, align 4
  %184 = getelementptr %SchemeObject, ptr %number43, i32 0, i32 1
  store i64 100, ptr %184, align 4
  %185 = getelementptr %SchemeObject, ptr %number43, i32 0, i32 0
  %186 = load i64, ptr %185, align 4
  %187 = icmp eq i64 %186, 0
  call void @__GLAssert(i1 %187)
  %188 = getelementptr %SchemeObject, ptr %number43, i32 0, i32 1
  %189 = load i64, ptr %188, align 4
  %190 = srem i64 %189, 100
  %191 = icmp eq i64 %190, 0
  call void @__GLAssert(i1 %191)
  %is_zero_then_one_check = icmp ne i64 %189, 0
  br i1 %is_zero_then_one_check, label %continue_branch44, label %modify_branch

true_branch40:                                    ; preds = %continue_branch44
  %boolean47 = alloca %SchemeObject, align 8
  %192 = getelementptr %SchemeObject, ptr %boolean47, i32 0, i32 0
  store i64 1, ptr %192, align 4
  %193 = getelementptr %SchemeObject, ptr %boolean47, i32 0, i32 2
  store i1 true, ptr %193, align 1
  br label %merge_branch42

false_branch41:                                   ; preds = %continue_branch44
  %boolean48 = alloca %SchemeObject, align 8
  %194 = getelementptr %SchemeObject, ptr %boolean48, i32 0, i32 0
  store i64 1, ptr %194, align 4
  %195 = getelementptr %SchemeObject, ptr %boolean48, i32 0, i32 2
  store i1 false, ptr %195, align 1
  br label %merge_branch42

merge_branch42:                                   ; preds = %false_branch41, %true_branch40
  %196 = phi ptr [ %boolean47, %true_branch40 ], [ %boolean48, %false_branch41 ]
  %197 = getelementptr %SchemeObject, ptr %196, i32 0, i32 0
  %198 = load i64, ptr %197, align 4
  %199 = icmp eq i64 %198, 1
  call void @__GLAssert(i1 %199)
  %200 = getelementptr %SchemeObject, ptr %196, i32 0, i32 2
  %201 = load i1, ptr %200, align 1
  br i1 %201, label %true_branch37, label %merge_branch38

modify_branch:                                    ; preds = %comparison_branch39
  br label %continue_branch44

continue_branch44:                                ; preds = %modify_branch, %comparison_branch39
  %202 = phi i64 [ 1, %modify_branch ], [ %189, %comparison_branch39 ]
  %203 = srem i64 %180, %202
  %number45 = alloca %SchemeObject, align 8
  %204 = getelementptr %SchemeObject, ptr %number45, i32 0, i32 0
  store i64 0, ptr %204, align 4
  %205 = getelementptr %SchemeObject, ptr %number45, i32 0, i32 1
  store i64 %203, ptr %205, align 4
  %206 = getelementptr %SchemeObject, ptr %number45, i32 0, i32 0
  %207 = load i64, ptr %206, align 4
  %208 = icmp eq i64 %207, 0
  call void @__GLAssert(i1 %208)
  %number46 = alloca %SchemeObject, align 8
  %209 = getelementptr %SchemeObject, ptr %number46, i32 0, i32 0
  store i64 0, ptr %209, align 4
  %210 = getelementptr %SchemeObject, ptr %number46, i32 0, i32 1
  store i64 0, ptr %210, align 4
  %211 = getelementptr %SchemeObject, ptr %number46, i32 0, i32 0
  %212 = load i64, ptr %211, align 4
  %213 = icmp eq i64 %212, 0
  call void @__GLAssert(i1 %213)
  %214 = getelementptr %SchemeObject, ptr %number45, i32 0, i32 1
  %215 = load i64, ptr %214, align 4
  %216 = getelementptr %SchemeObject, ptr %number46, i32 0, i32 1
  %217 = load i64, ptr %216, align 4
  %218 = icmp ne i64 %215, %217
  br i1 %218, label %false_branch41, label %true_branch40

end_branch56:                                     ; preds = %merge_branch
  %boolean57 = alloca %SchemeObject, align 8
  %219 = getelementptr %SchemeObject, ptr %boolean57, i32 0, i32 0
  store i64 1, ptr %219, align 4
  %220 = getelementptr %SchemeObject, ptr %boolean57, i32 0, i32 2
  store i1 true, ptr %220, align 1
  call void @__GLPrint(ptr %boolean57)
  br label %comparison_branch59

end_branch58:                                     ; preds = %continue_branch80, %is_boolean_smth_branch82, %is_boolean_smth_branch69
  %221 = phi ptr [ %252, %is_boolean_smth_branch69 ], [ %279, %is_boolean_smth_branch82 ], [ %275, %continue_branch80 ]
  call void @__GLPrint(ptr %221)
  %boolean86 = alloca %SchemeObject, align 8
  %222 = getelementptr %SchemeObject, ptr %boolean86, i32 0, i32 0
  store i64 1, ptr %222, align 4
  %223 = getelementptr %SchemeObject, ptr %boolean86, i32 0, i32 2
  store i1 true, ptr %223, align 1
  %224 = getelementptr %SchemeObject, ptr %boolean86, i32 0, i32 0
  %225 = load i64, ptr %224, align 4
  %is_type_check90 = icmp eq i64 %225, 1
  br i1 %is_type_check90, label %is_boolean_branch88, label %continue_branch87

comparison_branch59:                              ; preds = %end_branch56
  %number63 = alloca %SchemeObject, align 8
  %226 = getelementptr %SchemeObject, ptr %number63, i32 0, i32 0
  store i64 0, ptr %226, align 4
  %227 = getelementptr %SchemeObject, ptr %number63, i32 0, i32 1
  store i64 200, ptr %227, align 4
  %228 = getelementptr %SchemeObject, ptr %number63, i32 0, i32 0
  %229 = load i64, ptr %228, align 4
  %230 = icmp eq i64 %229, 0
  call void @__GLAssert(i1 %230)
  %number64 = alloca %SchemeObject, align 8
  %231 = getelementptr %SchemeObject, ptr %number64, i32 0, i32 0
  store i64 0, ptr %231, align 4
  %232 = getelementptr %SchemeObject, ptr %number64, i32 0, i32 1
  store i64 200, ptr %232, align 4
  %233 = getelementptr %SchemeObject, ptr %number64, i32 0, i32 0
  %234 = load i64, ptr %233, align 4
  %235 = icmp eq i64 %234, 0
  call void @__GLAssert(i1 %235)
  %236 = getelementptr %SchemeObject, ptr %number63, i32 0, i32 1
  %237 = load i64, ptr %236, align 4
  %238 = getelementptr %SchemeObject, ptr %number64, i32 0, i32 1
  %239 = load i64, ptr %238, align 4
  %240 = icmp ne i64 %237, %239
  br i1 %240, label %false_branch61, label %true_branch60

true_branch60:                                    ; preds = %comparison_branch59
  %boolean65 = alloca %SchemeObject, align 8
  %241 = getelementptr %SchemeObject, ptr %boolean65, i32 0, i32 0
  store i64 1, ptr %241, align 4
  %242 = getelementptr %SchemeObject, ptr %boolean65, i32 0, i32 2
  store i1 true, ptr %242, align 1
  br label %merge_branch62

false_branch61:                                   ; preds = %comparison_branch59
  %boolean66 = alloca %SchemeObject, align 8
  %243 = getelementptr %SchemeObject, ptr %boolean66, i32 0, i32 0
  store i64 1, ptr %243, align 4
  %244 = getelementptr %SchemeObject, ptr %boolean66, i32 0, i32 2
  store i1 false, ptr %244, align 1
  br label %merge_branch62

merge_branch62:                                   ; preds = %false_branch61, %true_branch60
  %245 = phi ptr [ %boolean65, %true_branch60 ], [ %boolean66, %false_branch61 ]
  %246 = getelementptr %SchemeObject, ptr %245, i32 0, i32 0
  %247 = load i64, ptr %246, align 4
  %is_type_check70 = icmp eq i64 %247, 1
  br i1 %is_type_check70, label %is_boolean_branch68, label %continue_branch67

continue_branch67:                                ; preds = %is_boolean_branch68, %merge_branch62
  %248 = phi ptr [ %245, %merge_branch62 ], [ %251, %is_boolean_branch68 ]
  br label %comparison_branch72

is_boolean_branch68:                              ; preds = %merge_branch62
  %249 = getelementptr %SchemeObject, ptr %245, i32 0, i32 2
  %250 = load i1, ptr %249, align 1
  %is_boolean_smth_check71 = icmp eq i1 %250, false
  %251 = phi ptr [ %245, %merge_branch62 ]
  br i1 %is_boolean_smth_check71, label %is_boolean_smth_branch69, label %continue_branch67

is_boolean_smth_branch69:                         ; preds = %is_boolean_branch68
  %252 = phi ptr [ %251, %is_boolean_branch68 ]
  br label %end_branch58

comparison_branch72:                              ; preds = %continue_branch67
  %number76 = alloca %SchemeObject, align 8
  %253 = getelementptr %SchemeObject, ptr %number76, i32 0, i32 0
  store i64 0, ptr %253, align 4
  %254 = getelementptr %SchemeObject, ptr %number76, i32 0, i32 1
  store i64 200, ptr %254, align 4
  %255 = getelementptr %SchemeObject, ptr %number76, i32 0, i32 0
  %256 = load i64, ptr %255, align 4
  %257 = icmp eq i64 %256, 0
  call void @__GLAssert(i1 %257)
  %number77 = alloca %SchemeObject, align 8
  %258 = getelementptr %SchemeObject, ptr %number77, i32 0, i32 0
  store i64 0, ptr %258, align 4
  %259 = getelementptr %SchemeObject, ptr %number77, i32 0, i32 1
  store i64 100, ptr %259, align 4
  %260 = getelementptr %SchemeObject, ptr %number77, i32 0, i32 0
  %261 = load i64, ptr %260, align 4
  %262 = icmp eq i64 %261, 0
  call void @__GLAssert(i1 %262)
  %263 = getelementptr %SchemeObject, ptr %number76, i32 0, i32 1
  %264 = load i64, ptr %263, align 4
  %265 = getelementptr %SchemeObject, ptr %number77, i32 0, i32 1
  %266 = load i64, ptr %265, align 4
  %267 = icmp sle i64 %264, %266
  br i1 %267, label %false_branch74, label %true_branch73

true_branch73:                                    ; preds = %comparison_branch72
  %boolean78 = alloca %SchemeObject, align 8
  %268 = getelementptr %SchemeObject, ptr %boolean78, i32 0, i32 0
  store i64 1, ptr %268, align 4
  %269 = getelementptr %SchemeObject, ptr %boolean78, i32 0, i32 2
  store i1 true, ptr %269, align 1
  br label %merge_branch75

false_branch74:                                   ; preds = %comparison_branch72
  %boolean79 = alloca %SchemeObject, align 8
  %270 = getelementptr %SchemeObject, ptr %boolean79, i32 0, i32 0
  store i64 1, ptr %270, align 4
  %271 = getelementptr %SchemeObject, ptr %boolean79, i32 0, i32 2
  store i1 false, ptr %271, align 1
  br label %merge_branch75

merge_branch75:                                   ; preds = %false_branch74, %true_branch73
  %272 = phi ptr [ %boolean78, %true_branch73 ], [ %boolean79, %false_branch74 ]
  %273 = getelementptr %SchemeObject, ptr %272, i32 0, i32 0
  %274 = load i64, ptr %273, align 4
  %is_type_check83 = icmp eq i64 %274, 1
  br i1 %is_type_check83, label %is_boolean_branch81, label %continue_branch80

continue_branch80:                                ; preds = %is_boolean_branch81, %merge_branch75
  %275 = phi ptr [ %272, %merge_branch75 ], [ %278, %is_boolean_branch81 ]
  br label %end_branch58

is_boolean_branch81:                              ; preds = %merge_branch75
  %276 = getelementptr %SchemeObject, ptr %272, i32 0, i32 2
  %277 = load i1, ptr %276, align 1
  %is_boolean_smth_check84 = icmp eq i1 %277, false
  %278 = phi ptr [ %272, %merge_branch75 ]
  br i1 %is_boolean_smth_check84, label %is_boolean_smth_branch82, label %continue_branch80

is_boolean_smth_branch82:                         ; preds = %is_boolean_branch81
  %279 = phi ptr [ %278, %is_boolean_branch81 ]
  br label %end_branch58

end_branch85:                                     ; preds = %continue_branch93, %is_boolean_smth_branch95, %is_boolean_smth_branch89
  %280 = phi ptr [ %289, %is_boolean_smth_branch89 ], [ %294, %is_boolean_smth_branch95 ], [ %290, %continue_branch93 ]
  call void @__GLPrint(ptr %280)
  br label %comparison_branch99

continue_branch87:                                ; preds = %is_boolean_branch88, %end_branch58
  %281 = phi ptr [ %boolean86, %end_branch58 ], [ %288, %is_boolean_branch88 ]
  %boolean92 = alloca %SchemeObject, align 8
  %282 = getelementptr %SchemeObject, ptr %boolean92, i32 0, i32 0
  store i64 1, ptr %282, align 4
  %283 = getelementptr %SchemeObject, ptr %boolean92, i32 0, i32 2
  store i1 false, ptr %283, align 1
  %284 = getelementptr %SchemeObject, ptr %boolean92, i32 0, i32 0
  %285 = load i64, ptr %284, align 4
  %is_type_check96 = icmp eq i64 %285, 1
  br i1 %is_type_check96, label %is_boolean_branch94, label %continue_branch93

is_boolean_branch88:                              ; preds = %end_branch58
  %286 = getelementptr %SchemeObject, ptr %boolean86, i32 0, i32 2
  %287 = load i1, ptr %286, align 1
  %is_boolean_smth_check91 = icmp eq i1 %287, false
  %288 = phi ptr [ %boolean86, %end_branch58 ]
  br i1 %is_boolean_smth_check91, label %is_boolean_smth_branch89, label %continue_branch87

is_boolean_smth_branch89:                         ; preds = %is_boolean_branch88
  %289 = phi ptr [ %288, %is_boolean_branch88 ]
  br label %end_branch85

continue_branch93:                                ; preds = %is_boolean_branch94, %continue_branch87
  %290 = phi ptr [ %boolean92, %continue_branch87 ], [ %293, %is_boolean_branch94 ]
  br label %end_branch85

is_boolean_branch94:                              ; preds = %continue_branch87
  %291 = getelementptr %SchemeObject, ptr %boolean92, i32 0, i32 2
  %292 = load i1, ptr %291, align 1
  %is_boolean_smth_check97 = icmp eq i1 %292, false
  %293 = phi ptr [ %boolean92, %continue_branch87 ]
  br i1 %is_boolean_smth_check97, label %is_boolean_smth_branch95, label %continue_branch93

is_boolean_smth_branch95:                         ; preds = %is_boolean_branch94
  %294 = phi ptr [ %293, %is_boolean_branch94 ]
  br label %end_branch85

end_branch98:                                     ; preds = %continue_branch120, %is_boolean_smth_branch122, %is_boolean_smth_branch109
  %295 = phi ptr [ %326, %is_boolean_smth_branch109 ], [ %353, %is_boolean_smth_branch122 ], [ %349, %continue_branch120 ]
  call void @__GLPrint(ptr %295)
  %number126 = alloca %SchemeObject, align 8
  %296 = getelementptr %SchemeObject, ptr %number126, i32 0, i32 0
  store i64 0, ptr %296, align 4
  %297 = getelementptr %SchemeObject, ptr %number126, i32 0, i32 1
  store i64 300, ptr %297, align 4
  %298 = getelementptr %SchemeObject, ptr %number126, i32 0, i32 0
  %299 = load i64, ptr %298, align 4
  %is_type_check130 = icmp eq i64 %299, 1
  br i1 %is_type_check130, label %is_boolean_branch128, label %continue_branch127

comparison_branch99:                              ; preds = %end_branch85
  %number103 = alloca %SchemeObject, align 8
  %300 = getelementptr %SchemeObject, ptr %number103, i32 0, i32 0
  store i64 0, ptr %300, align 4
  %301 = getelementptr %SchemeObject, ptr %number103, i32 0, i32 1
  store i64 200, ptr %301, align 4
  %302 = getelementptr %SchemeObject, ptr %number103, i32 0, i32 0
  %303 = load i64, ptr %302, align 4
  %304 = icmp eq i64 %303, 0
  call void @__GLAssert(i1 %304)
  %number104 = alloca %SchemeObject, align 8
  %305 = getelementptr %SchemeObject, ptr %number104, i32 0, i32 0
  store i64 0, ptr %305, align 4
  %306 = getelementptr %SchemeObject, ptr %number104, i32 0, i32 1
  store i64 200, ptr %306, align 4
  %307 = getelementptr %SchemeObject, ptr %number104, i32 0, i32 0
  %308 = load i64, ptr %307, align 4
  %309 = icmp eq i64 %308, 0
  call void @__GLAssert(i1 %309)
  %310 = getelementptr %SchemeObject, ptr %number103, i32 0, i32 1
  %311 = load i64, ptr %310, align 4
  %312 = getelementptr %SchemeObject, ptr %number104, i32 0, i32 1
  %313 = load i64, ptr %312, align 4
  %314 = icmp ne i64 %311, %313
  br i1 %314, label %false_branch101, label %true_branch100

true_branch100:                                   ; preds = %comparison_branch99
  %boolean105 = alloca %SchemeObject, align 8
  %315 = getelementptr %SchemeObject, ptr %boolean105, i32 0, i32 0
  store i64 1, ptr %315, align 4
  %316 = getelementptr %SchemeObject, ptr %boolean105, i32 0, i32 2
  store i1 true, ptr %316, align 1
  br label %merge_branch102

false_branch101:                                  ; preds = %comparison_branch99
  %boolean106 = alloca %SchemeObject, align 8
  %317 = getelementptr %SchemeObject, ptr %boolean106, i32 0, i32 0
  store i64 1, ptr %317, align 4
  %318 = getelementptr %SchemeObject, ptr %boolean106, i32 0, i32 2
  store i1 false, ptr %318, align 1
  br label %merge_branch102

merge_branch102:                                  ; preds = %false_branch101, %true_branch100
  %319 = phi ptr [ %boolean105, %true_branch100 ], [ %boolean106, %false_branch101 ]
  %320 = getelementptr %SchemeObject, ptr %319, i32 0, i32 0
  %321 = load i64, ptr %320, align 4
  %is_type_check110 = icmp eq i64 %321, 1
  br i1 %is_type_check110, label %is_boolean_branch108, label %continue_branch107

continue_branch107:                               ; preds = %is_boolean_branch108, %merge_branch102
  %322 = phi ptr [ %319, %merge_branch102 ], [ %325, %is_boolean_branch108 ]
  br label %comparison_branch112

is_boolean_branch108:                             ; preds = %merge_branch102
  %323 = getelementptr %SchemeObject, ptr %319, i32 0, i32 2
  %324 = load i1, ptr %323, align 1
  %is_boolean_smth_check111 = icmp eq i1 %324, false
  %325 = phi ptr [ %319, %merge_branch102 ]
  br i1 %is_boolean_smth_check111, label %is_boolean_smth_branch109, label %continue_branch107

is_boolean_smth_branch109:                        ; preds = %is_boolean_branch108
  %326 = phi ptr [ %325, %is_boolean_branch108 ]
  br label %end_branch98

comparison_branch112:                             ; preds = %continue_branch107
  %number116 = alloca %SchemeObject, align 8
  %327 = getelementptr %SchemeObject, ptr %number116, i32 0, i32 0
  store i64 0, ptr %327, align 4
  %328 = getelementptr %SchemeObject, ptr %number116, i32 0, i32 1
  store i64 200, ptr %328, align 4
  %329 = getelementptr %SchemeObject, ptr %number116, i32 0, i32 0
  %330 = load i64, ptr %329, align 4
  %331 = icmp eq i64 %330, 0
  call void @__GLAssert(i1 %331)
  %number117 = alloca %SchemeObject, align 8
  %332 = getelementptr %SchemeObject, ptr %number117, i32 0, i32 0
  store i64 0, ptr %332, align 4
  %333 = getelementptr %SchemeObject, ptr %number117, i32 0, i32 1
  store i64 100, ptr %333, align 4
  %334 = getelementptr %SchemeObject, ptr %number117, i32 0, i32 0
  %335 = load i64, ptr %334, align 4
  %336 = icmp eq i64 %335, 0
  call void @__GLAssert(i1 %336)
  %337 = getelementptr %SchemeObject, ptr %number116, i32 0, i32 1
  %338 = load i64, ptr %337, align 4
  %339 = getelementptr %SchemeObject, ptr %number117, i32 0, i32 1
  %340 = load i64, ptr %339, align 4
  %341 = icmp sge i64 %338, %340
  br i1 %341, label %false_branch114, label %true_branch113

true_branch113:                                   ; preds = %comparison_branch112
  %boolean118 = alloca %SchemeObject, align 8
  %342 = getelementptr %SchemeObject, ptr %boolean118, i32 0, i32 0
  store i64 1, ptr %342, align 4
  %343 = getelementptr %SchemeObject, ptr %boolean118, i32 0, i32 2
  store i1 true, ptr %343, align 1
  br label %merge_branch115

false_branch114:                                  ; preds = %comparison_branch112
  %boolean119 = alloca %SchemeObject, align 8
  %344 = getelementptr %SchemeObject, ptr %boolean119, i32 0, i32 0
  store i64 1, ptr %344, align 4
  %345 = getelementptr %SchemeObject, ptr %boolean119, i32 0, i32 2
  store i1 false, ptr %345, align 1
  br label %merge_branch115

merge_branch115:                                  ; preds = %false_branch114, %true_branch113
  %346 = phi ptr [ %boolean118, %true_branch113 ], [ %boolean119, %false_branch114 ]
  %347 = getelementptr %SchemeObject, ptr %346, i32 0, i32 0
  %348 = load i64, ptr %347, align 4
  %is_type_check123 = icmp eq i64 %348, 1
  br i1 %is_type_check123, label %is_boolean_branch121, label %continue_branch120

continue_branch120:                               ; preds = %is_boolean_branch121, %merge_branch115
  %349 = phi ptr [ %346, %merge_branch115 ], [ %352, %is_boolean_branch121 ]
  br label %end_branch98

is_boolean_branch121:                             ; preds = %merge_branch115
  %350 = getelementptr %SchemeObject, ptr %346, i32 0, i32 2
  %351 = load i1, ptr %350, align 1
  %is_boolean_smth_check124 = icmp eq i1 %351, false
  %352 = phi ptr [ %346, %merge_branch115 ]
  br i1 %is_boolean_smth_check124, label %is_boolean_smth_branch122, label %continue_branch120

is_boolean_smth_branch122:                        ; preds = %is_boolean_branch121
  %353 = phi ptr [ %352, %is_boolean_branch121 ]
  br label %end_branch98

end_branch125:                                    ; preds = %continue_branch146, %is_boolean_smth_branch148, %is_boolean_smth_branch142, %is_boolean_smth_branch129
  %354 = phi ptr [ %361, %is_boolean_smth_branch129 ], [ %392, %is_boolean_smth_branch142 ], [ %397, %is_boolean_smth_branch148 ], [ %393, %continue_branch146 ]
  call void @__GLPrint(ptr %354)
  %symbol151 = alloca %SchemeObject, align 8
  %355 = getelementptr %SchemeObject, ptr %symbol151, i32 0, i32 0
  store i64 2, ptr %355, align 4
  %356 = getelementptr %SchemeObject, ptr %symbol151, i32 0, i32 3
  store ptr @symbol_global.1, ptr %356, align 8
  call void @__GLPrint(ptr %symbol151)
  br label %end_branch152

continue_branch127:                               ; preds = %is_boolean_branch128, %end_branch98
  %357 = phi ptr [ %number126, %end_branch98 ], [ %360, %is_boolean_branch128 ]
  br label %comparison_branch132

is_boolean_branch128:                             ; preds = %end_branch98
  %358 = getelementptr %SchemeObject, ptr %number126, i32 0, i32 2
  %359 = load i1, ptr %358, align 1
  %is_boolean_smth_check131 = icmp eq i1 %359, false
  %360 = phi ptr [ %number126, %end_branch98 ]
  br i1 %is_boolean_smth_check131, label %is_boolean_smth_branch129, label %continue_branch127

is_boolean_smth_branch129:                        ; preds = %is_boolean_branch128
  %361 = phi ptr [ %360, %is_boolean_branch128 ]
  br label %end_branch125

comparison_branch132:                             ; preds = %continue_branch127
  %number136 = alloca %SchemeObject, align 8
  %362 = getelementptr %SchemeObject, ptr %number136, i32 0, i32 0
  store i64 0, ptr %362, align 4
  %363 = getelementptr %SchemeObject, ptr %number136, i32 0, i32 1
  store i64 200, ptr %363, align 4
  %364 = getelementptr %SchemeObject, ptr %number136, i32 0, i32 0
  %365 = load i64, ptr %364, align 4
  %366 = icmp eq i64 %365, 0
  call void @__GLAssert(i1 %366)
  %number137 = alloca %SchemeObject, align 8
  %367 = getelementptr %SchemeObject, ptr %number137, i32 0, i32 0
  store i64 0, ptr %367, align 4
  %368 = getelementptr %SchemeObject, ptr %number137, i32 0, i32 1
  store i64 200, ptr %368, align 4
  %369 = getelementptr %SchemeObject, ptr %number137, i32 0, i32 0
  %370 = load i64, ptr %369, align 4
  %371 = icmp eq i64 %370, 0
  call void @__GLAssert(i1 %371)
  %372 = getelementptr %SchemeObject, ptr %number136, i32 0, i32 1
  %373 = load i64, ptr %372, align 4
  %374 = getelementptr %SchemeObject, ptr %number137, i32 0, i32 1
  %375 = load i64, ptr %374, align 4
  %376 = icmp ne i64 %373, %375
  br i1 %376, label %false_branch134, label %true_branch133

true_branch133:                                   ; preds = %comparison_branch132
  %boolean138 = alloca %SchemeObject, align 8
  %377 = getelementptr %SchemeObject, ptr %boolean138, i32 0, i32 0
  store i64 1, ptr %377, align 4
  %378 = getelementptr %SchemeObject, ptr %boolean138, i32 0, i32 2
  store i1 true, ptr %378, align 1
  br label %merge_branch135

false_branch134:                                  ; preds = %comparison_branch132
  %boolean139 = alloca %SchemeObject, align 8
  %379 = getelementptr %SchemeObject, ptr %boolean139, i32 0, i32 0
  store i64 1, ptr %379, align 4
  %380 = getelementptr %SchemeObject, ptr %boolean139, i32 0, i32 2
  store i1 false, ptr %380, align 1
  br label %merge_branch135

merge_branch135:                                  ; preds = %false_branch134, %true_branch133
  %381 = phi ptr [ %boolean138, %true_branch133 ], [ %boolean139, %false_branch134 ]
  %382 = getelementptr %SchemeObject, ptr %381, i32 0, i32 0
  %383 = load i64, ptr %382, align 4
  %is_type_check143 = icmp eq i64 %383, 1
  br i1 %is_type_check143, label %is_boolean_branch141, label %continue_branch140

continue_branch140:                               ; preds = %is_boolean_branch141, %merge_branch135
  %384 = phi ptr [ %381, %merge_branch135 ], [ %391, %is_boolean_branch141 ]
  %number145 = alloca %SchemeObject, align 8
  %385 = getelementptr %SchemeObject, ptr %number145, i32 0, i32 0
  store i64 0, ptr %385, align 4
  %386 = getelementptr %SchemeObject, ptr %number145, i32 0, i32 1
  store i64 400, ptr %386, align 4
  %387 = getelementptr %SchemeObject, ptr %number145, i32 0, i32 0
  %388 = load i64, ptr %387, align 4
  %is_type_check149 = icmp eq i64 %388, 1
  br i1 %is_type_check149, label %is_boolean_branch147, label %continue_branch146

is_boolean_branch141:                             ; preds = %merge_branch135
  %389 = getelementptr %SchemeObject, ptr %381, i32 0, i32 2
  %390 = load i1, ptr %389, align 1
  %is_boolean_smth_check144 = icmp eq i1 %390, false
  %391 = phi ptr [ %381, %merge_branch135 ]
  br i1 %is_boolean_smth_check144, label %is_boolean_smth_branch142, label %continue_branch140

is_boolean_smth_branch142:                        ; preds = %is_boolean_branch141
  %392 = phi ptr [ %391, %is_boolean_branch141 ]
  br label %end_branch125

continue_branch146:                               ; preds = %is_boolean_branch147, %continue_branch140
  %393 = phi ptr [ %number145, %continue_branch140 ], [ %396, %is_boolean_branch147 ]
  br label %end_branch125

is_boolean_branch147:                             ; preds = %continue_branch140
  %394 = getelementptr %SchemeObject, ptr %number145, i32 0, i32 2
  %395 = load i1, ptr %394, align 1
  %is_boolean_smth_check150 = icmp eq i1 %395, false
  %396 = phi ptr [ %number145, %continue_branch140 ]
  br i1 %is_boolean_smth_check150, label %is_boolean_smth_branch148, label %continue_branch146

is_boolean_smth_branch148:                        ; preds = %is_boolean_branch147
  %397 = phi ptr [ %396, %is_boolean_branch147 ]
  br label %end_branch125

end_branch152:                                    ; preds = %end_branch125
  %boolean153 = alloca %SchemeObject, align 8
  %398 = getelementptr %SchemeObject, ptr %boolean153, i32 0, i32 0
  store i64 1, ptr %398, align 4
  %399 = getelementptr %SchemeObject, ptr %boolean153, i32 0, i32 2
  store i1 false, ptr %399, align 1
  call void @__GLPrint(ptr %boolean153)
  br label %comparison_branch155

end_branch154:                                    ; preds = %continue_branch176, %is_boolean_smth_branch178, %is_boolean_smth_branch165
  %400 = phi ptr [ %431, %is_boolean_smth_branch165 ], [ %458, %is_boolean_smth_branch178 ], [ %454, %continue_branch176 ]
  call void @__GLPrint(ptr %400)
  %boolean182 = alloca %SchemeObject, align 8
  %401 = getelementptr %SchemeObject, ptr %boolean182, i32 0, i32 0
  store i64 1, ptr %401, align 4
  %402 = getelementptr %SchemeObject, ptr %boolean182, i32 0, i32 2
  store i1 false, ptr %402, align 1
  %403 = getelementptr %SchemeObject, ptr %boolean182, i32 0, i32 0
  %404 = load i64, ptr %403, align 4
  %is_type_check186 = icmp eq i64 %404, 1
  br i1 %is_type_check186, label %is_boolean_branch184, label %continue_branch183

comparison_branch155:                             ; preds = %end_branch152
  %number159 = alloca %SchemeObject, align 8
  %405 = getelementptr %SchemeObject, ptr %number159, i32 0, i32 0
  store i64 0, ptr %405, align 4
  %406 = getelementptr %SchemeObject, ptr %number159, i32 0, i32 1
  store i64 200, ptr %406, align 4
  %407 = getelementptr %SchemeObject, ptr %number159, i32 0, i32 0
  %408 = load i64, ptr %407, align 4
  %409 = icmp eq i64 %408, 0
  call void @__GLAssert(i1 %409)
  %number160 = alloca %SchemeObject, align 8
  %410 = getelementptr %SchemeObject, ptr %number160, i32 0, i32 0
  store i64 0, ptr %410, align 4
  %411 = getelementptr %SchemeObject, ptr %number160, i32 0, i32 1
  store i64 200, ptr %411, align 4
  %412 = getelementptr %SchemeObject, ptr %number160, i32 0, i32 0
  %413 = load i64, ptr %412, align 4
  %414 = icmp eq i64 %413, 0
  call void @__GLAssert(i1 %414)
  %415 = getelementptr %SchemeObject, ptr %number159, i32 0, i32 1
  %416 = load i64, ptr %415, align 4
  %417 = getelementptr %SchemeObject, ptr %number160, i32 0, i32 1
  %418 = load i64, ptr %417, align 4
  %419 = icmp ne i64 %416, %418
  br i1 %419, label %false_branch157, label %true_branch156

true_branch156:                                   ; preds = %comparison_branch155
  %boolean161 = alloca %SchemeObject, align 8
  %420 = getelementptr %SchemeObject, ptr %boolean161, i32 0, i32 0
  store i64 1, ptr %420, align 4
  %421 = getelementptr %SchemeObject, ptr %boolean161, i32 0, i32 2
  store i1 true, ptr %421, align 1
  br label %merge_branch158

false_branch157:                                  ; preds = %comparison_branch155
  %boolean162 = alloca %SchemeObject, align 8
  %422 = getelementptr %SchemeObject, ptr %boolean162, i32 0, i32 0
  store i64 1, ptr %422, align 4
  %423 = getelementptr %SchemeObject, ptr %boolean162, i32 0, i32 2
  store i1 false, ptr %423, align 1
  br label %merge_branch158

merge_branch158:                                  ; preds = %false_branch157, %true_branch156
  %424 = phi ptr [ %boolean161, %true_branch156 ], [ %boolean162, %false_branch157 ]
  %425 = getelementptr %SchemeObject, ptr %424, i32 0, i32 0
  %426 = load i64, ptr %425, align 4
  %is_type_check166 = icmp eq i64 %426, 1
  br i1 %is_type_check166, label %is_boolean_branch164, label %continue_branch163

continue_branch163:                               ; preds = %is_boolean_branch164, %merge_branch158
  %427 = phi ptr [ %424, %merge_branch158 ], [ %430, %is_boolean_branch164 ]
  br label %comparison_branch168

is_boolean_branch164:                             ; preds = %merge_branch158
  %428 = getelementptr %SchemeObject, ptr %424, i32 0, i32 2
  %429 = load i1, ptr %428, align 1
  %is_boolean_smth_check167 = icmp eq i1 %429, true
  %430 = phi ptr [ %424, %merge_branch158 ]
  br i1 %is_boolean_smth_check167, label %is_boolean_smth_branch165, label %continue_branch163

is_boolean_smth_branch165:                        ; preds = %is_boolean_branch164
  %431 = phi ptr [ %430, %is_boolean_branch164 ]
  br label %end_branch154

comparison_branch168:                             ; preds = %continue_branch163
  %number172 = alloca %SchemeObject, align 8
  %432 = getelementptr %SchemeObject, ptr %number172, i32 0, i32 0
  store i64 0, ptr %432, align 4
  %433 = getelementptr %SchemeObject, ptr %number172, i32 0, i32 1
  store i64 200, ptr %433, align 4
  %434 = getelementptr %SchemeObject, ptr %number172, i32 0, i32 0
  %435 = load i64, ptr %434, align 4
  %436 = icmp eq i64 %435, 0
  call void @__GLAssert(i1 %436)
  %number173 = alloca %SchemeObject, align 8
  %437 = getelementptr %SchemeObject, ptr %number173, i32 0, i32 0
  store i64 0, ptr %437, align 4
  %438 = getelementptr %SchemeObject, ptr %number173, i32 0, i32 1
  store i64 100, ptr %438, align 4
  %439 = getelementptr %SchemeObject, ptr %number173, i32 0, i32 0
  %440 = load i64, ptr %439, align 4
  %441 = icmp eq i64 %440, 0
  call void @__GLAssert(i1 %441)
  %442 = getelementptr %SchemeObject, ptr %number172, i32 0, i32 1
  %443 = load i64, ptr %442, align 4
  %444 = getelementptr %SchemeObject, ptr %number173, i32 0, i32 1
  %445 = load i64, ptr %444, align 4
  %446 = icmp sle i64 %443, %445
  br i1 %446, label %false_branch170, label %true_branch169

true_branch169:                                   ; preds = %comparison_branch168
  %boolean174 = alloca %SchemeObject, align 8
  %447 = getelementptr %SchemeObject, ptr %boolean174, i32 0, i32 0
  store i64 1, ptr %447, align 4
  %448 = getelementptr %SchemeObject, ptr %boolean174, i32 0, i32 2
  store i1 true, ptr %448, align 1
  br label %merge_branch171

false_branch170:                                  ; preds = %comparison_branch168
  %boolean175 = alloca %SchemeObject, align 8
  %449 = getelementptr %SchemeObject, ptr %boolean175, i32 0, i32 0
  store i64 1, ptr %449, align 4
  %450 = getelementptr %SchemeObject, ptr %boolean175, i32 0, i32 2
  store i1 false, ptr %450, align 1
  br label %merge_branch171

merge_branch171:                                  ; preds = %false_branch170, %true_branch169
  %451 = phi ptr [ %boolean174, %true_branch169 ], [ %boolean175, %false_branch170 ]
  %452 = getelementptr %SchemeObject, ptr %451, i32 0, i32 0
  %453 = load i64, ptr %452, align 4
  %is_type_check179 = icmp eq i64 %453, 1
  br i1 %is_type_check179, label %is_boolean_branch177, label %continue_branch176

continue_branch176:                               ; preds = %is_boolean_branch177, %merge_branch171
  %454 = phi ptr [ %451, %merge_branch171 ], [ %457, %is_boolean_branch177 ]
  br label %end_branch154

is_boolean_branch177:                             ; preds = %merge_branch171
  %455 = getelementptr %SchemeObject, ptr %451, i32 0, i32 2
  %456 = load i1, ptr %455, align 1
  %is_boolean_smth_check180 = icmp eq i1 %456, true
  %457 = phi ptr [ %451, %merge_branch171 ]
  br i1 %is_boolean_smth_check180, label %is_boolean_smth_branch178, label %continue_branch176

is_boolean_smth_branch178:                        ; preds = %is_boolean_branch177
  %458 = phi ptr [ %457, %is_boolean_branch177 ]
  br label %end_branch154

end_branch181:                                    ; preds = %continue_branch196, %is_boolean_smth_branch198, %is_boolean_smth_branch185
  %459 = phi ptr [ %468, %is_boolean_smth_branch185 ], [ %495, %is_boolean_smth_branch198 ], [ %491, %continue_branch196 ]
  call void @__GLPrint(ptr %459)
  %boolean202 = alloca %SchemeObject, align 8
  %460 = getelementptr %SchemeObject, ptr %boolean202, i32 0, i32 0
  store i64 1, ptr %460, align 4
  %461 = getelementptr %SchemeObject, ptr %boolean202, i32 0, i32 2
  store i1 false, ptr %461, align 1
  %462 = getelementptr %SchemeObject, ptr %boolean202, i32 0, i32 0
  %463 = load i64, ptr %462, align 4
  %is_type_check206 = icmp eq i64 %463, 1
  br i1 %is_type_check206, label %is_boolean_branch204, label %continue_branch203

continue_branch183:                               ; preds = %is_boolean_branch184, %end_branch154
  %464 = phi ptr [ %boolean182, %end_branch154 ], [ %467, %is_boolean_branch184 ]
  br label %comparison_branch188

is_boolean_branch184:                             ; preds = %end_branch154
  %465 = getelementptr %SchemeObject, ptr %boolean182, i32 0, i32 2
  %466 = load i1, ptr %465, align 1
  %is_boolean_smth_check187 = icmp eq i1 %466, true
  %467 = phi ptr [ %boolean182, %end_branch154 ]
  br i1 %is_boolean_smth_check187, label %is_boolean_smth_branch185, label %continue_branch183

is_boolean_smth_branch185:                        ; preds = %is_boolean_branch184
  %468 = phi ptr [ %467, %is_boolean_branch184 ]
  br label %end_branch181

comparison_branch188:                             ; preds = %continue_branch183
  %number192 = alloca %SchemeObject, align 8
  %469 = getelementptr %SchemeObject, ptr %number192, i32 0, i32 0
  store i64 0, ptr %469, align 4
  %470 = getelementptr %SchemeObject, ptr %number192, i32 0, i32 1
  store i64 200, ptr %470, align 4
  %471 = getelementptr %SchemeObject, ptr %number192, i32 0, i32 0
  %472 = load i64, ptr %471, align 4
  %473 = icmp eq i64 %472, 0
  call void @__GLAssert(i1 %473)
  %number193 = alloca %SchemeObject, align 8
  %474 = getelementptr %SchemeObject, ptr %number193, i32 0, i32 0
  store i64 0, ptr %474, align 4
  %475 = getelementptr %SchemeObject, ptr %number193, i32 0, i32 1
  store i64 100, ptr %475, align 4
  %476 = getelementptr %SchemeObject, ptr %number193, i32 0, i32 0
  %477 = load i64, ptr %476, align 4
  %478 = icmp eq i64 %477, 0
  call void @__GLAssert(i1 %478)
  %479 = getelementptr %SchemeObject, ptr %number192, i32 0, i32 1
  %480 = load i64, ptr %479, align 4
  %481 = getelementptr %SchemeObject, ptr %number193, i32 0, i32 1
  %482 = load i64, ptr %481, align 4
  %483 = icmp sge i64 %480, %482
  br i1 %483, label %false_branch190, label %true_branch189

true_branch189:                                   ; preds = %comparison_branch188
  %boolean194 = alloca %SchemeObject, align 8
  %484 = getelementptr %SchemeObject, ptr %boolean194, i32 0, i32 0
  store i64 1, ptr %484, align 4
  %485 = getelementptr %SchemeObject, ptr %boolean194, i32 0, i32 2
  store i1 true, ptr %485, align 1
  br label %merge_branch191

false_branch190:                                  ; preds = %comparison_branch188
  %boolean195 = alloca %SchemeObject, align 8
  %486 = getelementptr %SchemeObject, ptr %boolean195, i32 0, i32 0
  store i64 1, ptr %486, align 4
  %487 = getelementptr %SchemeObject, ptr %boolean195, i32 0, i32 2
  store i1 false, ptr %487, align 1
  br label %merge_branch191

merge_branch191:                                  ; preds = %false_branch190, %true_branch189
  %488 = phi ptr [ %boolean194, %true_branch189 ], [ %boolean195, %false_branch190 ]
  %489 = getelementptr %SchemeObject, ptr %488, i32 0, i32 0
  %490 = load i64, ptr %489, align 4
  %is_type_check199 = icmp eq i64 %490, 1
  br i1 %is_type_check199, label %is_boolean_branch197, label %continue_branch196

continue_branch196:                               ; preds = %is_boolean_branch197, %merge_branch191
  %491 = phi ptr [ %488, %merge_branch191 ], [ %494, %is_boolean_branch197 ]
  br label %end_branch181

is_boolean_branch197:                             ; preds = %merge_branch191
  %492 = getelementptr %SchemeObject, ptr %488, i32 0, i32 2
  %493 = load i1, ptr %492, align 1
  %is_boolean_smth_check200 = icmp eq i1 %493, true
  %494 = phi ptr [ %488, %merge_branch191 ]
  br i1 %is_boolean_smth_check200, label %is_boolean_smth_branch198, label %continue_branch196

is_boolean_smth_branch198:                        ; preds = %is_boolean_branch197
  %495 = phi ptr [ %494, %is_boolean_branch197 ]
  br label %end_branch181

end_branch201:                                    ; preds = %continue_branch209, %is_boolean_smth_branch211, %is_boolean_smth_branch205
  %496 = phi ptr [ %511, %is_boolean_smth_branch205 ], [ %516, %is_boolean_smth_branch211 ], [ %512, %continue_branch209 ]
  call void @__GLPrint(ptr %496)
  %symbol214 = alloca %SchemeObject, align 8
  %497 = getelementptr %SchemeObject, ptr %symbol214, i32 0, i32 0
  store i64 2, ptr %497, align 4
  %498 = getelementptr %SchemeObject, ptr %symbol214, i32 0, i32 3
  store ptr @symbol_global.2, ptr %498, align 8
  call void @__GLPrint(ptr %symbol214)
  %boolean218 = alloca %SchemeObject, align 8
  %499 = getelementptr %SchemeObject, ptr %boolean218, i32 0, i32 0
  store i64 1, ptr %499, align 4
  %500 = getelementptr %SchemeObject, ptr %boolean218, i32 0, i32 2
  store i1 true, ptr %500, align 1
  %501 = getelementptr %SchemeObject, ptr %boolean218, i32 0, i32 0
  %502 = load i64, ptr %501, align 4
  %is_type_check219 = icmp eq i64 %502, 1
  br i1 %is_type_check219, label %true_branch215, label %false_branch216

continue_branch203:                               ; preds = %is_boolean_branch204, %end_branch181
  %503 = phi ptr [ %boolean202, %end_branch181 ], [ %510, %is_boolean_branch204 ]
  %number208 = alloca %SchemeObject, align 8
  %504 = getelementptr %SchemeObject, ptr %number208, i32 0, i32 0
  store i64 0, ptr %504, align 4
  %505 = getelementptr %SchemeObject, ptr %number208, i32 0, i32 1
  store i64 100, ptr %505, align 4
  %506 = getelementptr %SchemeObject, ptr %number208, i32 0, i32 0
  %507 = load i64, ptr %506, align 4
  %is_type_check212 = icmp eq i64 %507, 1
  br i1 %is_type_check212, label %is_boolean_branch210, label %continue_branch209

is_boolean_branch204:                             ; preds = %end_branch181
  %508 = getelementptr %SchemeObject, ptr %boolean202, i32 0, i32 2
  %509 = load i1, ptr %508, align 1
  %is_boolean_smth_check207 = icmp eq i1 %509, true
  %510 = phi ptr [ %boolean202, %end_branch181 ]
  br i1 %is_boolean_smth_check207, label %is_boolean_smth_branch205, label %continue_branch203

is_boolean_smth_branch205:                        ; preds = %is_boolean_branch204
  %511 = phi ptr [ %510, %is_boolean_branch204 ]
  br label %end_branch201

continue_branch209:                               ; preds = %is_boolean_branch210, %continue_branch203
  %512 = phi ptr [ %number208, %continue_branch203 ], [ %515, %is_boolean_branch210 ]
  br label %end_branch201

is_boolean_branch210:                             ; preds = %continue_branch203
  %513 = getelementptr %SchemeObject, ptr %number208, i32 0, i32 2
  %514 = load i1, ptr %513, align 1
  %is_boolean_smth_check213 = icmp eq i1 %514, true
  %515 = phi ptr [ %number208, %continue_branch203 ]
  br i1 %is_boolean_smth_check213, label %is_boolean_smth_branch211, label %continue_branch209

is_boolean_smth_branch211:                        ; preds = %is_boolean_branch210
  %516 = phi ptr [ %515, %is_boolean_branch210 ]
  br label %end_branch201

true_branch215:                                   ; preds = %end_branch201
  %boolean220 = alloca %SchemeObject, align 8
  %517 = getelementptr %SchemeObject, ptr %boolean220, i32 0, i32 0
  store i64 1, ptr %517, align 4
  %518 = getelementptr %SchemeObject, ptr %boolean220, i32 0, i32 2
  store i1 true, ptr %518, align 1
  br label %merge_branch217

false_branch216:                                  ; preds = %end_branch201
  %boolean221 = alloca %SchemeObject, align 8
  %519 = getelementptr %SchemeObject, ptr %boolean221, i32 0, i32 0
  store i64 1, ptr %519, align 4
  %520 = getelementptr %SchemeObject, ptr %boolean221, i32 0, i32 2
  store i1 false, ptr %520, align 1
  br label %merge_branch217

merge_branch217:                                  ; preds = %false_branch216, %true_branch215
  %521 = phi ptr [ %boolean220, %true_branch215 ], [ %boolean221, %false_branch216 ]
  call void @__GLPrint(ptr %521)
  %boolean225 = alloca %SchemeObject, align 8
  %522 = getelementptr %SchemeObject, ptr %boolean225, i32 0, i32 0
  store i64 1, ptr %522, align 4
  %523 = getelementptr %SchemeObject, ptr %boolean225, i32 0, i32 2
  store i1 false, ptr %523, align 1
  %524 = getelementptr %SchemeObject, ptr %boolean225, i32 0, i32 0
  %525 = load i64, ptr %524, align 4
  %is_type_check226 = icmp eq i64 %525, 1
  br i1 %is_type_check226, label %true_branch222, label %false_branch223

true_branch222:                                   ; preds = %merge_branch217
  %boolean227 = alloca %SchemeObject, align 8
  %526 = getelementptr %SchemeObject, ptr %boolean227, i32 0, i32 0
  store i64 1, ptr %526, align 4
  %527 = getelementptr %SchemeObject, ptr %boolean227, i32 0, i32 2
  store i1 true, ptr %527, align 1
  br label %merge_branch224

false_branch223:                                  ; preds = %merge_branch217
  %boolean228 = alloca %SchemeObject, align 8
  %528 = getelementptr %SchemeObject, ptr %boolean228, i32 0, i32 0
  store i64 1, ptr %528, align 4
  %529 = getelementptr %SchemeObject, ptr %boolean228, i32 0, i32 2
  store i1 false, ptr %529, align 1
  br label %merge_branch224

merge_branch224:                                  ; preds = %false_branch223, %true_branch222
  %530 = phi ptr [ %boolean227, %true_branch222 ], [ %boolean228, %false_branch223 ]
  call void @__GLPrint(ptr %530)
  %number232 = alloca %SchemeObject, align 8
  %531 = getelementptr %SchemeObject, ptr %number232, i32 0, i32 0
  store i64 0, ptr %531, align 4
  %532 = getelementptr %SchemeObject, ptr %number232, i32 0, i32 1
  store i64 100, ptr %532, align 4
  %533 = getelementptr %SchemeObject, ptr %number232, i32 0, i32 0
  %534 = load i64, ptr %533, align 4
  %is_type_check233 = icmp eq i64 %534, 1
  br i1 %is_type_check233, label %true_branch229, label %false_branch230

true_branch229:                                   ; preds = %merge_branch224
  %boolean234 = alloca %SchemeObject, align 8
  %535 = getelementptr %SchemeObject, ptr %boolean234, i32 0, i32 0
  store i64 1, ptr %535, align 4
  %536 = getelementptr %SchemeObject, ptr %boolean234, i32 0, i32 2
  store i1 true, ptr %536, align 1
  br label %merge_branch231

false_branch230:                                  ; preds = %merge_branch224
  %boolean235 = alloca %SchemeObject, align 8
  %537 = getelementptr %SchemeObject, ptr %boolean235, i32 0, i32 0
  store i64 1, ptr %537, align 4
  %538 = getelementptr %SchemeObject, ptr %boolean235, i32 0, i32 2
  store i1 false, ptr %538, align 1
  br label %merge_branch231

merge_branch231:                                  ; preds = %false_branch230, %true_branch229
  %539 = phi ptr [ %boolean234, %true_branch229 ], [ %boolean235, %false_branch230 ]
  call void @__GLPrint(ptr %539)
  %symbol236 = alloca %SchemeObject, align 8
  %540 = getelementptr %SchemeObject, ptr %symbol236, i32 0, i32 0
  store i64 2, ptr %540, align 4
  %541 = getelementptr %SchemeObject, ptr %symbol236, i32 0, i32 3
  store ptr @symbol_global.3, ptr %541, align 8
  call void @__GLPrint(ptr %symbol236)
  %symbol240 = alloca %SchemeObject, align 8
  %542 = getelementptr %SchemeObject, ptr %symbol240, i32 0, i32 0
  store i64 2, ptr %542, align 4
  %543 = getelementptr %SchemeObject, ptr %symbol240, i32 0, i32 3
  store ptr @symbol_global.4, ptr %543, align 8
  %544 = getelementptr %SchemeObject, ptr %symbol240, i32 0, i32 0
  %545 = load i64, ptr %544, align 4
  %is_type_check241 = icmp eq i64 %545, 2
  br i1 %is_type_check241, label %true_branch237, label %false_branch238

true_branch237:                                   ; preds = %merge_branch231
  %boolean242 = alloca %SchemeObject, align 8
  %546 = getelementptr %SchemeObject, ptr %boolean242, i32 0, i32 0
  store i64 1, ptr %546, align 4
  %547 = getelementptr %SchemeObject, ptr %boolean242, i32 0, i32 2
  store i1 true, ptr %547, align 1
  br label %merge_branch239

false_branch238:                                  ; preds = %merge_branch231
  %boolean243 = alloca %SchemeObject, align 8
  %548 = getelementptr %SchemeObject, ptr %boolean243, i32 0, i32 0
  store i64 1, ptr %548, align 4
  %549 = getelementptr %SchemeObject, ptr %boolean243, i32 0, i32 2
  store i1 false, ptr %549, align 1
  br label %merge_branch239

merge_branch239:                                  ; preds = %false_branch238, %true_branch237
  %550 = phi ptr [ %boolean242, %true_branch237 ], [ %boolean243, %false_branch238 ]
  call void @__GLPrint(ptr %550)
  %number247 = alloca %SchemeObject, align 8
  %551 = getelementptr %SchemeObject, ptr %number247, i32 0, i32 0
  store i64 0, ptr %551, align 4
  %552 = getelementptr %SchemeObject, ptr %number247, i32 0, i32 1
  store i64 100, ptr %552, align 4
  %553 = getelementptr %SchemeObject, ptr %number247, i32 0, i32 0
  %554 = load i64, ptr %553, align 4
  %is_type_check248 = icmp eq i64 %554, 2
  br i1 %is_type_check248, label %true_branch244, label %false_branch245

true_branch244:                                   ; preds = %merge_branch239
  %boolean249 = alloca %SchemeObject, align 8
  %555 = getelementptr %SchemeObject, ptr %boolean249, i32 0, i32 0
  store i64 1, ptr %555, align 4
  %556 = getelementptr %SchemeObject, ptr %boolean249, i32 0, i32 2
  store i1 true, ptr %556, align 1
  br label %merge_branch246

false_branch245:                                  ; preds = %merge_branch239
  %boolean250 = alloca %SchemeObject, align 8
  %557 = getelementptr %SchemeObject, ptr %boolean250, i32 0, i32 0
  store i64 1, ptr %557, align 4
  %558 = getelementptr %SchemeObject, ptr %boolean250, i32 0, i32 2
  store i1 false, ptr %558, align 1
  br label %merge_branch246

merge_branch246:                                  ; preds = %false_branch245, %true_branch244
  %559 = phi ptr [ %boolean249, %true_branch244 ], [ %boolean250, %false_branch245 ]
  call void @__GLPrint(ptr %559)
  %symbol251 = alloca %SchemeObject, align 8
  %560 = getelementptr %SchemeObject, ptr %symbol251, i32 0, i32 0
  store i64 2, ptr %560, align 4
  %561 = getelementptr %SchemeObject, ptr %symbol251, i32 0, i32 3
  store ptr @symbol_global.5, ptr %561, align 8
  call void @__GLPrint(ptr %symbol251)
  %number255 = alloca %SchemeObject, align 8
  %562 = getelementptr %SchemeObject, ptr %number255, i32 0, i32 0
  store i64 0, ptr %562, align 4
  %563 = getelementptr %SchemeObject, ptr %number255, i32 0, i32 1
  store i64 -100, ptr %563, align 4
  %564 = getelementptr %SchemeObject, ptr %number255, i32 0, i32 0
  %565 = load i64, ptr %564, align 4
  %is_type_check256 = icmp eq i64 %565, 0
  br i1 %is_type_check256, label %true_branch252, label %false_branch253

true_branch252:                                   ; preds = %merge_branch246
  %boolean257 = alloca %SchemeObject, align 8
  %566 = getelementptr %SchemeObject, ptr %boolean257, i32 0, i32 0
  store i64 1, ptr %566, align 4
  %567 = getelementptr %SchemeObject, ptr %boolean257, i32 0, i32 2
  store i1 true, ptr %567, align 1
  br label %merge_branch254

false_branch253:                                  ; preds = %merge_branch246
  %boolean258 = alloca %SchemeObject, align 8
  %568 = getelementptr %SchemeObject, ptr %boolean258, i32 0, i32 0
  store i64 1, ptr %568, align 4
  %569 = getelementptr %SchemeObject, ptr %boolean258, i32 0, i32 2
  store i1 false, ptr %569, align 1
  br label %merge_branch254

merge_branch254:                                  ; preds = %false_branch253, %true_branch252
  %570 = phi ptr [ %boolean257, %true_branch252 ], [ %boolean258, %false_branch253 ]
  call void @__GLPrint(ptr %570)
  %number262 = alloca %SchemeObject, align 8
  %571 = getelementptr %SchemeObject, ptr %number262, i32 0, i32 0
  store i64 0, ptr %571, align 4
  %572 = getelementptr %SchemeObject, ptr %number262, i32 0, i32 1
  store i64 100, ptr %572, align 4
  %573 = getelementptr %SchemeObject, ptr %number262, i32 0, i32 0
  %574 = load i64, ptr %573, align 4
  %is_type_check263 = icmp eq i64 %574, 0
  br i1 %is_type_check263, label %true_branch259, label %false_branch260

true_branch259:                                   ; preds = %merge_branch254
  %boolean264 = alloca %SchemeObject, align 8
  %575 = getelementptr %SchemeObject, ptr %boolean264, i32 0, i32 0
  store i64 1, ptr %575, align 4
  %576 = getelementptr %SchemeObject, ptr %boolean264, i32 0, i32 2
  store i1 true, ptr %576, align 1
  br label %merge_branch261

false_branch260:                                  ; preds = %merge_branch254
  %boolean265 = alloca %SchemeObject, align 8
  %577 = getelementptr %SchemeObject, ptr %boolean265, i32 0, i32 0
  store i64 1, ptr %577, align 4
  %578 = getelementptr %SchemeObject, ptr %boolean265, i32 0, i32 2
  store i1 false, ptr %578, align 1
  br label %merge_branch261

merge_branch261:                                  ; preds = %false_branch260, %true_branch259
  %579 = phi ptr [ %boolean264, %true_branch259 ], [ %boolean265, %false_branch260 ]
  call void @__GLPrint(ptr %579)
  %boolean269 = alloca %SchemeObject, align 8
  %580 = getelementptr %SchemeObject, ptr %boolean269, i32 0, i32 0
  store i64 1, ptr %580, align 4
  %581 = getelementptr %SchemeObject, ptr %boolean269, i32 0, i32 2
  store i1 true, ptr %581, align 1
  %582 = getelementptr %SchemeObject, ptr %boolean269, i32 0, i32 0
  %583 = load i64, ptr %582, align 4
  %is_type_check270 = icmp eq i64 %583, 0
  br i1 %is_type_check270, label %true_branch266, label %false_branch267

true_branch266:                                   ; preds = %merge_branch261
  %boolean271 = alloca %SchemeObject, align 8
  %584 = getelementptr %SchemeObject, ptr %boolean271, i32 0, i32 0
  store i64 1, ptr %584, align 4
  %585 = getelementptr %SchemeObject, ptr %boolean271, i32 0, i32 2
  store i1 true, ptr %585, align 1
  br label %merge_branch268

false_branch267:                                  ; preds = %merge_branch261
  %boolean272 = alloca %SchemeObject, align 8
  %586 = getelementptr %SchemeObject, ptr %boolean272, i32 0, i32 0
  store i64 1, ptr %586, align 4
  %587 = getelementptr %SchemeObject, ptr %boolean272, i32 0, i32 2
  store i1 false, ptr %587, align 1
  br label %merge_branch268

merge_branch268:                                  ; preds = %false_branch267, %true_branch266
  %588 = phi ptr [ %boolean271, %true_branch266 ], [ %boolean272, %false_branch267 ]
  call void @__GLPrint(ptr %588)
  %589 = alloca %SchemeObject, align 8
  %590 = getelementptr %SchemeObject, ptr %589, i32 0, i32 0
  store i64 3, ptr %590, align 4
  %591 = getelementptr %SchemeObject, ptr %589, i32 0, i32 4
  store ptr null, ptr %591, align 8
  %592 = getelementptr %SchemeObject, ptr %589, i32 0, i32 5
  store ptr null, ptr %592, align 8
  %number273 = alloca %SchemeObject, align 8
  %593 = getelementptr %SchemeObject, ptr %number273, i32 0, i32 0
  store i64 0, ptr %593, align 4
  %594 = getelementptr %SchemeObject, ptr %number273, i32 0, i32 1
  store i64 100, ptr %594, align 4
  %595 = getelementptr %SchemeObject, ptr %589, i32 0, i32 4
  store ptr %number273, ptr %595, align 8
  %596 = alloca %SchemeObject, align 8
  %597 = getelementptr %SchemeObject, ptr %596, i32 0, i32 0
  store i64 3, ptr %597, align 4
  %598 = getelementptr %SchemeObject, ptr %596, i32 0, i32 4
  store ptr null, ptr %598, align 8
  %599 = getelementptr %SchemeObject, ptr %596, i32 0, i32 5
  store ptr null, ptr %599, align 8
  %600 = getelementptr %SchemeObject, ptr %589, i32 0, i32 5
  store ptr %596, ptr %600, align 8
  %number274 = alloca %SchemeObject, align 8
  %601 = getelementptr %SchemeObject, ptr %number274, i32 0, i32 0
  store i64 0, ptr %601, align 4
  %602 = getelementptr %SchemeObject, ptr %number274, i32 0, i32 1
  store i64 200, ptr %602, align 4
  %603 = getelementptr %SchemeObject, ptr %596, i32 0, i32 4
  store ptr %number274, ptr %603, align 8
  %604 = alloca %SchemeObject, align 8
  %605 = getelementptr %SchemeObject, ptr %604, i32 0, i32 0
  store i64 3, ptr %605, align 4
  %606 = getelementptr %SchemeObject, ptr %604, i32 0, i32 4
  store ptr null, ptr %606, align 8
  %607 = getelementptr %SchemeObject, ptr %604, i32 0, i32 5
  store ptr null, ptr %607, align 8
  %608 = getelementptr %SchemeObject, ptr %596, i32 0, i32 5
  store ptr %604, ptr %608, align 8
  %number275 = alloca %SchemeObject, align 8
  %609 = getelementptr %SchemeObject, ptr %number275, i32 0, i32 0
  store i64 0, ptr %609, align 4
  %610 = getelementptr %SchemeObject, ptr %number275, i32 0, i32 1
  store i64 300, ptr %610, align 4
  %611 = getelementptr %SchemeObject, ptr %604, i32 0, i32 4
  store ptr %number275, ptr %611, align 8
  %612 = alloca %SchemeObject, align 8
  %613 = getelementptr %SchemeObject, ptr %612, i32 0, i32 0
  store i64 3, ptr %613, align 4
  %614 = getelementptr %SchemeObject, ptr %612, i32 0, i32 4
  store ptr null, ptr %614, align 8
  %615 = getelementptr %SchemeObject, ptr %612, i32 0, i32 5
  store ptr null, ptr %615, align 8
  %616 = getelementptr %SchemeObject, ptr %604, i32 0, i32 5
  store ptr %612, ptr %616, align 8
  %617 = getelementptr %SchemeObject, ptr %604, i32 0, i32 5
  store ptr null, ptr %617, align 8
  %variable276 = alloca %SchemeObject, align 8
  %618 = getelementptr %SchemeObject, ptr %589, i32 0
  %619 = load %SchemeObject, ptr %618, align 8
  store %SchemeObject %619, ptr %variable276, align 8
  %symbol277 = alloca %SchemeObject, align 8
  %620 = getelementptr %SchemeObject, ptr %symbol277, i32 0, i32 0
  store i64 2, ptr %620, align 4
  %621 = getelementptr %SchemeObject, ptr %symbol277, i32 0, i32 3
  store ptr @symbol_global.6, ptr %621, align 8
  call void @__GLPrint(ptr %symbol277)
  %622 = alloca %SchemeObject, align 8
  %623 = getelementptr %SchemeObject, ptr %622, i32 0, i32 0
  store i64 3, ptr %623, align 4
  %624 = getelementptr %SchemeObject, ptr %622, i32 0, i32 4
  store ptr null, ptr %624, align 8
  %625 = getelementptr %SchemeObject, ptr %622, i32 0, i32 5
  store ptr null, ptr %625, align 8
  %number278 = alloca %SchemeObject, align 8
  %626 = getelementptr %SchemeObject, ptr %number278, i32 0, i32 0
  store i64 0, ptr %626, align 4
  %627 = getelementptr %SchemeObject, ptr %number278, i32 0, i32 1
  store i64 100, ptr %627, align 4
  %628 = getelementptr %SchemeObject, ptr %622, i32 0, i32 4
  store ptr %number278, ptr %628, align 8
  %number279 = alloca %SchemeObject, align 8
  %629 = getelementptr %SchemeObject, ptr %number279, i32 0, i32 0
  store i64 0, ptr %629, align 4
  %630 = getelementptr %SchemeObject, ptr %number279, i32 0, i32 1
  store i64 200, ptr %630, align 4
  %631 = getelementptr %SchemeObject, ptr %622, i32 0, i32 5
  store ptr %number279, ptr %631, align 8
  call void @__GLPrint(ptr %622)
  %symbol280 = alloca %SchemeObject, align 8
  %632 = getelementptr %SchemeObject, ptr %symbol280, i32 0, i32 0
  store i64 2, ptr %632, align 4
  %633 = getelementptr %SchemeObject, ptr %symbol280, i32 0, i32 3
  store ptr @symbol_global.7, ptr %633, align 8
  call void @__GLPrint(ptr %symbol280)
  %634 = getelementptr %SchemeObject, ptr %variable276, i32 0, i32 0
  %635 = load i64, ptr %634, align 4
  %is_type_check288 = icmp eq i64 %635, 3
  br i1 %is_type_check288, label %true_branch285, label %false_branch286

continue_branch281:                               ; preds = %merge_branch287
  %636 = getelementptr %SchemeObject, ptr %654, i32 0, i32 0
  %637 = load i64, ptr %636, align 4
  %is_type_check289 = icmp eq i64 %637, 3
  br i1 %is_type_check289, label %is_cell_branch, label %false_branch283

is_cell_branch:                                   ; preds = %continue_branch281
  %638 = getelementptr %SchemeObject, ptr %654, i32 0, i32 4
  %639 = load ptr, ptr %638, align 8
  %640 = icmp eq ptr %639, null
  br i1 %640, label %is_cell_first_null_branch, label %false_branch283

is_cell_first_null_branch:                        ; preds = %is_cell_branch
  %641 = getelementptr %SchemeObject, ptr %654, i32 0, i32 5
  %642 = load ptr, ptr %641, align 8
  %643 = icmp eq ptr %642, null
  br i1 %643, label %true_branch282, label %false_branch283

true_branch282:                                   ; preds = %is_cell_first_null_branch, %merge_branch287
  %boolean290 = alloca %SchemeObject, align 8
  %644 = getelementptr %SchemeObject, ptr %boolean290, i32 0, i32 0
  store i64 1, ptr %644, align 4
  %645 = getelementptr %SchemeObject, ptr %boolean290, i32 0, i32 2
  store i1 true, ptr %645, align 1
  br label %merge_branch284

false_branch283:                                  ; preds = %is_cell_first_null_branch, %is_cell_branch, %continue_branch281
  %boolean291 = alloca %SchemeObject, align 8
  %646 = getelementptr %SchemeObject, ptr %boolean291, i32 0, i32 0
  store i64 1, ptr %646, align 4
  %647 = getelementptr %SchemeObject, ptr %boolean291, i32 0, i32 2
  store i1 false, ptr %647, align 1
  br label %merge_branch284

merge_branch284:                                  ; preds = %false_branch283, %true_branch282
  %648 = phi ptr [ %boolean290, %true_branch282 ], [ %boolean291, %false_branch283 ]
  call void @__GLPrint(ptr %648)
  %649 = getelementptr %SchemeObject, ptr %variable276, i32 0, i32 0
  %650 = load i64, ptr %649, align 4
  %is_type_check301 = icmp eq i64 %650, 3
  br i1 %is_type_check301, label %true_branch298, label %false_branch299

true_branch285:                                   ; preds = %merge_branch268
  %651 = getelementptr %SchemeObject, ptr %variable276, i32 0, i32 4
  %652 = load ptr, ptr %651, align 8
  br label %merge_branch287

false_branch286:                                  ; preds = %merge_branch268
  %653 = phi ptr [ %variable276, %merge_branch268 ]
  br label %merge_branch287

merge_branch287:                                  ; preds = %false_branch286, %true_branch285
  %654 = phi ptr [ %652, %true_branch285 ], [ %653, %false_branch286 ]
  %655 = icmp eq ptr %654, null
  br i1 %655, label %true_branch282, label %continue_branch281

continue_branch292:                               ; preds = %merge_branch300
  %656 = getelementptr %SchemeObject, ptr %677, i32 0, i32 0
  %657 = load i64, ptr %656, align 4
  %is_type_check302 = icmp eq i64 %657, 3
  br i1 %is_type_check302, label %is_cell_branch293, label %false_branch296

is_cell_branch293:                                ; preds = %continue_branch292
  %658 = getelementptr %SchemeObject, ptr %677, i32 0, i32 4
  %659 = load ptr, ptr %658, align 8
  %660 = icmp eq ptr %659, null
  br i1 %660, label %is_cell_first_null_branch294, label %false_branch296

is_cell_first_null_branch294:                     ; preds = %is_cell_branch293
  %661 = getelementptr %SchemeObject, ptr %677, i32 0, i32 5
  %662 = load ptr, ptr %661, align 8
  %663 = icmp eq ptr %662, null
  br i1 %663, label %true_branch295, label %false_branch296

true_branch295:                                   ; preds = %is_cell_first_null_branch294, %merge_branch300
  %boolean303 = alloca %SchemeObject, align 8
  %664 = getelementptr %SchemeObject, ptr %boolean303, i32 0, i32 0
  store i64 1, ptr %664, align 4
  %665 = getelementptr %SchemeObject, ptr %boolean303, i32 0, i32 2
  store i1 true, ptr %665, align 1
  br label %merge_branch297

false_branch296:                                  ; preds = %is_cell_first_null_branch294, %is_cell_branch293, %continue_branch292
  %boolean304 = alloca %SchemeObject, align 8
  %666 = getelementptr %SchemeObject, ptr %boolean304, i32 0, i32 0
  store i64 1, ptr %666, align 4
  %667 = getelementptr %SchemeObject, ptr %boolean304, i32 0, i32 2
  store i1 false, ptr %667, align 1
  br label %merge_branch297

merge_branch297:                                  ; preds = %false_branch296, %true_branch295
  %668 = phi ptr [ %boolean303, %true_branch295 ], [ %boolean304, %false_branch296 ]
  call void @__GLPrint(ptr %668)
  %669 = getelementptr %SchemeObject, ptr %variable276, i32 0, i32 0
  %670 = load i64, ptr %669, align 4
  %is_type_check317 = icmp eq i64 %670, 3
  br i1 %is_type_check317, label %true_branch314, label %false_branch315

true_branch298:                                   ; preds = %merge_branch284
  %671 = getelementptr %SchemeObject, ptr %variable276, i32 0, i32 5
  %672 = load ptr, ptr %671, align 8
  br label %merge_branch300

false_branch299:                                  ; preds = %merge_branch284
  %673 = alloca %SchemeObject, align 8
  %674 = getelementptr %SchemeObject, ptr %673, i32 0, i32 0
  store i64 3, ptr %674, align 4
  %675 = getelementptr %SchemeObject, ptr %673, i32 0, i32 4
  store ptr null, ptr %675, align 8
  %676 = getelementptr %SchemeObject, ptr %673, i32 0, i32 5
  store ptr null, ptr %676, align 8
  br label %merge_branch300

merge_branch300:                                  ; preds = %false_branch299, %true_branch298
  %677 = phi ptr [ %672, %true_branch298 ], [ %673, %false_branch299 ]
  %678 = icmp eq ptr %677, null
  br i1 %678, label %true_branch295, label %continue_branch292

continue_branch305:                               ; preds = %merge_branch313
  %679 = getelementptr %SchemeObject, ptr %697, i32 0, i32 0
  %680 = load i64, ptr %679, align 4
  %is_type_check319 = icmp eq i64 %680, 3
  br i1 %is_type_check319, label %is_cell_branch306, label %false_branch309

is_cell_branch306:                                ; preds = %continue_branch305
  %681 = getelementptr %SchemeObject, ptr %697, i32 0, i32 4
  %682 = load ptr, ptr %681, align 8
  %683 = icmp eq ptr %682, null
  br i1 %683, label %is_cell_first_null_branch307, label %false_branch309

is_cell_first_null_branch307:                     ; preds = %is_cell_branch306
  %684 = getelementptr %SchemeObject, ptr %697, i32 0, i32 5
  %685 = load ptr, ptr %684, align 8
  %686 = icmp eq ptr %685, null
  br i1 %686, label %true_branch308, label %false_branch309

true_branch308:                                   ; preds = %is_cell_first_null_branch307, %merge_branch313
  %boolean320 = alloca %SchemeObject, align 8
  %687 = getelementptr %SchemeObject, ptr %boolean320, i32 0, i32 0
  store i64 1, ptr %687, align 4
  %688 = getelementptr %SchemeObject, ptr %boolean320, i32 0, i32 2
  store i1 true, ptr %688, align 1
  br label %merge_branch310

false_branch309:                                  ; preds = %is_cell_first_null_branch307, %is_cell_branch306, %continue_branch305
  %boolean321 = alloca %SchemeObject, align 8
  %689 = getelementptr %SchemeObject, ptr %boolean321, i32 0, i32 0
  store i64 1, ptr %689, align 4
  %690 = getelementptr %SchemeObject, ptr %boolean321, i32 0, i32 2
  store i1 false, ptr %690, align 1
  br label %merge_branch310

merge_branch310:                                  ; preds = %false_branch309, %true_branch308
  %691 = phi ptr [ %boolean320, %true_branch308 ], [ %boolean321, %false_branch309 ]
  call void @__GLPrint(ptr %691)
  %692 = getelementptr %SchemeObject, ptr %variable276, i32 0, i32 0
  %693 = load i64, ptr %692, align 4
  %is_type_check334 = icmp eq i64 %693, 3
  br i1 %is_type_check334, label %true_branch331, label %false_branch332

true_branch311:                                   ; preds = %merge_branch316
  %694 = getelementptr %SchemeObject, ptr %705, i32 0, i32 4
  %695 = load ptr, ptr %694, align 8
  br label %merge_branch313

false_branch312:                                  ; preds = %merge_branch316
  %696 = phi ptr [ %705, %merge_branch316 ]
  br label %merge_branch313

merge_branch313:                                  ; preds = %false_branch312, %true_branch311
  %697 = phi ptr [ %695, %true_branch311 ], [ %696, %false_branch312 ]
  %698 = icmp eq ptr %697, null
  br i1 %698, label %true_branch308, label %continue_branch305

true_branch314:                                   ; preds = %merge_branch297
  %699 = getelementptr %SchemeObject, ptr %variable276, i32 0, i32 5
  %700 = load ptr, ptr %699, align 8
  br label %merge_branch316

false_branch315:                                  ; preds = %merge_branch297
  %701 = alloca %SchemeObject, align 8
  %702 = getelementptr %SchemeObject, ptr %701, i32 0, i32 0
  store i64 3, ptr %702, align 4
  %703 = getelementptr %SchemeObject, ptr %701, i32 0, i32 4
  store ptr null, ptr %703, align 8
  %704 = getelementptr %SchemeObject, ptr %701, i32 0, i32 5
  store ptr null, ptr %704, align 8
  br label %merge_branch316

merge_branch316:                                  ; preds = %false_branch315, %true_branch314
  %705 = phi ptr [ %700, %true_branch314 ], [ %701, %false_branch315 ]
  %706 = getelementptr %SchemeObject, ptr %705, i32 0, i32 0
  %707 = load i64, ptr %706, align 4
  %is_type_check318 = icmp eq i64 %707, 3
  br i1 %is_type_check318, label %true_branch311, label %false_branch312

continue_branch322:                               ; preds = %merge_branch330
  %708 = getelementptr %SchemeObject, ptr %729, i32 0, i32 0
  %709 = load i64, ptr %708, align 4
  %is_type_check336 = icmp eq i64 %709, 3
  br i1 %is_type_check336, label %is_cell_branch323, label %false_branch326

is_cell_branch323:                                ; preds = %continue_branch322
  %710 = getelementptr %SchemeObject, ptr %729, i32 0, i32 4
  %711 = load ptr, ptr %710, align 8
  %712 = icmp eq ptr %711, null
  br i1 %712, label %is_cell_first_null_branch324, label %false_branch326

is_cell_first_null_branch324:                     ; preds = %is_cell_branch323
  %713 = getelementptr %SchemeObject, ptr %729, i32 0, i32 5
  %714 = load ptr, ptr %713, align 8
  %715 = icmp eq ptr %714, null
  br i1 %715, label %true_branch325, label %false_branch326

true_branch325:                                   ; preds = %is_cell_first_null_branch324, %merge_branch330
  %boolean337 = alloca %SchemeObject, align 8
  %716 = getelementptr %SchemeObject, ptr %boolean337, i32 0, i32 0
  store i64 1, ptr %716, align 4
  %717 = getelementptr %SchemeObject, ptr %boolean337, i32 0, i32 2
  store i1 true, ptr %717, align 1
  br label %merge_branch327

false_branch326:                                  ; preds = %is_cell_first_null_branch324, %is_cell_branch323, %continue_branch322
  %boolean338 = alloca %SchemeObject, align 8
  %718 = getelementptr %SchemeObject, ptr %boolean338, i32 0, i32 0
  store i64 1, ptr %718, align 4
  %719 = getelementptr %SchemeObject, ptr %boolean338, i32 0, i32 2
  store i1 false, ptr %719, align 1
  br label %merge_branch327

merge_branch327:                                  ; preds = %false_branch326, %true_branch325
  %720 = phi ptr [ %boolean337, %true_branch325 ], [ %boolean338, %false_branch326 ]
  call void @__GLPrint(ptr %720)
  %721 = getelementptr %SchemeObject, ptr %variable276, i32 0, i32 0
  %722 = load i64, ptr %721, align 4
  %is_type_check354 = icmp eq i64 %722, 3
  br i1 %is_type_check354, label %true_branch351, label %false_branch352

true_branch328:                                   ; preds = %merge_branch333
  %723 = getelementptr %SchemeObject, ptr %737, i32 0, i32 5
  %724 = load ptr, ptr %723, align 8
  br label %merge_branch330

false_branch329:                                  ; preds = %merge_branch333
  %725 = alloca %SchemeObject, align 8
  %726 = getelementptr %SchemeObject, ptr %725, i32 0, i32 0
  store i64 3, ptr %726, align 4
  %727 = getelementptr %SchemeObject, ptr %725, i32 0, i32 4
  store ptr null, ptr %727, align 8
  %728 = getelementptr %SchemeObject, ptr %725, i32 0, i32 5
  store ptr null, ptr %728, align 8
  br label %merge_branch330

merge_branch330:                                  ; preds = %false_branch329, %true_branch328
  %729 = phi ptr [ %724, %true_branch328 ], [ %725, %false_branch329 ]
  %730 = icmp eq ptr %729, null
  br i1 %730, label %true_branch325, label %continue_branch322

true_branch331:                                   ; preds = %merge_branch310
  %731 = getelementptr %SchemeObject, ptr %variable276, i32 0, i32 5
  %732 = load ptr, ptr %731, align 8
  br label %merge_branch333

false_branch332:                                  ; preds = %merge_branch310
  %733 = alloca %SchemeObject, align 8
  %734 = getelementptr %SchemeObject, ptr %733, i32 0, i32 0
  store i64 3, ptr %734, align 4
  %735 = getelementptr %SchemeObject, ptr %733, i32 0, i32 4
  store ptr null, ptr %735, align 8
  %736 = getelementptr %SchemeObject, ptr %733, i32 0, i32 5
  store ptr null, ptr %736, align 8
  br label %merge_branch333

merge_branch333:                                  ; preds = %false_branch332, %true_branch331
  %737 = phi ptr [ %732, %true_branch331 ], [ %733, %false_branch332 ]
  %738 = getelementptr %SchemeObject, ptr %737, i32 0, i32 0
  %739 = load i64, ptr %738, align 4
  %is_type_check335 = icmp eq i64 %739, 3
  br i1 %is_type_check335, label %true_branch328, label %false_branch329

continue_branch339:                               ; preds = %merge_branch347
  %740 = getelementptr %SchemeObject, ptr %758, i32 0, i32 0
  %741 = load i64, ptr %740, align 4
  %is_type_check357 = icmp eq i64 %741, 3
  br i1 %is_type_check357, label %is_cell_branch340, label %false_branch343

is_cell_branch340:                                ; preds = %continue_branch339
  %742 = getelementptr %SchemeObject, ptr %758, i32 0, i32 4
  %743 = load ptr, ptr %742, align 8
  %744 = icmp eq ptr %743, null
  br i1 %744, label %is_cell_first_null_branch341, label %false_branch343

is_cell_first_null_branch341:                     ; preds = %is_cell_branch340
  %745 = getelementptr %SchemeObject, ptr %758, i32 0, i32 5
  %746 = load ptr, ptr %745, align 8
  %747 = icmp eq ptr %746, null
  br i1 %747, label %true_branch342, label %false_branch343

true_branch342:                                   ; preds = %is_cell_first_null_branch341, %merge_branch347
  %boolean358 = alloca %SchemeObject, align 8
  %748 = getelementptr %SchemeObject, ptr %boolean358, i32 0, i32 0
  store i64 1, ptr %748, align 4
  %749 = getelementptr %SchemeObject, ptr %boolean358, i32 0, i32 2
  store i1 true, ptr %749, align 1
  br label %merge_branch344

false_branch343:                                  ; preds = %is_cell_first_null_branch341, %is_cell_branch340, %continue_branch339
  %boolean359 = alloca %SchemeObject, align 8
  %750 = getelementptr %SchemeObject, ptr %boolean359, i32 0, i32 0
  store i64 1, ptr %750, align 4
  %751 = getelementptr %SchemeObject, ptr %boolean359, i32 0, i32 2
  store i1 false, ptr %751, align 1
  br label %merge_branch344

merge_branch344:                                  ; preds = %false_branch343, %true_branch342
  %752 = phi ptr [ %boolean358, %true_branch342 ], [ %boolean359, %false_branch343 ]
  call void @__GLPrint(ptr %752)
  %753 = getelementptr %SchemeObject, ptr %variable276, i32 0, i32 0
  %754 = load i64, ptr %753, align 4
  %is_type_check375 = icmp eq i64 %754, 3
  br i1 %is_type_check375, label %true_branch372, label %false_branch373

true_branch345:                                   ; preds = %merge_branch350
  %755 = getelementptr %SchemeObject, ptr %766, i32 0, i32 4
  %756 = load ptr, ptr %755, align 8
  br label %merge_branch347

false_branch346:                                  ; preds = %merge_branch350
  %757 = phi ptr [ %766, %merge_branch350 ]
  br label %merge_branch347

merge_branch347:                                  ; preds = %false_branch346, %true_branch345
  %758 = phi ptr [ %756, %true_branch345 ], [ %757, %false_branch346 ]
  %759 = icmp eq ptr %758, null
  br i1 %759, label %true_branch342, label %continue_branch339

true_branch348:                                   ; preds = %merge_branch353
  %760 = getelementptr %SchemeObject, ptr %775, i32 0, i32 5
  %761 = load ptr, ptr %760, align 8
  br label %merge_branch350

false_branch349:                                  ; preds = %merge_branch353
  %762 = alloca %SchemeObject, align 8
  %763 = getelementptr %SchemeObject, ptr %762, i32 0, i32 0
  store i64 3, ptr %763, align 4
  %764 = getelementptr %SchemeObject, ptr %762, i32 0, i32 4
  store ptr null, ptr %764, align 8
  %765 = getelementptr %SchemeObject, ptr %762, i32 0, i32 5
  store ptr null, ptr %765, align 8
  br label %merge_branch350

merge_branch350:                                  ; preds = %false_branch349, %true_branch348
  %766 = phi ptr [ %761, %true_branch348 ], [ %762, %false_branch349 ]
  %767 = getelementptr %SchemeObject, ptr %766, i32 0, i32 0
  %768 = load i64, ptr %767, align 4
  %is_type_check356 = icmp eq i64 %768, 3
  br i1 %is_type_check356, label %true_branch345, label %false_branch346

true_branch351:                                   ; preds = %merge_branch327
  %769 = getelementptr %SchemeObject, ptr %variable276, i32 0, i32 5
  %770 = load ptr, ptr %769, align 8
  br label %merge_branch353

false_branch352:                                  ; preds = %merge_branch327
  %771 = alloca %SchemeObject, align 8
  %772 = getelementptr %SchemeObject, ptr %771, i32 0, i32 0
  store i64 3, ptr %772, align 4
  %773 = getelementptr %SchemeObject, ptr %771, i32 0, i32 4
  store ptr null, ptr %773, align 8
  %774 = getelementptr %SchemeObject, ptr %771, i32 0, i32 5
  store ptr null, ptr %774, align 8
  br label %merge_branch353

merge_branch353:                                  ; preds = %false_branch352, %true_branch351
  %775 = phi ptr [ %770, %true_branch351 ], [ %771, %false_branch352 ]
  %776 = getelementptr %SchemeObject, ptr %775, i32 0, i32 0
  %777 = load i64, ptr %776, align 4
  %is_type_check355 = icmp eq i64 %777, 3
  br i1 %is_type_check355, label %true_branch348, label %false_branch349

continue_branch360:                               ; preds = %merge_branch368
  %778 = getelementptr %SchemeObject, ptr %797, i32 0, i32 0
  %779 = load i64, ptr %778, align 4
  %is_type_check378 = icmp eq i64 %779, 3
  br i1 %is_type_check378, label %is_cell_branch361, label %false_branch364

is_cell_branch361:                                ; preds = %continue_branch360
  %780 = getelementptr %SchemeObject, ptr %797, i32 0, i32 4
  %781 = load ptr, ptr %780, align 8
  %782 = icmp eq ptr %781, null
  br i1 %782, label %is_cell_first_null_branch362, label %false_branch364

is_cell_first_null_branch362:                     ; preds = %is_cell_branch361
  %783 = getelementptr %SchemeObject, ptr %797, i32 0, i32 5
  %784 = load ptr, ptr %783, align 8
  %785 = icmp eq ptr %784, null
  br i1 %785, label %true_branch363, label %false_branch364

true_branch363:                                   ; preds = %is_cell_first_null_branch362, %merge_branch368
  %boolean379 = alloca %SchemeObject, align 8
  %786 = getelementptr %SchemeObject, ptr %boolean379, i32 0, i32 0
  store i64 1, ptr %786, align 4
  %787 = getelementptr %SchemeObject, ptr %boolean379, i32 0, i32 2
  store i1 true, ptr %787, align 1
  br label %merge_branch365

false_branch364:                                  ; preds = %is_cell_first_null_branch362, %is_cell_branch361, %continue_branch360
  %boolean380 = alloca %SchemeObject, align 8
  %788 = getelementptr %SchemeObject, ptr %boolean380, i32 0, i32 0
  store i64 1, ptr %788, align 4
  %789 = getelementptr %SchemeObject, ptr %boolean380, i32 0, i32 2
  store i1 false, ptr %789, align 1
  br label %merge_branch365

merge_branch365:                                  ; preds = %false_branch364, %true_branch363
  %790 = phi ptr [ %boolean379, %true_branch363 ], [ %boolean380, %false_branch364 ]
  call void @__GLPrint(ptr %790)
  ret i32 0

true_branch366:                                   ; preds = %merge_branch371
  %791 = getelementptr %SchemeObject, ptr %805, i32 0, i32 5
  %792 = load ptr, ptr %791, align 8
  br label %merge_branch368

false_branch367:                                  ; preds = %merge_branch371
  %793 = alloca %SchemeObject, align 8
  %794 = getelementptr %SchemeObject, ptr %793, i32 0, i32 0
  store i64 3, ptr %794, align 4
  %795 = getelementptr %SchemeObject, ptr %793, i32 0, i32 4
  store ptr null, ptr %795, align 8
  %796 = getelementptr %SchemeObject, ptr %793, i32 0, i32 5
  store ptr null, ptr %796, align 8
  br label %merge_branch368

merge_branch368:                                  ; preds = %false_branch367, %true_branch366
  %797 = phi ptr [ %792, %true_branch366 ], [ %793, %false_branch367 ]
  %798 = icmp eq ptr %797, null
  br i1 %798, label %true_branch363, label %continue_branch360

true_branch369:                                   ; preds = %merge_branch374
  %799 = getelementptr %SchemeObject, ptr %814, i32 0, i32 5
  %800 = load ptr, ptr %799, align 8
  br label %merge_branch371

false_branch370:                                  ; preds = %merge_branch374
  %801 = alloca %SchemeObject, align 8
  %802 = getelementptr %SchemeObject, ptr %801, i32 0, i32 0
  store i64 3, ptr %802, align 4
  %803 = getelementptr %SchemeObject, ptr %801, i32 0, i32 4
  store ptr null, ptr %803, align 8
  %804 = getelementptr %SchemeObject, ptr %801, i32 0, i32 5
  store ptr null, ptr %804, align 8
  br label %merge_branch371

merge_branch371:                                  ; preds = %false_branch370, %true_branch369
  %805 = phi ptr [ %800, %true_branch369 ], [ %801, %false_branch370 ]
  %806 = getelementptr %SchemeObject, ptr %805, i32 0, i32 0
  %807 = load i64, ptr %806, align 4
  %is_type_check377 = icmp eq i64 %807, 3
  br i1 %is_type_check377, label %true_branch366, label %false_branch367

true_branch372:                                   ; preds = %merge_branch344
  %808 = getelementptr %SchemeObject, ptr %variable276, i32 0, i32 5
  %809 = load ptr, ptr %808, align 8
  br label %merge_branch374

false_branch373:                                  ; preds = %merge_branch344
  %810 = alloca %SchemeObject, align 8
  %811 = getelementptr %SchemeObject, ptr %810, i32 0, i32 0
  store i64 3, ptr %811, align 4
  %812 = getelementptr %SchemeObject, ptr %810, i32 0, i32 4
  store ptr null, ptr %812, align 8
  %813 = getelementptr %SchemeObject, ptr %810, i32 0, i32 5
  store ptr null, ptr %813, align 8
  br label %merge_branch374

merge_branch374:                                  ; preds = %false_branch373, %true_branch372
  %814 = phi ptr [ %809, %true_branch372 ], [ %810, %false_branch373 ]
  %815 = getelementptr %SchemeObject, ptr %814, i32 0, i32 0
  %816 = load i64, ptr %815, align 4
  %is_type_check376 = icmp eq i64 %816, 3
  br i1 %is_type_check376, label %true_branch369, label %false_branch370
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
