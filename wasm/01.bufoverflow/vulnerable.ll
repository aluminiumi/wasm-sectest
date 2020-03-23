; ModuleID = 'vulnerable.c'
source_filename = "vulnerable.c"
target datalayout = "e-m:e-p:32:32-i64:64-n32:64-S128"
target triple = "wasm32"

@src = hidden global [101 x i8] c"aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeeeeffffffffffgggggggggghhhhhhhhhhiiiiiiiiiijjjjjjjjjj\00", align 16
@.str = private unnamed_addr constant [11 x i8] c"\0Astrfun2: \00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"\0Astrfun1: \00", align 1
@vulnerable.strfun1 = private unnamed_addr constant [9 x i8] c"strfun1\0A\00", align 1
@vulnerable.str1 = private unnamed_addr constant [9 x i8] c"string1\0A\00", align 1
@vulnerable.str2 = private unnamed_addr constant [9 x i8] c"string2\0A\00", align 1
@.str.2 = private unnamed_addr constant [29 x i8] c"\0Adest is 5 characters long: \00", align 1
@.str.4 = private unnamed_addr constant [8 x i8] c"\0Adest: \00", align 1
@.str.5 = private unnamed_addr constant [31 x i8] c"\0APerforming function call one \00", align 1
@.str.6 = private unnamed_addr constant [31 x i8] c"\0APerforming function call two \00", align 1
@.str.7 = private unnamed_addr constant [12 x i8] c"\0Adest[30]: \00", align 1
@.str.8 = private unnamed_addr constant [11 x i8] c"\0Adest[3]: \00", align 1
@.str.9 = private unnamed_addr constant [8 x i8] c"\0Astr1: \00", align 1
@.str.10 = private unnamed_addr constant [8 x i8] c"\0Astr2: \00", align 1
@.str.11 = private unnamed_addr constant [12 x i8] c"Result: %d\0A\00", align 1
@str = private unnamed_addr constant [38 x i8] c"\0ACopying 100 char string into dest...\00"
@str.13 = private unnamed_addr constant [22 x i8] c"No overflow occurred.\00"

; Function Attrs: minsize nounwind optsize
define hidden i32 @fun2() local_unnamed_addr #0 {
  %1 = alloca i64, align 8
  %2 = bitcast i64* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2) #3
  store i64 14195199344538739, i64* %1, align 8
  %3 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #4
  %4 = call i32 @puts(i8* nonnull %2) #4
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2) #3
  ret i32 2
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i32(i8* nocapture writeonly, i8* nocapture readonly, i32, i32, i1) #1

; Function Attrs: minsize nounwind optsize
declare i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

; Function Attrs: minsize nounwind optsize
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

; Function Attrs: minsize nounwind optsize
define hidden i32 @fun1(i8* nocapture readonly) local_unnamed_addr #0 {
  %2 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0)) #4
  %3 = tail call i32 @puts(i8* %0) #4
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
  %9 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.2, i32 0, i32 0)) #4
  %10 = call i32 @puts(i8* nonnull %7) #4
  %11 = tail call i32 @puts(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @str, i32 0, i32 0))
  %12 = call i8* @strcpy(i8* nonnull %7, i8* getelementptr inbounds ([101 x i8], [101 x i8]* @src, i32 0, i32 0)) #5
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.4, i32 0, i32 0)) #4
  %14 = call i32 @puts(i8* nonnull %7) #4
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.5, i32 0, i32 0)) #4
  %16 = call i32 @fun1(i8* nonnull %5) #4
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.4, i32 0, i32 0)) #4
  %18 = call i32 @puts(i8* nonnull %7) #4
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.6, i32 0, i32 0)) #4
  %20 = call i32 @fun2() #4
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.4, i32 0, i32 0)) #4
  %22 = call i32 @puts(i8* nonnull %7) #4
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.7, i32 0, i32 0)) #4
  %24 = getelementptr inbounds [5 x i8], [5 x i8]* %3, i32 0, i32 30
  %25 = call i32 @puts(i8* nonnull %24) #4
  %26 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i32 0, i32 0)) #4
  %27 = getelementptr inbounds [5 x i8], [5 x i8]* %3, i32 0, i32 3
  %28 = call i32 @puts(i8* nonnull %27) #4
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.9, i32 0, i32 0)) #4
  %30 = call i32 @puts(i8* nonnull %6) #4
  %31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.10, i32 0, i32 0)) #4
  %32 = call i32 @puts(i8* nonnull %8) #4
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
  %2 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.11, i32 0, i32 0), i32 1) #4
  %3 = tail call i32 @puts(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @str.13, i32 0, i32 0))
  ret i32 0
}

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
