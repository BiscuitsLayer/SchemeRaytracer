; ModuleID = 'outfile.ll'
source_filename = "outfile.ll"

%SchemeObject = type { i64, i64, i1, ptr, ptr, ptr }

@symbol_global = private unnamed_addr constant [4 x i8] c"AND\00", align 1
@symbol_global.1 = private unnamed_addr constant [3 x i8] c"OR\00", align 1
@symbol_global.2 = private unnamed_addr constant [9 x i8] c"BOOLEAN?\00", align 1
@symbol_global.3 = private unnamed_addr constant [8 x i8] c"SYMBOL?\00", align 1
@symbol_global.4 = private unnamed_addr constant [2 x i8] c"x\00", align 1
@symbol_global.5 = private unnamed_addr constant [8 x i8] c"NUMBER?\00", align 1

define i32 @main() {
entry:
  %symbol = alloca %SchemeObject, align 8
  %0 = getelementptr %SchemeObject, ptr %symbol, i32 0, i32 0
  store i64 2, ptr %0, align 4
  %1 = getelementptr %SchemeObject, ptr %symbol, i32 0, i32 3
  store ptr @symbol_global, ptr %1, align 8
  call void @__GLPrint(ptr %symbol)
  br label %end_branch

end_branch:                                       ; preds = %entry
  %boolean = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %2, align 4
  %3 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %3, align 1
  call void @__GLPrint(ptr %boolean)
  br label %comparison_branch

end_branch1:                                      ; preds = %continue_branch13, %is_boolean_smth_branch15, %is_boolean_smth_branch
  %4 = phi ptr [ %35, %is_boolean_smth_branch ], [ %62, %is_boolean_smth_branch15 ], [ %58, %continue_branch13 ]
  call void @__GLPrint(ptr %4)
  %boolean19 = alloca %SchemeObject, align 8
  %5 = getelementptr %SchemeObject, ptr %boolean19, i32 0, i32 0
  store i64 1, ptr %5, align 4
  %6 = getelementptr %SchemeObject, ptr %boolean19, i32 0, i32 2
  store i1 true, ptr %6, align 1
  %7 = getelementptr %SchemeObject, ptr %boolean19, i32 0, i32 0
  %8 = load i64, ptr %7, align 4
  %is_type_check23 = icmp eq i64 %8, 1
  br i1 %is_type_check23, label %is_boolean_branch21, label %continue_branch20

comparison_branch:                                ; preds = %end_branch
  %number = alloca %SchemeObject, align 8
  %9 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %9, align 4
  %10 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 200, ptr %10, align 4
  %11 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  %12 = load i64, ptr %11, align 4
  %13 = icmp eq i64 %12, 0
  call void @__GLAssert(i1 %13)
  %number2 = alloca %SchemeObject, align 8
  %14 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  store i64 0, ptr %14, align 4
  %15 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  store i64 200, ptr %15, align 4
  %16 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  %17 = load i64, ptr %16, align 4
  %18 = icmp eq i64 %17, 0
  call void @__GLAssert(i1 %18)
  %19 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %20 = load i64, ptr %19, align 4
  %21 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  %22 = load i64, ptr %21, align 4
  %23 = icmp ne i64 %20, %22
  br i1 %23, label %false_branch, label %true_branch

true_branch:                                      ; preds = %comparison_branch
  %boolean3 = alloca %SchemeObject, align 8
  %24 = getelementptr %SchemeObject, ptr %boolean3, i32 0, i32 0
  store i64 1, ptr %24, align 4
  %25 = getelementptr %SchemeObject, ptr %boolean3, i32 0, i32 2
  store i1 true, ptr %25, align 1
  br label %merge_branch

false_branch:                                     ; preds = %comparison_branch
  %boolean4 = alloca %SchemeObject, align 8
  %26 = getelementptr %SchemeObject, ptr %boolean4, i32 0, i32 0
  store i64 1, ptr %26, align 4
  %27 = getelementptr %SchemeObject, ptr %boolean4, i32 0, i32 2
  store i1 false, ptr %27, align 1
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %28 = phi ptr [ %boolean3, %true_branch ], [ %boolean4, %false_branch ]
  %29 = getelementptr %SchemeObject, ptr %28, i32 0, i32 0
  %30 = load i64, ptr %29, align 4
  %is_type_check = icmp eq i64 %30, 1
  br i1 %is_type_check, label %is_boolean_branch, label %continue_branch

continue_branch:                                  ; preds = %is_boolean_branch, %merge_branch
  %31 = phi ptr [ %28, %merge_branch ], [ %34, %is_boolean_branch ]
  br label %comparison_branch5

is_boolean_branch:                                ; preds = %merge_branch
  %32 = getelementptr %SchemeObject, ptr %28, i32 0, i32 2
  %33 = load i1, ptr %32, align 1
  %is_boolean_smth_check = icmp eq i1 %33, false
  %34 = phi ptr [ %28, %merge_branch ]
  br i1 %is_boolean_smth_check, label %is_boolean_smth_branch, label %continue_branch

is_boolean_smth_branch:                           ; preds = %is_boolean_branch
  %35 = phi ptr [ %34, %is_boolean_branch ]
  br label %end_branch1

comparison_branch5:                               ; preds = %continue_branch
  %number9 = alloca %SchemeObject, align 8
  %36 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 0
  store i64 0, ptr %36, align 4
  %37 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 1
  store i64 200, ptr %37, align 4
  %38 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 0
  %39 = load i64, ptr %38, align 4
  %40 = icmp eq i64 %39, 0
  call void @__GLAssert(i1 %40)
  %number10 = alloca %SchemeObject, align 8
  %41 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 0
  store i64 0, ptr %41, align 4
  %42 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 100, ptr %42, align 4
  %43 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 0
  %44 = load i64, ptr %43, align 4
  %45 = icmp eq i64 %44, 0
  call void @__GLAssert(i1 %45)
  %46 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 1
  %47 = load i64, ptr %46, align 4
  %48 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  %49 = load i64, ptr %48, align 4
  %50 = icmp sle i64 %47, %49
  br i1 %50, label %false_branch7, label %true_branch6

true_branch6:                                     ; preds = %comparison_branch5
  %boolean11 = alloca %SchemeObject, align 8
  %51 = getelementptr %SchemeObject, ptr %boolean11, i32 0, i32 0
  store i64 1, ptr %51, align 4
  %52 = getelementptr %SchemeObject, ptr %boolean11, i32 0, i32 2
  store i1 true, ptr %52, align 1
  br label %merge_branch8

false_branch7:                                    ; preds = %comparison_branch5
  %boolean12 = alloca %SchemeObject, align 8
  %53 = getelementptr %SchemeObject, ptr %boolean12, i32 0, i32 0
  store i64 1, ptr %53, align 4
  %54 = getelementptr %SchemeObject, ptr %boolean12, i32 0, i32 2
  store i1 false, ptr %54, align 1
  br label %merge_branch8

merge_branch8:                                    ; preds = %false_branch7, %true_branch6
  %55 = phi ptr [ %boolean11, %true_branch6 ], [ %boolean12, %false_branch7 ]
  %56 = getelementptr %SchemeObject, ptr %55, i32 0, i32 0
  %57 = load i64, ptr %56, align 4
  %is_type_check16 = icmp eq i64 %57, 1
  br i1 %is_type_check16, label %is_boolean_branch14, label %continue_branch13

continue_branch13:                                ; preds = %is_boolean_branch14, %merge_branch8
  %58 = phi ptr [ %55, %merge_branch8 ], [ %61, %is_boolean_branch14 ]
  br label %end_branch1

is_boolean_branch14:                              ; preds = %merge_branch8
  %59 = getelementptr %SchemeObject, ptr %55, i32 0, i32 2
  %60 = load i1, ptr %59, align 1
  %is_boolean_smth_check17 = icmp eq i1 %60, false
  %61 = phi ptr [ %55, %merge_branch8 ]
  br i1 %is_boolean_smth_check17, label %is_boolean_smth_branch15, label %continue_branch13

is_boolean_smth_branch15:                         ; preds = %is_boolean_branch14
  %62 = phi ptr [ %61, %is_boolean_branch14 ]
  br label %end_branch1

end_branch18:                                     ; preds = %continue_branch26, %is_boolean_smth_branch28, %is_boolean_smth_branch22
  %63 = phi ptr [ %72, %is_boolean_smth_branch22 ], [ %77, %is_boolean_smth_branch28 ], [ %73, %continue_branch26 ]
  call void @__GLPrint(ptr %63)
  br label %comparison_branch32

continue_branch20:                                ; preds = %is_boolean_branch21, %end_branch1
  %64 = phi ptr [ %boolean19, %end_branch1 ], [ %71, %is_boolean_branch21 ]
  %boolean25 = alloca %SchemeObject, align 8
  %65 = getelementptr %SchemeObject, ptr %boolean25, i32 0, i32 0
  store i64 1, ptr %65, align 4
  %66 = getelementptr %SchemeObject, ptr %boolean25, i32 0, i32 2
  store i1 false, ptr %66, align 1
  %67 = getelementptr %SchemeObject, ptr %boolean25, i32 0, i32 0
  %68 = load i64, ptr %67, align 4
  %is_type_check29 = icmp eq i64 %68, 1
  br i1 %is_type_check29, label %is_boolean_branch27, label %continue_branch26

is_boolean_branch21:                              ; preds = %end_branch1
  %69 = getelementptr %SchemeObject, ptr %boolean19, i32 0, i32 2
  %70 = load i1, ptr %69, align 1
  %is_boolean_smth_check24 = icmp eq i1 %70, false
  %71 = phi ptr [ %boolean19, %end_branch1 ]
  br i1 %is_boolean_smth_check24, label %is_boolean_smth_branch22, label %continue_branch20

is_boolean_smth_branch22:                         ; preds = %is_boolean_branch21
  %72 = phi ptr [ %71, %is_boolean_branch21 ]
  br label %end_branch18

continue_branch26:                                ; preds = %is_boolean_branch27, %continue_branch20
  %73 = phi ptr [ %boolean25, %continue_branch20 ], [ %76, %is_boolean_branch27 ]
  br label %end_branch18

is_boolean_branch27:                              ; preds = %continue_branch20
  %74 = getelementptr %SchemeObject, ptr %boolean25, i32 0, i32 2
  %75 = load i1, ptr %74, align 1
  %is_boolean_smth_check30 = icmp eq i1 %75, false
  %76 = phi ptr [ %boolean25, %continue_branch20 ]
  br i1 %is_boolean_smth_check30, label %is_boolean_smth_branch28, label %continue_branch26

is_boolean_smth_branch28:                         ; preds = %is_boolean_branch27
  %77 = phi ptr [ %76, %is_boolean_branch27 ]
  br label %end_branch18

end_branch31:                                     ; preds = %continue_branch53, %is_boolean_smth_branch55, %is_boolean_smth_branch42
  %78 = phi ptr [ %109, %is_boolean_smth_branch42 ], [ %136, %is_boolean_smth_branch55 ], [ %132, %continue_branch53 ]
  call void @__GLPrint(ptr %78)
  %number59 = alloca %SchemeObject, align 8
  %79 = getelementptr %SchemeObject, ptr %number59, i32 0, i32 0
  store i64 0, ptr %79, align 4
  %80 = getelementptr %SchemeObject, ptr %number59, i32 0, i32 1
  store i64 300, ptr %80, align 4
  %81 = getelementptr %SchemeObject, ptr %number59, i32 0, i32 0
  %82 = load i64, ptr %81, align 4
  %is_type_check63 = icmp eq i64 %82, 1
  br i1 %is_type_check63, label %is_boolean_branch61, label %continue_branch60

comparison_branch32:                              ; preds = %end_branch18
  %number36 = alloca %SchemeObject, align 8
  %83 = getelementptr %SchemeObject, ptr %number36, i32 0, i32 0
  store i64 0, ptr %83, align 4
  %84 = getelementptr %SchemeObject, ptr %number36, i32 0, i32 1
  store i64 200, ptr %84, align 4
  %85 = getelementptr %SchemeObject, ptr %number36, i32 0, i32 0
  %86 = load i64, ptr %85, align 4
  %87 = icmp eq i64 %86, 0
  call void @__GLAssert(i1 %87)
  %number37 = alloca %SchemeObject, align 8
  %88 = getelementptr %SchemeObject, ptr %number37, i32 0, i32 0
  store i64 0, ptr %88, align 4
  %89 = getelementptr %SchemeObject, ptr %number37, i32 0, i32 1
  store i64 200, ptr %89, align 4
  %90 = getelementptr %SchemeObject, ptr %number37, i32 0, i32 0
  %91 = load i64, ptr %90, align 4
  %92 = icmp eq i64 %91, 0
  call void @__GLAssert(i1 %92)
  %93 = getelementptr %SchemeObject, ptr %number36, i32 0, i32 1
  %94 = load i64, ptr %93, align 4
  %95 = getelementptr %SchemeObject, ptr %number37, i32 0, i32 1
  %96 = load i64, ptr %95, align 4
  %97 = icmp ne i64 %94, %96
  br i1 %97, label %false_branch34, label %true_branch33

true_branch33:                                    ; preds = %comparison_branch32
  %boolean38 = alloca %SchemeObject, align 8
  %98 = getelementptr %SchemeObject, ptr %boolean38, i32 0, i32 0
  store i64 1, ptr %98, align 4
  %99 = getelementptr %SchemeObject, ptr %boolean38, i32 0, i32 2
  store i1 true, ptr %99, align 1
  br label %merge_branch35

false_branch34:                                   ; preds = %comparison_branch32
  %boolean39 = alloca %SchemeObject, align 8
  %100 = getelementptr %SchemeObject, ptr %boolean39, i32 0, i32 0
  store i64 1, ptr %100, align 4
  %101 = getelementptr %SchemeObject, ptr %boolean39, i32 0, i32 2
  store i1 false, ptr %101, align 1
  br label %merge_branch35

merge_branch35:                                   ; preds = %false_branch34, %true_branch33
  %102 = phi ptr [ %boolean38, %true_branch33 ], [ %boolean39, %false_branch34 ]
  %103 = getelementptr %SchemeObject, ptr %102, i32 0, i32 0
  %104 = load i64, ptr %103, align 4
  %is_type_check43 = icmp eq i64 %104, 1
  br i1 %is_type_check43, label %is_boolean_branch41, label %continue_branch40

continue_branch40:                                ; preds = %is_boolean_branch41, %merge_branch35
  %105 = phi ptr [ %102, %merge_branch35 ], [ %108, %is_boolean_branch41 ]
  br label %comparison_branch45

is_boolean_branch41:                              ; preds = %merge_branch35
  %106 = getelementptr %SchemeObject, ptr %102, i32 0, i32 2
  %107 = load i1, ptr %106, align 1
  %is_boolean_smth_check44 = icmp eq i1 %107, false
  %108 = phi ptr [ %102, %merge_branch35 ]
  br i1 %is_boolean_smth_check44, label %is_boolean_smth_branch42, label %continue_branch40

is_boolean_smth_branch42:                         ; preds = %is_boolean_branch41
  %109 = phi ptr [ %108, %is_boolean_branch41 ]
  br label %end_branch31

comparison_branch45:                              ; preds = %continue_branch40
  %number49 = alloca %SchemeObject, align 8
  %110 = getelementptr %SchemeObject, ptr %number49, i32 0, i32 0
  store i64 0, ptr %110, align 4
  %111 = getelementptr %SchemeObject, ptr %number49, i32 0, i32 1
  store i64 200, ptr %111, align 4
  %112 = getelementptr %SchemeObject, ptr %number49, i32 0, i32 0
  %113 = load i64, ptr %112, align 4
  %114 = icmp eq i64 %113, 0
  call void @__GLAssert(i1 %114)
  %number50 = alloca %SchemeObject, align 8
  %115 = getelementptr %SchemeObject, ptr %number50, i32 0, i32 0
  store i64 0, ptr %115, align 4
  %116 = getelementptr %SchemeObject, ptr %number50, i32 0, i32 1
  store i64 100, ptr %116, align 4
  %117 = getelementptr %SchemeObject, ptr %number50, i32 0, i32 0
  %118 = load i64, ptr %117, align 4
  %119 = icmp eq i64 %118, 0
  call void @__GLAssert(i1 %119)
  %120 = getelementptr %SchemeObject, ptr %number49, i32 0, i32 1
  %121 = load i64, ptr %120, align 4
  %122 = getelementptr %SchemeObject, ptr %number50, i32 0, i32 1
  %123 = load i64, ptr %122, align 4
  %124 = icmp sge i64 %121, %123
  br i1 %124, label %false_branch47, label %true_branch46

true_branch46:                                    ; preds = %comparison_branch45
  %boolean51 = alloca %SchemeObject, align 8
  %125 = getelementptr %SchemeObject, ptr %boolean51, i32 0, i32 0
  store i64 1, ptr %125, align 4
  %126 = getelementptr %SchemeObject, ptr %boolean51, i32 0, i32 2
  store i1 true, ptr %126, align 1
  br label %merge_branch48

false_branch47:                                   ; preds = %comparison_branch45
  %boolean52 = alloca %SchemeObject, align 8
  %127 = getelementptr %SchemeObject, ptr %boolean52, i32 0, i32 0
  store i64 1, ptr %127, align 4
  %128 = getelementptr %SchemeObject, ptr %boolean52, i32 0, i32 2
  store i1 false, ptr %128, align 1
  br label %merge_branch48

merge_branch48:                                   ; preds = %false_branch47, %true_branch46
  %129 = phi ptr [ %boolean51, %true_branch46 ], [ %boolean52, %false_branch47 ]
  %130 = getelementptr %SchemeObject, ptr %129, i32 0, i32 0
  %131 = load i64, ptr %130, align 4
  %is_type_check56 = icmp eq i64 %131, 1
  br i1 %is_type_check56, label %is_boolean_branch54, label %continue_branch53

continue_branch53:                                ; preds = %is_boolean_branch54, %merge_branch48
  %132 = phi ptr [ %129, %merge_branch48 ], [ %135, %is_boolean_branch54 ]
  br label %end_branch31

is_boolean_branch54:                              ; preds = %merge_branch48
  %133 = getelementptr %SchemeObject, ptr %129, i32 0, i32 2
  %134 = load i1, ptr %133, align 1
  %is_boolean_smth_check57 = icmp eq i1 %134, false
  %135 = phi ptr [ %129, %merge_branch48 ]
  br i1 %is_boolean_smth_check57, label %is_boolean_smth_branch55, label %continue_branch53

is_boolean_smth_branch55:                         ; preds = %is_boolean_branch54
  %136 = phi ptr [ %135, %is_boolean_branch54 ]
  br label %end_branch31

end_branch58:                                     ; preds = %continue_branch79, %is_boolean_smth_branch81, %is_boolean_smth_branch75, %is_boolean_smth_branch62
  %137 = phi ptr [ %144, %is_boolean_smth_branch62 ], [ %175, %is_boolean_smth_branch75 ], [ %180, %is_boolean_smth_branch81 ], [ %176, %continue_branch79 ]
  call void @__GLPrint(ptr %137)
  %symbol84 = alloca %SchemeObject, align 8
  %138 = getelementptr %SchemeObject, ptr %symbol84, i32 0, i32 0
  store i64 2, ptr %138, align 4
  %139 = getelementptr %SchemeObject, ptr %symbol84, i32 0, i32 3
  store ptr @symbol_global.1, ptr %139, align 8
  call void @__GLPrint(ptr %symbol84)
  br label %end_branch85

continue_branch60:                                ; preds = %is_boolean_branch61, %end_branch31
  %140 = phi ptr [ %number59, %end_branch31 ], [ %143, %is_boolean_branch61 ]
  br label %comparison_branch65

is_boolean_branch61:                              ; preds = %end_branch31
  %141 = getelementptr %SchemeObject, ptr %number59, i32 0, i32 2
  %142 = load i1, ptr %141, align 1
  %is_boolean_smth_check64 = icmp eq i1 %142, false
  %143 = phi ptr [ %number59, %end_branch31 ]
  br i1 %is_boolean_smth_check64, label %is_boolean_smth_branch62, label %continue_branch60

is_boolean_smth_branch62:                         ; preds = %is_boolean_branch61
  %144 = phi ptr [ %143, %is_boolean_branch61 ]
  br label %end_branch58

comparison_branch65:                              ; preds = %continue_branch60
  %number69 = alloca %SchemeObject, align 8
  %145 = getelementptr %SchemeObject, ptr %number69, i32 0, i32 0
  store i64 0, ptr %145, align 4
  %146 = getelementptr %SchemeObject, ptr %number69, i32 0, i32 1
  store i64 200, ptr %146, align 4
  %147 = getelementptr %SchemeObject, ptr %number69, i32 0, i32 0
  %148 = load i64, ptr %147, align 4
  %149 = icmp eq i64 %148, 0
  call void @__GLAssert(i1 %149)
  %number70 = alloca %SchemeObject, align 8
  %150 = getelementptr %SchemeObject, ptr %number70, i32 0, i32 0
  store i64 0, ptr %150, align 4
  %151 = getelementptr %SchemeObject, ptr %number70, i32 0, i32 1
  store i64 200, ptr %151, align 4
  %152 = getelementptr %SchemeObject, ptr %number70, i32 0, i32 0
  %153 = load i64, ptr %152, align 4
  %154 = icmp eq i64 %153, 0
  call void @__GLAssert(i1 %154)
  %155 = getelementptr %SchemeObject, ptr %number69, i32 0, i32 1
  %156 = load i64, ptr %155, align 4
  %157 = getelementptr %SchemeObject, ptr %number70, i32 0, i32 1
  %158 = load i64, ptr %157, align 4
  %159 = icmp ne i64 %156, %158
  br i1 %159, label %false_branch67, label %true_branch66

true_branch66:                                    ; preds = %comparison_branch65
  %boolean71 = alloca %SchemeObject, align 8
  %160 = getelementptr %SchemeObject, ptr %boolean71, i32 0, i32 0
  store i64 1, ptr %160, align 4
  %161 = getelementptr %SchemeObject, ptr %boolean71, i32 0, i32 2
  store i1 true, ptr %161, align 1
  br label %merge_branch68

false_branch67:                                   ; preds = %comparison_branch65
  %boolean72 = alloca %SchemeObject, align 8
  %162 = getelementptr %SchemeObject, ptr %boolean72, i32 0, i32 0
  store i64 1, ptr %162, align 4
  %163 = getelementptr %SchemeObject, ptr %boolean72, i32 0, i32 2
  store i1 false, ptr %163, align 1
  br label %merge_branch68

merge_branch68:                                   ; preds = %false_branch67, %true_branch66
  %164 = phi ptr [ %boolean71, %true_branch66 ], [ %boolean72, %false_branch67 ]
  %165 = getelementptr %SchemeObject, ptr %164, i32 0, i32 0
  %166 = load i64, ptr %165, align 4
  %is_type_check76 = icmp eq i64 %166, 1
  br i1 %is_type_check76, label %is_boolean_branch74, label %continue_branch73

continue_branch73:                                ; preds = %is_boolean_branch74, %merge_branch68
  %167 = phi ptr [ %164, %merge_branch68 ], [ %174, %is_boolean_branch74 ]
  %number78 = alloca %SchemeObject, align 8
  %168 = getelementptr %SchemeObject, ptr %number78, i32 0, i32 0
  store i64 0, ptr %168, align 4
  %169 = getelementptr %SchemeObject, ptr %number78, i32 0, i32 1
  store i64 400, ptr %169, align 4
  %170 = getelementptr %SchemeObject, ptr %number78, i32 0, i32 0
  %171 = load i64, ptr %170, align 4
  %is_type_check82 = icmp eq i64 %171, 1
  br i1 %is_type_check82, label %is_boolean_branch80, label %continue_branch79

is_boolean_branch74:                              ; preds = %merge_branch68
  %172 = getelementptr %SchemeObject, ptr %164, i32 0, i32 2
  %173 = load i1, ptr %172, align 1
  %is_boolean_smth_check77 = icmp eq i1 %173, false
  %174 = phi ptr [ %164, %merge_branch68 ]
  br i1 %is_boolean_smth_check77, label %is_boolean_smth_branch75, label %continue_branch73

is_boolean_smth_branch75:                         ; preds = %is_boolean_branch74
  %175 = phi ptr [ %174, %is_boolean_branch74 ]
  br label %end_branch58

continue_branch79:                                ; preds = %is_boolean_branch80, %continue_branch73
  %176 = phi ptr [ %number78, %continue_branch73 ], [ %179, %is_boolean_branch80 ]
  br label %end_branch58

is_boolean_branch80:                              ; preds = %continue_branch73
  %177 = getelementptr %SchemeObject, ptr %number78, i32 0, i32 2
  %178 = load i1, ptr %177, align 1
  %is_boolean_smth_check83 = icmp eq i1 %178, false
  %179 = phi ptr [ %number78, %continue_branch73 ]
  br i1 %is_boolean_smth_check83, label %is_boolean_smth_branch81, label %continue_branch79

is_boolean_smth_branch81:                         ; preds = %is_boolean_branch80
  %180 = phi ptr [ %179, %is_boolean_branch80 ]
  br label %end_branch58

end_branch85:                                     ; preds = %end_branch58
  %boolean86 = alloca %SchemeObject, align 8
  %181 = getelementptr %SchemeObject, ptr %boolean86, i32 0, i32 0
  store i64 1, ptr %181, align 4
  %182 = getelementptr %SchemeObject, ptr %boolean86, i32 0, i32 2
  store i1 false, ptr %182, align 1
  call void @__GLPrint(ptr %boolean86)
  br label %comparison_branch88

end_branch87:                                     ; preds = %continue_branch109, %is_boolean_smth_branch111, %is_boolean_smth_branch98
  %183 = phi ptr [ %214, %is_boolean_smth_branch98 ], [ %241, %is_boolean_smth_branch111 ], [ %237, %continue_branch109 ]
  call void @__GLPrint(ptr %183)
  %boolean115 = alloca %SchemeObject, align 8
  %184 = getelementptr %SchemeObject, ptr %boolean115, i32 0, i32 0
  store i64 1, ptr %184, align 4
  %185 = getelementptr %SchemeObject, ptr %boolean115, i32 0, i32 2
  store i1 false, ptr %185, align 1
  %186 = getelementptr %SchemeObject, ptr %boolean115, i32 0, i32 0
  %187 = load i64, ptr %186, align 4
  %is_type_check119 = icmp eq i64 %187, 1
  br i1 %is_type_check119, label %is_boolean_branch117, label %continue_branch116

comparison_branch88:                              ; preds = %end_branch85
  %number92 = alloca %SchemeObject, align 8
  %188 = getelementptr %SchemeObject, ptr %number92, i32 0, i32 0
  store i64 0, ptr %188, align 4
  %189 = getelementptr %SchemeObject, ptr %number92, i32 0, i32 1
  store i64 200, ptr %189, align 4
  %190 = getelementptr %SchemeObject, ptr %number92, i32 0, i32 0
  %191 = load i64, ptr %190, align 4
  %192 = icmp eq i64 %191, 0
  call void @__GLAssert(i1 %192)
  %number93 = alloca %SchemeObject, align 8
  %193 = getelementptr %SchemeObject, ptr %number93, i32 0, i32 0
  store i64 0, ptr %193, align 4
  %194 = getelementptr %SchemeObject, ptr %number93, i32 0, i32 1
  store i64 200, ptr %194, align 4
  %195 = getelementptr %SchemeObject, ptr %number93, i32 0, i32 0
  %196 = load i64, ptr %195, align 4
  %197 = icmp eq i64 %196, 0
  call void @__GLAssert(i1 %197)
  %198 = getelementptr %SchemeObject, ptr %number92, i32 0, i32 1
  %199 = load i64, ptr %198, align 4
  %200 = getelementptr %SchemeObject, ptr %number93, i32 0, i32 1
  %201 = load i64, ptr %200, align 4
  %202 = icmp ne i64 %199, %201
  br i1 %202, label %false_branch90, label %true_branch89

true_branch89:                                    ; preds = %comparison_branch88
  %boolean94 = alloca %SchemeObject, align 8
  %203 = getelementptr %SchemeObject, ptr %boolean94, i32 0, i32 0
  store i64 1, ptr %203, align 4
  %204 = getelementptr %SchemeObject, ptr %boolean94, i32 0, i32 2
  store i1 true, ptr %204, align 1
  br label %merge_branch91

false_branch90:                                   ; preds = %comparison_branch88
  %boolean95 = alloca %SchemeObject, align 8
  %205 = getelementptr %SchemeObject, ptr %boolean95, i32 0, i32 0
  store i64 1, ptr %205, align 4
  %206 = getelementptr %SchemeObject, ptr %boolean95, i32 0, i32 2
  store i1 false, ptr %206, align 1
  br label %merge_branch91

merge_branch91:                                   ; preds = %false_branch90, %true_branch89
  %207 = phi ptr [ %boolean94, %true_branch89 ], [ %boolean95, %false_branch90 ]
  %208 = getelementptr %SchemeObject, ptr %207, i32 0, i32 0
  %209 = load i64, ptr %208, align 4
  %is_type_check99 = icmp eq i64 %209, 1
  br i1 %is_type_check99, label %is_boolean_branch97, label %continue_branch96

continue_branch96:                                ; preds = %is_boolean_branch97, %merge_branch91
  %210 = phi ptr [ %207, %merge_branch91 ], [ %213, %is_boolean_branch97 ]
  br label %comparison_branch101

is_boolean_branch97:                              ; preds = %merge_branch91
  %211 = getelementptr %SchemeObject, ptr %207, i32 0, i32 2
  %212 = load i1, ptr %211, align 1
  %is_boolean_smth_check100 = icmp eq i1 %212, true
  %213 = phi ptr [ %207, %merge_branch91 ]
  br i1 %is_boolean_smth_check100, label %is_boolean_smth_branch98, label %continue_branch96

is_boolean_smth_branch98:                         ; preds = %is_boolean_branch97
  %214 = phi ptr [ %213, %is_boolean_branch97 ]
  br label %end_branch87

comparison_branch101:                             ; preds = %continue_branch96
  %number105 = alloca %SchemeObject, align 8
  %215 = getelementptr %SchemeObject, ptr %number105, i32 0, i32 0
  store i64 0, ptr %215, align 4
  %216 = getelementptr %SchemeObject, ptr %number105, i32 0, i32 1
  store i64 200, ptr %216, align 4
  %217 = getelementptr %SchemeObject, ptr %number105, i32 0, i32 0
  %218 = load i64, ptr %217, align 4
  %219 = icmp eq i64 %218, 0
  call void @__GLAssert(i1 %219)
  %number106 = alloca %SchemeObject, align 8
  %220 = getelementptr %SchemeObject, ptr %number106, i32 0, i32 0
  store i64 0, ptr %220, align 4
  %221 = getelementptr %SchemeObject, ptr %number106, i32 0, i32 1
  store i64 100, ptr %221, align 4
  %222 = getelementptr %SchemeObject, ptr %number106, i32 0, i32 0
  %223 = load i64, ptr %222, align 4
  %224 = icmp eq i64 %223, 0
  call void @__GLAssert(i1 %224)
  %225 = getelementptr %SchemeObject, ptr %number105, i32 0, i32 1
  %226 = load i64, ptr %225, align 4
  %227 = getelementptr %SchemeObject, ptr %number106, i32 0, i32 1
  %228 = load i64, ptr %227, align 4
  %229 = icmp sle i64 %226, %228
  br i1 %229, label %false_branch103, label %true_branch102

true_branch102:                                   ; preds = %comparison_branch101
  %boolean107 = alloca %SchemeObject, align 8
  %230 = getelementptr %SchemeObject, ptr %boolean107, i32 0, i32 0
  store i64 1, ptr %230, align 4
  %231 = getelementptr %SchemeObject, ptr %boolean107, i32 0, i32 2
  store i1 true, ptr %231, align 1
  br label %merge_branch104

false_branch103:                                  ; preds = %comparison_branch101
  %boolean108 = alloca %SchemeObject, align 8
  %232 = getelementptr %SchemeObject, ptr %boolean108, i32 0, i32 0
  store i64 1, ptr %232, align 4
  %233 = getelementptr %SchemeObject, ptr %boolean108, i32 0, i32 2
  store i1 false, ptr %233, align 1
  br label %merge_branch104

merge_branch104:                                  ; preds = %false_branch103, %true_branch102
  %234 = phi ptr [ %boolean107, %true_branch102 ], [ %boolean108, %false_branch103 ]
  %235 = getelementptr %SchemeObject, ptr %234, i32 0, i32 0
  %236 = load i64, ptr %235, align 4
  %is_type_check112 = icmp eq i64 %236, 1
  br i1 %is_type_check112, label %is_boolean_branch110, label %continue_branch109

continue_branch109:                               ; preds = %is_boolean_branch110, %merge_branch104
  %237 = phi ptr [ %234, %merge_branch104 ], [ %240, %is_boolean_branch110 ]
  br label %end_branch87

is_boolean_branch110:                             ; preds = %merge_branch104
  %238 = getelementptr %SchemeObject, ptr %234, i32 0, i32 2
  %239 = load i1, ptr %238, align 1
  %is_boolean_smth_check113 = icmp eq i1 %239, true
  %240 = phi ptr [ %234, %merge_branch104 ]
  br i1 %is_boolean_smth_check113, label %is_boolean_smth_branch111, label %continue_branch109

is_boolean_smth_branch111:                        ; preds = %is_boolean_branch110
  %241 = phi ptr [ %240, %is_boolean_branch110 ]
  br label %end_branch87

end_branch114:                                    ; preds = %continue_branch129, %is_boolean_smth_branch131, %is_boolean_smth_branch118
  %242 = phi ptr [ %251, %is_boolean_smth_branch118 ], [ %278, %is_boolean_smth_branch131 ], [ %274, %continue_branch129 ]
  call void @__GLPrint(ptr %242)
  %boolean135 = alloca %SchemeObject, align 8
  %243 = getelementptr %SchemeObject, ptr %boolean135, i32 0, i32 0
  store i64 1, ptr %243, align 4
  %244 = getelementptr %SchemeObject, ptr %boolean135, i32 0, i32 2
  store i1 false, ptr %244, align 1
  %245 = getelementptr %SchemeObject, ptr %boolean135, i32 0, i32 0
  %246 = load i64, ptr %245, align 4
  %is_type_check139 = icmp eq i64 %246, 1
  br i1 %is_type_check139, label %is_boolean_branch137, label %continue_branch136

continue_branch116:                               ; preds = %is_boolean_branch117, %end_branch87
  %247 = phi ptr [ %boolean115, %end_branch87 ], [ %250, %is_boolean_branch117 ]
  br label %comparison_branch121

is_boolean_branch117:                             ; preds = %end_branch87
  %248 = getelementptr %SchemeObject, ptr %boolean115, i32 0, i32 2
  %249 = load i1, ptr %248, align 1
  %is_boolean_smth_check120 = icmp eq i1 %249, true
  %250 = phi ptr [ %boolean115, %end_branch87 ]
  br i1 %is_boolean_smth_check120, label %is_boolean_smth_branch118, label %continue_branch116

is_boolean_smth_branch118:                        ; preds = %is_boolean_branch117
  %251 = phi ptr [ %250, %is_boolean_branch117 ]
  br label %end_branch114

comparison_branch121:                             ; preds = %continue_branch116
  %number125 = alloca %SchemeObject, align 8
  %252 = getelementptr %SchemeObject, ptr %number125, i32 0, i32 0
  store i64 0, ptr %252, align 4
  %253 = getelementptr %SchemeObject, ptr %number125, i32 0, i32 1
  store i64 200, ptr %253, align 4
  %254 = getelementptr %SchemeObject, ptr %number125, i32 0, i32 0
  %255 = load i64, ptr %254, align 4
  %256 = icmp eq i64 %255, 0
  call void @__GLAssert(i1 %256)
  %number126 = alloca %SchemeObject, align 8
  %257 = getelementptr %SchemeObject, ptr %number126, i32 0, i32 0
  store i64 0, ptr %257, align 4
  %258 = getelementptr %SchemeObject, ptr %number126, i32 0, i32 1
  store i64 100, ptr %258, align 4
  %259 = getelementptr %SchemeObject, ptr %number126, i32 0, i32 0
  %260 = load i64, ptr %259, align 4
  %261 = icmp eq i64 %260, 0
  call void @__GLAssert(i1 %261)
  %262 = getelementptr %SchemeObject, ptr %number125, i32 0, i32 1
  %263 = load i64, ptr %262, align 4
  %264 = getelementptr %SchemeObject, ptr %number126, i32 0, i32 1
  %265 = load i64, ptr %264, align 4
  %266 = icmp sge i64 %263, %265
  br i1 %266, label %false_branch123, label %true_branch122

true_branch122:                                   ; preds = %comparison_branch121
  %boolean127 = alloca %SchemeObject, align 8
  %267 = getelementptr %SchemeObject, ptr %boolean127, i32 0, i32 0
  store i64 1, ptr %267, align 4
  %268 = getelementptr %SchemeObject, ptr %boolean127, i32 0, i32 2
  store i1 true, ptr %268, align 1
  br label %merge_branch124

false_branch123:                                  ; preds = %comparison_branch121
  %boolean128 = alloca %SchemeObject, align 8
  %269 = getelementptr %SchemeObject, ptr %boolean128, i32 0, i32 0
  store i64 1, ptr %269, align 4
  %270 = getelementptr %SchemeObject, ptr %boolean128, i32 0, i32 2
  store i1 false, ptr %270, align 1
  br label %merge_branch124

merge_branch124:                                  ; preds = %false_branch123, %true_branch122
  %271 = phi ptr [ %boolean127, %true_branch122 ], [ %boolean128, %false_branch123 ]
  %272 = getelementptr %SchemeObject, ptr %271, i32 0, i32 0
  %273 = load i64, ptr %272, align 4
  %is_type_check132 = icmp eq i64 %273, 1
  br i1 %is_type_check132, label %is_boolean_branch130, label %continue_branch129

continue_branch129:                               ; preds = %is_boolean_branch130, %merge_branch124
  %274 = phi ptr [ %271, %merge_branch124 ], [ %277, %is_boolean_branch130 ]
  br label %end_branch114

is_boolean_branch130:                             ; preds = %merge_branch124
  %275 = getelementptr %SchemeObject, ptr %271, i32 0, i32 2
  %276 = load i1, ptr %275, align 1
  %is_boolean_smth_check133 = icmp eq i1 %276, true
  %277 = phi ptr [ %271, %merge_branch124 ]
  br i1 %is_boolean_smth_check133, label %is_boolean_smth_branch131, label %continue_branch129

is_boolean_smth_branch131:                        ; preds = %is_boolean_branch130
  %278 = phi ptr [ %277, %is_boolean_branch130 ]
  br label %end_branch114

end_branch134:                                    ; preds = %continue_branch142, %is_boolean_smth_branch144, %is_boolean_smth_branch138
  %279 = phi ptr [ %294, %is_boolean_smth_branch138 ], [ %299, %is_boolean_smth_branch144 ], [ %295, %continue_branch142 ]
  call void @__GLPrint(ptr %279)
  %symbol147 = alloca %SchemeObject, align 8
  %280 = getelementptr %SchemeObject, ptr %symbol147, i32 0, i32 0
  store i64 2, ptr %280, align 4
  %281 = getelementptr %SchemeObject, ptr %symbol147, i32 0, i32 3
  store ptr @symbol_global.2, ptr %281, align 8
  call void @__GLPrint(ptr %symbol147)
  %boolean151 = alloca %SchemeObject, align 8
  %282 = getelementptr %SchemeObject, ptr %boolean151, i32 0, i32 0
  store i64 1, ptr %282, align 4
  %283 = getelementptr %SchemeObject, ptr %boolean151, i32 0, i32 2
  store i1 true, ptr %283, align 1
  %284 = getelementptr %SchemeObject, ptr %boolean151, i32 0, i32 0
  %285 = load i64, ptr %284, align 4
  %is_type_check152 = icmp eq i64 %285, 1
  br i1 %is_type_check152, label %true_branch148, label %false_branch149

continue_branch136:                               ; preds = %is_boolean_branch137, %end_branch114
  %286 = phi ptr [ %boolean135, %end_branch114 ], [ %293, %is_boolean_branch137 ]
  %number141 = alloca %SchemeObject, align 8
  %287 = getelementptr %SchemeObject, ptr %number141, i32 0, i32 0
  store i64 0, ptr %287, align 4
  %288 = getelementptr %SchemeObject, ptr %number141, i32 0, i32 1
  store i64 100, ptr %288, align 4
  %289 = getelementptr %SchemeObject, ptr %number141, i32 0, i32 0
  %290 = load i64, ptr %289, align 4
  %is_type_check145 = icmp eq i64 %290, 1
  br i1 %is_type_check145, label %is_boolean_branch143, label %continue_branch142

is_boolean_branch137:                             ; preds = %end_branch114
  %291 = getelementptr %SchemeObject, ptr %boolean135, i32 0, i32 2
  %292 = load i1, ptr %291, align 1
  %is_boolean_smth_check140 = icmp eq i1 %292, true
  %293 = phi ptr [ %boolean135, %end_branch114 ]
  br i1 %is_boolean_smth_check140, label %is_boolean_smth_branch138, label %continue_branch136

is_boolean_smth_branch138:                        ; preds = %is_boolean_branch137
  %294 = phi ptr [ %293, %is_boolean_branch137 ]
  br label %end_branch134

continue_branch142:                               ; preds = %is_boolean_branch143, %continue_branch136
  %295 = phi ptr [ %number141, %continue_branch136 ], [ %298, %is_boolean_branch143 ]
  br label %end_branch134

is_boolean_branch143:                             ; preds = %continue_branch136
  %296 = getelementptr %SchemeObject, ptr %number141, i32 0, i32 2
  %297 = load i1, ptr %296, align 1
  %is_boolean_smth_check146 = icmp eq i1 %297, true
  %298 = phi ptr [ %number141, %continue_branch136 ]
  br i1 %is_boolean_smth_check146, label %is_boolean_smth_branch144, label %continue_branch142

is_boolean_smth_branch144:                        ; preds = %is_boolean_branch143
  %299 = phi ptr [ %298, %is_boolean_branch143 ]
  br label %end_branch134

true_branch148:                                   ; preds = %end_branch134
  %boolean153 = alloca %SchemeObject, align 8
  %300 = getelementptr %SchemeObject, ptr %boolean153, i32 0, i32 0
  store i64 1, ptr %300, align 4
  %301 = getelementptr %SchemeObject, ptr %boolean153, i32 0, i32 2
  store i1 true, ptr %301, align 1
  br label %merge_branch150

false_branch149:                                  ; preds = %end_branch134
  %boolean154 = alloca %SchemeObject, align 8
  %302 = getelementptr %SchemeObject, ptr %boolean154, i32 0, i32 0
  store i64 1, ptr %302, align 4
  %303 = getelementptr %SchemeObject, ptr %boolean154, i32 0, i32 2
  store i1 false, ptr %303, align 1
  br label %merge_branch150

merge_branch150:                                  ; preds = %false_branch149, %true_branch148
  %304 = phi ptr [ %boolean153, %true_branch148 ], [ %boolean154, %false_branch149 ]
  call void @__GLPrint(ptr %304)
  %boolean158 = alloca %SchemeObject, align 8
  %305 = getelementptr %SchemeObject, ptr %boolean158, i32 0, i32 0
  store i64 1, ptr %305, align 4
  %306 = getelementptr %SchemeObject, ptr %boolean158, i32 0, i32 2
  store i1 false, ptr %306, align 1
  %307 = getelementptr %SchemeObject, ptr %boolean158, i32 0, i32 0
  %308 = load i64, ptr %307, align 4
  %is_type_check159 = icmp eq i64 %308, 1
  br i1 %is_type_check159, label %true_branch155, label %false_branch156

true_branch155:                                   ; preds = %merge_branch150
  %boolean160 = alloca %SchemeObject, align 8
  %309 = getelementptr %SchemeObject, ptr %boolean160, i32 0, i32 0
  store i64 1, ptr %309, align 4
  %310 = getelementptr %SchemeObject, ptr %boolean160, i32 0, i32 2
  store i1 true, ptr %310, align 1
  br label %merge_branch157

false_branch156:                                  ; preds = %merge_branch150
  %boolean161 = alloca %SchemeObject, align 8
  %311 = getelementptr %SchemeObject, ptr %boolean161, i32 0, i32 0
  store i64 1, ptr %311, align 4
  %312 = getelementptr %SchemeObject, ptr %boolean161, i32 0, i32 2
  store i1 false, ptr %312, align 1
  br label %merge_branch157

merge_branch157:                                  ; preds = %false_branch156, %true_branch155
  %313 = phi ptr [ %boolean160, %true_branch155 ], [ %boolean161, %false_branch156 ]
  call void @__GLPrint(ptr %313)
  %number165 = alloca %SchemeObject, align 8
  %314 = getelementptr %SchemeObject, ptr %number165, i32 0, i32 0
  store i64 0, ptr %314, align 4
  %315 = getelementptr %SchemeObject, ptr %number165, i32 0, i32 1
  store i64 100, ptr %315, align 4
  %316 = getelementptr %SchemeObject, ptr %number165, i32 0, i32 0
  %317 = load i64, ptr %316, align 4
  %is_type_check166 = icmp eq i64 %317, 1
  br i1 %is_type_check166, label %true_branch162, label %false_branch163

true_branch162:                                   ; preds = %merge_branch157
  %boolean167 = alloca %SchemeObject, align 8
  %318 = getelementptr %SchemeObject, ptr %boolean167, i32 0, i32 0
  store i64 1, ptr %318, align 4
  %319 = getelementptr %SchemeObject, ptr %boolean167, i32 0, i32 2
  store i1 true, ptr %319, align 1
  br label %merge_branch164

false_branch163:                                  ; preds = %merge_branch157
  %boolean168 = alloca %SchemeObject, align 8
  %320 = getelementptr %SchemeObject, ptr %boolean168, i32 0, i32 0
  store i64 1, ptr %320, align 4
  %321 = getelementptr %SchemeObject, ptr %boolean168, i32 0, i32 2
  store i1 false, ptr %321, align 1
  br label %merge_branch164

merge_branch164:                                  ; preds = %false_branch163, %true_branch162
  %322 = phi ptr [ %boolean167, %true_branch162 ], [ %boolean168, %false_branch163 ]
  call void @__GLPrint(ptr %322)
  %symbol169 = alloca %SchemeObject, align 8
  %323 = getelementptr %SchemeObject, ptr %symbol169, i32 0, i32 0
  store i64 2, ptr %323, align 4
  %324 = getelementptr %SchemeObject, ptr %symbol169, i32 0, i32 3
  store ptr @symbol_global.3, ptr %324, align 8
  call void @__GLPrint(ptr %symbol169)
  %symbol173 = alloca %SchemeObject, align 8
  %325 = getelementptr %SchemeObject, ptr %symbol173, i32 0, i32 0
  store i64 2, ptr %325, align 4
  %326 = getelementptr %SchemeObject, ptr %symbol173, i32 0, i32 3
  store ptr @symbol_global.4, ptr %326, align 8
  %327 = getelementptr %SchemeObject, ptr %symbol173, i32 0, i32 0
  %328 = load i64, ptr %327, align 4
  %is_type_check174 = icmp eq i64 %328, 2
  br i1 %is_type_check174, label %true_branch170, label %false_branch171

true_branch170:                                   ; preds = %merge_branch164
  %boolean175 = alloca %SchemeObject, align 8
  %329 = getelementptr %SchemeObject, ptr %boolean175, i32 0, i32 0
  store i64 1, ptr %329, align 4
  %330 = getelementptr %SchemeObject, ptr %boolean175, i32 0, i32 2
  store i1 true, ptr %330, align 1
  br label %merge_branch172

false_branch171:                                  ; preds = %merge_branch164
  %boolean176 = alloca %SchemeObject, align 8
  %331 = getelementptr %SchemeObject, ptr %boolean176, i32 0, i32 0
  store i64 1, ptr %331, align 4
  %332 = getelementptr %SchemeObject, ptr %boolean176, i32 0, i32 2
  store i1 false, ptr %332, align 1
  br label %merge_branch172

merge_branch172:                                  ; preds = %false_branch171, %true_branch170
  %333 = phi ptr [ %boolean175, %true_branch170 ], [ %boolean176, %false_branch171 ]
  call void @__GLPrint(ptr %333)
  %number180 = alloca %SchemeObject, align 8
  %334 = getelementptr %SchemeObject, ptr %number180, i32 0, i32 0
  store i64 0, ptr %334, align 4
  %335 = getelementptr %SchemeObject, ptr %number180, i32 0, i32 1
  store i64 100, ptr %335, align 4
  %336 = getelementptr %SchemeObject, ptr %number180, i32 0, i32 0
  %337 = load i64, ptr %336, align 4
  %is_type_check181 = icmp eq i64 %337, 2
  br i1 %is_type_check181, label %true_branch177, label %false_branch178

true_branch177:                                   ; preds = %merge_branch172
  %boolean182 = alloca %SchemeObject, align 8
  %338 = getelementptr %SchemeObject, ptr %boolean182, i32 0, i32 0
  store i64 1, ptr %338, align 4
  %339 = getelementptr %SchemeObject, ptr %boolean182, i32 0, i32 2
  store i1 true, ptr %339, align 1
  br label %merge_branch179

false_branch178:                                  ; preds = %merge_branch172
  %boolean183 = alloca %SchemeObject, align 8
  %340 = getelementptr %SchemeObject, ptr %boolean183, i32 0, i32 0
  store i64 1, ptr %340, align 4
  %341 = getelementptr %SchemeObject, ptr %boolean183, i32 0, i32 2
  store i1 false, ptr %341, align 1
  br label %merge_branch179

merge_branch179:                                  ; preds = %false_branch178, %true_branch177
  %342 = phi ptr [ %boolean182, %true_branch177 ], [ %boolean183, %false_branch178 ]
  call void @__GLPrint(ptr %342)
  %symbol184 = alloca %SchemeObject, align 8
  %343 = getelementptr %SchemeObject, ptr %symbol184, i32 0, i32 0
  store i64 2, ptr %343, align 4
  %344 = getelementptr %SchemeObject, ptr %symbol184, i32 0, i32 3
  store ptr @symbol_global.5, ptr %344, align 8
  call void @__GLPrint(ptr %symbol184)
  %number188 = alloca %SchemeObject, align 8
  %345 = getelementptr %SchemeObject, ptr %number188, i32 0, i32 0
  store i64 0, ptr %345, align 4
  %346 = getelementptr %SchemeObject, ptr %number188, i32 0, i32 1
  store i64 -100, ptr %346, align 4
  %347 = getelementptr %SchemeObject, ptr %number188, i32 0, i32 0
  %348 = load i64, ptr %347, align 4
  %is_type_check189 = icmp eq i64 %348, 0
  br i1 %is_type_check189, label %true_branch185, label %false_branch186

true_branch185:                                   ; preds = %merge_branch179
  %boolean190 = alloca %SchemeObject, align 8
  %349 = getelementptr %SchemeObject, ptr %boolean190, i32 0, i32 0
  store i64 1, ptr %349, align 4
  %350 = getelementptr %SchemeObject, ptr %boolean190, i32 0, i32 2
  store i1 true, ptr %350, align 1
  br label %merge_branch187

false_branch186:                                  ; preds = %merge_branch179
  %boolean191 = alloca %SchemeObject, align 8
  %351 = getelementptr %SchemeObject, ptr %boolean191, i32 0, i32 0
  store i64 1, ptr %351, align 4
  %352 = getelementptr %SchemeObject, ptr %boolean191, i32 0, i32 2
  store i1 false, ptr %352, align 1
  br label %merge_branch187

merge_branch187:                                  ; preds = %false_branch186, %true_branch185
  %353 = phi ptr [ %boolean190, %true_branch185 ], [ %boolean191, %false_branch186 ]
  call void @__GLPrint(ptr %353)
  %number195 = alloca %SchemeObject, align 8
  %354 = getelementptr %SchemeObject, ptr %number195, i32 0, i32 0
  store i64 0, ptr %354, align 4
  %355 = getelementptr %SchemeObject, ptr %number195, i32 0, i32 1
  store i64 100, ptr %355, align 4
  %356 = getelementptr %SchemeObject, ptr %number195, i32 0, i32 0
  %357 = load i64, ptr %356, align 4
  %is_type_check196 = icmp eq i64 %357, 0
  br i1 %is_type_check196, label %true_branch192, label %false_branch193

true_branch192:                                   ; preds = %merge_branch187
  %boolean197 = alloca %SchemeObject, align 8
  %358 = getelementptr %SchemeObject, ptr %boolean197, i32 0, i32 0
  store i64 1, ptr %358, align 4
  %359 = getelementptr %SchemeObject, ptr %boolean197, i32 0, i32 2
  store i1 true, ptr %359, align 1
  br label %merge_branch194

false_branch193:                                  ; preds = %merge_branch187
  %boolean198 = alloca %SchemeObject, align 8
  %360 = getelementptr %SchemeObject, ptr %boolean198, i32 0, i32 0
  store i64 1, ptr %360, align 4
  %361 = getelementptr %SchemeObject, ptr %boolean198, i32 0, i32 2
  store i1 false, ptr %361, align 1
  br label %merge_branch194

merge_branch194:                                  ; preds = %false_branch193, %true_branch192
  %362 = phi ptr [ %boolean197, %true_branch192 ], [ %boolean198, %false_branch193 ]
  call void @__GLPrint(ptr %362)
  %boolean202 = alloca %SchemeObject, align 8
  %363 = getelementptr %SchemeObject, ptr %boolean202, i32 0, i32 0
  store i64 1, ptr %363, align 4
  %364 = getelementptr %SchemeObject, ptr %boolean202, i32 0, i32 2
  store i1 true, ptr %364, align 1
  %365 = getelementptr %SchemeObject, ptr %boolean202, i32 0, i32 0
  %366 = load i64, ptr %365, align 4
  %is_type_check203 = icmp eq i64 %366, 0
  br i1 %is_type_check203, label %true_branch199, label %false_branch200

true_branch199:                                   ; preds = %merge_branch194
  %boolean204 = alloca %SchemeObject, align 8
  %367 = getelementptr %SchemeObject, ptr %boolean204, i32 0, i32 0
  store i64 1, ptr %367, align 4
  %368 = getelementptr %SchemeObject, ptr %boolean204, i32 0, i32 2
  store i1 true, ptr %368, align 1
  br label %merge_branch201

false_branch200:                                  ; preds = %merge_branch194
  %boolean205 = alloca %SchemeObject, align 8
  %369 = getelementptr %SchemeObject, ptr %boolean205, i32 0, i32 0
  store i64 1, ptr %369, align 4
  %370 = getelementptr %SchemeObject, ptr %boolean205, i32 0, i32 2
  store i1 false, ptr %370, align 1
  br label %merge_branch201

merge_branch201:                                  ; preds = %false_branch200, %true_branch199
  %371 = phi ptr [ %boolean204, %true_branch199 ], [ %boolean205, %false_branch200 ]
  call void @__GLPrint(ptr %371)
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
