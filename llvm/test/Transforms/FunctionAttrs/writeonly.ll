; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes
; RUN: opt < %s -passes=function-attrs -S | FileCheck %s

define void @nouses-argworn-funrn(ptr writeonly %.aaa) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@nouses-argworn-funrn
; CHECK-SAME: (ptr nocapture readnone [[DOTAAA:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  nouses-argworn-funrn_entry:
; CHECK-NEXT:    ret void
;
nouses-argworn-funrn_entry:
  ret void
}

define void @nouses-argworn-funro(ptr writeonly %.aaa, ptr %.bbb) {
; CHECK: Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind readonly willreturn
; CHECK-LABEL: define {{[^@]+}}@nouses-argworn-funro
; CHECK-SAME: (ptr nocapture readnone [[DOTAAA:%.*]], ptr nocapture readonly [[DOTBBB:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:  nouses-argworn-funro_entry:
; CHECK-NEXT:    [[VAL:%.*]] = load i32, ptr [[DOTBBB]], align 4
; CHECK-NEXT:    ret void
;
nouses-argworn-funro_entry:
  %val = load i32 , ptr %.bbb
  ret void
}

%_type_of_d-ccc = type <{ ptr, i8, i8, i8, i8 }>

@d-ccc = internal global %_type_of_d-ccc <{ ptr null, i8 1, i8 13, i8 0, i8 -127 }>, align 8

define void @nouses-argworn-funwo(ptr writeonly %.aaa) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn writeonly
; CHECK-LABEL: define {{[^@]+}}@nouses-argworn-funwo
; CHECK-SAME: (ptr nocapture readnone [[DOTAAA:%.*]]) #[[ATTR2:[0-9]+]] {
; CHECK-NEXT:  nouses-argworn-funwo_entry:
; CHECK-NEXT:    store i8 0, ptr getelementptr inbounds ([[_TYPE_OF_D_CCC:%.*]], ptr @d-ccc, i32 0, i32 3), align 1
; CHECK-NEXT:    ret void
;
nouses-argworn-funwo_entry:
  store i8 0, ptr getelementptr inbounds (%_type_of_d-ccc, ptr @d-ccc, i32 0, i32 3)
  ret void
}

define void @test_store(ptr %p) {
; CHECK: Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn writeonly
; CHECK-LABEL: define {{[^@]+}}@test_store
; CHECK-SAME: (ptr nocapture writeonly [[P:%.*]]) #[[ATTR3:[0-9]+]] {
; CHECK-NEXT:    store i8 0, ptr [[P]], align 1
; CHECK-NEXT:    ret void
;
  store i8 0, ptr %p
  ret void
}

@G = external global ptr
define i8 @test_store_capture(ptr %p) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn
; CHECK-LABEL: define {{[^@]+}}@test_store_capture
; CHECK-SAME: (ptr [[P:%.*]]) #[[ATTR4:[0-9]+]] {
; CHECK-NEXT:    store ptr [[P]], ptr @G, align 8
; CHECK-NEXT:    [[P2:%.*]] = load ptr, ptr @G, align 8
; CHECK-NEXT:    [[V:%.*]] = load i8, ptr [[P2]], align 1
; CHECK-NEXT:    ret i8 [[V]]
;
  store ptr %p, ptr @G
  %p2 = load ptr, ptr @G
  %v = load i8, ptr %p2
  ret i8 %v
}

define void @test_addressing(ptr %p) {
; CHECK: Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn writeonly
; CHECK-LABEL: define {{[^@]+}}@test_addressing
; CHECK-SAME: (ptr nocapture writeonly [[P:%.*]]) #[[ATTR3]] {
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i8, ptr [[P]], i64 8
; CHECK-NEXT:    store i32 0, ptr [[GEP]], align 4
; CHECK-NEXT:    ret void
;
  %gep = getelementptr i8, ptr %p, i64 8
  store i32 0, ptr %gep
  ret void
}

define void @test_readwrite(ptr %p) {
; CHECK: Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn
; CHECK-LABEL: define {{[^@]+}}@test_readwrite
; CHECK-SAME: (ptr nocapture [[P:%.*]]) #[[ATTR5:[0-9]+]] {
; CHECK-NEXT:    [[V:%.*]] = load i8, ptr [[P]], align 1
; CHECK-NEXT:    store i8 [[V]], ptr [[P]], align 1
; CHECK-NEXT:    ret void
;
  %v = load i8, ptr %p
  store i8 %v, ptr %p
  ret void
}

define void @test_volatile(ptr %p) {
; CHECK: Function Attrs: inaccessiblemem_or_argmemonly nofree norecurse nounwind
; CHECK-LABEL: define {{[^@]+}}@test_volatile
; CHECK-SAME: (ptr [[P:%.*]]) #[[ATTR6:[0-9]+]] {
; CHECK-NEXT:    store volatile i8 0, ptr [[P]], align 1
; CHECK-NEXT:    ret void
;
  store volatile i8 0, ptr %p
  ret void
}

define void @test_atomicrmw(ptr %p) {
; CHECK: Function Attrs: argmemonly mustprogress nofree norecurse nounwind willreturn
; CHECK-LABEL: define {{[^@]+}}@test_atomicrmw
; CHECK-SAME: (ptr nocapture [[P:%.*]]) #[[ATTR7:[0-9]+]] {
; CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw add ptr [[P]], i8 0 seq_cst, align 1
; CHECK-NEXT:    ret void
;
  atomicrmw add ptr %p, i8 0  seq_cst
  ret void
}


declare void @direct1_callee(ptr %p)

define void @direct1(ptr %p) {
; CHECK-LABEL: define {{[^@]+}}@direct1
; CHECK-SAME: (ptr [[P:%.*]]) {
; CHECK-NEXT:    call void @direct1_callee(ptr [[P]])
; CHECK-NEXT:    ret void
;
  call void @direct1_callee(ptr %p)
  ret void
}

declare void @direct2_callee(ptr %p) writeonly

; writeonly w/o nocapture is not enough
define void @direct2(ptr %p) {
; CHECK: Function Attrs: writeonly
; CHECK-LABEL: define {{[^@]+}}@direct2
; CHECK-SAME: (ptr [[P:%.*]]) #[[ATTR8:[0-9]+]] {
; CHECK-NEXT:    call void @direct2_callee(ptr [[P]])
; CHECK-NEXT:    ret void
;
  call void @direct2_callee(ptr %p)
  ; read back from global, read through pointer...
  ret void
}

define void @direct2b(ptr %p) {
; CHECK: Function Attrs: writeonly
; CHECK-LABEL: define {{[^@]+}}@direct2b
; CHECK-SAME: (ptr nocapture writeonly [[P:%.*]]) #[[ATTR8]] {
; CHECK-NEXT:    call void @direct2_callee(ptr nocapture [[P]])
; CHECK-NEXT:    ret void
;
  call void @direct2_callee(ptr nocapture %p)
  ret void
}

declare void @direct3_callee(ptr nocapture writeonly %p)

define void @direct3(ptr %p) {
; CHECK-LABEL: define {{[^@]+}}@direct3
; CHECK-SAME: (ptr nocapture writeonly [[P:%.*]]) {
; CHECK-NEXT:    call void @direct3_callee(ptr [[P]])
; CHECK-NEXT:    ret void
;
  call void @direct3_callee(ptr %p)
  ret void
}

define void @direct3b(ptr %p) {
; CHECK-LABEL: define {{[^@]+}}@direct3b
; CHECK-SAME: (ptr [[P:%.*]]) {
; CHECK-NEXT:    call void @direct3_callee(ptr [[P]]) [ "may-read-and-capture"(ptr [[P]]) ]
; CHECK-NEXT:    ret void
;
  call void @direct3_callee(ptr %p) ["may-read-and-capture"(ptr %p)]
  ret void
}

define void @direct3c(ptr %p) {
; CHECK-LABEL: define {{[^@]+}}@direct3c
; CHECK-SAME: (ptr nocapture [[P:%.*]]) {
; CHECK-NEXT:    call void @direct3_callee(ptr [[P]]) [ "may-read"() ]
; CHECK-NEXT:    ret void
;
  call void @direct3_callee(ptr %p) ["may-read"()]
  ret void
}

define void @fptr_test1(ptr %p, ptr %f) {
; CHECK-LABEL: define {{[^@]+}}@fptr_test1
; CHECK-SAME: (ptr [[P:%.*]], ptr nocapture readonly [[F:%.*]]) {
; CHECK-NEXT:    call void [[F]](ptr [[P]])
; CHECK-NEXT:    ret void
;
  call void %f(ptr %p)
  ret void
}

define void @fptr_test2(ptr %p, ptr %f) {
; CHECK-LABEL: define {{[^@]+}}@fptr_test2
; CHECK-SAME: (ptr nocapture writeonly [[P:%.*]], ptr nocapture readonly [[F:%.*]]) {
; CHECK-NEXT:    call void [[F]](ptr nocapture writeonly [[P]])
; CHECK-NEXT:    ret void
;
  call void %f(ptr nocapture writeonly %p)
  ret void
}

define void @fptr_test3(ptr %p, ptr %f) {
; CHECK: Function Attrs: writeonly
; CHECK-LABEL: define {{[^@]+}}@fptr_test3
; CHECK-SAME: (ptr nocapture writeonly [[P:%.*]], ptr nocapture readonly [[F:%.*]]) #[[ATTR8]] {
; CHECK-NEXT:    call void [[F]](ptr nocapture [[P]]) #[[ATTR8]]
; CHECK-NEXT:    ret void
;
  call void %f(ptr nocapture %p) writeonly
  ret void
}