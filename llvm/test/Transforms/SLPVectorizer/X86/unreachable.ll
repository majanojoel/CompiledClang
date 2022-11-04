; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer -S -mtriple=x86_64-apple-macosx10.8.0 -mcpu=corei7 | FileCheck %s

; Check if the SLPVectorizer does not crash when handling
; unreachable blocks with unscheduleable instructions.

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.9.0"

define void @foo(i32* nocapture %x) #0 {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[BB2:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[BAD:%.*]] = fadd float [[BAD]], 0.000000e+00
; CHECK-NEXT:    br label [[BB2]]
; CHECK:       bb2:
; CHECK-NEXT:    [[TMP0:%.*]] = phi <4 x i32> [ poison, [[BB1:%.*]] ], [ <i32 2, i32 2, i32 2, i32 2>, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32* [[X:%.*]] to <4 x i32>*
; CHECK-NEXT:    store <4 x i32> [[TMP0]], <4 x i32>* [[TMP1]], align 4
; CHECK-NEXT:    ret void
;
entry:
  br label %bb2

bb1:                                    ; an unreachable block
  %t3 = getelementptr inbounds i32, i32* %x, i64 4
  %t4 = load i32, i32* %t3, align 4
  %t5 = getelementptr inbounds i32, i32* %x, i64 5
  %t6 = load i32, i32* %t5, align 4
  %bad = fadd float %bad, 0.000000e+00  ; <- an instruction with self dependency,
  ;    but legal in unreachable code
  %t7 = getelementptr inbounds i32, i32* %x, i64 6
  %t8 = load i32, i32* %t7, align 4
  %t9 = getelementptr inbounds i32, i32* %x, i64 7
  %t10 = load i32, i32* %t9, align 4
  br label %bb2

bb2:
  %t1.0 = phi i32 [ %t4, %bb1 ], [ 2, %entry ]
  %t2.0 = phi i32 [ %t6, %bb1 ], [ 2, %entry ]
  %t3.0 = phi i32 [ %t8, %bb1 ], [ 2, %entry ]
  %t4.0 = phi i32 [ %t10, %bb1 ], [ 2, %entry ]
  store i32 %t1.0, i32* %x, align 4
  %t12 = getelementptr inbounds i32, i32* %x, i64 1
  store i32 %t2.0, i32* %t12, align 4
  %t13 = getelementptr inbounds i32, i32* %x, i64 2
  store i32 %t3.0, i32* %t13, align 4
  %t14 = getelementptr inbounds i32, i32* %x, i64 3
  store i32 %t4.0, i32* %t14, align 4
  ret void
}

define void @bar() {
; CHECK-LABEL: @bar(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP:%.*]] = load atomic i8*, i8** undef unordered, align 8
; CHECK-NEXT:    br label [[BB6:%.*]]
; CHECK:       bb5:
; CHECK-NEXT:    [[TMP4:%.*]] = load atomic i8*, i8** undef unordered, align 8
; CHECK-NEXT:    br label [[BB6]]
; CHECK:       bb6:
; CHECK-NEXT:    [[TMP7:%.*]] = phi i8* [ [[TMP]], [[BB5:%.*]] ], [ undef, [[BB:%.*]] ]
; CHECK-NEXT:    [[TMP8:%.*]] = phi i8* [ [[TMP4]], [[BB5]] ], [ undef, [[BB]] ]
; CHECK-NEXT:    ret void
;
bb:
  %tmp = load atomic i8*, i8** undef unordered, align 8
  br label %bb6

bb5:                                              ; No predecessors!
  %tmp4 = load atomic i8*, i8** undef unordered, align 8
  br label %bb6

bb6:                                              ; preds = %bb5, %bb
  %tmp7 = phi i8* [ %tmp, %bb5 ], [ undef, %bb ]
  %tmp8 = phi i8* [ %tmp4, %bb5 ], [ undef, %bb ]
  ret void
}