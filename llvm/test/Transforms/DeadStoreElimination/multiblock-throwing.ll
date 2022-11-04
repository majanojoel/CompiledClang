; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=dse -S | FileCheck %s

target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"
declare void @unknown_func()

define void @test6_store_same_value(ptr noalias %P) {
; CHECK-LABEL: @test6_store_same_value(
; CHECK-NEXT:    store i32 0, ptr [[P:%.*]], align 4
; CHECK-NEXT:    br i1 true, label [[BB1:%.*]], label [[BB2:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    br label [[BB3:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    call void @unknown_func()
; CHECK-NEXT:    br label [[BB3]]
; CHECK:       bb3:
; CHECK-NEXT:    store i32 0, ptr [[P]], align 4
; CHECK-NEXT:    ret void
;
  store i32 0, ptr %P
  br i1 true, label %bb1, label %bb2
bb1:
  br label %bb3
bb2:
  call void @unknown_func()
  br label %bb3
bb3:
  store i32 0, ptr %P
  ret void
}

define void @test6_store_other_value(ptr noalias %P) {
; CHECK-LABEL: @test6_store_other_value(
; CHECK-NEXT:    store i32 0, ptr [[P:%.*]], align 4
; CHECK-NEXT:    br i1 true, label [[BB1:%.*]], label [[BB2:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    br label [[BB3:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    call void @unknown_func()
; CHECK-NEXT:    br label [[BB3]]
; CHECK:       bb3:
; CHECK-NEXT:    store i32 1, ptr [[P]], align 4
; CHECK-NEXT:    ret void
;
  store i32 0, ptr %P
  br i1 true, label %bb1, label %bb2
bb1:
  br label %bb3
bb2:
  call void @unknown_func()
  br label %bb3
bb3:
  store i32 1, ptr %P
  ret void
}

define void @test23(ptr noalias %P) {
; CHECK-LABEL: @test23(
; CHECK-NEXT:    br i1 true, label [[BB1:%.*]], label [[BB2:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    br label [[BB3:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    call void @unknown_func()
; CHECK-NEXT:    br label [[BB3]]
; CHECK:       bb3:
; CHECK-NEXT:    store i32 0, ptr [[P:%.*]], align 4
; CHECK-NEXT:    ret void
;
  br i1 true, label %bb1, label %bb2
bb1:
  store i32 0, ptr %P
  br label %bb3
bb2:
  call void @unknown_func()
  br label %bb3
bb3:
  store i32 0, ptr %P
  ret void
}


define void @test24(ptr noalias %P) {
; CHECK-LABEL: @test24(
; CHECK-NEXT:    br i1 true, label [[BB2:%.*]], label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    br label [[BB3:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    call void @unknown_func()
; CHECK-NEXT:    br label [[BB3]]
; CHECK:       bb3:
; CHECK-NEXT:    store i32 0, ptr [[P:%.*]], align 4
; CHECK-NEXT:    ret void
;
  br i1 true, label %bb2, label %bb1
bb1:
  store i32 0, ptr %P
  br label %bb3
bb2:
  call void @unknown_func()
  br label %bb3
bb3:
  store i32 0, ptr %P
  ret void
}