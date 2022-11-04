; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py UTC_ARGS: --filter "LV: Found an estimated cost of [0-9]+ for VF [0-9]+ For instruction:\s*store i32 %v1, ptr %out1"
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+sse2 --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefix=SSE2
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx  --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefix=AVX1
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx2 --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefix=AVX2
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx512vl --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefix=AVX512
; REQUIRES: asserts

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@A = global [1024 x i8] zeroinitializer, align 128
@B = global [1024 x i32] zeroinitializer, align 128

define void @test() {
; SSE2-LABEL: 'test'
; SSE2:  LV: Found an estimated cost of 1 for VF 1 For instruction: store i32 %v1, ptr %out1, align 4
; SSE2:  LV: Found an estimated cost of 2 for VF 2 For instruction: store i32 %v1, ptr %out1, align 4
; SSE2:  LV: Found an estimated cost of 30 for VF 4 For instruction: store i32 %v1, ptr %out1, align 4
; SSE2:  LV: Found an estimated cost of 60 for VF 8 For instruction: store i32 %v1, ptr %out1, align 4
; SSE2:  LV: Found an estimated cost of 120 for VF 16 For instruction: store i32 %v1, ptr %out1, align 4
;
; AVX1-LABEL: 'test'
; AVX1:  LV: Found an estimated cost of 1 for VF 1 For instruction: store i32 %v1, ptr %out1, align 4
; AVX1:  LV: Found an estimated cost of 2 for VF 2 For instruction: store i32 %v1, ptr %out1, align 4
; AVX1:  LV: Found an estimated cost of 19 for VF 4 For instruction: store i32 %v1, ptr %out1, align 4
; AVX1:  LV: Found an estimated cost of 40 for VF 8 For instruction: store i32 %v1, ptr %out1, align 4
; AVX1:  LV: Found an estimated cost of 80 for VF 16 For instruction: store i32 %v1, ptr %out1, align 4
; AVX1:  LV: Found an estimated cost of 160 for VF 32 For instruction: store i32 %v1, ptr %out1, align 4
;
; AVX2-LABEL: 'test'
; AVX2:  LV: Found an estimated cost of 1 for VF 1 For instruction: store i32 %v1, ptr %out1, align 4
; AVX2:  LV: Found an estimated cost of 2 for VF 2 For instruction: store i32 %v1, ptr %out1, align 4
; AVX2:  LV: Found an estimated cost of 3 for VF 4 For instruction: store i32 %v1, ptr %out1, align 4
; AVX2:  LV: Found an estimated cost of 6 for VF 8 For instruction: store i32 %v1, ptr %out1, align 4
; AVX2:  LV: Found an estimated cost of 12 for VF 16 For instruction: store i32 %v1, ptr %out1, align 4
; AVX2:  LV: Found an estimated cost of 24 for VF 32 For instruction: store i32 %v1, ptr %out1, align 4
;
; AVX512-LABEL: 'test'
; AVX512:  LV: Found an estimated cost of 1 for VF 1 For instruction: store i32 %v1, ptr %out1, align 4
; AVX512:  LV: Found an estimated cost of 2 for VF 2 For instruction: store i32 %v1, ptr %out1, align 4
; AVX512:  LV: Found an estimated cost of 2 for VF 4 For instruction: store i32 %v1, ptr %out1, align 4
; AVX512:  LV: Found an estimated cost of 2 for VF 8 For instruction: store i32 %v1, ptr %out1, align 4
; AVX512:  LV: Found an estimated cost of 5 for VF 16 For instruction: store i32 %v1, ptr %out1, align 4
; AVX512:  LV: Found an estimated cost of 10 for VF 32 For instruction: store i32 %v1, ptr %out1, align 4
; AVX512:  LV: Found an estimated cost of 20 for VF 64 For instruction: store i32 %v1, ptr %out1, align 4
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]

  %iv.0 = add nuw nsw i64 %iv, 0
  %iv.1 = add nuw nsw i64 %iv, 1

  %in = getelementptr inbounds [1024 x i8], ptr @A, i64 0, i64 %iv.0
  %v.narrow = load i8, ptr %in

  %v = zext i8 %v.narrow to i32

  %v0 = add i32 %v, 0
  %v1 = add i32 %v, 1

  %out0 = getelementptr inbounds [1024 x i32], ptr @B, i64 0, i64 %iv.0
  %out1 = getelementptr inbounds [1024 x i32], ptr @B, i64 0, i64 %iv.1

  store i32 %v0, ptr %out0
  store i32 %v1, ptr %out1

  %iv.next = add nuw nsw i64 %iv.0, 2
  %cmp = icmp ult i64 %iv.next, 1024
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:
  ret void
}