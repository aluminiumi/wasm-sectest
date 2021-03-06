; ModuleID = 'vulnerable.c'
source_filename = "vulnerable.c"
target datalayout = "e-m:e-p:32:32-i64:64-n32:64-S128"
target triple = "wasm32"

@.str = private unnamed_addr constant [10 x i8] c"boop: %s\0A\00", align 1
@.str.1 = private unnamed_addr constant [10 x i8] c"beep: %s\0A\00", align 1
@.str.3 = private unnamed_addr constant [15 x i8] c"a->func == %p\0A\00", align 1
@.str.4 = private unnamed_addr constant [41 x i8] c"assigned a->func to boop; a->func == %p\0A\00", align 1
@.str.6 = private unnamed_addr constant [55 x i8] c"this print done by calling a->func() where func = boop\00", align 1
@.str.8 = private unnamed_addr constant [72 x i8] c"this print done by calling a->func() where a was freed (use after free)\00", align 1
@.str.10 = private unnamed_addr constant [36 x i8] c"set a->func to beep; a->func == %p\0A\00", align 1
@.str.11 = private unnamed_addr constant [55 x i8] c"this print done by calling a->func() where func = beep\00", align 1
@.str.12 = private unnamed_addr constant [38 x i8] c"set a->func2 to beep; a->func2 == %p\0A\00", align 1
@.str.13 = private unnamed_addr constant [57 x i8] c"this print done by calling a->func2() where func2 = beep\00", align 1
@.str.14 = private unnamed_addr constant [35 x i8] c"set a->func to bop; a->func == %p\0A\00", align 1
@.str.15 = private unnamed_addr constant [36 x i8] c"set a->func2 to 14; a->func2 == %p\0A\00", align 1
@.str.16 = private unnamed_addr constant [34 x i8] c"set a->func to 14; a->func == %p\0A\00", align 1
@.str.19 = private unnamed_addr constant [12 x i8] c"unreachable\00", align 1
@str = private unnamed_addr constant [9 x i8] c"bop: bop\00"
@str.21 = private unnamed_addr constant [31 x i8] c"freeing a without modifying it\00"
@str.22 = private unnamed_addr constant [34 x i8] c"setting a to a different function\00"
@str.23 = private unnamed_addr constant [18 x i8] c"setting a to null\00"
@str.24 = private unnamed_addr constant [36 x i8] c"calling a->func() when a is null...\00"
@str.25 = private unnamed_addr constant [7 x i8] c"ending\00"

; Function Attrs: minsize nounwind optsize
define hidden void @boop(i8*) #0 {
  %2 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i32 0, i32 0), i8* %0) #3
  ret void
}

; Function Attrs: minsize nounwind optsize
declare i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #1

; Function Attrs: minsize nounwind optsize
define hidden void @beep(i8*) #0 {
  %2 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i8* %0) #3
  ret void
}

; Function Attrs: minsize nounwind optsize
define hidden void @bop() #0 {
  %1 = tail call i32 @puts(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @str, i32 0, i32 0))
  ret void
}

; Function Attrs: minsize nounwind optsize
define hidden i32 @main() local_unnamed_addr #0 {
  %1 = tail call noalias i8* @malloc(i32 12) #4
  %2 = getelementptr inbounds i8, i8* %1, i32 4
  %3 = bitcast i8* %2 to void (i8*)**
  %4 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.3, i32 0, i32 0), void (i8*)* undef) #3
  %5 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.4, i32 0, i32 0), void (i8*)* nonnull @boop) #3
  tail call void @boop(i8* getelementptr inbounds ([55 x i8], [55 x i8]* @.str.6, i32 0, i32 0)) #3
  %6 = tail call i32 @puts(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @str.21, i32 0, i32 0))
  tail call void @free(i8* %1) #4
  %7 = load void (i8*)*, void (i8*)** %3, align 4, !tbaa !2
  tail call void %7(i8* getelementptr inbounds ([72 x i8], [72 x i8]* @.str.8, i32 0, i32 0)) #4
  %8 = tail call i32 @puts(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @str.22, i32 0, i32 0))
  %9 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.10, i32 0, i32 0), void (i8*)* nonnull @beep) #3
  tail call void @beep(i8* getelementptr inbounds ([55 x i8], [55 x i8]* @.str.11, i32 0, i32 0)) #3
  %10 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.12, i32 0, i32 0), void (i8*)* nonnull @beep) #3
  tail call void @beep(i8* getelementptr inbounds ([57 x i8], [57 x i8]* @.str.13, i32 0, i32 0)) #4
  %11 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), void (i8*)* bitcast (void ()* @bop to void (i8*)*)) #3
  %12 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.15, i32 0, i32 0), void (...)* inttoptr (i32 14 to void (...)*)) #3
  %13 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.16, i32 0, i32 0), void (i8*)* inttoptr (i32 14 to void (i8*)*)) #3
  %14 = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.23, i32 0, i32 0))
  %15 = tail call i32 @puts(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @str.24, i32 0, i32 0))
  %16 = load void (i8*)*, void (i8*)** inttoptr (i32 4 to void (i8*)**), align 4, !tbaa !2
  tail call void %16(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.19, i32 0, i32 0)) #4
  %17 = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @str.25, i32 0, i32 0))
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
!3 = !{!"somestruct", !4, i64 0, !4, i64 4, !4, i64 8}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
