; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -ppc-asm-full-reg-names \
; RUN:   -mtriple=powerpc64le-unknown-linux-gnu -mattr=+altivec \
; RUN:   -mattr=-power8-vector -mattr=-vsx < %s 2>&1 | FileCheck %s

@Global = dso_local global i32 55, align 4

define dso_local void @test(float %0) local_unnamed_addr {
; CHECK-LABEL: test:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fctiwz f0, f1
; CHECK-NEXT:    addi r3, r1, -4
; CHECK-NEXT:    addis r4, r2, Global@toc@ha
; CHECK-NEXT:    stfiwx f0, 0, r3
; CHECK-NEXT:    lwz r3, -4(r1)
; CHECK-NEXT:    stw r3, Global@toc@l(r4)
; CHECK-NEXT:    blr
entry:
  %1 = fptosi float %0 to i32
  store i32 %1, ptr @Global, align 4
  ret void
}
