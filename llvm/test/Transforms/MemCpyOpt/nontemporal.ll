; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -memcpyopt -S -verify-memoryssa | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

; Verify that we don't combine nontemporal stores into memset calls.

define void @nontemporal_stores_1(ptr nocapture %dst) {
; CHECK-LABEL: @nontemporal_stores_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store <4 x float> zeroinitializer, ptr [[DST:%.*]], align 16, !nontemporal !0
; CHECK-NEXT:    [[PTR1:%.*]] = getelementptr inbounds <4 x float>, ptr [[DST]], i64 1
; CHECK-NEXT:    store <4 x float> zeroinitializer, ptr [[PTR1]], align 16, !nontemporal !0
; CHECK-NEXT:    [[PTR2:%.*]] = getelementptr inbounds <4 x float>, ptr [[DST]], i64 2
; CHECK-NEXT:    store <4 x float> zeroinitializer, ptr [[PTR2]], align 16, !nontemporal !0
; CHECK-NEXT:    [[PTR3:%.*]] = getelementptr inbounds <4 x float>, ptr [[DST]], i64 3
; CHECK-NEXT:    store <4 x float> zeroinitializer, ptr [[PTR3]], align 16, !nontemporal !0
; CHECK-NEXT:    [[PTR4:%.*]] = getelementptr inbounds <4 x float>, ptr [[DST]], i64 4
; CHECK-NEXT:    store <4 x float> zeroinitializer, ptr [[PTR4]], align 16, !nontemporal !0
; CHECK-NEXT:    [[PTR5:%.*]] = getelementptr inbounds <4 x float>, ptr [[DST]], i64 5
; CHECK-NEXT:    store <4 x float> zeroinitializer, ptr [[PTR5]], align 16, !nontemporal !0
; CHECK-NEXT:    [[PTR6:%.*]] = getelementptr inbounds <4 x float>, ptr [[DST]], i64 6
; CHECK-NEXT:    store <4 x float> zeroinitializer, ptr [[PTR6]], align 16, !nontemporal !0
; CHECK-NEXT:    [[PTR7:%.*]] = getelementptr inbounds <4 x float>, ptr [[DST]], i64 7
; CHECK-NEXT:    store <4 x float> zeroinitializer, ptr [[PTR7]], align 16, !nontemporal !0
; CHECK-NEXT:    ret void
;
entry:
  store <4 x float> zeroinitializer, ptr %dst, align 16, !nontemporal !0
  %ptr1 = getelementptr inbounds <4 x float>, ptr %dst, i64 1
  store <4 x float> zeroinitializer, ptr %ptr1, align 16, !nontemporal !0
  %ptr2 = getelementptr inbounds <4 x float>, ptr %dst, i64 2
  store <4 x float> zeroinitializer, ptr %ptr2, align 16, !nontemporal !0
  %ptr3 = getelementptr inbounds <4 x float>, ptr %dst, i64 3
  store <4 x float> zeroinitializer, ptr %ptr3, align 16, !nontemporal !0
  %ptr4 = getelementptr inbounds <4 x float>, ptr %dst, i64 4
  store <4 x float> zeroinitializer, ptr %ptr4, align 16, !nontemporal !0
  %ptr5 = getelementptr inbounds <4 x float>, ptr %dst, i64 5
  store <4 x float> zeroinitializer, ptr %ptr5, align 16, !nontemporal !0
  %ptr6 = getelementptr inbounds <4 x float>, ptr %dst, i64 6
  store <4 x float> zeroinitializer, ptr %ptr6, align 16, !nontemporal !0
  %ptr7 = getelementptr inbounds <4 x float>, ptr %dst, i64 7
  store <4 x float> zeroinitializer, ptr %ptr7, align 16, !nontemporal !0
  ret void
}

define void @nontemporal_stores_2(ptr nocapture %dst) {
; CHECK-LABEL: @nontemporal_stores_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store <4 x float> zeroinitializer, ptr [[DST:%.*]], align 16, !nontemporal !0
; CHECK-NEXT:    [[PTR1:%.*]] = getelementptr inbounds <4 x float>, ptr [[DST]], i64 1
; CHECK-NEXT:    store <4 x float> zeroinitializer, ptr [[PTR1]], align 16, !nontemporal !0
; CHECK-NEXT:    ret void
;
entry:
  store <4 x float> zeroinitializer, ptr %dst, align 16, !nontemporal !0
  %ptr1 = getelementptr inbounds <4 x float>, ptr %dst, i64 1
  store <4 x float> zeroinitializer, ptr %ptr1, align 16, !nontemporal !0
  ret void
}

!0 = !{i32 1}
