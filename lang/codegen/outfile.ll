; ModuleID = 'scheme.ll'
source_filename = "scheme.ll"

%SchemeObject = type { i64, i64, i1, ptr, ptr, ptr }

define i32 @main() {
entry:
  %0 = alloca %SchemeObject, align 8
  %1 = getelementptr %SchemeObject, ptr %0, i32 0, i32 0
  store i64 0, ptr %1, align 4
  %2 = getelementptr %SchemeObject, ptr %0, i32 0, i32 1
  store i64 0, ptr %2, align 4
  %number = alloca %SchemeObject, align 8
  %3 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  store i64 0, ptr %3, align 4
  %4 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  store i64 500, ptr %4, align 4
  %5 = getelementptr %SchemeObject, ptr %number, i32 0, i32 0
  %6 = load i64, ptr %5, align 4
  %7 = icmp eq i64 %6, 0
  call void @__GLAssert(i1 %7)
  %8 = getelementptr %SchemeObject, ptr %0, i32 0, i32 1
  %9 = load i64, ptr %8, align 4
  %10 = getelementptr %SchemeObject, ptr %number, i32 0, i32 1
  %11 = load i64, ptr %10, align 4
  %12 = sub i64 %9, %11
  %13 = getelementptr %SchemeObject, ptr %0, i32 0, i32 1
  store i64 %11, ptr %13, align 4
  %number1 = alloca %SchemeObject, align 8
  %14 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 0
  store i64 0, ptr %14, align 4
  %15 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 1
  store i64 200, ptr %15, align 4
  %16 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 0
  %17 = load i64, ptr %16, align 4
  %18 = icmp eq i64 %17, 0
  call void @__GLAssert(i1 %18)
  %19 = getelementptr %SchemeObject, ptr %0, i32 0, i32 1
  %20 = load i64, ptr %19, align 4
  %21 = getelementptr %SchemeObject, ptr %number1, i32 0, i32 1
  %22 = load i64, ptr %21, align 4
  %23 = sub i64 %20, %22
  %24 = getelementptr %SchemeObject, ptr %0, i32 0, i32 1
  store i64 %23, ptr %24, align 4
  call void @__GLPrint(ptr %0)
  %25 = alloca %SchemeObject, align 8
  %26 = getelementptr %SchemeObject, ptr %25, i32 0, i32 0
  store i64 0, ptr %26, align 4
  %27 = getelementptr %SchemeObject, ptr %25, i32 0, i32 1
  store i64 0, ptr %27, align 4
  %number2 = alloca %SchemeObject, align 8
  %28 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  store i64 0, ptr %28, align 4
  %29 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  store i64 500, ptr %29, align 4
  %30 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 0
  %31 = load i64, ptr %30, align 4
  %32 = icmp eq i64 %31, 0
  call void @__GLAssert(i1 %32)
  %33 = getelementptr %SchemeObject, ptr %25, i32 0, i32 1
  %34 = load i64, ptr %33, align 4
  %35 = getelementptr %SchemeObject, ptr %number2, i32 0, i32 1
  %36 = load i64, ptr %35, align 4
  %37 = sub i64 %34, %36
  %38 = getelementptr %SchemeObject, ptr %25, i32 0, i32 1
  store i64 %36, ptr %38, align 4
  %number3 = alloca %SchemeObject, align 8
  %39 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 0
  store i64 0, ptr %39, align 4
  %40 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 1
  store i64 100, ptr %40, align 4
  %41 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 0
  %42 = load i64, ptr %41, align 4
  %43 = icmp eq i64 %42, 0
  call void @__GLAssert(i1 %43)
  %44 = getelementptr %SchemeObject, ptr %25, i32 0, i32 1
  %45 = load i64, ptr %44, align 4
  %46 = getelementptr %SchemeObject, ptr %number3, i32 0, i32 1
  %47 = load i64, ptr %46, align 4
  %48 = sub i64 %45, %47
  %49 = getelementptr %SchemeObject, ptr %25, i32 0, i32 1
  store i64 %48, ptr %49, align 4
  %number4 = alloca %SchemeObject, align 8
  %50 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 0
  store i64 0, ptr %50, align 4
  %51 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 1
  store i64 200, ptr %51, align 4
  %52 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 0
  %53 = load i64, ptr %52, align 4
  %54 = icmp eq i64 %53, 0
  call void @__GLAssert(i1 %54)
  %55 = getelementptr %SchemeObject, ptr %25, i32 0, i32 1
  %56 = load i64, ptr %55, align 4
  %57 = getelementptr %SchemeObject, ptr %number4, i32 0, i32 1
  %58 = load i64, ptr %57, align 4
  %59 = sub i64 %56, %58
  %60 = getelementptr %SchemeObject, ptr %25, i32 0, i32 1
  store i64 %59, ptr %60, align 4
  call void @__GLPrint(ptr %25)
  %61 = alloca %SchemeObject, align 8
  %62 = getelementptr %SchemeObject, ptr %61, i32 0, i32 0
  store i64 0, ptr %62, align 4
  %63 = getelementptr %SchemeObject, ptr %61, i32 0, i32 1
  store i64 100, ptr %63, align 4
  %number5 = alloca %SchemeObject, align 8
  %64 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  store i64 0, ptr %64, align 4
  %65 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  store i64 400, ptr %65, align 4
  %66 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 0
  %67 = load i64, ptr %66, align 4
  %68 = icmp eq i64 %67, 0
  call void @__GLAssert(i1 %68)
  %69 = getelementptr %SchemeObject, ptr %61, i32 0, i32 1
  %70 = load i64, ptr %69, align 4
  %71 = getelementptr %SchemeObject, ptr %number5, i32 0, i32 1
  %72 = load i64, ptr %71, align 4
  %73 = icmp ne i64 %72, 0
  br i1 %73, label %continue_branch, label %modify_branch

modify_branch:                                    ; preds = %entry
  br label %continue_branch

continue_branch:                                  ; preds = %modify_branch, %entry
  %74 = phi i64 [ 1, %modify_branch ], [ %72, %entry ]
  %75 = mul i64 %70, 100
  %76 = sdiv i64 %75, %74
  %77 = getelementptr %SchemeObject, ptr %61, i32 0, i32 1
  store i64 %72, ptr %77, align 4
  %number6 = alloca %SchemeObject, align 8
  %78 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 0
  store i64 0, ptr %78, align 4
  %79 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 1
  store i64 200, ptr %79, align 4
  %80 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 0
  %81 = load i64, ptr %80, align 4
  %82 = icmp eq i64 %81, 0
  call void @__GLAssert(i1 %82)
  %83 = getelementptr %SchemeObject, ptr %61, i32 0, i32 1
  %84 = load i64, ptr %83, align 4
  %85 = getelementptr %SchemeObject, ptr %number6, i32 0, i32 1
  %86 = load i64, ptr %85, align 4
  %87 = icmp ne i64 %86, 0
  br i1 %87, label %continue_branch8, label %modify_branch7

modify_branch7:                                   ; preds = %continue_branch
  br label %continue_branch8

continue_branch8:                                 ; preds = %modify_branch7, %continue_branch
  %88 = phi i64 [ 1, %modify_branch7 ], [ %86, %continue_branch ]
  %89 = mul i64 %84, 100
  %90 = sdiv i64 %89, %88
  %91 = getelementptr %SchemeObject, ptr %61, i32 0, i32 1
  store i64 %90, ptr %91, align 4
  call void @__GLPrint(ptr %61)
  %92 = alloca %SchemeObject, align 8
  %93 = getelementptr %SchemeObject, ptr %92, i32 0, i32 0
  store i64 0, ptr %93, align 4
  %94 = getelementptr %SchemeObject, ptr %92, i32 0, i32 1
  store i64 100, ptr %94, align 4
  %number9 = alloca %SchemeObject, align 8
  %95 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 0
  store i64 0, ptr %95, align 4
  %96 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 1
  store i64 400, ptr %96, align 4
  %97 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 0
  %98 = load i64, ptr %97, align 4
  %99 = icmp eq i64 %98, 0
  call void @__GLAssert(i1 %99)
  %100 = getelementptr %SchemeObject, ptr %92, i32 0, i32 1
  %101 = load i64, ptr %100, align 4
  %102 = getelementptr %SchemeObject, ptr %number9, i32 0, i32 1
  %103 = load i64, ptr %102, align 4
  %104 = icmp ne i64 %103, 0
  br i1 %104, label %continue_branch11, label %modify_branch10

modify_branch10:                                  ; preds = %continue_branch8
  br label %continue_branch11

continue_branch11:                                ; preds = %modify_branch10, %continue_branch8
  %105 = phi i64 [ 1, %modify_branch10 ], [ %103, %continue_branch8 ]
  %106 = mul i64 %101, 100
  %107 = sdiv i64 %106, %105
  %108 = getelementptr %SchemeObject, ptr %92, i32 0, i32 1
  store i64 %103, ptr %108, align 4
  %number12 = alloca %SchemeObject, align 8
  %109 = getelementptr %SchemeObject, ptr %number12, i32 0, i32 0
  store i64 0, ptr %109, align 4
  %110 = getelementptr %SchemeObject, ptr %number12, i32 0, i32 1
  store i64 200, ptr %110, align 4
  %111 = getelementptr %SchemeObject, ptr %number12, i32 0, i32 0
  %112 = load i64, ptr %111, align 4
  %113 = icmp eq i64 %112, 0
  call void @__GLAssert(i1 %113)
  %114 = getelementptr %SchemeObject, ptr %92, i32 0, i32 1
  %115 = load i64, ptr %114, align 4
  %116 = getelementptr %SchemeObject, ptr %number12, i32 0, i32 1
  %117 = load i64, ptr %116, align 4
  %118 = icmp ne i64 %117, 0
  br i1 %118, label %continue_branch14, label %modify_branch13

modify_branch13:                                  ; preds = %continue_branch11
  br label %continue_branch14

continue_branch14:                                ; preds = %modify_branch13, %continue_branch11
  %119 = phi i64 [ 1, %modify_branch13 ], [ %117, %continue_branch11 ]
  %120 = mul i64 %115, 100
  %121 = sdiv i64 %120, %119
  %122 = getelementptr %SchemeObject, ptr %92, i32 0, i32 1
  store i64 %121, ptr %122, align 4
  %number15 = alloca %SchemeObject, align 8
  %123 = getelementptr %SchemeObject, ptr %number15, i32 0, i32 0
  store i64 0, ptr %123, align 4
  %124 = getelementptr %SchemeObject, ptr %number15, i32 0, i32 1
  store i64 200, ptr %124, align 4
  %125 = getelementptr %SchemeObject, ptr %number15, i32 0, i32 0
  %126 = load i64, ptr %125, align 4
  %127 = icmp eq i64 %126, 0
  call void @__GLAssert(i1 %127)
  %128 = getelementptr %SchemeObject, ptr %92, i32 0, i32 1
  %129 = load i64, ptr %128, align 4
  %130 = getelementptr %SchemeObject, ptr %number15, i32 0, i32 1
  %131 = load i64, ptr %130, align 4
  %132 = icmp ne i64 %131, 0
  br i1 %132, label %continue_branch17, label %modify_branch16

modify_branch16:                                  ; preds = %continue_branch14
  br label %continue_branch17

continue_branch17:                                ; preds = %modify_branch16, %continue_branch14
  %133 = phi i64 [ 1, %modify_branch16 ], [ %131, %continue_branch14 ]
  %134 = mul i64 %129, 100
  %135 = sdiv i64 %134, %133
  %136 = getelementptr %SchemeObject, ptr %92, i32 0, i32 1
  store i64 %135, ptr %136, align 4
  call void @__GLPrint(ptr %92)
  %137 = alloca %SchemeObject, align 8
  %138 = getelementptr %SchemeObject, ptr %137, i32 0, i32 0
  store i64 0, ptr %138, align 4
  %139 = getelementptr %SchemeObject, ptr %137, i32 0, i32 1
  store i64 100, ptr %139, align 4
  %number18 = alloca %SchemeObject, align 8
  %140 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 0
  store i64 0, ptr %140, align 4
  %141 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  store i64 400, ptr %141, align 4
  %142 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 0
  %143 = load i64, ptr %142, align 4
  %144 = icmp eq i64 %143, 0
  call void @__GLAssert(i1 %144)
  %145 = getelementptr %SchemeObject, ptr %137, i32 0, i32 1
  %146 = load i64, ptr %145, align 4
  %147 = getelementptr %SchemeObject, ptr %number18, i32 0, i32 1
  %148 = load i64, ptr %147, align 4
  %149 = icmp ne i64 %148, 0
  br i1 %149, label %continue_branch20, label %modify_branch19

modify_branch19:                                  ; preds = %continue_branch17
  br label %continue_branch20

continue_branch20:                                ; preds = %modify_branch19, %continue_branch17
  %150 = phi i64 [ 1, %modify_branch19 ], [ %148, %continue_branch17 ]
  %151 = mul i64 %146, 100
  %152 = sdiv i64 %151, %150
  %153 = getelementptr %SchemeObject, ptr %137, i32 0, i32 1
  store i64 %148, ptr %153, align 4
  %number21 = alloca %SchemeObject, align 8
  %154 = getelementptr %SchemeObject, ptr %number21, i32 0, i32 0
  store i64 0, ptr %154, align 4
  %155 = getelementptr %SchemeObject, ptr %number21, i32 0, i32 1
  store i64 200, ptr %155, align 4
  %156 = getelementptr %SchemeObject, ptr %number21, i32 0, i32 0
  %157 = load i64, ptr %156, align 4
  %158 = icmp eq i64 %157, 0
  call void @__GLAssert(i1 %158)
  %159 = getelementptr %SchemeObject, ptr %137, i32 0, i32 1
  %160 = load i64, ptr %159, align 4
  %161 = getelementptr %SchemeObject, ptr %number21, i32 0, i32 1
  %162 = load i64, ptr %161, align 4
  %163 = icmp ne i64 %162, 0
  br i1 %163, label %continue_branch23, label %modify_branch22

modify_branch22:                                  ; preds = %continue_branch20
  br label %continue_branch23

continue_branch23:                                ; preds = %modify_branch22, %continue_branch20
  %164 = phi i64 [ 1, %modify_branch22 ], [ %162, %continue_branch20 ]
  %165 = mul i64 %160, 100
  %166 = sdiv i64 %165, %164
  %167 = getelementptr %SchemeObject, ptr %137, i32 0, i32 1
  store i64 %166, ptr %167, align 4
  %number24 = alloca %SchemeObject, align 8
  %168 = getelementptr %SchemeObject, ptr %number24, i32 0, i32 0
  store i64 0, ptr %168, align 4
  %169 = getelementptr %SchemeObject, ptr %number24, i32 0, i32 1
  store i64 0, ptr %169, align 4
  %170 = getelementptr %SchemeObject, ptr %number24, i32 0, i32 0
  %171 = load i64, ptr %170, align 4
  %172 = icmp eq i64 %171, 0
  call void @__GLAssert(i1 %172)
  %173 = getelementptr %SchemeObject, ptr %137, i32 0, i32 1
  %174 = load i64, ptr %173, align 4
  %175 = getelementptr %SchemeObject, ptr %number24, i32 0, i32 1
  %176 = load i64, ptr %175, align 4
  %177 = icmp ne i64 %176, 0
  br i1 %177, label %continue_branch26, label %modify_branch25

modify_branch25:                                  ; preds = %continue_branch23
  br label %continue_branch26

continue_branch26:                                ; preds = %modify_branch25, %continue_branch23
  %178 = phi i64 [ 1, %modify_branch25 ], [ %176, %continue_branch23 ]
  %179 = mul i64 %174, 100
  %180 = sdiv i64 %179, %178
  %181 = getelementptr %SchemeObject, ptr %137, i32 0, i32 1
  store i64 %180, ptr %181, align 4
  call void @__GLPrint(ptr %137)
  %182 = alloca %SchemeObject, align 8
  %183 = getelementptr %SchemeObject, ptr %182, i32 0, i32 0
  store i64 0, ptr %183, align 4
  %184 = getelementptr %SchemeObject, ptr %182, i32 0, i32 1
  store i64 100, ptr %184, align 4
  %number27 = alloca %SchemeObject, align 8
  %185 = getelementptr %SchemeObject, ptr %number27, i32 0, i32 0
  store i64 0, ptr %185, align 4
  %186 = getelementptr %SchemeObject, ptr %number27, i32 0, i32 1
  store i64 0, ptr %186, align 4
  %187 = getelementptr %SchemeObject, ptr %number27, i32 0, i32 0
  %188 = load i64, ptr %187, align 4
  %189 = icmp eq i64 %188, 0
  call void @__GLAssert(i1 %189)
  %190 = getelementptr %SchemeObject, ptr %182, i32 0, i32 1
  %191 = load i64, ptr %190, align 4
  %192 = getelementptr %SchemeObject, ptr %number27, i32 0, i32 1
  %193 = load i64, ptr %192, align 4
  %194 = icmp ne i64 %193, 0
  br i1 %194, label %continue_branch29, label %modify_branch28

modify_branch28:                                  ; preds = %continue_branch26
  br label %continue_branch29

continue_branch29:                                ; preds = %modify_branch28, %continue_branch26
  %195 = phi i64 [ 1, %modify_branch28 ], [ %193, %continue_branch26 ]
  %196 = mul i64 %191, 100
  %197 = sdiv i64 %196, %195
  %198 = getelementptr %SchemeObject, ptr %182, i32 0, i32 1
  store i64 %193, ptr %198, align 4
  %number30 = alloca %SchemeObject, align 8
  %199 = getelementptr %SchemeObject, ptr %number30, i32 0, i32 0
  store i64 0, ptr %199, align 4
  %200 = getelementptr %SchemeObject, ptr %number30, i32 0, i32 1
  store i64 200, ptr %200, align 4
  %201 = getelementptr %SchemeObject, ptr %number30, i32 0, i32 0
  %202 = load i64, ptr %201, align 4
  %203 = icmp eq i64 %202, 0
  call void @__GLAssert(i1 %203)
  %204 = getelementptr %SchemeObject, ptr %182, i32 0, i32 1
  %205 = load i64, ptr %204, align 4
  %206 = getelementptr %SchemeObject, ptr %number30, i32 0, i32 1
  %207 = load i64, ptr %206, align 4
  %208 = icmp ne i64 %207, 0
  br i1 %208, label %continue_branch32, label %modify_branch31

modify_branch31:                                  ; preds = %continue_branch29
  br label %continue_branch32

continue_branch32:                                ; preds = %modify_branch31, %continue_branch29
  %209 = phi i64 [ 1, %modify_branch31 ], [ %207, %continue_branch29 ]
  %210 = mul i64 %205, 100
  %211 = sdiv i64 %210, %209
  %212 = getelementptr %SchemeObject, ptr %182, i32 0, i32 1
  store i64 %211, ptr %212, align 4
  call void @__GLPrint(ptr %182)
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
