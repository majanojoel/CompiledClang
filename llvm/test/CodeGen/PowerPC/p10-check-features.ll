; RUN: llc -mattr=mma,isa-v31-instructions,pcrelative-memops,prefix-instrs,paired-vector-memops,rop-protect,privileged \
; RUN:   -mtriple=powerpc64le-unknown-unknown -ppc-asm-full-reg-names \
; RUN:   %s -o - 2>&1 | FileCheck %s
; RUN: llc -mattr=mma,isa-v31-instructions,pcrelative-memops,prefix-instrs,paired-vector-memops,rop-protect,privileged \
; RUN:   -mtriple=powerpc64-unknown-unknown -ppc-asm-full-reg-names \
; RUN:   %s -o - 2>&1 | FileCheck %s

define dso_local signext i32 @f() {
entry:
  ret i32 0
}

; Make sure that all of the features listed are recognized.
; CHECK-NOT:    is not a recognized feature for this target

; Make sure that the test was actually compiled.
; CHECK:        li r3, 0
; CHECK-NEXT:   blr
