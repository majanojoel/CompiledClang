; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mcpu=pwr9 -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu < %s | FileCheck %s

; void foo(ptr data, float d) {
;   long i;
;   for (i = 0; i < 8000; i++)
;     data[i] = d;
; }
;
; This loop will be unrolled by 96 and vectorized on power9.
; icmp for loop iteration index and loop trip count(384) has LSRUse for 'reg({0,+,384})'.
; Make sure above icmp does not impact LSR choose best formulae sets based on 'reg({(192 + %0),+,384})'

define void @foo(ptr nocapture %data, float %d) {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xscvdpspn 0, 1
; CHECK-NEXT:    li 5, 83
; CHECK-NEXT:    addi 4, 3, 192
; CHECK-NEXT:    mtctr 5
; CHECK-NEXT:    xxspltw 0, 0, 0
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_1: # %vector.body
; CHECK-NEXT:    #
; CHECK-NEXT:    stxv 0, -192(4)
; CHECK-NEXT:    stxv 0, -176(4)
; CHECK-NEXT:    stxv 0, -160(4)
; CHECK-NEXT:    stxv 0, -144(4)
; CHECK-NEXT:    stxv 0, -128(4)
; CHECK-NEXT:    stxv 0, -112(4)
; CHECK-NEXT:    stxv 0, -96(4)
; CHECK-NEXT:    stxv 0, -80(4)
; CHECK-NEXT:    stxv 0, -64(4)
; CHECK-NEXT:    stxv 0, -48(4)
; CHECK-NEXT:    stxv 0, -32(4)
; CHECK-NEXT:    stxv 0, -16(4)
; CHECK-NEXT:    stxv 0, 0(4)
; CHECK-NEXT:    stxv 0, 16(4)
; CHECK-NEXT:    stxv 0, 32(4)
; CHECK-NEXT:    stxv 0, 48(4)
; CHECK-NEXT:    stxv 0, 64(4)
; CHECK-NEXT:    stxv 0, 80(4)
; CHECK-NEXT:    stxv 0, 96(4)
; CHECK-NEXT:    stxv 0, 112(4)
; CHECK-NEXT:    stxv 0, 128(4)
; CHECK-NEXT:    stxv 0, 144(4)
; CHECK-NEXT:    stxv 0, 160(4)
; CHECK-NEXT:    stxv 0, 176(4)
; CHECK-NEXT:    addi 4, 4, 384
; CHECK-NEXT:    bdnz .LBB0_1
; CHECK-NEXT:  # %bb.2: # %for.body
; CHECK-NEXT:    stfs 1, 31872(3)
; CHECK-NEXT:    stfs 1, 31876(3)
; CHECK-NEXT:    stfs 1, 31880(3)
; CHECK-NEXT:    stfs 1, 31884(3)
; CHECK-NEXT:    stfs 1, 31888(3)
; CHECK-NEXT:    stfs 1, 31892(3)
; CHECK-NEXT:    stfs 1, 31896(3)
; CHECK-NEXT:    stfs 1, 31900(3)
; CHECK-NEXT:    stfs 1, 31904(3)
; CHECK-NEXT:    stfs 1, 31908(3)
; CHECK-NEXT:    stfs 1, 31912(3)
; CHECK-NEXT:    stfs 1, 31916(3)
; CHECK-NEXT:    stfs 1, 31920(3)
; CHECK-NEXT:    stfs 1, 31924(3)
; CHECK-NEXT:    stfs 1, 31928(3)
; CHECK-NEXT:    stfs 1, 31932(3)
; CHECK-NEXT:    stfs 1, 31936(3)
; CHECK-NEXT:    stfs 1, 31940(3)
; CHECK-NEXT:    stfs 1, 31944(3)
; CHECK-NEXT:    stfs 1, 31948(3)
; CHECK-NEXT:    stfs 1, 31952(3)
; CHECK-NEXT:    stfs 1, 31956(3)
; CHECK-NEXT:    stfs 1, 31960(3)
; CHECK-NEXT:    stfs 1, 31964(3)
; CHECK-NEXT:    stfs 1, 31968(3)
; CHECK-NEXT:    stfs 1, 31972(3)
; CHECK-NEXT:    stfs 1, 31976(3)
; CHECK-NEXT:    stfs 1, 31980(3)
; CHECK-NEXT:    stfs 1, 31984(3)
; CHECK-NEXT:    stfs 1, 31988(3)
; CHECK-NEXT:    stfs 1, 31992(3)
; CHECK-NEXT:    stfs 1, 31996(3)
; CHECK-NEXT:    blr

entry:
  %broadcast.splatinsert16 = insertelement <4 x float> undef, float %d, i32 0
  %broadcast.splat17 = shufflevector <4 x float> %broadcast.splatinsert16, <4 x float> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert18 = insertelement <4 x float> undef, float %d, i32 0
  %broadcast.splat19 = shufflevector <4 x float> %broadcast.splatinsert18, <4 x float> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert20 = insertelement <4 x float> undef, float %d, i32 0
  %broadcast.splat21 = shufflevector <4 x float> %broadcast.splatinsert20, <4 x float> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert22 = insertelement <4 x float> undef, float %d, i32 0
  %broadcast.splat23 = shufflevector <4 x float> %broadcast.splatinsert22, <4 x float> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert24 = insertelement <4 x float> undef, float %d, i32 0
  %broadcast.splat25 = shufflevector <4 x float> %broadcast.splatinsert24, <4 x float> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert26 = insertelement <4 x float> undef, float %d, i32 0
  %broadcast.splat27 = shufflevector <4 x float> %broadcast.splatinsert26, <4 x float> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert28 = insertelement <4 x float> undef, float %d, i32 0
  %broadcast.splat29 = shufflevector <4 x float> %broadcast.splatinsert28, <4 x float> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert30 = insertelement <4 x float> undef, float %d, i32 0
  %broadcast.splat31 = shufflevector <4 x float> %broadcast.splatinsert30, <4 x float> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert32 = insertelement <4 x float> undef, float %d, i32 0
  %broadcast.splat33 = shufflevector <4 x float> %broadcast.splatinsert32, <4 x float> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert34 = insertelement <4 x float> undef, float %d, i32 0
  %broadcast.splat35 = shufflevector <4 x float> %broadcast.splatinsert34, <4 x float> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert36 = insertelement <4 x float> undef, float %d, i32 0
  %broadcast.splat37 = shufflevector <4 x float> %broadcast.splatinsert36, <4 x float> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert38 = insertelement <4 x float> undef, float %d, i32 0
  %broadcast.splat39 = shufflevector <4 x float> %broadcast.splatinsert38, <4 x float> undef, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next.1, %vector.body ]
  %0 = getelementptr inbounds float, ptr %data, i64 %index
  store <4 x float> %broadcast.splat17, ptr %0, align 4
  %1 = getelementptr inbounds float, ptr %0, i64 4
  store <4 x float> %broadcast.splat19, ptr %1, align 4
  %2 = getelementptr inbounds float, ptr %0, i64 8
  store <4 x float> %broadcast.splat21, ptr %2, align 4
  %3 = getelementptr inbounds float, ptr %0, i64 12
  store <4 x float> %broadcast.splat23, ptr %3, align 4
  %4 = getelementptr inbounds float, ptr %0, i64 16
  store <4 x float> %broadcast.splat25, ptr %4, align 4
  %5 = getelementptr inbounds float, ptr %0, i64 20
  store <4 x float> %broadcast.splat27, ptr %5, align 4
  %6 = getelementptr inbounds float, ptr %0, i64 24
  store <4 x float> %broadcast.splat29, ptr %6, align 4
  %7 = getelementptr inbounds float, ptr %0, i64 28
  store <4 x float> %broadcast.splat31, ptr %7, align 4
  %8 = getelementptr inbounds float, ptr %0, i64 32
  store <4 x float> %broadcast.splat33, ptr %8, align 4
  %9 = getelementptr inbounds float, ptr %0, i64 36
  store <4 x float> %broadcast.splat35, ptr %9, align 4
  %10 = getelementptr inbounds float, ptr %0, i64 40
  store <4 x float> %broadcast.splat37, ptr %10, align 4
  %11 = getelementptr inbounds float, ptr %0, i64 44
  store <4 x float> %broadcast.splat39, ptr %11, align 4
  %index.next = add nuw nsw i64 %index, 48
  %12 = getelementptr inbounds float, ptr %data, i64 %index.next
  store <4 x float> %broadcast.splat17, ptr %12, align 4
  %13 = getelementptr inbounds float, ptr %12, i64 4
  store <4 x float> %broadcast.splat19, ptr %13, align 4
  %14 = getelementptr inbounds float, ptr %12, i64 8
  store <4 x float> %broadcast.splat21, ptr %14, align 4
  %15 = getelementptr inbounds float, ptr %12, i64 12
  store <4 x float> %broadcast.splat23, ptr %15, align 4
  %16 = getelementptr inbounds float, ptr %12, i64 16
  store <4 x float> %broadcast.splat25, ptr %16, align 4
  %17 = getelementptr inbounds float, ptr %12, i64 20
  store <4 x float> %broadcast.splat27, ptr %17, align 4
  %18 = getelementptr inbounds float, ptr %12, i64 24
  store <4 x float> %broadcast.splat29, ptr %18, align 4
  %19 = getelementptr inbounds float, ptr %12, i64 28
  store <4 x float> %broadcast.splat31, ptr %19, align 4
  %20 = getelementptr inbounds float, ptr %12, i64 32
  store <4 x float> %broadcast.splat33, ptr %20, align 4
  %21 = getelementptr inbounds float, ptr %12, i64 36
  store <4 x float> %broadcast.splat35, ptr %21, align 4
  %22 = getelementptr inbounds float, ptr %12, i64 40
  store <4 x float> %broadcast.splat37, ptr %22, align 4
  %23 = getelementptr inbounds float, ptr %12, i64 44
  store <4 x float> %broadcast.splat39, ptr %23, align 4
  %index.next.1 = add nuw nsw i64 %index, 96
  %24 = icmp eq i64 %index.next.1, 7968
  br i1 %24, label %for.body, label %vector.body

