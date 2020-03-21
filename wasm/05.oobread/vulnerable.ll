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
@vulnerable.dest = private unnamed_addr constant [5 x i8] c"cccc\00", align 1
@vulnerable.str2 = private unnamed_addr constant [9 x i8] c"string2\0A\00", align 1
@.str.2 = private unnamed_addr constant [29 x i8] c"\0Adest is 5 characters long: \00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"\0Adest[%d]: \00", align 1
@.str.4 = private unnamed_addr constant [11 x i8] c"\0Adest[5]: \00", align 1
@.str.5 = private unnamed_addr constant [13 x i8] c"\0Adest[512]: \00", align 1
@.str.6 = private unnamed_addr constant [14 x i8] c"\0Adest[1024]: \00", align 1
@.str.7 = private unnamed_addr constant [14 x i8] c"\0Adest[4096]: \00", align 1
@main.mainstring = private unnamed_addr constant [11 x i8] c"mainstring\00", align 1
@.str.8 = private unnamed_addr constant [12 x i8] c"Result: %d\0A\00", align 1

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
define i32 @vulnerable(i8*) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca [9 x i8], align 1
  %6 = alloca [9 x i8], align 1
  %7 = alloca [5 x i8], align 1
  %8 = alloca [9 x i8], align 1
  %9 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  store i32 65, i32* %3, align 4
  store i32 66, i32* %4, align 4
  %10 = bitcast [9 x i8]* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %10, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @vulnerable.strfun1, i32 0, i32 0), i64 9, i32 1, i1 false)
  %11 = bitcast [9 x i8]* %6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %11, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @vulnerable.str1, i32 0, i32 0), i64 9, i32 1, i1 false)
  %12 = bitcast [5 x i8]* %7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @vulnerable.dest, i32 0, i32 0), i64 5, i32 1, i1 false)
  %13 = bitcast [9 x i8]* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @vulnerable.str2, i32 0, i32 0), i64 9, i32 1, i1 false)
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.2, i32 0, i32 0))
  %15 = getelementptr inbounds [5 x i8], [5 x i8]* %7, i32 0, i32 0
  %16 = call i32 @puts(i8* %15)
  store i32 0, i32* %9, align 4
  br label %17

; <label>:17:                                     ; preds = %28, %1
  %18 = load i32, i32* %9, align 4
  %19 = icmp slt i32 %18, 512
  br i1 %19, label %20, label %31

; <label>:20:                                     ; preds = %17
  %21 = load i32, i32* %9, align 4
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i32 %21)
  %23 = getelementptr inbounds [5 x i8], [5 x i8]* %7, i32 0, i32 0
  %24 = load i32, i32* %9, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds i8, i8* %23, i64 %25
  %27 = call i32 @puts(i8* %26)
  br label %28

; <label>:28:                                     ; preds = %20
  %29 = load i32, i32* %9, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, i32* %9, align 4
  br label %17

; <label>:31:                                     ; preds = %17
  %32 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.4, i32 0, i32 0))
  %33 = getelementptr inbounds [5 x i8], [5 x i8]* %7, i32 0, i32 0
  %34 = getelementptr inbounds i8, i8* %33, i64 5
  %35 = call i32 @puts(i8* %34)
  %36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.5, i32 0, i32 0))
  %37 = getelementptr inbounds [5 x i8], [5 x i8]* %7, i32 0, i32 0
  %38 = getelementptr inbounds i8, i8* %37, i64 512
  %39 = call i32 @puts(i8* %38)
  %40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.6, i32 0, i32 0))
  %41 = getelementptr inbounds [5 x i8], [5 x i8]* %7, i32 0, i32 0
  %42 = getelementptr inbounds i8, i8* %41, i64 1024
  %43 = call i32 @puts(i8* %42)
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.7, i32 0, i32 0))
  %45 = getelementptr inbounds [5 x i8], [5 x i8]* %7, i32 0, i32 0
  %46 = getelementptr inbounds i8, i8* %45, i64 4096
  %47 = call i32 @puts(i8* %46)
  ret i32 1
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca [11 x i8], align 1
  store i32 0, i32* %1, align 4
  store i32 0, i32* %2, align 4
  %4 = bitcast [11 x i8]* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %4, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @main.mainstring, i32 0, i32 0), i64 11, i32 1, i1 false)
  %5 = getelementptr inbounds [11 x i8], [11 x i8]* %3, i32 0, i32 0
  %6 = call i32 @vulnerable(i8* %5)
  store i32 %6, i32* %2, align 4
  %7 = load i32, i32* %2, align 4
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.8, i32 0, i32 0), i32 %7)
  ret i32 0
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
