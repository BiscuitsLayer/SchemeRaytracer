; ModuleID = 'scheme.ll'
source_filename = "scheme.ll"

%SchemeObject = type { i64, i64, i1, ptr, ptr, ptr }

@symbol_global = private unnamed_addr constant [7 x i8] c"phrase\00", align 1
@symbol_global.1 = private unnamed_addr constant [7 x i8] c"SAMPLE\00", align 1
@symbol_global.2 = private unnamed_addr constant [6 x i8] c"TRUE1\00", align 1
@symbol_global.3 = private unnamed_addr constant [7 x i8] c"FALSE1\00", align 1
@symbol_global.4 = private unnamed_addr constant [7 x i8] c"AFTER1\00", align 1
@symbol_global.5 = private unnamed_addr constant [6 x i8] c"TRUE2\00", align 1
@symbol_global.6 = private unnamed_addr constant [7 x i8] c"AFTER2\00", align 1
@symbol_global.7 = private unnamed_addr constant [6 x i8] c"TRUE3\00", align 1
@symbol_global.8 = private unnamed_addr constant [7 x i8] c"FALSE3\00", align 1
@symbol_global.9 = private unnamed_addr constant [7 x i8] c"AFTER3\00", align 1
@symbol_global.10 = private unnamed_addr constant [6 x i8] c"TRUE4\00", align 1
@symbol_global.11 = private unnamed_addr constant [7 x i8] c"AFTER4\00", align 1
@symbol_global.12 = private unnamed_addr constant [7 x i8] c"PHRASE\00", align 1