for.body:                                         ; preds = %vector.body
  %arrayidx = getelementptr inbounds float, ptr %data, i64 7968
  store float %d, ptr %arrayidx, align 4
  %arrayidx.1 = getelementptr inbounds float, ptr %data, i64 7969
  store float %d, ptr %arrayidx.1, align 4
  %arrayidx.2 = getelementptr inbounds float, ptr %data, i64 7970
  store float %d, ptr %arrayidx.2, align 4
  %arrayidx.3 = getelementptr inbounds float, ptr %data, i64 7971
  store float %d, ptr %arrayidx.3, align 4
  %arrayidx.4 = getelementptr inbounds float, ptr %data, i64 7972
  store float %d, ptr %arrayidx.4, align 4
  %arrayidx.5 = getelementptr inbounds float, ptr %data, i64 7973
  store float %d, ptr %arrayidx.5, align 4
  %arrayidx.6 = getelementptr inbounds float, ptr %data, i64 7974
  store float %d, ptr %arrayidx.6, align 4
  %arrayidx.7 = getelementptr inbounds float, ptr %data, i64 7975
  store float %d, ptr %arrayidx.7, align 4
  %arrayidx.8 = getelementptr inbounds float, ptr %data, i64 7976
  store float %d, ptr %arrayidx.8, align 4
  %arrayidx.9 = getelementptr inbounds float, ptr %data, i64 7977
  store float %d, ptr %arrayidx.9, align 4
  %arrayidx.10 = getelementptr inbounds float, ptr %data, i64 7978
  store float %d, ptr %arrayidx.10, align 4
  %arrayidx.11 = getelementptr inbounds float, ptr %data, i64 7979
  store float %d, ptr %arrayidx.11, align 4
  %arrayidx.12 = getelementptr inbounds float, ptr %data, i64 7980
  store float %d, ptr %arrayidx.12, align 4
  %arrayidx.13 = getelementptr inbounds float, ptr %data, i64 7981
  store float %d, ptr %arrayidx.13, align 4
  %arrayidx.14 = getelementptr inbounds float, ptr %data, i64 7982
  store float %d, ptr %arrayidx.14, align 4
  %arrayidx.15 = getelementptr inbounds float, ptr %data, i64 7983
  store float %d, ptr %arrayidx.15, align 4
  %arrayidx.16 = getelementptr inbounds float, ptr %data, i64 7984
  store float %d, ptr %arrayidx.16, align 4
  %arrayidx.17 = getelementptr inbounds float, ptr %data, i64 7985
  store float %d, ptr %arrayidx.17, align 4
  %arrayidx.18 = getelementptr inbounds float, ptr %data, i64 7986
  store float %d, ptr %arrayidx.18, align 4
  %arrayidx.19 = getelementptr inbounds float, ptr %data, i64 7987
  store float %d, ptr %arrayidx.19, align 4
  %arrayidx.20 = getelementptr inbounds float, ptr %data, i64 7988
  store float %d, ptr %arrayidx.20, align 4
  %arrayidx.21 = getelementptr inbounds float, ptr %data, i64 7989
  store float %d, ptr %arrayidx.21, align 4
  %arrayidx.22 = getelementptr inbounds float, ptr %data, i64 7990
  store float %d, ptr %arrayidx.22, align 4
  %arrayidx.23 = getelementptr inbounds float, ptr %data, i64 7991
  store float %d, ptr %arrayidx.23, align 4
  %arrayidx.24 = getelementptr inbounds float, ptr %data, i64 7992
  store float %d, ptr %arrayidx.24, align 4
  %arrayidx.25 = getelementptr inbounds float, ptr %data, i64 7993
  store float %d, ptr %arrayidx.25, align 4
  %arrayidx.26 = getelementptr inbounds float, ptr %data, i64 7994
  store float %d, ptr %arrayidx.26, align 4
  %arrayidx.27 = getelementptr inbounds float, ptr %data, i64 7995
  store float %d, ptr %arrayidx.27, align 4
  %arrayidx.28 = getelementptr inbounds float, ptr %data, i64 7996
  store float %d, ptr %arrayidx.28, align 4
  %arrayidx.29 = getelementptr inbounds float, ptr %data, i64 7997
  store float %d, ptr %arrayidx.29, align 4
  %arrayidx.30 = getelementptr inbounds float, ptr %data, i64 7998
  store float %d, ptr %arrayidx.30, align 4
  %arrayidx.31 = getelementptr inbounds float, ptr %data, i64 7999
  store float %d, ptr %arrayidx.31, align 4
  ret void
}
