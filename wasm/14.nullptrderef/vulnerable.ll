; ModuleID = 'vulnerable.c'
source_filename = "vulnerable.c"
target datalayout = "e-m:e-p:32:32-i64:64-n32:64-S128"
target triple = "wasm32"

@.str = private unnamed_addr constant [51 x i8] c"a: %d, b: %d, c: %d, *ptr: %d, ptr: %p, *ptr2: %d\0A\00", align 1
@.str.2 = private unnamed_addr constant [42 x i8] c"a: %d, b: %d, c: %d, *ptr: %d, *ptr2: %d\0A\00", align 1
@str = private unnamed_addr constant [28 x i8] c"setting ptr to address of a\00"
@str.6 = private unnamed_addr constant [37 x i8] c"setting b to value pointed to by ptr\00"
@str.7 = private unnamed_addr constant [20 x i8] c"setting ptr to null\00"
@str.8 = private unnamed_addr constant [64 x i8] c"setting c to value pointed to by ptr (null pointer dereference)\00"

; Function Attrs: minsize nounwind optsize
define hidden i32 @main() local_unnamed_addr #0 {
  %1 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([51 x i8], [51 x i8]* @.str, i32 0, i32 0), i32 2, i32 undef, i32 undef, i32 undef, i32* undef, i32 undef) #3
  %2 = tail call i32 @puts(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @str, i32 0, i32 0))
  %3 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.2, i32 0, i32 0), i32 2, i32 undef, i32 undef, i32 2, i32 undef) #3
  %4 = tail call i32 @puts(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @str.6, i32 0, i32 0))
  %5 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.2, i32 0, i32 0), i32 2, i32 2, i32 undef, i32 2, i32 undef) #3
  %6 = tail call i32 @puts(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @str.7, i32 0, i32 0))
  %7 = tail call i32 @puts(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @str.8, i32 0, i32 0))
  ret i32 0
}

; Function Attrs: minsize nounwind optsize
declare i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #1

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #2

attributes #0 = { minsize nounwind optsize "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { minsize nounwind optsize "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { minsize optsize }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
