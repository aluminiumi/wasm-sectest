; ModuleID = 'vulnerable.c'
source_filename = "vulnerable.c"
target datalayout = "e-m:e-p:32:32-i64:64-n32:64-S128"
target triple = "wasm32"

@src = hidden local_unnamed_addr global [101 x i8] c"aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeeeeffffffffffgggggggggghhhhhhhhhhiiiiiiiiiijjjjjjjjjj\00", align 16
@.str = private unnamed_addr constant [11 x i8] c"\0Astrfun2: \00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"\0Astrfun1: \00", align 1
@vulnerable.dest = private unnamed_addr constant [5 x i8] c"cccc\00", align 1
@.str.2 = private unnamed_addr constant [29 x i8] c"\0Adest is 5 characters long: \00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"\0Adest[%d]: \00", align 1
@.str.4 = private unnamed_addr constant [12 x i8] c"\0Aheap[%d]: \00", align 1
@.str.5 = private unnamed_addr constant [11 x i8] c"\0Adest[5]: \00", align 1
@.str.6 = private unnamed_addr constant [13 x i8] c"\0Adest[512]: \00", align 1
@.str.7 = private unnamed_addr constant [14 x i8] c"\0Adest[1024]: \00", align 1
@.str.8 = private unnamed_addr constant [14 x i8] c"\0Adest[4096]: \00", align 1
@.str.9 = private unnamed_addr constant [12 x i8] c"Result: %d\0A\00", align 1

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
define hidden i32 @vulnerable(i8* nocapture readnone) local_unnamed_addr #0 {
  %2 = alloca [5 x i8], align 1
  %3 = getelementptr inbounds [5 x i8], [5 x i8]* %2, i32 0, i32 0
  call void @llvm.lifetime.start.p0i8(i64 5, i8* nonnull %3) #3
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* nonnull %3, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @vulnerable.dest, i32 0, i32 0), i32 5, i32 1, i1 false)
  %4 = tail call noalias i8* @malloc(i32 1) #5
  %5 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.2, i32 0, i32 0)) #4
  %6 = call i32 @puts(i8* nonnull %3) #4
  br label %7

; <label>:7:                                      ; preds = %11, %1
  %8 = phi i32 [ 0, %1 ], [ %15, %11 ]
  %9 = icmp eq i32 %8, 512
  br i1 %9, label %10, label %11

; <label>:10:                                     ; preds = %7
  br label %16

; <label>:11:                                     ; preds = %7
  %12 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i32 %8) #4
  %13 = getelementptr inbounds [5 x i8], [5 x i8]* %2, i32 0, i32 %8
  %14 = call i32 @puts(i8* nonnull %13) #4
  %15 = add nuw nsw i32 %8, 1
  br label %7

; <label>:16:                                     ; preds = %10, %20
  %17 = phi i32 [ %24, %20 ], [ 0, %10 ]
  %18 = icmp eq i32 %17, 512
  br i1 %18, label %19, label %20

; <label>:19:                                     ; preds = %16
  br label %25

; <label>:20:                                     ; preds = %16
  %21 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.4, i32 0, i32 0), i32 %17) #4
  %22 = getelementptr inbounds i8, i8* %4, i32 %17
  %23 = tail call i32 @puts(i8* %22) #4
  %24 = add nuw nsw i32 %17, 1
  br label %16

; <label>:25:                                     ; preds = %19, %28
  %26 = phi i32 [ %32, %28 ], [ 0, %19 ]
  %27 = icmp sgt i32 %26, -512
  br i1 %27, label %28, label %33

; <label>:28:                                     ; preds = %25
  %29 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.4, i32 0, i32 0), i32 %26) #4
  %30 = getelementptr inbounds i8, i8* %4, i32 %26
  %31 = tail call i32 @puts(i8* %30) #4
  %32 = add nsw i32 %26, -1
  br label %25

; <label>:33:                                     ; preds = %25
  %34 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.5, i32 0, i32 0)) #4
  %35 = getelementptr inbounds [5 x i8], [5 x i8]* %2, i32 0, i32 5
  %36 = call i32 @puts(i8* nonnull %35) #4
  %37 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.6, i32 0, i32 0)) #4
  %38 = getelementptr inbounds [5 x i8], [5 x i8]* %2, i32 0, i32 512
  %39 = call i32 @puts(i8* nonnull %38) #4
  %40 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.7, i32 0, i32 0)) #4
  %41 = getelementptr inbounds [5 x i8], [5 x i8]* %2, i32 0, i32 1024
  %42 = call i32 @puts(i8* nonnull %41) #4
  %43 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.8, i32 0, i32 0)) #4
  %44 = getelementptr inbounds [5 x i8], [5 x i8]* %2, i32 0, i32 4096
  %45 = call i32 @puts(i8* nonnull %44) #4
  call void @llvm.lifetime.end.p0i8(i64 5, i8* nonnull %3) #3
  ret i32 1
}

; Function Attrs: minsize nounwind optsize
declare noalias i8* @malloc(i32) local_unnamed_addr #2

; Function Attrs: minsize nounwind optsize
define hidden i32 @main() local_unnamed_addr #0 {
  %1 = tail call i32 @vulnerable(i8* undef) #4
  %2 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.9, i32 0, i32 0), i32 1) #4
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
