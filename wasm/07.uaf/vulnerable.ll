; ModuleID = 'vulnerable.c'
source_filename = "vulnerable.c"
target datalayout = "e-m:e-p:32:32-i64:64-n32:64-S128"
target triple = "wasm32"

@.str = private unnamed_addr constant [10 x i8] c"boop: %s\0A\00", align 1
@.str.1 = private unnamed_addr constant [10 x i8] c"beep: %s\0A\00", align 1
@.str.3 = private unnamed_addr constant [55 x i8] c"this print done by calling a->func() where func = boop\00", align 1
@.str.5 = private unnamed_addr constant [72 x i8] c"this print done by calling a->func() where a was freed (use after free)\00", align 1
@.str.8 = private unnamed_addr constant [55 x i8] c"this print done by calling a->func() where func = beep\00", align 1
@.str.11 = private unnamed_addr constant [12 x i8] c"unreachable\00", align 1
@str = private unnamed_addr constant [31 x i8] c"freeing a without modifying it\00"
@str.13 = private unnamed_addr constant [34 x i8] c"setting a to a different function\00"
@str.14 = private unnamed_addr constant [20 x i8] c"set a->func to beep\00"
@str.15 = private unnamed_addr constant [18 x i8] c"setting a to null\00"
@str.16 = private unnamed_addr constant [36 x i8] c"calling a->func() when a is null...\00"
@str.17 = private unnamed_addr constant [7 x i8] c"ending\00"

; Function Attrs: minsize nounwind optsize
define hidden void @boop(i8*) local_unnamed_addr #0 {
  %2 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i32 0, i32 0), i8* %0) #3
  ret void
}

; Function Attrs: minsize nounwind optsize
declare i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #1

; Function Attrs: minsize nounwind optsize
define hidden void @beep(i8*) local_unnamed_addr #0 {
  %2 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i8* %0) #3
  ret void
}

; Function Attrs: minsize nounwind optsize
define hidden i32 @main() local_unnamed_addr #0 {
  %1 = tail call noalias i8* @malloc(i32 8) #4
  %2 = getelementptr inbounds i8, i8* %1, i32 4
  %3 = bitcast i8* %2 to void (i8*)**
  tail call void @boop(i8* getelementptr inbounds ([55 x i8], [55 x i8]* @.str.3, i32 0, i32 0)) #3
  %4 = tail call i32 @puts(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @str, i32 0, i32 0))
  tail call void @free(i8* %1) #4
  %5 = load void (i8*)*, void (i8*)** %3, align 4, !tbaa !2
  tail call void %5(i8* getelementptr inbounds ([72 x i8], [72 x i8]* @.str.5, i32 0, i32 0)) #4
  %6 = tail call i32 @puts(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @str.13, i32 0, i32 0))
  %7 = tail call i32 @puts(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @str.14, i32 0, i32 0))
  tail call void @beep(i8* getelementptr inbounds ([55 x i8], [55 x i8]* @.str.8, i32 0, i32 0)) #3
  %8 = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.15, i32 0, i32 0))
  %9 = tail call i32 @puts(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @str.16, i32 0, i32 0))
  %10 = load void (i8*)*, void (i8*)** inttoptr (i32 4 to void (i8*)**), align 4, !tbaa !2
  tail call void %10(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.11, i32 0, i32 0)) #4
  %11 = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @str.17, i32 0, i32 0))
  ret i32 0
}

; Function Attrs: minsize nounwind optsize
declare noalias i8* @malloc(i32) local_unnamed_addr #1

; Function Attrs: minsize nounwind optsize
declare void @free(i8* nocapture) local_unnamed_addr #1

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #2

attributes #0 = { minsize nounwind optsize "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { minsize nounwind optsize "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { minsize optsize }
attributes #4 = { minsize nounwind optsize }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
!2 = !{!3, !4, i64 4}
!3 = !{!"somestruct", !4, i64 0, !4, i64 4}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
