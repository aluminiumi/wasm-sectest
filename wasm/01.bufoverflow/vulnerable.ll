; ModuleID = 'vulnerable.c'
source_filename = "vulnerable.c"
target datalayout = "e-m:e-p:32:32-i64:64-n32:64-S128"
target triple = "wasm32"

@src = hidden global [101 x i8] c"aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeeeeffffffffffgggggggggghhhhhhhhhhiiiiiiiiiijjjjjjjjjj\00", align 16
@.str = private unnamed_addr constant [18 x i8] c"stack string: %s\0A\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"ptr string: %s\0A\00", align 1
@vulnerable.strfun1 = private unnamed_addr constant [9 x i8] c"strfun1\0A\00", align 1
@vulnerable.str1 = private unnamed_addr constant [9 x i8] c"string1\0A\00", align 1
@vulnerable.str2 = private unnamed_addr constant [9 x i8] c"string2\0A\00", align 1
@.str.2 = private unnamed_addr constant [31 x i8] c"dest is 5 characters long: %s\0A\00", align 1
@.str.4 = private unnamed_addr constant [10 x i8] c"dest: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [14 x i8] c"dest[30]: %s\0A\00", align 1
@.str.8 = private unnamed_addr constant [13 x i8] c"dest[3]: %s\0A\00", align 1
@.str.9 = private unnamed_addr constant [10 x i8] c"str1: %s\0A\00", align 1
@.str.10 = private unnamed_addr constant [10 x i8] c"str2: %s\0A\00", align 1
@.str.12 = private unnamed_addr constant [12 x i8] c"Result: %d\0A\00", align 1
@str = private unnamed_addr constant [37 x i8] c"Copying 100 char string into dest...\00"
@str.14 = private unnamed_addr constant [29 x i8] c"Performing function call one\00"
@str.15 = private unnamed_addr constant [29 x i8] c"Performing function call two\00"
@str.16 = private unnamed_addr constant [13 x i8] c"returning...\00"
@str.17 = private unnamed_addr constant [28 x i8] c"No stack smashing occurred.\00"

; Function Attrs: minsize nounwind optsize
define hidden i32 @fun2() local_unnamed_addr #0 {
  %1 = alloca i64, align 8
  %2 = bitcast i64* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2) #3
  store i64 14195199344538739, i64* %1, align 8
  %3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str, i32 0, i32 0), i64* nonnull %1) #4
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2) #3
  ret i32 2
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i32(i8* nocapture writeonly, i8* nocapture readonly, i32, i32, i1) #1

; Function Attrs: minsize nounwind optsize
declare i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

; Function Attrs: minsize nounwind optsize
define hidden i32 @fun1(i8*) local_unnamed_addr #0 {
  %2 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1, i32 0, i32 0), i8* %0) #4
  ret i32 1
}

; Function Attrs: minsize nounwind optsize
define hidden i32 @vulnerable() local_unnamed_addr #0 {
  %1 = alloca [9 x i8], align 1
  %2 = alloca [9 x i8], align 1
  %3 = alloca [5 x i8], align 1
  %4 = alloca [9 x i8], align 1
  %5 = getelementptr inbounds [9 x i8], [9 x i8]* %1, i32 0, i32 0
  call void @llvm.lifetime.start.p0i8(i64 9, i8* nonnull %5) #3
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* nonnull %5, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @vulnerable.strfun1, i32 0, i32 0), i32 9, i32 1, i1 false)
  %6 = getelementptr inbounds [9 x i8], [9 x i8]* %2, i32 0, i32 0
  call void @llvm.lifetime.start.p0i8(i64 9, i8* nonnull %6) #3
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* nonnull %6, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @vulnerable.str1, i32 0, i32 0), i32 9, i32 1, i1 false)
  %7 = getelementptr inbounds [5 x i8], [5 x i8]* %3, i32 0, i32 0
  call void @llvm.lifetime.start.p0i8(i64 5, i8* nonnull %7) #3
  %8 = getelementptr inbounds [9 x i8], [9 x i8]* %4, i32 0, i32 0
  call void @llvm.lifetime.start.p0i8(i64 9, i8* nonnull %8) #3
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* nonnull %8, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @vulnerable.str2, i32 0, i32 0), i32 9, i32 1, i1 false)
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.2, i32 0, i32 0), i8* nonnull %7) #4
  %10 = call i32 @puts(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @str, i32 0, i32 0))
  %11 = call i8* @strcpy(i8* nonnull %7, i8* getelementptr inbounds ([101 x i8], [101 x i8]* @src, i32 0, i32 0)) #5
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.4, i32 0, i32 0), i8* nonnull %7) #4
  %13 = call i32 @puts(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @str.14, i32 0, i32 0))
  %14 = call i32 @fun1(i8* nonnull %5) #4
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.4, i32 0, i32 0), i8* nonnull %7) #4
  %16 = call i32 @puts(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @str.15, i32 0, i32 0))
  %17 = call i32 @fun2() #4
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.4, i32 0, i32 0), i8* nonnull %7) #4
  %19 = getelementptr inbounds [5 x i8], [5 x i8]* %3, i32 0, i32 30
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.7, i32 0, i32 0), i8* nonnull %19) #4
  %21 = getelementptr inbounds [5 x i8], [5 x i8]* %3, i32 0, i32 3
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.8, i32 0, i32 0), i8* nonnull %21) #4
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.9, i32 0, i32 0), i8* nonnull %6) #4
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.10, i32 0, i32 0), i8* nonnull %8) #4
  %25 = call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.16, i32 0, i32 0))
  call void @llvm.lifetime.end.p0i8(i64 9, i8* nonnull %8) #3
  call void @llvm.lifetime.end.p0i8(i64 5, i8* nonnull %7) #3
  call void @llvm.lifetime.end.p0i8(i64 9, i8* nonnull %6) #3
  call void @llvm.lifetime.end.p0i8(i64 9, i8* nonnull %5) #3
  ret i32 1
}

; Function Attrs: minsize nounwind optsize
declare i8* @strcpy(i8*, i8* nocapture readonly) local_unnamed_addr #2

; Function Attrs: minsize nounwind optsize
define hidden i32 @main() local_unnamed_addr #0 {
  %1 = tail call i32 @vulnerable() #4
  %2 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.12, i32 0, i32 0), i32 1) #4
  %3 = tail call i32 @puts(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @str.17, i32 0, i32 0))
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #3

attributes #0 = { minsize nounwind optsize "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { minsize nounwind optsize "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { minsize optsize }
attributes #5 = { minsize nounwind optsize }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
