; ModuleID = 'scheme.ll'
source_filename = "scheme.ll"

%SchemeObject = type { i64, i64, i1, ptr, ptr, ptr }

@symbol_global = private unnamed_addr constant [7 x i8] c"OPENED\00", align 1
@symbol_global.1 = private unnamed_addr constant [9 x i8] c"FINISHED\00", align 1

define i32 @main() {
entry:
  call void @__GLInit()
  br label %condition_branch

condition_branch:                                 ; preds = %loop_branch, %entry
  %is-open = alloca %SchemeObject, align 8
  %0 = call %SchemeObject @__GLIsOpen()
  store %SchemeObject %0, ptr %is-open, align 8
  %1 = getelementptr %SchemeObject, ptr %is-open, i32 0, i32 0
  %2 = load i64, ptr %1, align 4
  %3 = icmp eq i64 %2, 1
  %4 = getelementptr %SchemeObject, ptr %is-open, i32 0, i32 2
  %5 = load i1, ptr %4, align 1
  br i1 %5, label %loop_branch, label %merge_branch

loop_branch:                                      ; preds = %condition_branch
  %symbol = alloca %SchemeObject, align 8
  %6 = getelementptr %SchemeObject, ptr %symbol, i32 0, i32 0
  store i64 2, ptr %6, align 4
  %7 = getelementptr %SchemeObject, ptr %symbol, i32 0, i32 3
  store ptr @symbol_global, ptr %7, align 8
  call void @__GLPrint(ptr %symbol)
  br label %condition_branch

merge_branch:                                     ; preds = %condition_branch
  %symbol1 = alloca %SchemeObject, align 8
  %8 = getelementptr %SchemeObject, ptr %symbol1, i32 0, i32 0
  store i64 2, ptr %8, align 4
  %9 = getelementptr %SchemeObject, ptr %symbol1, i32 0, i32 3
  store ptr @symbol_global.1, ptr %9, align 8
  call void @__GLPrint(ptr %symbol1)
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