define i32 @main() {
entry:
  %number = alloca %SchemeObject, align 8
  %0 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %0, align 4
  %1 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 500, ptr %1, align 4
  call void @__GLPrint(ptr %number)
  %symbol = alloca %SchemeObject, align 8
  %2 = getelementptr %SchemeObject, ptr %symbol, i32 0, i32 0
  store i64 2, ptr %2, align 4
  %3 = getelementptr %SchemeObject, ptr %symbol, i32 0, i32 3
  store ptr @symbol_global, ptr %3, align 8
  call void @__GLPrint(ptr %symbol)
  %boolean = alloca %SchemeObject, align 8
  %4 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 0
  store i64 1, ptr %4, align 4
  %5 = getelementptr %SchemeObject, ptr %boolean, i32 0, i32 2
  store i1 true, ptr %5, align 1
  call void @__GLPrint(ptr %boolean)
  call void @__GLInit()
  call void @__GLClear()
  %is-open = alloca %SchemeObject, align 8
  %6 = call %SchemeObject @__GLIsOpen()
  store %SchemeObject %6, ptr %is-open, align 8
  call void @__GLPrint(ptr %is-open)
  %number1 = alloca %SchemeObject, align 8
  %7 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 0
  store i64 0, ptr %7, align 4
  %8 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 1
  store i64 1000, ptr %8, align 4
  %number2 = alloca %SchemeObject, align 8
  %9 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  store i64 0, ptr %9, align 4
  %10 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  store i64 1000, ptr %10, align 4
  %number3 = alloca %SchemeObject, align 8
  %11 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 0
  store i64 0, ptr %11, align 4
  %12 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 1
  store i64 100, ptr %12, align 4
  %number4 = alloca %SchemeObject, align 8
  %13 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 0
  store i64 0, ptr %13, align 4
  %14 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 1
  store i64 100, ptr %14, align 4
  %number5 = alloca %SchemeObject, align 8
  %15 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  store i64 0, ptr %15, align 4
  %16 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 100, ptr %16, align 4
  call void @__GLPutPixel(ptr %number1, ptr %number2, ptr %number3, ptr %number4, ptr %number5)
  call void @__GLDraw()
  call void @__GLFinish()
  %boolean6 = alloca %SchemeObject, align 8
  %17 = getelementptr %SchemeObject, ptr %boolean6, i32 0, i32 0
  store i64 1, ptr %17, align 4
  %18 = getelementptr %SchemeObject, ptr %boolean6, i32 0, i32 2
  store i1 false, ptr %18, align 1
  call void @__GLPrint(ptr %boolean6)
  %number7 = alloca %SchemeObject, align 8
  %19 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 0
  store i64 0, ptr %19, align 4
  %20 = getelementptr %SchemeObject, ptr %number7, i32 0, i32 1
  store i64 45, ptr %20, align 4
  call void @__GLPrint(ptr %number7)
  %21 = alloca %SchemeObject, align 8
  %22 = getelementptr %SchemeObject, ptr %21, i32 0, i32 0
  store i64 0, ptr %22, align 4
  %23 = getelementptr %SchemeObject, ptr %21, i32 0, i32 1
  store i64 100, ptr %23, align 4
  %number8 = alloca %SchemeObject, align 8
  %24 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 0
  store i64 0, ptr %24, align 4
  %25 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 1
  store i64 500, ptr %25, align 4
  %26 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 0
  %27 = load i64, ptr %26, align 4
  %28 = icmp eq i64 %27, 0
  call void @__GLAssert(i1 %28)
  %29 = getelementptr %SchemeObject, ptr %21, i32 0, i32 1
  %30 = load i64, ptr %29, align 4
  %31 = getelementptr %SchemeObject, ptr %number8, i32 0, i32 1
  %32 = load i64, ptr %31, align 4
  %33 = mul i64 %30, %32
  %34 = sdiv i64 %33, 100
  %35 = getelementptr %SchemeObject, ptr %21, i32 0, i32 1
  store i64 %34, ptr %35, align 4
  %number9 = alloca %SchemeObject, align 8
  %36 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 0
  store i64 0, ptr %36, align 4
  %37 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 1
  store i64 600, ptr %37, align 4
  %38 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 0
  %39 = load i64, ptr %38, align 4
  %40 = icmp eq i64 %39, 0
  call void @__GLAssert(i1 %40)
  %41 = getelementptr %SchemeObject, ptr %21, i32 0, i32 1
  %42 = load i64, ptr %41, align 4
  %43 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 1
  %44 = load i64, ptr %43, align 4
  %45 = mul i64 %42, %44
  %46 = sdiv i64 %45, 100
  %47 = getelementptr %SchemeObject, ptr %21, i32 0, i32 1
  store i64 %46, ptr %47, align 4
  %number10 = alloca %SchemeObject, align 8
  %48 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 0
  store i64 0, ptr %48, align 4
  %49 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  store i64 700, ptr %49, align 4
  %50 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 0
  %51 = load i64, ptr %50, align 4
  %52 = icmp eq i64 %51, 0
  call void @__GLAssert(i1 %52)
  %53 = getelementptr %SchemeObject, ptr %21, i32 0, i32 1
  %54 = load i64, ptr %53, align 4
  %55 = getelementptr %SchemeObject, ptr %number10, i32 0, i32 1
  %56 = load i64, ptr %55, align 4
  %57 = mul i64 %54, %56
  %58 = sdiv i64 %57, 100
  %59 = getelementptr %SchemeObject, ptr %21, i32 0, i32 1
  store i64 %58, ptr %59, align 4
  call void @__GLPrint(ptr %21)
  %60 = alloca %SchemeObject, align 8
  %61 = getelementptr %SchemeObject, ptr %60, i32 0, i32 0
  store i64 0, ptr %61, align 4
  %62 = getelementptr %SchemeObject, ptr %60, i32 0, i32 1
  store i64 0, ptr %62, align 4
  %number11 = alloca %SchemeObject, align 8
  %63 = getelementptr %SchemeObject, ptr %number11, i32 0, i32 0
  store i64 0, ptr %63, align 4
  %64 = getelementptr %SchemeObject, ptr %number11, i32 0, i32 1
  store i64 100, ptr %64, align 4
  %65 = getelementptr %SchemeObject, ptr %number11, i32 0, i32 0
  %66 = load i64, ptr %65, align 4
  %67 = icmp eq i64 %66, 0
  call void @__GLAssert(i1 %67)
  %68 = getelementptr %SchemeObject, ptr %60, i32 0, i32 1
  %69 = load i64, ptr %68, align 4
  %70 = getelementptr %SchemeObject, ptr %number11, i32 0, i32 1
  %71 = load i64, ptr %70, align 4
  %72 = add i64 %69, %71
  %73 = getelementptr %SchemeObject, ptr %60, i32 0, i32 1
  store i64 %72, ptr %73, align 4
  %74 = alloca %SchemeObject, align 8
  %75 = getelementptr %SchemeObject, ptr %74, i32 0, i32 0
  store i64 0, ptr %75, align 4
  %76 = getelementptr %SchemeObject, ptr %74, i32 0, i32 1
  store i64 0, ptr %76, align 4
  %number12 = alloca %SchemeObject, align 8
  %77 = getelementptr %SchemeObject, ptr %number12, i32 0, i32 0
  store i64 0, ptr %77, align 4
  %78 = getelementptr %SchemeObject, ptr %number12, i32 0, i32 1
  store i64 300, ptr %78, align 4
  %79 = getelementptr %SchemeObject, ptr %number12, i32 0, i32 0
  %80 = load i64, ptr %79, align 4
  %81 = icmp eq i64 %80, 0
  call void @__GLAssert(i1 %81)
  %82 = getelementptr %SchemeObject, ptr %74, i32 0, i32 1
  %83 = load i64, ptr %82, align 4
  %84 = getelementptr %SchemeObject, ptr %number12, i32 0, i32 1
  %85 = load i64, ptr %84, align 4
  %86 = add i64 %83, %85
  %87 = getelementptr %SchemeObject, ptr %74, i32 0, i32 1
  store i64 %86, ptr %87, align 4
  %number13 = alloca %SchemeObject, align 8
  %88 = getelementptr %SchemeObject, ptr %number13, i32 0, i32 0
  store i64 0, ptr %88, align 4
  %89 = getelementptr %SchemeObject, ptr %number13, i32 0, i32 1
  store i64 400, ptr %89, align 4
  %90 = getelementptr %SchemeObject, ptr %number13, i32 0, i32 0
  %91 = load i64, ptr %90, align 4
  %92 = icmp eq i64 %91, 0
  call void @__GLAssert(i1 %92)
  %93 = getelementptr %SchemeObject, ptr %74, i32 0, i32 1
  %94 = load i64, ptr %93, align 4
  %95 = getelementptr %SchemeObject, ptr %number13, i32 0, i32 1
  %96 = load i64, ptr %95, align 4
  %97 = add i64 %94, %96
  %98 = getelementptr %SchemeObject, ptr %74, i32 0, i32 1
  store i64 %97, ptr %98, align 4
  %number14 = alloca %SchemeObject, align 8
  %99 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 0
  store i64 0, ptr %99, align 4
  %100 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  store i64 500, ptr %100, align 4
  %101 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 0
  %102 = load i64, ptr %101, align 4
  %103 = icmp eq i64 %102, 0
  call void @__GLAssert(i1 %103)
  %104 = getelementptr %SchemeObject, ptr %74, i32 0, i32 1
  %105 = load i64, ptr %104, align 4
  %106 = getelementptr %SchemeObject, ptr %number14, i32 0, i32 1
  %107 = load i64, ptr %106, align 4
  %108 = add i64 %105, %107
  %109 = getelementptr %SchemeObject, ptr %74, i32 0, i32 1
  store i64 %108, ptr %109, align 4
  %110 = getelementptr %SchemeObject, ptr %74, i32 0, i32 0
  %111 = load i64, ptr %110, align 4
  %112 = icmp eq i64 %111, 0
  call void @__GLAssert(i1 %112)
  %113 = getelementptr %SchemeObject, ptr %60, i32 0, i32 1
  %114 = load i64, ptr %113, align 4
  %115 = getelementptr %SchemeObject, ptr %74, i32 0, i32 1
  %116 = load i64, ptr %115, align 4
  %117 = add i64 %114, %116
  %118 = getelementptr %SchemeObject, ptr %60, i32 0, i32 1
  store i64 %117, ptr %118, align 4
  call void @__GLPrint(ptr %60)
  %119 = alloca %SchemeObject, align 8
  %120 = getelementptr %SchemeObject, ptr %119, i32 0, i32 0
  store i64 3, ptr %120, align 4
  %121 = getelementptr %SchemeObject, ptr %119, i32 0, i32 4
  %number15 = alloca %SchemeObject, align 8
  %122 = getelementptr %SchemeObject, ptr %number15, i32 0, i32 0
  store i64 0, ptr %122, align 4
  %123 = getelementptr %SchemeObject, ptr %number15, i32 0, i32 1
  store i64 100, ptr %123, align 4
  store ptr %number15, ptr %121, align 8
  %124 = alloca %SchemeObject, align 8
  %125 = getelementptr %SchemeObject, ptr %119, i32 0, i32 0
  store i64 3, ptr %125, align 4
  %126 = getelementptr %SchemeObject, ptr %119, i32 0, i32 5
  store ptr %124, ptr %126, align 8
  %127 = getelementptr %SchemeObject, ptr %124, i32 0, i32 4
  %number16 = alloca %SchemeObject, align 8
  %128 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 0
  store i64 0, ptr %128, align 4
  %129 = getelementptr %SchemeObject, ptr %number16, i32 0, i32 1
  store i64 200, ptr %129, align 4
  store ptr %number16, ptr %127, align 8
  %130 = alloca %SchemeObject, align 8
  %131 = getelementptr %SchemeObject, ptr %124, i32 0, i32 0
  store i64 3, ptr %131, align 4
  %132 = getelementptr %SchemeObject, ptr %124, i32 0, i32 5
  store ptr %130, ptr %132, align 8
  %133 = getelementptr %SchemeObject, ptr %130, i32 0, i32 4
  %number17 = alloca %SchemeObject, align 8
  %134 = getelementptr %SchemeObject, ptr %number17, i32 0, i32 0
  store i64 0, ptr %134, align 4
  %135 = getelementptr %SchemeObject, ptr %number17, i32 0, i32 1
  store i64 300, ptr %135, align 4
  store ptr %number17, ptr %133, align 8
  %136 = alloca %SchemeObject, align 8
  %137 = getelementptr %SchemeObject, ptr %130, i32 0, i32 0
  store i64 3, ptr %137, align 4
  %138 = getelementptr %SchemeObject, ptr %130, i32 0, i32 5
  store ptr %136, ptr %138, align 8
  %139 = getelementptr %SchemeObject, ptr %136, i32 0, i32 4
  %140 = alloca %SchemeObject, align 8
  %141 = getelementptr %SchemeObject, ptr %140, i32 0, i32 0
  store i64 3, ptr %141, align 4
  %142 = getelementptr %SchemeObject, ptr %140, i32 0, i32 4
  %number18 = alloca %SchemeObject, align 8
  %143 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 0
  store i64 0, ptr %143, align 4
  %144 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  store i64 300, ptr %144, align 4
  store ptr %number18, ptr %142, align 8
  %145 = alloca %SchemeObject, align 8
  %146 = getelementptr %SchemeObject, ptr %140, i32 0, i32 0
  store i64 3, ptr %146, align 4
  %147 = getelementptr %SchemeObject, ptr %140, i32 0, i32 5
  store ptr %145, ptr %147, align 8
  %148 = getelementptr %SchemeObject, ptr %145, i32 0, i32 4
  %number19 = alloca %SchemeObject, align 8
  %149 = getelementptr %SchemeObject, ptr %number19, i32 0, i32 0
  store i64 0, ptr %149, align 4
  %150 = getelementptr %SchemeObject, ptr %number19, i32 0, i32 1
  store i64 400, ptr %150, align 4
  store ptr %number19, ptr %148, align 8
  %151 = alloca %SchemeObject, align 8
  %152 = getelementptr %SchemeObject, ptr %145, i32 0, i32 0
  store i64 3, ptr %152, align 4
  %153 = getelementptr %SchemeObject, ptr %145, i32 0, i32 5
  store ptr %151, ptr %153, align 8
  %154 = getelementptr %SchemeObject, ptr %151, i32 0, i32 4
  %symbol20 = alloca %SchemeObject, align 8
  %155 = getelementptr %SchemeObject, ptr %symbol20, i32 0, i32 0
  store i64 2, ptr %155, align 4
  %156 = getelementptr %SchemeObject, ptr %symbol20, i32 0, i32 3
  store ptr @symbol_global.1, ptr %156, align 8
  store ptr %symbol20, ptr %154, align 8
  %157 = alloca %SchemeObject, align 8
  %158 = getelementptr %SchemeObject, ptr %151, i32 0, i32 0
  store i64 3, ptr %158, align 4
  %159 = getelementptr %SchemeObject, ptr %151, i32 0, i32 5
  store ptr %157, ptr %159, align 8
  %160 = getelementptr %SchemeObject, ptr %151, i32 0, i32 5
  store i64 0, ptr %160, align 4
  store ptr %140, ptr %139, align 8
  %161 = alloca %SchemeObject, align 8
  %162 = getelementptr %SchemeObject, ptr %136, i32 0, i32 0
  store i64 3, ptr %162, align 4
  %163 = getelementptr %SchemeObject, ptr %136, i32 0, i32 5
  store ptr %161, ptr %163, align 8
  %164 = getelementptr %SchemeObject, ptr %136, i32 0, i32 5
  store i64 0, ptr %164, align 4
  call void @__GLPrint(ptr %119)
  %number21 = alloca %SchemeObject, align 8
  %165 = getelementptr %SchemeObject, ptr %number21, i32 0, i32 0
  store i64 0, ptr %165, align 4
  %166 = getelementptr %SchemeObject, ptr %number21, i32 0, i32 1
  store i64 500, ptr %166, align 4
  %number22 = alloca %SchemeObject, align 8
  %167 = getelementptr %SchemeObject, ptr %number22, i32 0, i32 0
  store i64 0, ptr %167, align 4
  %168 = getelementptr %SchemeObject, ptr %number22, i32 0, i32 1
  store i64 200, ptr %168, align 4
  %expt = alloca %SchemeObject, align 8
  %169 = call %SchemeObject @__GLExpt(ptr %number21, ptr %number22)
  store %SchemeObject %169, ptr %expt, align 8
  call void @__GLPrint(ptr %expt)
  %number23 = alloca %SchemeObject, align 8
  %170 = getelementptr %SchemeObject, ptr %number23, i32 0, i32 0
  store i64 0, ptr %170, align 4
  %171 = getelementptr %SchemeObject, ptr %number23, i32 0, i32 1
  store i64 2500, ptr %171, align 4
  %sqrt = alloca %SchemeObject, align 8
  %172 = call %SchemeObject @__GLSqrt(ptr %number23)
  store %SchemeObject %172, ptr %sqrt, align 8
  call void @__GLPrint(ptr %sqrt)
  %number24 = alloca %SchemeObject, align 8
  %173 = getelementptr %SchemeObject, ptr %number24, i32 0, i32 0
  store i64 0, ptr %173, align 4
  %174 = getelementptr %SchemeObject, ptr %number24, i32 0, i32 1
  store i64 200, ptr %174, align 4
  %sqrt25 = alloca %SchemeObject, align 8
  %175 = call %SchemeObject @__GLSqrt(ptr %number24)
  store %SchemeObject %175, ptr %sqrt25, align 8
  call void @__GLPrint(ptr %sqrt25)
  %boolean26 = alloca %SchemeObject, align 8
  %176 = getelementptr %SchemeObject, ptr %boolean26, i32 0, i32 0
  store i64 1, ptr %176, align 4
  %177 = getelementptr %SchemeObject, ptr %boolean26, i32 0, i32 2
  store i1 true, ptr %177, align 1
  %178 = getelementptr %SchemeObject, ptr %boolean26, i32 0, i32 0
  %179 = load i64, ptr %178, align 4
  %180 = icmp eq i64 %179, 1
  %181 = getelementptr %SchemeObject, ptr %boolean26, i32 0, i32 2
  %182 = load i1, ptr %181, align 1
  br i1 %182, label %true_branch, label %false_branch

true_branch:                                      ; preds = %entry
  %symbol27 = alloca %SchemeObject, align 8
  %183 = getelementptr %SchemeObject, ptr %symbol27, i32 0, i32 0
  store i64 2, ptr %183, align 4
  %184 = getelementptr %SchemeObject, ptr %symbol27, i32 0, i32 3
  store ptr @symbol_global.2, ptr %184, align 8
  call void @__GLPrint(ptr %symbol27)
  br label %merge_branch

false_branch:                                     ; preds = %entry
  %symbol28 = alloca %SchemeObject, align 8
  %185 = getelementptr %SchemeObject, ptr %symbol28, i32 0, i32 0
  store i64 2, ptr %185, align 4
  %186 = getelementptr %SchemeObject, ptr %symbol28, i32 0, i32 3
  store ptr @symbol_global.3, ptr %186, align 8
  call void @__GLPrint(ptr %symbol28)
  br label %merge_branch

merge_branch:                                     ; preds = %false_branch, %true_branch
  %187 = phi ptr [ %symbol27, %true_branch ], [ %symbol28, %false_branch ]
  %symbol29 = alloca %SchemeObject, align 8
  %188 = getelementptr %SchemeObject, ptr %symbol29, i32 0, i32 0
  store i64 2, ptr %188, align 4
  %189 = getelementptr %SchemeObject, ptr %symbol29, i32 0, i32 3
  store ptr @symbol_global.4, ptr %189, align 8
  call void @__GLPrint(ptr %symbol29)
  %boolean32 = alloca %SchemeObject, align 8
  %190 = getelementptr %SchemeObject, ptr %boolean32, i32 0, i32 0
  store i64 1, ptr %190, align 4
  %191 = getelementptr %SchemeObject, ptr %boolean32, i32 0, i32 2
  store i1 true, ptr %191, align 1
  %192 = getelementptr %SchemeObject, ptr %boolean32, i32 0, i32 0
  %193 = load i64, ptr %192, align 4
  %194 = icmp eq i64 %193, 1
  %195 = getelementptr %SchemeObject, ptr %boolean32, i32 0, i32 2
  %196 = load i1, ptr %195, align 1
  br i1 %196, label %true_branch30, label %merge_branch31

true_branch30:                                    ; preds = %merge_branch
  %symbol33 = alloca %SchemeObject, align 8
  %197 = getelementptr %SchemeObject, ptr %symbol33, i32 0, i32 0
  store i64 2, ptr %197, align 4
  %198 = getelementptr %SchemeObject, ptr %symbol33, i32 0, i32 3
  store ptr @symbol_global.5, ptr %198, align 8
  call void @__GLPrint(ptr %symbol33)
  br label %merge_branch31

merge_branch31:                                   ; preds = %true_branch30, %merge_branch
  %199 = phi ptr [ %symbol33, %true_branch30 ]
  %symbol34 = alloca %SchemeObject, align 8
  %200 = getelementptr %SchemeObject, ptr %symbol34, i32 0, i32 0
  store i64 2, ptr %200, align 4
  %201 = getelementptr %SchemeObject, ptr %symbol34, i32 0, i32 3
  store ptr @symbol_global.6, ptr %201, align 8
  call void @__GLPrint(ptr %symbol34)
  %boolean38 = alloca %SchemeObject, align 8
  %202 = getelementptr %SchemeObject, ptr %boolean38, i32 0, i32 0
  store i64 1, ptr %202, align 4
  %203 = getelementptr %SchemeObject, ptr %boolean38, i32 0, i32 2
  store i1 false, ptr %203, align 1
  %204 = getelementptr %SchemeObject, ptr %boolean38, i32 0, i32 0
  %205 = load i64, ptr %204, align 4
  %206 = icmp eq i64 %205, 1
  %207 = getelementptr %SchemeObject, ptr %boolean38, i32 0, i32 2
  %208 = load i1, ptr %207, align 1
  br i1 %208, label %true_branch35, label %false_branch36

true_branch35:                                    ; preds = %merge_branch31
  %symbol39 = alloca %SchemeObject, align 8
  %209 = getelementptr %SchemeObject, ptr %symbol39, i32 0, i32 0
  store i64 2, ptr %209, align 4
  %210 = getelementptr %SchemeObject, ptr %symbol39, i32 0, i32 3
  store ptr @symbol_global.7, ptr %210, align 8
  call void @__GLPrint(ptr %symbol39)
  br label %merge_branch37

false_branch36:                                   ; preds = %merge_branch31
  %symbol40 = alloca %SchemeObject, align 8
  %211 = getelementptr %SchemeObject, ptr %symbol40, i32 0, i32 0
  store i64 2, ptr %211, align 4
  %212 = getelementptr %SchemeObject, ptr %symbol40, i32 0, i32 3
  store ptr @symbol_global.8, ptr %212, align 8
  call void @__GLPrint(ptr %symbol40)
  br label %merge_branch37

merge_branch37:                                   ; preds = %false_branch36, %true_branch35
  %213 = phi ptr [ %symbol39, %true_branch35 ], [ %symbol40, %false_branch36 ]
  %symbol41 = alloca %SchemeObject, align 8
  %214 = getelementptr %SchemeObject, ptr %symbol41, i32 0, i32 0
  store i64 2, ptr %214, align 4
  %215 = getelementptr %SchemeObject, ptr %symbol41, i32 0, i32 3
  store ptr @symbol_global.9, ptr %215, align 8
  call void @__GLPrint(ptr %symbol41)
  %boolean44 = alloca %SchemeObject, align 8
  %216 = getelementptr %SchemeObject, ptr %boolean44, i32 0, i32 0
  store i64 1, ptr %216, align 4
  %217 = getelementptr %SchemeObject, ptr %boolean44, i32 0, i32 2
  store i1 false, ptr %217, align 1
  %218 = getelementptr %SchemeObject, ptr %boolean44, i32 0, i32 0
  %219 = load i64, ptr %218, align 4
  %220 = icmp eq i64 %219, 1
  %221 = getelementptr %SchemeObject, ptr %boolean44, i32 0, i32 2
  %222 = load i1, ptr %221, align 1
  br i1 %222, label %true_branch42, label %merge_branch43

true_branch42:                                    ; preds = %merge_branch37
  %symbol45 = alloca %SchemeObject, align 8
  %223 = getelementptr %SchemeObject, ptr %symbol45, i32 0, i32 0
  store i64 2, ptr %223, align 4
  %224 = getelementptr %SchemeObject, ptr %symbol45, i32 0, i32 3
  store ptr @symbol_global.10, ptr %224, align 8
  call void @__GLPrint(ptr %symbol45)
  br label %merge_branch43

merge_branch43:                                   ; preds = %true_branch42, %merge_branch37
  %225 = phi ptr [ %symbol45, %true_branch42 ]
  %symbol46 = alloca %SchemeObject, align 8
  %226 = getelementptr %SchemeObject, ptr %symbol46, i32 0, i32 0
  store i64 2, ptr %226, align 4
  %227 = getelementptr %SchemeObject, ptr %symbol46, i32 0, i32 3
  store ptr @symbol_global.11, ptr %227, align 8
  call void @__GLPrint(ptr %symbol46)
  %228 = alloca %SchemeObject, align 8
  %229 = getelementptr %SchemeObject, ptr %228, i32 0, i32 0
  store i64 0, ptr %229, align 4
  %230 = getelementptr %SchemeObject, ptr %228, i32 0, i32 1
  store i64 0, ptr %230, align 4
  %number47 = alloca %SchemeObject, align 8
  %231 = getelementptr %SchemeObject, ptr %number47, i32 0, i32 0
  store i64 0, ptr %231, align 4
  %232 = getelementptr %SchemeObject, ptr %number47, i32 0, i32 1
  store i64 500, ptr %232, align 4
  %233 = getelementptr %SchemeObject, ptr %number47, i32 0, i32 0
  %234 = load i64, ptr %233, align 4
  %235 = icmp eq i64 %234, 0
  call void @__GLAssert(i1 %235)
  %236 = getelementptr %SchemeObject, ptr %228, i32 0, i32 1
  %237 = load i64, ptr %236, align 4
  %238 = getelementptr %SchemeObject, ptr %number47, i32 0, i32 1
  %239 = load i64, ptr %238, align 4
  %240 = sub i64 %237, %239
  %241 = getelementptr %SchemeObject, ptr %228, i32 0, i32 1
  store i64 %239, ptr %241, align 4
  %number48 = alloca %SchemeObject, align 8
  %242 = getelementptr %SchemeObject, ptr %number48, i32 0, i32 0
  store i64 0, ptr %242, align 4
  %243 = getelementptr %SchemeObject, ptr %number48, i32 0, i32 1
  store i64 200, ptr %243, align 4
  %244 = getelementptr %SchemeObject, ptr %number48, i32 0, i32 0
  %245 = load i64, ptr %244, align 4
  %246 = icmp eq i64 %245, 0
  call void @__GLAssert(i1 %246)
  %247 = getelementptr %SchemeObject, ptr %228, i32 0, i32 1
  %248 = load i64, ptr %247, align 4
  %249 = getelementptr %SchemeObject, ptr %number48, i32 0, i32 1
  %250 = load i64, ptr %249, align 4
  %251 = sub i64 %248, %250
  %252 = getelementptr %SchemeObject, ptr %228, i32 0, i32 1
  store i64 %251, ptr %252, align 4
  call void @__GLPrint(ptr %228)
  %253 = alloca %SchemeObject, align 8
  %254 = getelementptr %SchemeObject, ptr %253, i32 0, i32 0
  store i64 0, ptr %254, align 4
  %255 = getelementptr %SchemeObject, ptr %253, i32 0, i32 1
  store i64 0, ptr %255, align 4
  %number49 = alloca %SchemeObject, align 8
  %256 = getelementptr %SchemeObject, ptr %number49, i32 0, i32 0
  store i64 0, ptr %256, align 4
  %257 = getelementptr %SchemeObject, ptr %number49, i32 0, i32 1
  store i64 500, ptr %257, align 4
  %258 = getelementptr %SchemeObject, ptr %number49, i32 0, i32 0
  %259 = load i64, ptr %258, align 4
  %260 = icmp eq i64 %259, 0
  call void @__GLAssert(i1 %260)
  %261 = getelementptr %SchemeObject, ptr %253, i32 0, i32 1
  %262 = load i64, ptr %261, align 4
  %263 = getelementptr %SchemeObject, ptr %number49, i32 0, i32 1
  %264 = load i64, ptr %263, align 4
  %265 = sub i64 %262, %264
  %266 = getelementptr %SchemeObject, ptr %253, i32 0, i32 1
  store i64 %264, ptr %266, align 4
  %number50 = alloca %SchemeObject, align 8
  %267 = getelementptr %SchemeObject, ptr %number50, i32 0, i32 0
  store i64 0, ptr %267, align 4
  %268 = getelementptr %SchemeObject, ptr %number50, i32 0, i32 1
  store i64 100, ptr %268, align 4
  %269 = getelementptr %SchemeObject, ptr %number50, i32 0, i32 0
  %270 = load i64, ptr %269, align 4
  %271 = icmp eq i64 %270, 0
  call void @__GLAssert(i1 %271)
  %272 = getelementptr %SchemeObject, ptr %253, i32 0, i32 1
  %273 = load i64, ptr %272, align 4
  %274 = getelementptr %SchemeObject, ptr %number50, i32 0, i32 1
  %275 = load i64, ptr %274, align 4
  %276 = sub i64 %273, %275
  %277 = getelementptr %SchemeObject, ptr %253, i32 0, i32 1
  store i64 %276, ptr %277, align 4
  %number51 = alloca %SchemeObject, align 8
  %278 = getelementptr %SchemeObject, ptr %number51, i32 0, i32 0
  store i64 0, ptr %278, align 4
  %279 = getelementptr %SchemeObject, ptr %number51, i32 0, i32 1
  store i64 200, ptr %279, align 4
  %280 = getelementptr %SchemeObject, ptr %number51, i32 0, i32 0
  %281 = load i64, ptr %280, align 4
  %282 = icmp eq i64 %281, 0
  call void @__GLAssert(i1 %282)
  %283 = getelementptr %SchemeObject, ptr %253, i32 0, i32 1
  %284 = load i64, ptr %283, align 4
  %285 = getelementptr %SchemeObject, ptr %number51, i32 0, i32 1
  %286 = load i64, ptr %285, align 4
  %287 = sub i64 %284, %286
  %288 = getelementptr %SchemeObject, ptr %253, i32 0, i32 1
  store i64 %287, ptr %288, align 4
  call void @__GLPrint(ptr %253)
  %289 = alloca %SchemeObject, align 8
  %290 = getelementptr %SchemeObject, ptr %289, i32 0, i32 0
  store i64 0, ptr %290, align 4
  %291 = getelementptr %SchemeObject, ptr %289, i32 0, i32 1
  store i64 100, ptr %291, align 4
  %number52 = alloca %SchemeObject, align 8
  %292 = getelementptr %SchemeObject, ptr %number52, i32 0, i32 0
  store i64 0, ptr %292, align 4
  %293 = getelementptr %SchemeObject, ptr %number52, i32 0, i32 1
  store i64 400, ptr %293, align 4
  %294 = getelementptr %SchemeObject, ptr %number52, i32 0, i32 0
  %295 = load i64, ptr %294, align 4
  %296 = icmp eq i64 %295, 0
  call void @__GLAssert(i1 %296)
  %297 = getelementptr %SchemeObject, ptr %289, i32 0, i32 1
  %298 = load i64, ptr %297, align 4
  %299 = getelementptr %SchemeObject, ptr %number52, i32 0, i32 1
  %300 = load i64, ptr %299, align 4
  %301 = icmp ne i64 %300, 0
  br i1 %301, label %continue_branch, label %modify_branch

modify_branch:                                    ; preds = %merge_branch43
  br label %continue_branch

continue_branch:                                  ; preds = %modify_branch, %merge_branch43
  %302 = phi i64 [ 1, %modify_branch ], [ %300, %merge_branch43 ]
  %303 = mul i64 %298, 100
  %304 = sdiv i64 %303, %302
  %305 = getelementptr %SchemeObject, ptr %289, i32 0, i32 1
  store i64 %300, ptr %305, align 4
  %number53 = alloca %SchemeObject, align 8
  %306 = getelementptr %SchemeObject, ptr %number53, i32 0, i32 0
  store i64 0, ptr %306, align 4
  %307 = getelementptr %SchemeObject, ptr %number53, i32 0, i32 1
  store i64 200, ptr %307, align 4
  %308 = getelementptr %SchemeObject, ptr %number53, i32 0, i32 0
  %309 = load i64, ptr %308, align 4
  %310 = icmp eq i64 %309, 0
  call void @__GLAssert(i1 %310)
  %311 = getelementptr %SchemeObject, ptr %289, i32 0, i32 1
  %312 = load i64, ptr %311, align 4
  %313 = getelementptr %SchemeObject, ptr %number53, i32 0, i32 1
  %314 = load i64, ptr %313, align 4
  %315 = icmp ne i64 %314, 0
  br i1 %315, label %continue_branch55, label %modify_branch54

modify_branch54:                                  ; preds = %continue_branch
  br label %continue_branch55

continue_branch55:                                ; preds = %modify_branch54, %continue_branch
  %316 = phi i64 [ 1, %modify_branch54 ], [ %314, %continue_branch ]
  %317 = mul i64 %312, 100
  %318 = sdiv i64 %317, %316
  %319 = getelementptr %SchemeObject, ptr %289, i32 0, i32 1
  store i64 %318, ptr %319, align 4
  call void @__GLPrint(ptr %289)
  %320 = alloca %SchemeObject, align 8
  %321 = getelementptr %SchemeObject, ptr %320, i32 0, i32 0
  store i64 0, ptr %321, align 4
  %322 = getelementptr %SchemeObject, ptr %320, i32 0, i32 1
  store i64 100, ptr %322, align 4
  %number56 = alloca %SchemeObject, align 8
  %323 = getelementptr %SchemeObject, ptr %number56, i32 0, i32 0
  store i64 0, ptr %323, align 4
  %324 = getelementptr %SchemeObject, ptr %number56, i32 0, i32 1
  store i64 400, ptr %324, align 4
  %325 = getelementptr %SchemeObject, ptr %number56, i32 0, i32 0
  %326 = load i64, ptr %325, align 4
  %327 = icmp eq i64 %326, 0
  call void @__GLAssert(i1 %327)
  %328 = getelementptr %SchemeObject, ptr %320, i32 0, i32 1
  %329 = load i64, ptr %328, align 4
  %330 = getelementptr %SchemeObject, ptr %number56, i32 0, i32 1
  %331 = load i64, ptr %330, align 4
  %332 = icmp ne i64 %331, 0
  br i1 %332, label %continue_branch58, label %modify_branch57

modify_branch57:                                  ; preds = %continue_branch55
  br label %continue_branch58

continue_branch58:                                ; preds = %modify_branch57, %continue_branch55
  %333 = phi i64 [ 1, %modify_branch57 ], [ %331, %continue_branch55 ]
  %334 = mul i64 %329, 100
  %335 = sdiv i64 %334, %333
  %336 = getelementptr %SchemeObject, ptr %320, i32 0, i32 1
  store i64 %331, ptr %336, align 4
  %number59 = alloca %SchemeObject, align 8
  %337 = getelementptr %SchemeObject, ptr %number59, i32 0, i32 0
  store i64 0, ptr %337, align 4
  %338 = getelementptr %SchemeObject, ptr %number59, i32 0, i32 1
  store i64 200, ptr %338, align 4
  %339 = getelementptr %SchemeObject, ptr %number59, i32 0, i32 0
  %340 = load i64, ptr %339, align 4
  %341 = icmp eq i64 %340, 0
  call void @__GLAssert(i1 %341)
  %342 = getelementptr %SchemeObject, ptr %320, i32 0, i32 1
  %343 = load i64, ptr %342, align 4
  %344 = getelementptr %SchemeObject, ptr %number59, i32 0, i32 1
  %345 = load i64, ptr %344, align 4
  %346 = icmp ne i64 %345, 0
  br i1 %346, label %continue_branch61, label %modify_branch60

modify_branch60:                                  ; preds = %continue_branch58
  br label %continue_branch61

continue_branch61:                                ; preds = %modify_branch60, %continue_branch58
  %347 = phi i64 [ 1, %modify_branch60 ], [ %345, %continue_branch58 ]
  %348 = mul i64 %343, 100
  %349 = sdiv i64 %348, %347
  %350 = getelementptr %SchemeObject, ptr %320, i32 0, i32 1
  store i64 %349, ptr %350, align 4
  %number62 = alloca %SchemeObject, align 8
  %351 = getelementptr %SchemeObject, ptr %number62, i32 0, i32 0
  store i64 0, ptr %351, align 4
  %352 = getelementptr %SchemeObject, ptr %number62, i32 0, i32 1
  store i64 200, ptr %352, align 4
  %353 = getelementptr %SchemeObject, ptr %number62, i32 0, i32 0
  %354 = load i64, ptr %353, align 4
  %355 = icmp eq i64 %354, 0
  call void @__GLAssert(i1 %355)
  %356 = getelementptr %SchemeObject, ptr %320, i32 0, i32 1
  %357 = load i64, ptr %356, align 4
  %358 = getelementptr %SchemeObject, ptr %number62, i32 0, i32 1
  %359 = load i64, ptr %358, align 4
  %360 = icmp ne i64 %359, 0
  br i1 %360, label %continue_branch64, label %modify_branch63

modify_branch63:                                  ; preds = %continue_branch61
  br label %continue_branch64

continue_branch64:                                ; preds = %modify_branch63, %continue_branch61
  %361 = phi i64 [ 1, %modify_branch63 ], [ %359, %continue_branch61 ]
  %362 = mul i64 %357, 100
  %363 = sdiv i64 %362, %361
  %364 = getelementptr %SchemeObject, ptr %320, i32 0, i32 1
  store i64 %363, ptr %364, align 4
  call void @__GLPrint(ptr %320)
  %365 = alloca %SchemeObject, align 8
  %366 = getelementptr %SchemeObject, ptr %365, i32 0, i32 0
  store i64 0, ptr %366, align 4
  %367 = getelementptr %SchemeObject, ptr %365, i32 0, i32 1
  store i64 100, ptr %367, align 4
  %number65 = alloca %SchemeObject, align 8
  %368 = getelementptr %SchemeObject, ptr %number65, i32 0, i32 0
  store i64 0, ptr %368, align 4
  %369 = getelementptr %SchemeObject, ptr %number65, i32 0, i32 1
  store i64 400, ptr %369, align 4
  %370 = getelementptr %SchemeObject, ptr %number65, i32 0, i32 0
  %371 = load i64, ptr %370, align 4
  %372 = icmp eq i64 %371, 0
  call void @__GLAssert(i1 %372)
  %373 = getelementptr %SchemeObject, ptr %365, i32 0, i32 1
  %374 = load i64, ptr %373, align 4
  %375 = getelementptr %SchemeObject, ptr %number65, i32 0, i32 1
  %376 = load i64, ptr %375, align 4
  %377 = icmp ne i64 %376, 0
  br i1 %377, label %continue_branch67, label %modify_branch66

modify_branch66:                                  ; preds = %continue_branch64
  br label %continue_branch67

continue_branch67:                                ; preds = %modify_branch66, %continue_branch64
  %378 = phi i64 [ 1, %modify_branch66 ], [ %376, %continue_branch64 ]
  %379 = mul i64 %374, 100
  %380 = sdiv i64 %379, %378
  %381 = getelementptr %SchemeObject, ptr %365, i32 0, i32 1
  store i64 %376, ptr %381, align 4
  %number68 = alloca %SchemeObject, align 8
  %382 = getelementptr %SchemeObject, ptr %number68, i32 0, i32 0
  store i64 0, ptr %382, align 4
  %383 = getelementptr %SchemeObject, ptr %number68, i32 0, i32 1
  store i64 200, ptr %383, align 4
  %384 = getelementptr %SchemeObject, ptr %number68, i32 0, i32 0
  %385 = load i64, ptr %384, align 4
  %386 = icmp eq i64 %385, 0
  call void @__GLAssert(i1 %386)
  %387 = getelementptr %SchemeObject, ptr %365, i32 0, i32 1
  %388 = load i64, ptr %387, align 4
  %389 = getelementptr %SchemeObject, ptr %number68, i32 0, i32 1
  %390 = load i64, ptr %389, align 4
  %391 = icmp ne i64 %390, 0
  br i1 %391, label %continue_branch70, label %modify_branch69

modify_branch69:                                  ; preds = %continue_branch67
  br label %continue_branch70

continue_branch70:                                ; preds = %modify_branch69, %continue_branch67
  %392 = phi i64 [ 1, %modify_branch69 ], [ %390, %continue_branch67 ]
  %393 = mul i64 %388, 100
  %394 = sdiv i64 %393, %392
  %395 = getelementptr %SchemeObject, ptr %365, i32 0, i32 1
  store i64 %394, ptr %395, align 4
  %number71 = alloca %SchemeObject, align 8
  %396 = getelementptr %SchemeObject, ptr %number71, i32 0, i32 0
  store i64 0, ptr %396, align 4
  %397 = getelementptr %SchemeObject, ptr %number71, i32 0, i32 1
  store i64 0, ptr %397, align 4
  %398 = getelementptr %SchemeObject, ptr %number71, i32 0, i32 0
  %399 = load i64, ptr %398, align 4
  %400 = icmp eq i64 %399, 0
  call void @__GLAssert(i1 %400)
  %401 = getelementptr %SchemeObject, ptr %365, i32 0, i32 1
  %402 = load i64, ptr %401, align 4
  %403 = getelementptr %SchemeObject, ptr %number71, i32 0, i32 1
  %404 = load i64, ptr %403, align 4
  %405 = icmp ne i64 %404, 0
  br i1 %405, label %continue_branch73, label %modify_branch72

modify_branch72:                                  ; preds = %continue_branch70
  br label %continue_branch73

continue_branch73:                                ; preds = %modify_branch72, %continue_branch70
  %406 = phi i64 [ 1, %modify_branch72 ], [ %404, %continue_branch70 ]
  %407 = mul i64 %402, 100
  %408 = sdiv i64 %407, %406
  %409 = getelementptr %SchemeObject, ptr %365, i32 0, i32 1
  store i64 %408, ptr %409, align 4
  call void @__GLPrint(ptr %365)
  %410 = alloca %SchemeObject, align 8
  %411 = getelementptr %SchemeObject, ptr %410, i32 0, i32 0
  store i64 0, ptr %411, align 4
  %412 = getelementptr %SchemeObject, ptr %410, i32 0, i32 1
  store i64 100, ptr %412, align 4
  %number74 = alloca %SchemeObject, align 8
  %413 = getelementptr %SchemeObject, ptr %number74, i32 0, i32 0
  store i64 0, ptr %413, align 4
  %414 = getelementptr %SchemeObject, ptr %number74, i32 0, i32 1
  store i64 0, ptr %414, align 4
  %415 = getelementptr %SchemeObject, ptr %number74, i32 0, i32 0
  %416 = load i64, ptr %415, align 4
  %417 = icmp eq i64 %416, 0
  call void @__GLAssert(i1 %417)
  %418 = getelementptr %SchemeObject, ptr %410, i32 0, i32 1
  %419 = load i64, ptr %418, align 4
  %420 = getelementptr %SchemeObject, ptr %number74, i32 0, i32 1
  %421 = load i64, ptr %420, align 4
  %422 = icmp ne i64 %421, 0
  br i1 %422, label %continue_branch76, label %modify_branch75

modify_branch75:                                  ; preds = %continue_branch73
  br label %continue_branch76

continue_branch76:                                ; preds = %modify_branch75, %continue_branch73
  %423 = phi i64 [ 1, %modify_branch75 ], [ %421, %continue_branch73 ]
  %424 = mul i64 %419, 100
  %425 = sdiv i64 %424, %423
  %426 = getelementptr %SchemeObject, ptr %410, i32 0, i32 1
  store i64 %421, ptr %426, align 4
  %number77 = alloca %SchemeObject, align 8
  %427 = getelementptr %SchemeObject, ptr %number77, i32 0, i32 0
  store i64 0, ptr %427, align 4
  %428 = getelementptr %SchemeObject, ptr %number77, i32 0, i32 1
  store i64 200, ptr %428, align 4
  %429 = getelementptr %SchemeObject, ptr %number77, i32 0, i32 0
  %430 = load i64, ptr %429, align 4
  %431 = icmp eq i64 %430, 0
  call void @__GLAssert(i1 %431)
  %432 = getelementptr %SchemeObject, ptr %410, i32 0, i32 1
  %433 = load i64, ptr %432, align 4
  %434 = getelementptr %SchemeObject, ptr %number77, i32 0, i32 1
  %435 = load i64, ptr %434, align 4
  %436 = icmp ne i64 %435, 0
  br i1 %436, label %continue_branch79, label %modify_branch78

modify_branch78:                                  ; preds = %continue_branch76
  br label %continue_branch79

continue_branch79:                                ; preds = %modify_branch78, %continue_branch76
  %437 = phi i64 [ 1, %modify_branch78 ], [ %435, %continue_branch76 ]
  %438 = mul i64 %433, 100
  %439 = sdiv i64 %438, %437
  %440 = getelementptr %SchemeObject, ptr %410, i32 0, i32 1
  store i64 %439, ptr %440, align 4
  call void @__GLPrint(ptr %410)
  %symbol80 = alloca %SchemeObject, align 8
  %441 = getelementptr %SchemeObject, ptr %symbol80, i32 0, i32 0
  store i64 2, ptr %441, align 4
  %442 = getelementptr %SchemeObject, ptr %symbol80, i32 0, i32 3
  store ptr @symbol_global.12, ptr %442, align 8
  call void @__GLPrint(ptr %symbol80)
  %number81 = alloca %SchemeObject, align 8
  %443 = getelementptr %SchemeObject, ptr %number81, i32 0, i32 0
  store i64 0, ptr %443, align 4
  %444 = getelementptr %SchemeObject, ptr %number81, i32 0, i32 1
  store i64 500, ptr %444, align 4
  %445 = alloca %SchemeObject, align 8
  %446 = getelementptr %SchemeObject, ptr %445, i32 0, i32 0
  store i64 0, ptr %446, align 4
  %447 = getelementptr %SchemeObject, ptr %445, i32 0, i32 1
  store i64 0, ptr %447, align 4
  %448 = getelementptr %SchemeObject, ptr %number81, i32 0, i32 0
  %449 = load i64, ptr %448, align 4
  %450 = icmp eq i64 %449, 0
  call void @__GLAssert(i1 %450)
  %451 = getelementptr %SchemeObject, ptr %445, i32 0, i32 1
  %452 = load i64, ptr %451, align 4
  %453 = getelementptr %SchemeObject, ptr %number81, i32 0, i32 1
  %454 = load i64, ptr %453, align 4
  %455 = sub i64 %452, %454
  %456 = getelementptr %SchemeObject, ptr %445, i32 0, i32 1
  store i64 %454, ptr %456, align 4
  %number82 = alloca %SchemeObject, align 8
  %457 = getelementptr %SchemeObject, ptr %number82, i32 0, i32 0
  store i64 0, ptr %457, align 4
  %458 = getelementptr %SchemeObject, ptr %number82, i32 0, i32 1
  store i64 100, ptr %458, align 4
  %459 = getelementptr %SchemeObject, ptr %number82, i32 0, i32 0
  %460 = load i64, ptr %459, align 4
  %461 = icmp eq i64 %460, 0
  call void @__GLAssert(i1 %461)
  %462 = getelementptr %SchemeObject, ptr %445, i32 0, i32 1
  %463 = load i64, ptr %462, align 4
  %464 = getelementptr %SchemeObject, ptr %number82, i32 0, i32 1
  %465 = load i64, ptr %464, align 4
  %466 = sub i64 %463, %465
  %467 = getelementptr %SchemeObject, ptr %445, i32 0, i32 1
  store i64 %466, ptr %467, align 4
  %number83 = alloca %SchemeObject, align 8
  %468 = getelementptr %SchemeObject, ptr %number83, i32 0, i32 0
  store i64 0, ptr %468, align 4
  %469 = getelementptr %SchemeObject, ptr %number83, i32 0, i32 1
  store i64 100, ptr %469, align 4
  %470 = getelementptr %SchemeObject, ptr %number83, i32 0, i32 0
  %471 = load i64, ptr %470, align 4
  %472 = icmp eq i64 %471, 0
  call void @__GLAssert(i1 %472)
  %473 = getelementptr %SchemeObject, ptr %445, i32 0, i32 1
  %474 = load i64, ptr %473, align 4
  %475 = getelementptr %SchemeObject, ptr %number83, i32 0, i32 1
  %476 = load i64, ptr %475, align 4
  %477 = sub i64 %474, %476
  %478 = getelementptr %SchemeObject, ptr %445, i32 0, i32 1
  store i64 %477, ptr %478, align 4
  %479 = alloca %SchemeObject, align 8
  %480 = getelementptr %SchemeObject, ptr %479, i32 0, i32 0
  store i64 0, ptr %480, align 4
  %481 = getelementptr %SchemeObject, ptr %479, i32 0, i32 1
  store i64 0, ptr %481, align 4
  %482 = getelementptr %SchemeObject, ptr %445, i32 0, i32 0
  %483 = load i64, ptr %482, align 4
  %484 = icmp eq i64 %483, 0
  call void @__GLAssert(i1 %484)
  %485 = getelementptr %SchemeObject, ptr %479, i32 0, i32 1
  %486 = load i64, ptr %485, align 4
  %487 = getelementptr %SchemeObject, ptr %445, i32 0, i32 1
  %488 = load i64, ptr %487, align 4
  %489 = add i64 %486, %488
  %490 = getelementptr %SchemeObject, ptr %479, i32 0, i32 1
  store i64 %489, ptr %490, align 4
  %number84 = alloca %SchemeObject, align 8
  %491 = getelementptr %SchemeObject, ptr %number84, i32 0, i32 0
  store i64 0, ptr %491, align 4
  %492 = getelementptr %SchemeObject, ptr %number84, i32 0, i32 1
  store i64 500, ptr %492, align 4
  %493 = getelementptr %SchemeObject, ptr %number84, i32 0, i32 0
  %494 = load i64, ptr %493, align 4
  %495 = icmp eq i64 %494, 0
  call void @__GLAssert(i1 %495)
  %496 = getelementptr %SchemeObject, ptr %479, i32 0, i32 1
  %497 = load i64, ptr %496, align 4
  %498 = getelementptr %SchemeObject, ptr %number84, i32 0, i32 1
  %499 = load i64, ptr %498, align 4
  %500 = add i64 %497, %499
  %501 = getelementptr %SchemeObject, ptr %479, i32 0, i32 1
  store i64 %500, ptr %501, align 4
  call void @__GLPrint(ptr %479)
  %number85 = alloca %SchemeObject, align 8
  %502 = getelementptr %SchemeObject, ptr %number85, i32 0, i32 0
  store i64 0, ptr %502, align 4
  %503 = getelementptr %SchemeObject, ptr %number85, i32 0, i32 1
  store i64 500, ptr %503, align 4
  %504 = getelementptr %SchemeObject, ptr %number85, i32 0, i32 0
  %505 = load i64, ptr %504, align 4
  %506 = icmp eq i64 %505, 0
  call void @__GLAssert(i1 %506)
  %507 = getelementptr %SchemeObject, ptr %number85, i32 0, i32 1
  %508 = load i64, ptr %507, align 4
  %509 = srem i64 %508, 100
  %510 = icmp eq i64 %509, 0
  call void @__GLAssert(i1 %510)
  %number86 = alloca %SchemeObject, align 8
  %511 = getelementptr %SchemeObject, ptr %number86, i32 0, i32 0
  store i64 0, ptr %511, align 4
  %512 = getelementptr %SchemeObject, ptr %number86, i32 0, i32 1
  store i64 300, ptr %512, align 4
  %513 = getelementptr %SchemeObject, ptr %number86, i32 0, i32 0
  %514 = load i64, ptr %513, align 4
  %515 = icmp eq i64 %514, 0
  call void @__GLAssert(i1 %515)
  %516 = getelementptr %SchemeObject, ptr %number86, i32 0, i32 1
  %517 = load i64, ptr %516, align 4
  %518 = srem i64 %517, 100
  %519 = icmp eq i64 %518, 0
  call void @__GLAssert(i1 %519)
  %520 = icmp ne i64 %517, 0
  br i1 %520, label %continue_branch88, label %modify_branch87

modify_branch87:                                  ; preds = %continue_branch79
  br label %continue_branch88

continue_branch88:                                ; preds = %modify_branch87, %continue_branch79
  %521 = phi i64 [ 1, %modify_branch87 ], [ %517, %continue_branch79 ]
  %522 = mul i64 %508, 100
  %523 = sdiv i64 %522, %521
  %524 = alloca %SchemeObject, align 8
  %525 = getelementptr %SchemeObject, ptr %524, i32 0, i32 0
  store i64 0, ptr %525, align 4
  %526 = getelementptr %SchemeObject, ptr %524, i32 0, i32 1
  store i64 %523, ptr %526, align 4
  call void @__GLPrint(ptr %524)
  %number89 = alloca %SchemeObject, align 8
  %527 = getelementptr %SchemeObject, ptr %number89, i32 0, i32 0
  store i64 0, ptr %527, align 4
  %528 = getelementptr %SchemeObject, ptr %number89, i32 0, i32 1
  store i64 500, ptr %528, align 4
  %529 = getelementptr %SchemeObject, ptr %number89, i32 0, i32 0
  %530 = load i64, ptr %529, align 4
  %531 = icmp eq i64 %530, 0
  call void @__GLAssert(i1 %531)
  %532 = getelementptr %SchemeObject, ptr %number89, i32 0, i32 1
  %533 = load i64, ptr %532, align 4
  %534 = srem i64 %533, 100
  %535 = icmp eq i64 %534, 0
  call void @__GLAssert(i1 %535)
  %number90 = alloca %SchemeObject, align 8
  %536 = getelementptr %SchemeObject, ptr %number90, i32 0, i32 0
  store i64 0, ptr %536, align 4
  %537 = getelementptr %SchemeObject, ptr %number90, i32 0, i32 1
  store i64 0, ptr %537, align 4
  %538 = getelementptr %SchemeObject, ptr %number90, i32 0, i32 0
  %539 = load i64, ptr %538, align 4
  %540 = icmp eq i64 %539, 0
  call void @__GLAssert(i1 %540)
  %541 = getelementptr %SchemeObject, ptr %number90, i32 0, i32 1
  %542 = load i64, ptr %541, align 4
  %543 = srem i64 %542, 100
  %544 = icmp eq i64 %543, 0
  call void @__GLAssert(i1 %544)
  %545 = icmp ne i64 %542, 0
  br i1 %545, label %continue_branch92, label %modify_branch91

modify_branch91:                                  ; preds = %continue_branch88
  br label %continue_branch92

continue_branch92:                                ; preds = %modify_branch91, %continue_branch88
  %546 = phi i64 [ 1, %modify_branch91 ], [ %542, %continue_branch88 ]
  %547 = mul i64 %533, 100
  %548 = sdiv i64 %547, %546
  %549 = alloca %SchemeObject, align 8
  %550 = getelementptr %SchemeObject, ptr %549, i32 0, i32 0
  store i64 0, ptr %550, align 4
  %551 = getelementptr %SchemeObject, ptr %549, i32 0, i32 1
  store i64 %548, ptr %551, align 4
  call void @__GLPrint(ptr %549)
  %number93 = alloca %SchemeObject, align 8
  %552 = getelementptr %SchemeObject, ptr %number93, i32 0, i32 0
  store i64 0, ptr %552, align 4
  %553 = getelementptr %SchemeObject, ptr %number93, i32 0, i32 1
  store i64 600, ptr %553, align 4
  %554 = getelementptr %SchemeObject, ptr %number93, i32 0, i32 0
  %555 = load i64, ptr %554, align 4
  %556 = icmp eq i64 %555, 0
  call void @__GLAssert(i1 %556)
  %557 = getelementptr %SchemeObject, ptr %number93, i32 0, i32 1
  %558 = load i64, ptr %557, align 4
  %559 = srem i64 %558, 100
  %560 = icmp eq i64 %559, 0
  call void @__GLAssert(i1 %560)
  %number94 = alloca %SchemeObject, align 8
  %561 = getelementptr %SchemeObject, ptr %number94, i32 0, i32 0
  store i64 0, ptr %561, align 4
  %562 = getelementptr %SchemeObject, ptr %number94, i32 0, i32 1
  store i64 300, ptr %562, align 4
  %563 = getelementptr %SchemeObject, ptr %number94, i32 0, i32 0
  %564 = load i64, ptr %563, align 4
  %565 = icmp eq i64 %564, 0
  call void @__GLAssert(i1 %565)
  %566 = getelementptr %SchemeObject, ptr %number94, i32 0, i32 1
  %567 = load i64, ptr %566, align 4
  %568 = srem i64 %567, 100
  %569 = icmp eq i64 %568, 0
  call void @__GLAssert(i1 %569)
  %570 = icmp ne i64 %567, 0
  br i1 %570, label %continue_branch96, label %modify_branch95

modify_branch95:                                  ; preds = %continue_branch92
  br label %continue_branch96

continue_branch96:                                ; preds = %modify_branch95, %continue_branch92
  %571 = phi i64 [ 1, %modify_branch95 ], [ %567, %continue_branch92 ]
  %572 = mul i64 %558, 100
  %573 = sdiv i64 %572, %571
  %574 = alloca %SchemeObject, align 8
  %575 = getelementptr %SchemeObject, ptr %574, i32 0, i32 0
  store i64 0, ptr %575, align 4
  %576 = getelementptr %SchemeObject, ptr %574, i32 0, i32 1
  store i64 %573, ptr %576, align 4
  call void @__GLPrint(ptr %574)
  %number97 = alloca %SchemeObject, align 8
  %577 = getelementptr %SchemeObject, ptr %number97, i32 0, i32 0
  store i64 0, ptr %577, align 4
  %578 = getelementptr %SchemeObject, ptr %number97, i32 0, i32 1
  store i64 500, ptr %578, align 4
  %579 = getelementptr %SchemeObject, ptr %number97, i32 0, i32 0
  %580 = load i64, ptr %579, align 4
  %581 = icmp eq i64 %580, 0
  call void @__GLAssert(i1 %581)
  %582 = getelementptr %SchemeObject, ptr %number97, i32 0, i32 1
  %583 = load i64, ptr %582, align 4
  %584 = srem i64 %583, 100
  %585 = icmp eq i64 %584, 0
  call void @__GLAssert(i1 %585)
  %number98 = alloca %SchemeObject, align 8
  %586 = getelementptr %SchemeObject, ptr %number98, i32 0, i32 0
  store i64 0, ptr %586, align 4
  %587 = getelementptr %SchemeObject, ptr %number98, i32 0, i32 1
  store i64 300, ptr %587, align 4
  %588 = getelementptr %SchemeObject, ptr %number98, i32 0, i32 0
  %589 = load i64, ptr %588, align 4
  %590 = icmp eq i64 %589, 0
  call void @__GLAssert(i1 %590)
  %591 = getelementptr %SchemeObject, ptr %number98, i32 0, i32 1
  %592 = load i64, ptr %591, align 4
  %593 = srem i64 %592, 100
  %594 = icmp eq i64 %593, 0
  call void @__GLAssert(i1 %594)
  %595 = icmp ne i64 %592, 0
  br i1 %595, label %continue_branch100, label %modify_branch99

modify_branch99:                                  ; preds = %continue_branch96
  br label %continue_branch100

continue_branch100:                               ; preds = %modify_branch99, %continue_branch96
  %596 = phi i64 [ 1, %modify_branch99 ], [ %592, %continue_branch96 ]
  %597 = srem i64 %583, %596
  %598 = alloca %SchemeObject, align 8
  %599 = getelementptr %SchemeObject, ptr %598, i32 0, i32 0
  store i64 0, ptr %599, align 4
  %600 = getelementptr %SchemeObject, ptr %598, i32 0, i32 1
  store i64 %597, ptr %600, align 4
  call void @__GLPrint(ptr %598)
  %number101 = alloca %SchemeObject, align 8
  %601 = getelementptr %SchemeObject, ptr %number101, i32 0, i32 0
  store i64 0, ptr %601, align 4
  %602 = getelementptr %SchemeObject, ptr %number101, i32 0, i32 1
  store i64 500, ptr %602, align 4
  %603 = getelementptr %SchemeObject, ptr %number101, i32 0, i32 0
  %604 = load i64, ptr %603, align 4
  %605 = icmp eq i64 %604, 0
  call void @__GLAssert(i1 %605)
  %606 = getelementptr %SchemeObject, ptr %number101, i32 0, i32 1
  %607 = load i64, ptr %606, align 4
  %608 = srem i64 %607, 100
  %609 = icmp eq i64 %608, 0
  call void @__GLAssert(i1 %609)
  %number102 = alloca %SchemeObject, align 8
  %610 = getelementptr %SchemeObject, ptr %number102, i32 0, i32 0
  store i64 0, ptr %610, align 4
  %611 = getelementptr %SchemeObject, ptr %number102, i32 0, i32 1
  store i64 0, ptr %611, align 4
  %612 = getelementptr %SchemeObject, ptr %number102, i32 0, i32 0
  %613 = load i64, ptr %612, align 4
  %614 = icmp eq i64 %613, 0
  call void @__GLAssert(i1 %614)
  %615 = getelementptr %SchemeObject, ptr %number102, i32 0, i32 1
  %616 = load i64, ptr %615, align 4
  %617 = srem i64 %616, 100
  %618 = icmp eq i64 %617, 0
  call void @__GLAssert(i1 %618)
  %619 = icmp ne i64 %616, 0
  br i1 %619, label %continue_branch104, label %modify_branch103

modify_branch103:                                 ; preds = %continue_branch100
  br label %continue_branch104

continue_branch104:                               ; preds = %modify_branch103, %continue_branch100
  %620 = phi i64 [ 1, %modify_branch103 ], [ %616, %continue_branch100 ]
  %621 = srem i64 %607, %620
  %622 = alloca %SchemeObject, align 8
  %623 = getelementptr %SchemeObject, ptr %622, i32 0, i32 0
  store i64 0, ptr %623, align 4
  %624 = getelementptr %SchemeObject, ptr %622, i32 0, i32 1
  store i64 %621, ptr %624, align 4
  call void @__GLPrint(ptr %622)
  %number105 = alloca %SchemeObject, align 8
  %625 = getelementptr %SchemeObject, ptr %number105, i32 0, i32 0
  store i64 0, ptr %625, align 4
  %626 = getelementptr %SchemeObject, ptr %number105, i32 0, i32 1
  store i64 600, ptr %626, align 4
  %627 = getelementptr %SchemeObject, ptr %number105, i32 0, i32 0
  %628 = load i64, ptr %627, align 4
  %629 = icmp eq i64 %628, 0
  call void @__GLAssert(i1 %629)
  %630 = getelementptr %SchemeObject, ptr %number105, i32 0, i32 1
  %631 = load i64, ptr %630, align 4
  %632 = srem i64 %631, 100
  %633 = icmp eq i64 %632, 0
  call void @__GLAssert(i1 %633)
  %number106 = alloca %SchemeObject, align 8
  %634 = getelementptr %SchemeObject, ptr %number106, i32 0, i32 0
  store i64 0, ptr %634, align 4
  %635 = getelementptr %SchemeObject, ptr %number106, i32 0, i32 1
  store i64 400, ptr %635, align 4
  %636 = getelementptr %SchemeObject, ptr %number106, i32 0, i32 0
  %637 = load i64, ptr %636, align 4
  %638 = icmp eq i64 %637, 0
  call void @__GLAssert(i1 %638)
  %639 = getelementptr %SchemeObject, ptr %number106, i32 0, i32 1
  %640 = load i64, ptr %639, align 4
  %641 = srem i64 %640, 100
  %642 = icmp eq i64 %641, 0
  call void @__GLAssert(i1 %642)
  %643 = icmp ne i64 %640, 0
  br i1 %643, label %continue_branch108, label %modify_branch107

modify_branch107:                                 ; preds = %continue_branch104
  br label %continue_branch108

continue_branch108:                               ; preds = %modify_branch107, %continue_branch104
  %644 = phi i64 [ 1, %modify_branch107 ], [ %640, %continue_branch104 ]
  %645 = srem i64 %631, %644
  %646 = alloca %SchemeObject, align 8
  %647 = getelementptr %SchemeObject, ptr %646, i32 0, i32 0
  store i64 0, ptr %647, align 4
  %648 = getelementptr %SchemeObject, ptr %646, i32 0, i32 1
  store i64 %645, ptr %648, align 4
  call void @__GLPrint(ptr %646)
  br label %comparison_branch

comparison_branch:                                ; preds = %continue_branch108
  %number112 = alloca %SchemeObject, align 8
  %649 = getelementptr %SchemeObject, ptr %number112, i32 0, i32 0
  store i64 0, ptr %649, align 4
  %650 = getelementptr %SchemeObject, ptr %number112, i32 0, i32 1
  store i64 900, ptr %650, align 4
  %651 = getelementptr %SchemeObject, ptr %number112, i32 0, i32 0
  %652 = load i64, ptr %651, align 4
  %653 = icmp eq i64 %652, 0
  call void @__GLAssert(i1 %653)
  %number113 = alloca %SchemeObject, align 8
  %654 = getelementptr %SchemeObject, ptr %number113, i32 0, i32 0
  store i64 0, ptr %654, align 4
  %655 = getelementptr %SchemeObject, ptr %number113, i32 0, i32 1
  store i64 800, ptr %655, align 4
  %656 = getelementptr %SchemeObject, ptr %number113, i32 0, i32 0
  %657 = load i64, ptr %656, align 4
  %658 = icmp eq i64 %657, 0
  call void @__GLAssert(i1 %658)
  %659 = getelementptr %SchemeObject, ptr %number112, i32 0, i32 1
  %660 = load i64, ptr %659, align 4
  %661 = getelementptr %SchemeObject, ptr %number113, i32 0, i32 1
  %662 = load i64, ptr %661, align 4
  %663 = icmp sle i64 %660, %662
  br i1 %663, label %false_branch110, label %comparison_branch114

true_branch109:                                   ; preds = %comparison_branch126
  %664 = alloca %SchemeObject, align 8
  %665 = getelementptr %SchemeObject, ptr %664, i32 0, i32 0
  store i64 1, ptr %665, align 4
  %666 = getelementptr %SchemeObject, ptr %664, i32 0, i32 2
  store i1 true, ptr %666, align 1
  br label %merge_branch111

false_branch110:                                  ; preds = %comparison_branch126, %comparison_branch124, %comparison_branch122, %comparison_branch120, %comparison_branch118, %comparison_branch116, %comparison_branch114, %comparison_branch
  %667 = alloca %SchemeObject, align 8
  %668 = getelementptr %SchemeObject, ptr %667, i32 0, i32 0
  store i64 1, ptr %668, align 4
  %669 = getelementptr %SchemeObject, ptr %667, i32 0, i32 2
  store i1 false, ptr %669, align 1
  br label %merge_branch111

merge_branch111:                                  ; preds = %false_branch110, %true_branch109
  %670 = phi ptr [ %664, %true_branch109 ], [ %667, %false_branch110 ]
  call void @__GLPrint(ptr %670)
  br label %comparison_branch128

comparison_branch114:                             ; preds = %comparison_branch
  %number115 = alloca %SchemeObject, align 8
  %671 = getelementptr %SchemeObject, ptr %number115, i32 0, i32 0
  store i64 0, ptr %671, align 4
  %672 = getelementptr %SchemeObject, ptr %number115, i32 0, i32 1
  store i64 700, ptr %672, align 4
  %673 = getelementptr %SchemeObject, ptr %number115, i32 0, i32 0
  %674 = load i64, ptr %673, align 4
  %675 = icmp eq i64 %674, 0
  call void @__GLAssert(i1 %675)
  %676 = getelementptr %SchemeObject, ptr %number113, i32 0, i32 1
  %677 = load i64, ptr %676, align 4
  %678 = getelementptr %SchemeObject, ptr %number115, i32 0, i32 1
  %679 = load i64, ptr %678, align 4
  %680 = icmp sle i64 %677, %679
  br i1 %680, label %false_branch110, label %comparison_branch116

comparison_branch116:                             ; preds = %comparison_branch114
  %number117 = alloca %SchemeObject, align 8
  %681 = getelementptr %SchemeObject, ptr %number117, i32 0, i32 0
  store i64 0, ptr %681, align 4
  %682 = getelementptr %SchemeObject, ptr %number117, i32 0, i32 1
  store i64 600, ptr %682, align 4
  %683 = getelementptr %SchemeObject, ptr %number117, i32 0, i32 0
  %684 = load i64, ptr %683, align 4
  %685 = icmp eq i64 %684, 0
  call void @__GLAssert(i1 %685)
  %686 = getelementptr %SchemeObject, ptr %number115, i32 0, i32 1
  %687 = load i64, ptr %686, align 4
  %688 = getelementptr %SchemeObject, ptr %number117, i32 0, i32 1
  %689 = load i64, ptr %688, align 4
  %690 = icmp sle i64 %687, %689
  br i1 %690, label %false_branch110, label %comparison_branch118

comparison_branch118:                             ; preds = %comparison_branch116
  %number119 = alloca %SchemeObject, align 8
  %691 = getelementptr %SchemeObject, ptr %number119, i32 0, i32 0
  store i64 0, ptr %691, align 4
  %692 = getelementptr %SchemeObject, ptr %number119, i32 0, i32 1
  store i64 500, ptr %692, align 4
  %693 = getelementptr %SchemeObject, ptr %number119, i32 0, i32 0
  %694 = load i64, ptr %693, align 4
  %695 = icmp eq i64 %694, 0
  call void @__GLAssert(i1 %695)
  %696 = getelementptr %SchemeObject, ptr %number117, i32 0, i32 1
  %697 = load i64, ptr %696, align 4
  %698 = getelementptr %SchemeObject, ptr %number119, i32 0, i32 1
  %699 = load i64, ptr %698, align 4
  %700 = icmp sle i64 %697, %699
  br i1 %700, label %false_branch110, label %comparison_branch120

comparison_branch120:                             ; preds = %comparison_branch118
  %number121 = alloca %SchemeObject, align 8
  %701 = getelementptr %SchemeObject, ptr %number121, i32 0, i32 0
  store i64 0, ptr %701, align 4
  %702 = getelementptr %SchemeObject, ptr %number121, i32 0, i32 1
  store i64 400, ptr %702, align 4
  %703 = getelementptr %SchemeObject, ptr %number121, i32 0, i32 0
  %704 = load i64, ptr %703, align 4
  %705 = icmp eq i64 %704, 0
  call void @__GLAssert(i1 %705)
  %706 = getelementptr %SchemeObject, ptr %number119, i32 0, i32 1
  %707 = load i64, ptr %706, align 4
  %708 = getelementptr %SchemeObject, ptr %number121, i32 0, i32 1
  %709 = load i64, ptr %708, align 4
  %710 = icmp sle i64 %707, %709
  br i1 %710, label %false_branch110, label %comparison_branch122

comparison_branch122:                             ; preds = %comparison_branch120
  %number123 = alloca %SchemeObject, align 8
  %711 = getelementptr %SchemeObject, ptr %number123, i32 0, i32 0
  store i64 0, ptr %711, align 4
  %712 = getelementptr %SchemeObject, ptr %number123, i32 0, i32 1
  store i64 300, ptr %712, align 4
  %713 = getelementptr %SchemeObject, ptr %number123, i32 0, i32 0
  %714 = load i64, ptr %713, align 4
  %715 = icmp eq i64 %714, 0
  call void @__GLAssert(i1 %715)
  %716 = getelementptr %SchemeObject, ptr %number121, i32 0, i32 1
  %717 = load i64, ptr %716, align 4
  %718 = getelementptr %SchemeObject, ptr %number123, i32 0, i32 1
  %719 = load i64, ptr %718, align 4
  %720 = icmp sle i64 %717, %719
  br i1 %720, label %false_branch110, label %comparison_branch124

comparison_branch124:                             ; preds = %comparison_branch122
  %number125 = alloca %SchemeObject, align 8
  %721 = getelementptr %SchemeObject, ptr %number125, i32 0, i32 0
  store i64 0, ptr %721, align 4
  %722 = getelementptr %SchemeObject, ptr %number125, i32 0, i32 1
  store i64 200, ptr %722, align 4
  %723 = getelementptr %SchemeObject, ptr %number125, i32 0, i32 0
  %724 = load i64, ptr %723, align 4
  %725 = icmp eq i64 %724, 0
  call void @__GLAssert(i1 %725)
  %726 = getelementptr %SchemeObject, ptr %number123, i32 0, i32 1
  %727 = load i64, ptr %726, align 4
  %728 = getelementptr %SchemeObject, ptr %number125, i32 0, i32 1
  %729 = load i64, ptr %728, align 4
  %730 = icmp sle i64 %727, %729
  br i1 %730, label %false_branch110, label %comparison_branch126

comparison_branch126:                             ; preds = %comparison_branch124
  %number127 = alloca %SchemeObject, align 8
  %731 = getelementptr %SchemeObject, ptr %number127, i32 0, i32 0
  store i64 0, ptr %731, align 4
  %732 = getelementptr %SchemeObject, ptr %number127, i32 0, i32 1
  store i64 9, ptr %732, align 4
  %733 = getelementptr %SchemeObject, ptr %number127, i32 0, i32 0
  %734 = load i64, ptr %733, align 4
  %735 = icmp eq i64 %734, 0
  call void @__GLAssert(i1 %735)
  %736 = getelementptr %SchemeObject, ptr %number125, i32 0, i32 1
  %737 = load i64, ptr %736, align 4
  %738 = getelementptr %SchemeObject, ptr %number127, i32 0, i32 1
  %739 = load i64, ptr %738, align 4
  %740 = icmp sle i64 %737, %739
  br i1 %740, label %false_branch110, label %true_branch109

comparison_branch128:                             ; preds = %merge_branch111
  %number132 = alloca %SchemeObject, align 8
  %741 = getelementptr %SchemeObject, ptr %number132, i32 0, i32 0
  store i64 0, ptr %741, align 4
  %742 = getelementptr %SchemeObject, ptr %number132, i32 0, i32 1
  store i64 100, ptr %742, align 4
  %743 = getelementptr %SchemeObject, ptr %number132, i32 0, i32 0
  %744 = load i64, ptr %743, align 4
  %745 = icmp eq i64 %744, 0
  call void @__GLAssert(i1 %745)
  %number133 = alloca %SchemeObject, align 8
  %746 = getelementptr %SchemeObject, ptr %number133, i32 0, i32 0
  store i64 0, ptr %746, align 4
  %747 = getelementptr %SchemeObject, ptr %number133, i32 0, i32 1
  store i64 300, ptr %747, align 4
  %748 = getelementptr %SchemeObject, ptr %number133, i32 0, i32 0
  %749 = load i64, ptr %748, align 4
  %750 = icmp eq i64 %749, 0
  call void @__GLAssert(i1 %750)
  %751 = getelementptr %SchemeObject, ptr %number132, i32 0, i32 1
  %752 = load i64, ptr %751, align 4
  %753 = getelementptr %SchemeObject, ptr %number133, i32 0, i32 1
  %754 = load i64, ptr %753, align 4
  %755 = icmp sge i64 %752, %754
  br i1 %755, label %false_branch130, label %comparison_branch134

true_branch129:                                   ; preds = %comparison_branch134
  %756 = alloca %SchemeObject, align 8
  %757 = getelementptr %SchemeObject, ptr %756, i32 0, i32 0
  store i64 1, ptr %757, align 4
  %758 = getelementptr %SchemeObject, ptr %756, i32 0, i32 2
  store i1 true, ptr %758, align 1
  br label %merge_branch131

false_branch130:                                  ; preds = %comparison_branch134, %comparison_branch128
  %759 = alloca %SchemeObject, align 8
  %760 = getelementptr %SchemeObject, ptr %759, i32 0, i32 0
  store i64 1, ptr %760, align 4
  %761 = getelementptr %SchemeObject, ptr %759, i32 0, i32 2
  store i1 false, ptr %761, align 1
  br label %merge_branch131

merge_branch131:                                  ; preds = %false_branch130, %true_branch129
  %762 = phi ptr [ %756, %true_branch129 ], [ %759, %false_branch130 ]
  call void @__GLPrint(ptr %762)
  br label %comparison_branch136

comparison_branch134:                             ; preds = %comparison_branch128
  %number135 = alloca %SchemeObject, align 8
  %763 = getelementptr %SchemeObject, ptr %number135, i32 0, i32 0
  store i64 0, ptr %763, align 4
  %764 = getelementptr %SchemeObject, ptr %number135, i32 0, i32 1
  store i64 400, ptr %764, align 4
  %765 = getelementptr %SchemeObject, ptr %number135, i32 0, i32 0
  %766 = load i64, ptr %765, align 4
  %767 = icmp eq i64 %766, 0
  call void @__GLAssert(i1 %767)
  %768 = getelementptr %SchemeObject, ptr %number133, i32 0, i32 1
  %769 = load i64, ptr %768, align 4
  %770 = getelementptr %SchemeObject, ptr %number135, i32 0, i32 1
  %771 = load i64, ptr %770, align 4
  %772 = icmp sge i64 %769, %771
  br i1 %772, label %false_branch130, label %true_branch129

comparison_branch136:                             ; preds = %merge_branch131
  %number140 = alloca %SchemeObject, align 8
  %773 = getelementptr %SchemeObject, ptr %number140, i32 0, i32 0
  store i64 0, ptr %773, align 4
  %774 = getelementptr %SchemeObject, ptr %number140, i32 0, i32 1
  store i64 300, ptr %774, align 4
  %775 = getelementptr %SchemeObject, ptr %number140, i32 0, i32 0
  %776 = load i64, ptr %775, align 4
  %777 = icmp eq i64 %776, 0
  call void @__GLAssert(i1 %777)
  %number141 = alloca %SchemeObject, align 8
  %778 = getelementptr %SchemeObject, ptr %number141, i32 0, i32 0
  store i64 0, ptr %778, align 4
  %779 = getelementptr %SchemeObject, ptr %number141, i32 0, i32 1
  store i64 300, ptr %779, align 4
  %780 = getelementptr %SchemeObject, ptr %number141, i32 0, i32 0
  %781 = load i64, ptr %780, align 4
  %782 = icmp eq i64 %781, 0
  call void @__GLAssert(i1 %782)
  %783 = getelementptr %SchemeObject, ptr %number140, i32 0, i32 1
  %784 = load i64, ptr %783, align 4
  %785 = getelementptr %SchemeObject, ptr %number141, i32 0, i32 1
  %786 = load i64, ptr %785, align 4
  %787 = icmp ne i64 %784, %786
  br i1 %787, label %false_branch138, label %comparison_branch142

true_branch137:                                   ; preds = %comparison_branch144
  %788 = alloca %SchemeObject, align 8
  %789 = getelementptr %SchemeObject, ptr %788, i32 0, i32 0
  store i64 1, ptr %789, align 4
  %790 = getelementptr %SchemeObject, ptr %788, i32 0, i32 2
  store i1 true, ptr %790, align 1
  br label %merge_branch139

false_branch138:                                  ; preds = %comparison_branch144, %comparison_branch142, %comparison_branch136
  %791 = alloca %SchemeObject, align 8
  %792 = getelementptr %SchemeObject, ptr %791, i32 0, i32 0
  store i64 1, ptr %792, align 4
  %793 = getelementptr %SchemeObject, ptr %791, i32 0, i32 2
  store i1 false, ptr %793, align 1
  br label %merge_branch139

merge_branch139:                                  ; preds = %false_branch138, %true_branch137
  %794 = phi ptr [ %788, %true_branch137 ], [ %791, %false_branch138 ]
  call void @__GLPrint(ptr %794)
  br label %comparison_branch146

comparison_branch142:                             ; preds = %comparison_branch136
  %number143 = alloca %SchemeObject, align 8
  %795 = getelementptr %SchemeObject, ptr %number143, i32 0, i32 0
  store i64 0, ptr %795, align 4
  %796 = getelementptr %SchemeObject, ptr %number143, i32 0, i32 1
  store i64 300, ptr %796, align 4
  %797 = getelementptr %SchemeObject, ptr %number143, i32 0, i32 0
  %798 = load i64, ptr %797, align 4
  %799 = icmp eq i64 %798, 0
  call void @__GLAssert(i1 %799)
  %800 = getelementptr %SchemeObject, ptr %number141, i32 0, i32 1
  %801 = load i64, ptr %800, align 4
  %802 = getelementptr %SchemeObject, ptr %number143, i32 0, i32 1
  %803 = load i64, ptr %802, align 4
  %804 = icmp ne i64 %801, %803
  br i1 %804, label %false_branch138, label %comparison_branch144

comparison_branch144:                             ; preds = %comparison_branch142
  %number145 = alloca %SchemeObject, align 8
  %805 = getelementptr %SchemeObject, ptr %number145, i32 0, i32 0
  store i64 0, ptr %805, align 4
  %806 = getelementptr %SchemeObject, ptr %number145, i32 0, i32 1
  store i64 300, ptr %806, align 4
  %807 = getelementptr %SchemeObject, ptr %number145, i32 0, i32 0
  %808 = load i64, ptr %807, align 4
  %809 = icmp eq i64 %808, 0
  call void @__GLAssert(i1 %809)
  %810 = getelementptr %SchemeObject, ptr %number143, i32 0, i32 1
  %811 = load i64, ptr %810, align 4
  %812 = getelementptr %SchemeObject, ptr %number145, i32 0, i32 1
  %813 = load i64, ptr %812, align 4
  %814 = icmp ne i64 %811, %813
  br i1 %814, label %false_branch138, label %true_branch137

comparison_branch146:                             ; preds = %merge_branch139
  %number150 = alloca %SchemeObject, align 8
  %815 = getelementptr %SchemeObject, ptr %number150, i32 0, i32 0
  store i64 0, ptr %815, align 4
  %816 = getelementptr %SchemeObject, ptr %number150, i32 0, i32 1
  store i64 400, ptr %816, align 4
  %817 = getelementptr %SchemeObject, ptr %number150, i32 0, i32 0
  %818 = load i64, ptr %817, align 4
  %819 = icmp eq i64 %818, 0
  call void @__GLAssert(i1 %819)
  %number151 = alloca %SchemeObject, align 8
  %820 = getelementptr %SchemeObject, ptr %number151, i32 0, i32 0
  store i64 0, ptr %820, align 4
  %821 = getelementptr %SchemeObject, ptr %number151, i32 0, i32 1
  store i64 400, ptr %821, align 4
  %822 = getelementptr %SchemeObject, ptr %number151, i32 0, i32 0
  %823 = load i64, ptr %822, align 4
  %824 = icmp eq i64 %823, 0
  call void @__GLAssert(i1 %824)
  %825 = getelementptr %SchemeObject, ptr %number150, i32 0, i32 1
  %826 = load i64, ptr %825, align 4
  %827 = getelementptr %SchemeObject, ptr %number151, i32 0, i32 1
  %828 = load i64, ptr %827, align 4
  %829 = icmp slt i64 %826, %828
  br i1 %829, label %false_branch148, label %comparison_branch152

true_branch147:                                   ; preds = %comparison_branch154
  %830 = alloca %SchemeObject, align 8
  %831 = getelementptr %SchemeObject, ptr %830, i32 0, i32 0
  store i64 1, ptr %831, align 4
  %832 = getelementptr %SchemeObject, ptr %830, i32 0, i32 2
  store i1 true, ptr %832, align 1
  br label %merge_branch149

false_branch148:                                  ; preds = %comparison_branch154, %comparison_branch152, %comparison_branch146
  %833 = alloca %SchemeObject, align 8
  %834 = getelementptr %SchemeObject, ptr %833, i32 0, i32 0
  store i64 1, ptr %834, align 4
  %835 = getelementptr %SchemeObject, ptr %833, i32 0, i32 2
  store i1 false, ptr %835, align 1
  br label %merge_branch149

merge_branch149:                                  ; preds = %false_branch148, %true_branch147
  %836 = phi ptr [ %830, %true_branch147 ], [ %833, %false_branch148 ]
  call void @__GLPrint(ptr %836)
  br label %comparison_branch156

comparison_branch152:                             ; preds = %comparison_branch146
  %number153 = alloca %SchemeObject, align 8
  %837 = getelementptr %SchemeObject, ptr %number153, i32 0, i32 0
  store i64 0, ptr %837, align 4
  %838 = getelementptr %SchemeObject, ptr %number153, i32 0, i32 1
  store i64 300, ptr %838, align 4
  %839 = getelementptr %SchemeObject, ptr %number153, i32 0, i32 0
  %840 = load i64, ptr %839, align 4
  %841 = icmp eq i64 %840, 0
  call void @__GLAssert(i1 %841)
  %842 = getelementptr %SchemeObject, ptr %number151, i32 0, i32 1
  %843 = load i64, ptr %842, align 4
  %844 = getelementptr %SchemeObject, ptr %number153, i32 0, i32 1
  %845 = load i64, ptr %844, align 4
  %846 = icmp slt i64 %843, %845
  br i1 %846, label %false_branch148, label %comparison_branch154

comparison_branch154:                             ; preds = %comparison_branch152
  %number155 = alloca %SchemeObject, align 8
  %847 = getelementptr %SchemeObject, ptr %number155, i32 0, i32 0
  store i64 0, ptr %847, align 4
  %848 = getelementptr %SchemeObject, ptr %number155, i32 0, i32 1
  store i64 300, ptr %848, align 4
  %849 = getelementptr %SchemeObject, ptr %number155, i32 0, i32 0
  %850 = load i64, ptr %849, align 4
  %851 = icmp eq i64 %850, 0
  call void @__GLAssert(i1 %851)
  %852 = getelementptr %SchemeObject, ptr %number153, i32 0, i32 1
  %853 = load i64, ptr %852, align 4
  %854 = getelementptr %SchemeObject, ptr %number155, i32 0, i32 1
  %855 = load i64, ptr %854, align 4
  %856 = icmp slt i64 %853, %855
  br i1 %856, label %false_branch148, label %true_branch147

comparison_branch156:                             ; preds = %merge_branch149
  %number160 = alloca %SchemeObject, align 8
  %857 = getelementptr %SchemeObject, ptr %number160, i32 0, i32 0
  store i64 0, ptr %857, align 4
  %858 = getelementptr %SchemeObject, ptr %number160, i32 0, i32 1
  store i64 200, ptr %858, align 4
  %859 = getelementptr %SchemeObject, ptr %number160, i32 0, i32 0
  %860 = load i64, ptr %859, align 4
  %861 = icmp eq i64 %860, 0
  call void @__GLAssert(i1 %861)
  %number161 = alloca %SchemeObject, align 8
  %862 = getelementptr %SchemeObject, ptr %number161, i32 0, i32 0
  store i64 0, ptr %862, align 4
  %863 = getelementptr %SchemeObject, ptr %number161, i32 0, i32 1
  store i64 200, ptr %863, align 4
  %864 = getelementptr %SchemeObject, ptr %number161, i32 0, i32 0
  %865 = load i64, ptr %864, align 4
  %866 = icmp eq i64 %865, 0
  call void @__GLAssert(i1 %866)
  %867 = getelementptr %SchemeObject, ptr %number160, i32 0, i32 1
  %868 = load i64, ptr %867, align 4
  %869 = getelementptr %SchemeObject, ptr %number161, i32 0, i32 1
  %870 = load i64, ptr %869, align 4
  %871 = icmp sgt i64 %868, %870
  br i1 %871, label %false_branch158, label %comparison_branch162

true_branch157:                                   ; preds = %comparison_branch166
  %872 = alloca %SchemeObject, align 8
  %873 = getelementptr %SchemeObject, ptr %872, i32 0, i32 0
  store i64 1, ptr %873, align 4
  %874 = getelementptr %SchemeObject, ptr %872, i32 0, i32 2
  store i1 true, ptr %874, align 1
  br label %merge_branch159

false_branch158:                                  ; preds = %comparison_branch166, %comparison_branch164, %comparison_branch162, %comparison_branch156
  %875 = alloca %SchemeObject, align 8
  %876 = getelementptr %SchemeObject, ptr %875, i32 0, i32 0
  store i64 1, ptr %876, align 4
  %877 = getelementptr %SchemeObject, ptr %875, i32 0, i32 2
  store i1 false, ptr %877, align 1
  br label %merge_branch159

merge_branch159:                                  ; preds = %false_branch158, %true_branch157
  %878 = phi ptr [ %872, %true_branch157 ], [ %875, %false_branch158 ]
  call void @__GLPrint(ptr %878)
  ret i32 0

comparison_branch162:                             ; preds = %comparison_branch156
  %number163 = alloca %SchemeObject, align 8
  %879 = getelementptr %SchemeObject, ptr %number163, i32 0, i32 0
  store i64 0, ptr %879, align 4
  %880 = getelementptr %SchemeObject, ptr %number163, i32 0, i32 1
  store i64 500, ptr %880, align 4
  %881 = getelementptr %SchemeObject, ptr %number163, i32 0, i32 0
  %882 = load i64, ptr %881, align 4
  %883 = icmp eq i64 %882, 0
  call void @__GLAssert(i1 %883)
  %884 = getelementptr %SchemeObject, ptr %number161, i32 0, i32 1
  %885 = load i64, ptr %884, align 4
  %886 = getelementptr %SchemeObject, ptr %number163, i32 0, i32 1
  %887 = load i64, ptr %886, align 4
  %888 = icmp sgt i64 %885, %887
  br i1 %888, label %false_branch158, label %comparison_branch164

comparison_branch164:                             ; preds = %comparison_branch162
  %number165 = alloca %SchemeObject, align 8
  %889 = getelementptr %SchemeObject, ptr %number165, i32 0, i32 0
  store i64 0, ptr %889, align 4
  %890 = getelementptr %SchemeObject, ptr %number165, i32 0, i32 1
  store i64 600, ptr %890, align 4
  %891 = getelementptr %SchemeObject, ptr %number165, i32 0, i32 0
  %892 = load i64, ptr %891, align 4
  %893 = icmp eq i64 %892, 0
  call void @__GLAssert(i1 %893)
  %894 = getelementptr %SchemeObject, ptr %number163, i32 0, i32 1
  %895 = load i64, ptr %894, align 4
  %896 = getelementptr %SchemeObject, ptr %number165, i32 0, i32 1
  %897 = load i64, ptr %896, align 4
  %898 = icmp sgt i64 %895, %897
  br i1 %898, label %false_branch158, label %comparison_branch166

comparison_branch166:                             ; preds = %comparison_branch164
  %number167 = alloca %SchemeObject, align 8
  %899 = getelementptr %SchemeObject, ptr %number167, i32 0, i32 0
  store i64 0, ptr %899, align 4
  %900 = getelementptr %SchemeObject, ptr %number167, i32 0, i32 1
  store i64 600, ptr %900, align 4
  %901 = getelementptr %SchemeObject, ptr %number167, i32 0, i32 0
  %902 = load i64, ptr %901, align 4
  %903 = icmp eq i64 %902, 0
  call void @__GLAssert(i1 %903)
  %904 = getelementptr %SchemeObject, ptr %number165, i32 0, i32 1
  %905 = load i64, ptr %904, align 4
  %906 = getelementptr %SchemeObject, ptr %number167, i32 0, i32 1
  %907 = load i64, ptr %906, align 4
  %908 = icmp sgt i64 %905, %907
  br i1 %908, label %false_branch158, label %true_branch157
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
