; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sme -verify-machineinstrs < %s | FileCheck %s


define void @zero() {
; CHECK-LABEL: zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    zero {}
; CHECK-NEXT:    zero {za0.d}
; CHECK-NEXT:    zero {za1.d}
; CHECK-NEXT:    zero {za0.d, za1.d}
; CHECK-NEXT:    zero {za2.d}
; CHECK-NEXT:    zero {za0.d, za2.d}
; CHECK-NEXT:    zero {za1.d, za2.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d}
; CHECK-NEXT:    zero {za3.d}
; CHECK-NEXT:    zero {za0.d, za3.d}
; CHECK-NEXT:    zero {za1.d, za3.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za3.d}
; CHECK-NEXT:    zero {za2.d, za3.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za3.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za3.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za3.d}
; CHECK-NEXT:    zero {za4.d}
; CHECK-NEXT:    zero {za0.s}
; CHECK-NEXT:    zero {za1.d, za4.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za4.d}
; CHECK-NEXT:    zero {za2.d, za4.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za4.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za4.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za4.d}
; CHECK-NEXT:    zero {za3.d, za4.d}
; CHECK-NEXT:    zero {za0.d, za3.d, za4.d}
; CHECK-NEXT:    zero {za1.d, za3.d, za4.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za3.d, za4.d}
; CHECK-NEXT:    zero {za2.d, za3.d, za4.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za3.d, za4.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za3.d, za4.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za3.d, za4.d}
; CHECK-NEXT:    zero {za5.d}
; CHECK-NEXT:    zero {za0.d, za5.d}
; CHECK-NEXT:    zero {za1.s}
; CHECK-NEXT:    zero {za0.d, za1.d, za5.d}
; CHECK-NEXT:    zero {za2.d, za5.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za5.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za5.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za5.d}
; CHECK-NEXT:    zero {za3.d, za5.d}
; CHECK-NEXT:    zero {za0.d, za3.d, za5.d}
; CHECK-NEXT:    zero {za1.d, za3.d, za5.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za3.d, za5.d}
; CHECK-NEXT:    zero {za2.d, za3.d, za5.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za3.d, za5.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za3.d, za5.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za3.d, za5.d}
; CHECK-NEXT:    zero {za4.d, za5.d}
; CHECK-NEXT:    zero {za0.d, za4.d, za5.d}
; CHECK-NEXT:    zero {za1.d, za4.d, za5.d}
; CHECK-NEXT:    zero {za0.s,za1.s}
; CHECK-NEXT:    zero {za2.d, za4.d, za5.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za4.d, za5.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za4.d, za5.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za4.d, za5.d}
; CHECK-NEXT:    zero {za3.d, za4.d, za5.d}
; CHECK-NEXT:    zero {za0.d, za3.d, za4.d, za5.d}
; CHECK-NEXT:    zero {za1.d, za3.d, za4.d, za5.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za3.d, za4.d, za5.d}
; CHECK-NEXT:    zero {za2.d, za3.d, za4.d, za5.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za3.d, za4.d, za5.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za3.d, za4.d, za5.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za3.d, za4.d, za5.d}
; CHECK-NEXT:    zero {za6.d}
; CHECK-NEXT:    zero {za0.d, za6.d}
; CHECK-NEXT:    zero {za1.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za6.d}
; CHECK-NEXT:    zero {za2.s}
; CHECK-NEXT:    zero {za0.d, za2.d, za6.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za6.d}
; CHECK-NEXT:    zero {za3.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za3.d, za6.d}
; CHECK-NEXT:    zero {za1.d, za3.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za3.d, za6.d}
; CHECK-NEXT:    zero {za2.d, za3.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za3.d, za6.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za3.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za3.d, za6.d}
; CHECK-NEXT:    zero {za4.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za4.d, za6.d}
; CHECK-NEXT:    zero {za1.d, za4.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za4.d, za6.d}
; CHECK-NEXT:    zero {za2.d, za4.d, za6.d}
; CHECK-NEXT:    zero {za0.h}
; CHECK-NEXT:    zero {za1.d, za2.d, za4.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za4.d, za6.d}
; CHECK-NEXT:    zero {za3.d, za4.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za3.d, za4.d, za6.d}
; CHECK-NEXT:    zero {za1.d, za3.d, za4.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za3.d, za4.d, za6.d}
; CHECK-NEXT:    zero {za2.d, za3.d, za4.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za3.d, za4.d, za6.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za3.d, za4.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za3.d, za4.d, za6.d}
; CHECK-NEXT:    zero {za5.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za1.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za2.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za1.s,za2.s}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za3.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za3.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za1.d, za3.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za3.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za2.d, za3.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za3.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za3.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za3.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za4.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za4.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za1.d, za4.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za4.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za2.d, za4.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za4.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za4.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za0.s,za1.s,za2.s}
; CHECK-NEXT:    zero {za3.d, za4.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za3.d, za4.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za1.d, za3.d, za4.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za3.d, za4.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za2.d, za3.d, za4.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za3.d, za4.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za3.d, za4.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za3.d, za4.d, za5.d, za6.d}
; CHECK-NEXT:    zero {za7.d}
; CHECK-NEXT:    zero {za0.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za7.d}
; CHECK-NEXT:    zero {za2.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za7.d}
; CHECK-NEXT:    zero {za3.s}
; CHECK-NEXT:    zero {za0.d, za3.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za3.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za3.d, za7.d}
; CHECK-NEXT:    zero {za2.d, za3.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za3.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za3.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za3.d, za7.d}
; CHECK-NEXT:    zero {za4.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za4.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za4.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za4.d, za7.d}
; CHECK-NEXT:    zero {za2.d, za4.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za4.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za4.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za4.d, za7.d}
; CHECK-NEXT:    zero {za3.d, za4.d, za7.d}
; CHECK-NEXT:    zero {za0.s,za3.s}
; CHECK-NEXT:    zero {za1.d, za3.d, za4.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za3.d, za4.d, za7.d}
; CHECK-NEXT:    zero {za2.d, za3.d, za4.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za3.d, za4.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za3.d, za4.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za3.d, za4.d, za7.d}
; CHECK-NEXT:    zero {za5.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za2.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za3.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za3.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za1.h}
; CHECK-NEXT:    zero {za0.d, za1.d, za3.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za2.d, za3.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za3.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za3.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za3.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za4.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za4.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za4.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za4.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za2.d, za4.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za4.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za4.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za4.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za3.d, za4.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za3.d, za4.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za3.d, za4.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za0.s,za1.s,za3.s}
; CHECK-NEXT:    zero {za2.d, za3.d, za4.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za3.d, za4.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za3.d, za4.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za3.d, za4.d, za5.d, za7.d}
; CHECK-NEXT:    zero {za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za2.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za3.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za3.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za3.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za3.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za2.s,za3.s}
; CHECK-NEXT:    zero {za0.d, za2.d, za3.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za3.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za3.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za4.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za4.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za4.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za4.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za2.d, za4.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za4.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za4.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za4.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za3.d, za4.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za3.d, za4.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za3.d, za4.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za3.d, za4.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za2.d, za3.d, za4.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.s,za2.s,za3.s}
; CHECK-NEXT:    zero {za1.d, za2.d, za3.d, za4.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za3.d, za4.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za2.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za3.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za3.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za3.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za3.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za2.d, za3.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za3.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za1.s,za2.s,za3.s}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za3.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za4.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za4.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za4.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za4.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za2.d, za4.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za4.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za4.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za2.d, za4.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za3.d, za4.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za3.d, za4.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za3.d, za4.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za1.d, za3.d, za4.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za2.d, za3.d, za4.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za0.d, za2.d, za3.d, za4.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za1.d, za2.d, za3.d, za4.d, za5.d, za6.d, za7.d}
; CHECK-NEXT:    zero {za}
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.zero(i32 0)
  call void @llvm.aarch64.sme.zero(i32 1)
  call void @llvm.aarch64.sme.zero(i32 2)
  call void @llvm.aarch64.sme.zero(i32 3)
  call void @llvm.aarch64.sme.zero(i32 4)
  call void @llvm.aarch64.sme.zero(i32 5)
  call void @llvm.aarch64.sme.zero(i32 6)
  call void @llvm.aarch64.sme.zero(i32 7)
  call void @llvm.aarch64.sme.zero(i32 8)
  call void @llvm.aarch64.sme.zero(i32 9)
  call void @llvm.aarch64.sme.zero(i32 10)
  call void @llvm.aarch64.sme.zero(i32 11)
  call void @llvm.aarch64.sme.zero(i32 12)
  call void @llvm.aarch64.sme.zero(i32 13)
  call void @llvm.aarch64.sme.zero(i32 14)
  call void @llvm.aarch64.sme.zero(i32 15)
  call void @llvm.aarch64.sme.zero(i32 16)
  call void @llvm.aarch64.sme.zero(i32 17)
  call void @llvm.aarch64.sme.zero(i32 18)
  call void @llvm.aarch64.sme.zero(i32 19)
  call void @llvm.aarch64.sme.zero(i32 20)
  call void @llvm.aarch64.sme.zero(i32 21)
  call void @llvm.aarch64.sme.zero(i32 22)
  call void @llvm.aarch64.sme.zero(i32 23)
  call void @llvm.aarch64.sme.zero(i32 24)
  call void @llvm.aarch64.sme.zero(i32 25)
  call void @llvm.aarch64.sme.zero(i32 26)
  call void @llvm.aarch64.sme.zero(i32 27)
  call void @llvm.aarch64.sme.zero(i32 28)
  call void @llvm.aarch64.sme.zero(i32 29)
  call void @llvm.aarch64.sme.zero(i32 30)
  call void @llvm.aarch64.sme.zero(i32 31)
  call void @llvm.aarch64.sme.zero(i32 32)
  call void @llvm.aarch64.sme.zero(i32 33)
  call void @llvm.aarch64.sme.zero(i32 34)
  call void @llvm.aarch64.sme.zero(i32 35)
  call void @llvm.aarch64.sme.zero(i32 36)
  call void @llvm.aarch64.sme.zero(i32 37)
  call void @llvm.aarch64.sme.zero(i32 38)
  call void @llvm.aarch64.sme.zero(i32 39)
  call void @llvm.aarch64.sme.zero(i32 40)
  call void @llvm.aarch64.sme.zero(i32 41)
  call void @llvm.aarch64.sme.zero(i32 42)
  call void @llvm.aarch64.sme.zero(i32 43)
  call void @llvm.aarch64.sme.zero(i32 44)
  call void @llvm.aarch64.sme.zero(i32 45)
  call void @llvm.aarch64.sme.zero(i32 46)
  call void @llvm.aarch64.sme.zero(i32 47)
  call void @llvm.aarch64.sme.zero(i32 48)
  call void @llvm.aarch64.sme.zero(i32 49)
  call void @llvm.aarch64.sme.zero(i32 50)
  call void @llvm.aarch64.sme.zero(i32 51)
  call void @llvm.aarch64.sme.zero(i32 52)
  call void @llvm.aarch64.sme.zero(i32 53)
  call void @llvm.aarch64.sme.zero(i32 54)
  call void @llvm.aarch64.sme.zero(i32 55)
  call void @llvm.aarch64.sme.zero(i32 56)
  call void @llvm.aarch64.sme.zero(i32 57)
  call void @llvm.aarch64.sme.zero(i32 58)
  call void @llvm.aarch64.sme.zero(i32 59)
  call void @llvm.aarch64.sme.zero(i32 60)
  call void @llvm.aarch64.sme.zero(i32 61)
  call void @llvm.aarch64.sme.zero(i32 62)
  call void @llvm.aarch64.sme.zero(i32 63)
  call void @llvm.aarch64.sme.zero(i32 64)
  call void @llvm.aarch64.sme.zero(i32 65)
  call void @llvm.aarch64.sme.zero(i32 66)
  call void @llvm.aarch64.sme.zero(i32 67)
  call void @llvm.aarch64.sme.zero(i32 68)
  call void @llvm.aarch64.sme.zero(i32 69)
  call void @llvm.aarch64.sme.zero(i32 70)
  call void @llvm.aarch64.sme.zero(i32 71)
  call void @llvm.aarch64.sme.zero(i32 72)
  call void @llvm.aarch64.sme.zero(i32 73)
  call void @llvm.aarch64.sme.zero(i32 74)
  call void @llvm.aarch64.sme.zero(i32 75)
  call void @llvm.aarch64.sme.zero(i32 76)
  call void @llvm.aarch64.sme.zero(i32 77)
  call void @llvm.aarch64.sme.zero(i32 78)
  call void @llvm.aarch64.sme.zero(i32 79)
  call void @llvm.aarch64.sme.zero(i32 80)
  call void @llvm.aarch64.sme.zero(i32 81)
  call void @llvm.aarch64.sme.zero(i32 82)
  call void @llvm.aarch64.sme.zero(i32 83)
  call void @llvm.aarch64.sme.zero(i32 84)
  call void @llvm.aarch64.sme.zero(i32 85)
  call void @llvm.aarch64.sme.zero(i32 86)
  call void @llvm.aarch64.sme.zero(i32 87)
  call void @llvm.aarch64.sme.zero(i32 88)
  call void @llvm.aarch64.sme.zero(i32 89)
  call void @llvm.aarch64.sme.zero(i32 90)
  call void @llvm.aarch64.sme.zero(i32 91)
  call void @llvm.aarch64.sme.zero(i32 92)
  call void @llvm.aarch64.sme.zero(i32 93)
  call void @llvm.aarch64.sme.zero(i32 94)
  call void @llvm.aarch64.sme.zero(i32 95)
  call void @llvm.aarch64.sme.zero(i32 96)
  call void @llvm.aarch64.sme.zero(i32 97)
  call void @llvm.aarch64.sme.zero(i32 98)
  call void @llvm.aarch64.sme.zero(i32 99)
  call void @llvm.aarch64.sme.zero(i32 100)
  call void @llvm.aarch64.sme.zero(i32 101)
  call void @llvm.aarch64.sme.zero(i32 102)
  call void @llvm.aarch64.sme.zero(i32 103)
  call void @llvm.aarch64.sme.zero(i32 104)
  call void @llvm.aarch64.sme.zero(i32 105)
  call void @llvm.aarch64.sme.zero(i32 106)
  call void @llvm.aarch64.sme.zero(i32 107)
  call void @llvm.aarch64.sme.zero(i32 108)
  call void @llvm.aarch64.sme.zero(i32 109)
  call void @llvm.aarch64.sme.zero(i32 110)
  call void @llvm.aarch64.sme.zero(i32 111)
  call void @llvm.aarch64.sme.zero(i32 112)
  call void @llvm.aarch64.sme.zero(i32 113)
  call void @llvm.aarch64.sme.zero(i32 114)
  call void @llvm.aarch64.sme.zero(i32 115)
  call void @llvm.aarch64.sme.zero(i32 116)
  call void @llvm.aarch64.sme.zero(i32 117)
  call void @llvm.aarch64.sme.zero(i32 118)
  call void @llvm.aarch64.sme.zero(i32 119)
  call void @llvm.aarch64.sme.zero(i32 120)
  call void @llvm.aarch64.sme.zero(i32 121)
  call void @llvm.aarch64.sme.zero(i32 122)
  call void @llvm.aarch64.sme.zero(i32 123)
  call void @llvm.aarch64.sme.zero(i32 124)
  call void @llvm.aarch64.sme.zero(i32 125)
  call void @llvm.aarch64.sme.zero(i32 126)
  call void @llvm.aarch64.sme.zero(i32 127)
  call void @llvm.aarch64.sme.zero(i32 128)
  call void @llvm.aarch64.sme.zero(i32 129)
  call void @llvm.aarch64.sme.zero(i32 130)
  call void @llvm.aarch64.sme.zero(i32 131)
  call void @llvm.aarch64.sme.zero(i32 132)
  call void @llvm.aarch64.sme.zero(i32 133)
  call void @llvm.aarch64.sme.zero(i32 134)
  call void @llvm.aarch64.sme.zero(i32 135)
  call void @llvm.aarch64.sme.zero(i32 136)
  call void @llvm.aarch64.sme.zero(i32 137)
  call void @llvm.aarch64.sme.zero(i32 138)
  call void @llvm.aarch64.sme.zero(i32 139)
  call void @llvm.aarch64.sme.zero(i32 140)
  call void @llvm.aarch64.sme.zero(i32 141)
  call void @llvm.aarch64.sme.zero(i32 142)
  call void @llvm.aarch64.sme.zero(i32 143)
  call void @llvm.aarch64.sme.zero(i32 144)
  call void @llvm.aarch64.sme.zero(i32 145)
  call void @llvm.aarch64.sme.zero(i32 146)
  call void @llvm.aarch64.sme.zero(i32 147)
  call void @llvm.aarch64.sme.zero(i32 148)
  call void @llvm.aarch64.sme.zero(i32 149)
  call void @llvm.aarch64.sme.zero(i32 150)
  call void @llvm.aarch64.sme.zero(i32 151)
  call void @llvm.aarch64.sme.zero(i32 152)
  call void @llvm.aarch64.sme.zero(i32 153)
  call void @llvm.aarch64.sme.zero(i32 154)
  call void @llvm.aarch64.sme.zero(i32 155)
  call void @llvm.aarch64.sme.zero(i32 156)
  call void @llvm.aarch64.sme.zero(i32 157)
  call void @llvm.aarch64.sme.zero(i32 158)
  call void @llvm.aarch64.sme.zero(i32 159)
  call void @llvm.aarch64.sme.zero(i32 160)
  call void @llvm.aarch64.sme.zero(i32 161)
  call void @llvm.aarch64.sme.zero(i32 162)
  call void @llvm.aarch64.sme.zero(i32 163)
  call void @llvm.aarch64.sme.zero(i32 164)
  call void @llvm.aarch64.sme.zero(i32 165)
  call void @llvm.aarch64.sme.zero(i32 166)
  call void @llvm.aarch64.sme.zero(i32 167)
  call void @llvm.aarch64.sme.zero(i32 168)
  call void @llvm.aarch64.sme.zero(i32 169)
  call void @llvm.aarch64.sme.zero(i32 170)
  call void @llvm.aarch64.sme.zero(i32 171)
  call void @llvm.aarch64.sme.zero(i32 172)
  call void @llvm.aarch64.sme.zero(i32 173)
  call void @llvm.aarch64.sme.zero(i32 174)
  call void @llvm.aarch64.sme.zero(i32 175)
  call void @llvm.aarch64.sme.zero(i32 176)
  call void @llvm.aarch64.sme.zero(i32 177)
  call void @llvm.aarch64.sme.zero(i32 178)
  call void @llvm.aarch64.sme.zero(i32 179)
  call void @llvm.aarch64.sme.zero(i32 180)
  call void @llvm.aarch64.sme.zero(i32 181)
  call void @llvm.aarch64.sme.zero(i32 182)
  call void @llvm.aarch64.sme.zero(i32 183)
  call void @llvm.aarch64.sme.zero(i32 184)
  call void @llvm.aarch64.sme.zero(i32 185)
  call void @llvm.aarch64.sme.zero(i32 186)
  call void @llvm.aarch64.sme.zero(i32 187)
  call void @llvm.aarch64.sme.zero(i32 188)
  call void @llvm.aarch64.sme.zero(i32 189)
  call void @llvm.aarch64.sme.zero(i32 190)
  call void @llvm.aarch64.sme.zero(i32 191)
  call void @llvm.aarch64.sme.zero(i32 192)
  call void @llvm.aarch64.sme.zero(i32 193)
  call void @llvm.aarch64.sme.zero(i32 194)
  call void @llvm.aarch64.sme.zero(i32 195)
  call void @llvm.aarch64.sme.zero(i32 196)
  call void @llvm.aarch64.sme.zero(i32 197)
  call void @llvm.aarch64.sme.zero(i32 198)
  call void @llvm.aarch64.sme.zero(i32 199)
  call void @llvm.aarch64.sme.zero(i32 200)
  call void @llvm.aarch64.sme.zero(i32 201)
  call void @llvm.aarch64.sme.zero(i32 202)
  call void @llvm.aarch64.sme.zero(i32 203)
  call void @llvm.aarch64.sme.zero(i32 204)
  call void @llvm.aarch64.sme.zero(i32 205)
  call void @llvm.aarch64.sme.zero(i32 206)
  call void @llvm.aarch64.sme.zero(i32 207)
  call void @llvm.aarch64.sme.zero(i32 208)
  call void @llvm.aarch64.sme.zero(i32 209)
  call void @llvm.aarch64.sme.zero(i32 210)
  call void @llvm.aarch64.sme.zero(i32 211)
  call void @llvm.aarch64.sme.zero(i32 212)
  call void @llvm.aarch64.sme.zero(i32 213)
  call void @llvm.aarch64.sme.zero(i32 214)
  call void @llvm.aarch64.sme.zero(i32 215)
  call void @llvm.aarch64.sme.zero(i32 216)
  call void @llvm.aarch64.sme.zero(i32 217)
  call void @llvm.aarch64.sme.zero(i32 218)
  call void @llvm.aarch64.sme.zero(i32 219)
  call void @llvm.aarch64.sme.zero(i32 220)
  call void @llvm.aarch64.sme.zero(i32 221)
  call void @llvm.aarch64.sme.zero(i32 222)
  call void @llvm.aarch64.sme.zero(i32 223)
  call void @llvm.aarch64.sme.zero(i32 224)
  call void @llvm.aarch64.sme.zero(i32 225)
  call void @llvm.aarch64.sme.zero(i32 226)
  call void @llvm.aarch64.sme.zero(i32 227)
  call void @llvm.aarch64.sme.zero(i32 228)
  call void @llvm.aarch64.sme.zero(i32 229)
  call void @llvm.aarch64.sme.zero(i32 230)
  call void @llvm.aarch64.sme.zero(i32 231)
  call void @llvm.aarch64.sme.zero(i32 232)
  call void @llvm.aarch64.sme.zero(i32 233)
  call void @llvm.aarch64.sme.zero(i32 234)
  call void @llvm.aarch64.sme.zero(i32 235)
  call void @llvm.aarch64.sme.zero(i32 236)
  call void @llvm.aarch64.sme.zero(i32 237)
  call void @llvm.aarch64.sme.zero(i32 238)
  call void @llvm.aarch64.sme.zero(i32 239)
  call void @llvm.aarch64.sme.zero(i32 240)
  call void @llvm.aarch64.sme.zero(i32 241)
  call void @llvm.aarch64.sme.zero(i32 242)
  call void @llvm.aarch64.sme.zero(i32 243)
  call void @llvm.aarch64.sme.zero(i32 244)
  call void @llvm.aarch64.sme.zero(i32 245)
  call void @llvm.aarch64.sme.zero(i32 246)
  call void @llvm.aarch64.sme.zero(i32 247)
  call void @llvm.aarch64.sme.zero(i32 248)
  call void @llvm.aarch64.sme.zero(i32 249)
  call void @llvm.aarch64.sme.zero(i32 250)
  call void @llvm.aarch64.sme.zero(i32 251)
  call void @llvm.aarch64.sme.zero(i32 252)
  call void @llvm.aarch64.sme.zero(i32 253)
  call void @llvm.aarch64.sme.zero(i32 254)
  call void @llvm.aarch64.sme.zero(i32 255)
  ret void
}

declare void @llvm.aarch64.sme.zero(i32)
