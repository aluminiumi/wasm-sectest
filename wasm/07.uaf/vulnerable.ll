; ModuleID = 'vulnerable.c'
source_filename = "vulnerable.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.somestruct = type { i8*, void (i8*)* }

@.str = private unnamed_addr constant [10 x i8] c"boop: %s\0A\00", align 1
@.str.1 = private unnamed_addr constant [10 x i8] c"beep: %s\0A\00", align 1
@.str.2 = private unnamed_addr constant [9 x i8] c"beepboop\00", align 1
@.str.3 = private unnamed_addr constant [55 x i8] c"this print done by calling a->func() where func = boop\00", align 1
@.str.4 = private unnamed_addr constant [32 x i8] c"freeing a without modifying it\0A\00", align 1
@.str.5 = private unnamed_addr constant [72 x i8] c"this print done by calling a->func() where a was freed (use after free)\00", align 1
@.str.6 = private unnamed_addr constant [35 x i8] c"setting a to a different function\0A\00", align 1
@.str.7 = private unnamed_addr constant [21 x i8] c"set a->func to beep\0A\00", align 1
@.str.8 = private unnamed_addr constant [55 x i8] c"this print done by calling a->func() where func = beep\00", align 1
@.str.9 = private unnamed_addr constant [19 x i8] c"setting a to null\0A\00", align 1
@.str.10 = private unnamed_addr constant [37 x i8] c"calling a->func() when a is null...\0A\00", align 1
@.str.11 = private unnamed_addr constant [12 x i8] c"unreachable\00", align 1
@.str.12 = private unnamed_addr constant [8 x i8] c"ending\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @boop(i8*) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i32 0, i32 0), i8* %3)
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind optnone uwtable
define void @beep(i8*) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i8* %3)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 {
  %1 = alloca %struct.somestruct*, align 8
  %2 = call noalias i8* @malloc(i64 16) #3
  %3 = bitcast i8* %2 to %struct.somestruct*
  store %struct.somestruct* %3, %struct.somestruct** %1, align 8
  %4 = load %struct.somestruct*, %struct.somestruct** %1, align 8
  %5 = getelementptr inbounds %struct.somestruct, %struct.somestruct* %4, i32 0, i32 1
  store void (i8*)* @boop, void (i8*)** %5, align 8
  %6 = load %struct.somestruct*, %struct.somestruct** %1, align 8
  %7 = getelementptr inbounds %struct.somestruct, %struct.somestruct* %6, i32 0, i32 0
  store i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i8** %7, align 8
  %8 = load %struct.somestruct*, %struct.somestruct** %1, align 8
  %9 = getelementptr inbounds %struct.somestruct, %struct.somestruct* %8, i32 0, i32 1
  %10 = load void (i8*)*, void (i8*)** %9, align 8
  call void %10(i8* getelementptr inbounds ([55 x i8], [55 x i8]* @.str.3, i32 0, i32 0))
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.4, i32 0, i32 0))
  %12 = load %struct.somestruct*, %struct.somestruct** %1, align 8
  %13 = bitcast %struct.somestruct* %12 to i8*
  call void @free(i8* %13) #3
  %14 = load %struct.somestruct*, %struct.somestruct** %1, align 8
  %15 = getelementptr inbounds %struct.somestruct, %struct.somestruct* %14, i32 0, i32 1
  %16 = load void (i8*)*, void (i8*)** %15, align 8
  call void %16(i8* getelementptr inbounds ([72 x i8], [72 x i8]* @.str.5, i32 0, i32 0))
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.6, i32 0, i32 0))
  %18 = load %struct.somestruct*, %struct.somestruct** %1, align 8
  %19 = getelementptr inbounds %struct.somestruct, %struct.somestruct* %18, i32 0, i32 1
  store void (i8*)* @beep, void (i8*)** %19, align 8
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.7, i32 0, i32 0))
  %21 = load %struct.somestruct*, %struct.somestruct** %1, align 8
  %22 = getelementptr inbounds %struct.somestruct, %struct.somestruct* %21, i32 0, i32 1
  %23 = load void (i8*)*, void (i8*)** %22, align 8
  call void %23(i8* getelementptr inbounds ([55 x i8], [55 x i8]* @.str.8, i32 0, i32 0))
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.9, i32 0, i32 0))
  store %struct.somestruct* null, %struct.somestruct** %1, align 8
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.10, i32 0, i32 0))
  %26 = load %struct.somestruct*, %struct.somestruct** %1, align 8
  %27 = getelementptr inbounds %struct.somestruct, %struct.somestruct* %26, i32 0, i32 1
  %28 = load void (i8*)*, void (i8*)** %27, align 8
  call void %28(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.11, i32 0, i32 0))
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.12, i32 0, i32 0))
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

; Function Attrs: nounwind
declare void @free(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
