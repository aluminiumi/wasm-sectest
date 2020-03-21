; ModuleID = 'vulnerable.c'
source_filename = "vulnerable.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@src = global [101 x i8] c"aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeeeeffffffffffgggggggggghhhhhhhhhhiiiiiiiiiijjjjjjjjjj\00", align 16
@fun2.strfun2 = private unnamed_addr constant [8 x i8] c"strfun2\00", align 1
@.str = private unnamed_addr constant [11 x i8] c"\0Astrfun2: \00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"\0Astrfun1: \00", align 1
@vulnerable.strfun1 = private unnamed_addr constant [9 x i8] c"strfun1\0A\00", align 1
@vulnerable.str1 = private unnamed_addr constant [9 x i8] c"string1\0A\00", align 1
@vulnerable.str2 = private unnamed_addr constant [9 x i8] c"string2\0A\00", align 1
@.str.2 = private unnamed_addr constant [29 x i8] c"\0Adest is 5 characters long: \00", align 1
@.str.3 = private unnamed_addr constant [39 x i8] c"\0ACopying 100 char string into dest...\0A\00", align 1
@.str.4 = private unnamed_addr constant [8 x i8] c"\0Adest: \00", align 1
@.str.5 = private unnamed_addr constant [31 x i8] c"\0APerforming function call one \00", align 1
@.str.6 = private unnamed_addr constant [31 x i8] c"\0APerforming function call two \00", align 1
@.str.7 = private unnamed_addr constant [12 x i8] c"\0Adest[30]: \00", align 1
@.str.8 = private unnamed_addr constant [11 x i8] c"\0Adest[3]: \00", align 1
@.str.9 = private unnamed_addr constant [8 x i8] c"\0Astr1: \00", align 1
@.str.10 = private unnamed_addr constant [8 x i8] c"\0Astr2: \00", align 1
@.str.11 = private unnamed_addr constant [12 x i8] c"Result: %d\0A\00", align 1
@.str.12 = private unnamed_addr constant [23 x i8] c"No overflow occurred.\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @fun2() #0 {
  %1 = alloca [8 x i8], align 1
  %2 = bitcast [8 x i8]* %1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @fun2.strfun2, i32 0, i32 0), i64 8, i32 1, i1 false)
  %3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0))
  %4 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i32 0, i32 0
  %5 = call i32 @puts(i8* %4)
  ret i32 2
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #1

declare i32 @printf(i8*, ...) #2

declare i32 @puts(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @fun1(i8*) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0))
  %4 = load i8*, i8** %2, align 8
  %5 = call i32 @puts(i8* %4)
  ret i32 1
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @vulnerable() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca [9 x i8], align 1
  %4 = alloca [9 x i8], align 1
  %5 = alloca [5 x i8], align 1
  %6 = alloca [9 x i8], align 1
  %7 = bitcast [9 x i8]* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %7, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @vulnerable.strfun1, i32 0, i32 0), i64 9, i32 1, i1 false)
  %8 = bitcast [9 x i8]* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @vulnerable.str1, i32 0, i32 0), i64 9, i32 1, i1 false)
  %9 = bitcast [9 x i8]* %6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %9, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @vulnerable.str2, i32 0, i32 0), i64 9, i32 1, i1 false)
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.2, i32 0, i32 0))
  %11 = getelementptr inbounds [5 x i8], [5 x i8]* %5, i32 0, i32 0
  %12 = call i32 @puts(i8* %11)
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.3, i32 0, i32 0))
  %14 = getelementptr inbounds [5 x i8], [5 x i8]* %5, i32 0, i32 0
  %15 = call i8* @strcpy(i8* %14, i8* getelementptr inbounds ([101 x i8], [101 x i8]* @src, i32 0, i32 0)) #4
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.4, i32 0, i32 0))
  %17 = getelementptr inbounds [5 x i8], [5 x i8]* %5, i32 0, i32 0
  %18 = call i32 @puts(i8* %17)
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.5, i32 0, i32 0))
  %20 = getelementptr inbounds [9 x i8], [9 x i8]* %3, i32 0, i32 0
  %21 = call i32 @fun1(i8* %20)
  store i32 %21, i32* %1, align 4
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.4, i32 0, i32 0))
  %23 = getelementptr inbounds [5 x i8], [5 x i8]* %5, i32 0, i32 0
  %24 = call i32 @puts(i8* %23)
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.6, i32 0, i32 0))
  %26 = call i32 @fun2()
  store i32 %26, i32* %2, align 4
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.4, i32 0, i32 0))
  %28 = getelementptr inbounds [5 x i8], [5 x i8]* %5, i32 0, i32 0
  %29 = call i32 @puts(i8* %28)
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.7, i32 0, i32 0))
  %31 = getelementptr inbounds [5 x i8], [5 x i8]* %5, i32 0, i32 0
  %32 = getelementptr inbounds i8, i8* %31, i64 30
  %33 = call i32 @puts(i8* %32)
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i32 0, i32 0))
  %35 = getelementptr inbounds [5 x i8], [5 x i8]* %5, i32 0, i32 0
  %36 = getelementptr inbounds i8, i8* %35, i64 3
  %37 = call i32 @puts(i8* %36)
  %38 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.9, i32 0, i32 0))
  %39 = getelementptr inbounds [9 x i8], [9 x i8]* %4, i32 0, i32 0
  %40 = call i32 @puts(i8* %39)
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.10, i32 0, i32 0))
  %42 = getelementptr inbounds [9 x i8], [9 x i8]* %6, i32 0, i32 0
  %43 = call i32 @puts(i8* %42)
  ret i32 1
}

; Function Attrs: nounwind
declare i8* @strcpy(i8*, i8*) #3

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 0, i32* %2, align 4
  %3 = call i32 @vulnerable()
  store i32 %3, i32* %2, align 4
  %4 = load i32, i32* %2, align 4
  %5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.11, i32 0, i32 0), i32 %4)
  %6 = load i32, i32* %2, align 4
  %7 = icmp eq i32 %6, 1
  br i1 %7, label %8, label %10

; <label>:8:                                      ; preds = %0
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.12, i32 0, i32 0))
  br label %10

; <label>:10:                                     ; preds = %8, %0
  ret i32 0
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
