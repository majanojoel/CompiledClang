; Test strict 128-bit floating-point division.
;
; RUN: llc < %s -mtriple=s390x-linux-gnu | FileCheck %s

declare fp128 @llvm.experimental.constrained.fdiv.f128(fp128, fp128, metadata, metadata)
declare fp128 @llvm.experimental.constrained.fpext.f128.f32(float, metadata)

; There is no memory form of 128-bit division.
define void @f1(ptr %ptr, float %f2) strictfp {
; CHECK-LABEL: f1:
; CHECK-DAG: lxebr %f0, %f0
; CHECK-DAG: ld %f1, 0(%r2)
; CHECK-DAG: ld %f3, 8(%r2)
; CHECK: dxbr %f1, %f0
; CHECK: std %f1, 0(%r2)
; CHECK: std %f3, 8(%r2)
; CHECK: br %r14
  %f1 = load fp128, ptr %ptr
  %f2x = call fp128 @llvm.experimental.constrained.fpext.f128.f32(float %f2,
                                               metadata !"fpexcept.strict") #0
  %sum = call fp128 @llvm.experimental.constrained.fdiv.f128(
                        fp128 %f1, fp128 %f2x,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict") #0
  store fp128 %sum, ptr %ptr
  ret void
}

attributes #0 = { strictfp }
