; ModuleID = 'vulnerable.c'
source_filename = "vulnerable.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [31 x i8] c"a: %d, b: %d, c: %d, *ptr: %d\0A\00", align 1
@.str.1 = private unnamed_addr constant [29 x i8] c"setting ptr to address of a\0A\00", align 1
@.str.2 = private unnamed_addr constant [38 x i8] c"setting b to value pointed to by ptr\0A\00", align 1
@.str.3 = private unnamed_addr constant [21 x i8] c"setting ptr to null\0A\00", align 1
@.str.4 = private unnamed_addr constant [65 x i8] c"setting c to value pointed to by ptr (null pointer dereference)\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32*, align 8
  store i32 0, i32* %1, align 4
  store i32 2, i32* %2, align 4
  %6 = load i32, i32* %2, align 4
  %7 = load i32, i32* %3, align 4
  %8 = load i32, i32* %4, align 4
  %9 = load i32*, i32** %5, align 8
  %10 = load i32, i32* %9, align 4
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str, i32 0, i32 0), i32 %6, i32 %7, i32 %8, i32 %10)
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.1, i32 0, i32 0))
  store i32* %2, i32** %5, align 8
  %13 = load i32, i32* %2, align 4
  %14 = load i32, i32* %3, align 4
  %15 = load i32, i32* %4, align 4
  %16 = load i32*, i32** %5, align 8
  %17 = load i32, i32* %16, align 4
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str, i32 0, i32 0), i32 %13, i32 %14, i32 %15, i32 %17)
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.2, i32 0, i32 0))
  %20 = load i32*, i32** %5, align 8
  %21 = load i32, i32* %20, align 4
  store i32 %21, i32* %3, align 4
  %22 = load i32, i32* %2, align 4
  %23 = load i32, i32* %3, align 4
  %24 = load i32, i32* %4, align 4
  %25 = load i32*, i32** %5, align 8
  %26 = load i32, i32* %25, align 4
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str, i32 0, i32 0), i32 %22, i32 %23, i32 %24, i32 %26)
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.3, i32 0, i32 0))
  store i32* null, i32** %5, align 8
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([65 x i8], [65 x i8]* @.str.4, i32 0, i32 0))
  %30 = load i32*, i32** %5, align 8
  %31 = load i32, i32* %30, align 4
  store i32 %31, i32* %4, align 4
  ret i32 0
}

declare i32 @printf(i8*, ...) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
