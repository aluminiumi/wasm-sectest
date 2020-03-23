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
@.str.4 = private unnamed_addr constant [11 x i8] c"\0Adest[5]: \00", align 1
@.str.5 = private unnamed_addr constant [13 x i8] c"\0Adest[512]: \00", align 1
@.str.6 = private unnamed_addr constant [14 x i8] c"\0Adest[1024]: \00", align 1
@.str.7 = private unnamed_addr constant [14 x i8] c"\0Adest[4096]: \00", align 1
@.str.8 = private unnamed_addr constant [12 x i8] c"Result: %d\0A\00", align 1

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
  %4 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.2, i32 0, i32 0)) #4
  %5 = call i32 @puts(i8* nonnull %3) #4
  br label %6

; <label>:6:                                      ; preds = %9, %1
  %7 = phi i32 [ 0, %1 ], [ %13, %9 ]
  %8 = icmp eq i32 %7, 512
  br i1 %8, label %14, label %9

; <label>:9:                                      ; preds = %6
  %10 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i32 %7) #4
  %11 = getelementptr inbounds [5 x i8], [5 x i8]* %2, i32 0, i32 %7
  %12 = call i32 @puts(i8* nonnull %11) #4
  %13 = add nuw nsw i32 %7, 1
  br label %6

; <label>:14:                                     ; preds = %6
  %15 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.4, i32 0, i32 0)) #4
  %16 = getelementptr inbounds [5 x i8], [5 x i8]* %2, i32 0, i32 5
  %17 = call i32 @puts(i8* nonnull %16) #4
  %18 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.5, i32 0, i32 0)) #4
  %19 = getelementptr inbounds [5 x i8], [5 x i8]* %2, i32 0, i32 512
  %20 = call i32 @puts(i8* nonnull %19) #4
  %21 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.6, i32 0, i32 0)) #4
  %22 = getelementptr inbounds [5 x i8], [5 x i8]* %2, i32 0, i32 1024
  %23 = call i32 @puts(i8* nonnull %22) #4
  %24 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.7, i32 0, i32 0)) #4
  %25 = getelementptr inbounds [5 x i8], [5 x i8]* %2, i32 0, i32 4096
  %26 = call i32 @puts(i8* nonnull %25) #4
  call void @llvm.lifetime.end.p0i8(i64 5, i8* nonnull %3) #3
  ret i32 1
}

; Function Attrs: minsize nounwind optsize
define hidden i32 @main() local_unnamed_addr #0 {
  %1 = tail call i32 @vulnerable(i8* undef) #4
  %2 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.8, i32 0, i32 0), i32 1) #4
  ret i32 0
}

attributes #0 = { minsize nounwind optsize "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { minsize nounwind optsize "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { minsize optsize }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
