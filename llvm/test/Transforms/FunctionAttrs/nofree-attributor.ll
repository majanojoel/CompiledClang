; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes
; RUN: opt -passes=function-attrs --aa-pipeline=basic-aa --disable-nofree-inference=false -S < %s | FileCheck %s --check-prefix=FNATTR

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

; Test cases specifically designed for the "nofree" function attribute.
; We use FIXME's to indicate problems and missing attributes.

; Free functions
declare void @free(ptr nocapture) local_unnamed_addr #1
declare noalias ptr @realloc(ptr nocapture, i64) local_unnamed_addr #0
declare void @_ZdaPv(ptr) local_unnamed_addr #2


; TEST 1 (positive case)
define void @only_return() #0 {
; FNATTR: Function Attrs: mustprogress nofree noinline norecurse nosync nounwind readnone willreturn uwtable
; FNATTR-LABEL: define {{[^@]+}}@only_return
; FNATTR-SAME: () #[[ATTR3:[0-9]+]] {
; FNATTR-NEXT:    ret void
;
  ret void
}


; TEST 2 (negative case)
; Only free
; void only_free(char* p) {
;    free(p);
; }

define void @only_free(ptr nocapture %0) local_unnamed_addr #0 {
; FNATTR: Function Attrs: noinline nounwind uwtable
; FNATTR-LABEL: define {{[^@]+}}@only_free
; FNATTR-SAME: (ptr nocapture [[TMP0:%.*]]) local_unnamed_addr #[[ATTR1:[0-9]+]] {
; FNATTR-NEXT:    tail call void @free(ptr [[TMP0]]) #[[ATTR0:[0-9]+]]
; FNATTR-NEXT:    ret void
;
  tail call void @free(ptr %0) #1
  ret void
}


; TEST 3 (negative case)
; Free occurs in same scc.
; void free_in_scc1(char*p){
;    free_in_scc2(p);
; }
; void free_in_scc2(char*p){
;    free_in_scc1(p);
;    free(p);
; }

define void @free_in_scc1(ptr nocapture %0) local_unnamed_addr #0 {
; FNATTR: Function Attrs: noinline nounwind uwtable
; FNATTR-LABEL: define {{[^@]+}}@free_in_scc1
; FNATTR-SAME: (ptr nocapture [[TMP0:%.*]]) local_unnamed_addr #[[ATTR1]] {
; FNATTR-NEXT:    tail call void @free_in_scc2(ptr [[TMP0]]) #[[ATTR0]]
; FNATTR-NEXT:    ret void
;
  tail call void @free_in_scc2(ptr %0) #1
  ret void
}

define void @free_in_scc2(ptr nocapture %0) local_unnamed_addr #0 {
; FNATTR: Function Attrs: noinline nounwind uwtable
; FNATTR-LABEL: define {{[^@]+}}@free_in_scc2
; FNATTR-SAME: (ptr nocapture [[TMP0:%.*]]) local_unnamed_addr #[[ATTR1]] {
; FNATTR-NEXT:    [[CMP:%.*]] = icmp eq ptr [[TMP0]], null
; FNATTR-NEXT:    br i1 [[CMP]], label [[REC:%.*]], label [[CALL:%.*]]
; FNATTR:       call:
; FNATTR-NEXT:    tail call void @free(ptr [[TMP0]]) #[[ATTR0]]
; FNATTR-NEXT:    br label [[END:%.*]]
; FNATTR:       rec:
; FNATTR-NEXT:    tail call void @free_in_scc1(ptr [[TMP0]])
; FNATTR-NEXT:    br label [[END]]
; FNATTR:       end:
; FNATTR-NEXT:    ret void
;
  %cmp = icmp eq ptr %0, null
  br i1 %cmp, label %rec, label %call
call:
  tail call void @free(ptr %0) #1
  br label %end
rec:
  tail call void @free_in_scc1(ptr %0)
  br label %end
end:
  ret void
}


; TEST 4 (positive case)
; Free doesn't occur.
; void mutual_recursion1(){
;    mutual_recursion2();
; }
; void mutual_recursion2(){
;     mutual_recursion1();
; }


define void @mutual_recursion1() #0 {
; FNATTR: Function Attrs: nofree noinline nosync nounwind readnone uwtable
; FNATTR-LABEL: define {{[^@]+}}@mutual_recursion1
; FNATTR-SAME: () #[[ATTR4:[0-9]+]] {
; FNATTR-NEXT:    call void @mutual_recursion2()
; FNATTR-NEXT:    ret void
;
  call void @mutual_recursion2()
  ret void
}

define void @mutual_recursion2() #0 {
; FNATTR: Function Attrs: nofree noinline nosync nounwind readnone uwtable
; FNATTR-LABEL: define {{[^@]+}}@mutual_recursion2
; FNATTR-SAME: () #[[ATTR4]] {
; FNATTR-NEXT:    call void @mutual_recursion1()
; FNATTR-NEXT:    ret void
;
  call void @mutual_recursion1()
  ret void
}


; TEST 5
; C++ delete operation (negative case)
; void delete_op (char p[]){
;     delete [] p;
; }

define void @_Z9delete_opPc(ptr %0) local_unnamed_addr #0 {
; FNATTR: Function Attrs: noinline nounwind uwtable
; FNATTR-LABEL: define {{[^@]+}}@_Z9delete_opPc
; FNATTR-SAME: (ptr [[TMP0:%.*]]) local_unnamed_addr #[[ATTR1]] {
; FNATTR-NEXT:    [[TMP2:%.*]] = icmp eq ptr [[TMP0]], null
; FNATTR-NEXT:    br i1 [[TMP2]], label [[TMP4:%.*]], label [[TMP3:%.*]]
; FNATTR:       3:
; FNATTR-NEXT:    tail call void @_ZdaPv(ptr nonnull [[TMP0]]) #[[ATTR2:[0-9]+]]
; FNATTR-NEXT:    br label [[TMP4]]
; FNATTR:       4:
; FNATTR-NEXT:    ret void
;
  %2 = icmp eq ptr %0, null
  br i1 %2, label %4, label %3

; <label>:3:                                      ; preds = %1
  tail call void @_ZdaPv(ptr nonnull %0) #2
  br label %4

; <label>:4:                                      ; preds = %3, %1
  ret void
}


; TEST 6 (negative case)
; Call realloc
define noalias ptr @call_realloc(ptr nocapture %0, i64 %1) local_unnamed_addr #0 {
; FNATTR: Function Attrs: noinline nounwind uwtable
; FNATTR-LABEL: define {{[^@]+}}@call_realloc
; FNATTR-SAME: (ptr nocapture [[TMP0:%.*]], i64 [[TMP1:%.*]]) local_unnamed_addr #[[ATTR1]] {
; FNATTR-NEXT:    [[RET:%.*]] = tail call ptr @realloc(ptr [[TMP0]], i64 [[TMP1]]) #[[ATTR2]]
; FNATTR-NEXT:    ret ptr [[RET]]
;
  %ret = tail call ptr @realloc(ptr %0, i64 %1) #2
  ret ptr %ret
}


; TEST 7 (positive case)
; Call function declaration with "nofree"


declare void @nofree_function() nofree readnone #0

define void @call_nofree_function() #0 {
; FNATTR: Function Attrs: nofree noinline nosync nounwind readnone uwtable
; FNATTR-LABEL: define {{[^@]+}}@call_nofree_function
; FNATTR-SAME: () #[[ATTR4]] {
; FNATTR-NEXT:    tail call void @nofree_function()
; FNATTR-NEXT:    ret void
;
  tail call void @nofree_function()
  ret void
}

; TEST 8 (negative case)
; Call function declaration without "nofree"


declare void @maybe_free() #0


define void @call_maybe_free() #0 {
; FNATTR: Function Attrs: noinline nounwind uwtable
; FNATTR-LABEL: define {{[^@]+}}@call_maybe_free
; FNATTR-SAME: () #[[ATTR1]] {
; FNATTR-NEXT:    tail call void @maybe_free()
; FNATTR-NEXT:    ret void
;
  tail call void @maybe_free()
  ret void
}


; TEST 9 (negative case)
; Call both of above functions

define void @call_both() #0 {
; FNATTR: Function Attrs: noinline nounwind uwtable
; FNATTR-LABEL: define {{[^@]+}}@call_both
; FNATTR-SAME: () #[[ATTR1]] {
; FNATTR-NEXT:    tail call void @maybe_free()
; FNATTR-NEXT:    tail call void @nofree_function()
; FNATTR-NEXT:    ret void
;
  tail call void @maybe_free()
  tail call void @nofree_function()
  ret void
}


; TEST 10 (positive case)
; Call intrinsic function
declare float @llvm.floor.f32(float)

define void @call_floor(float %a) #0 {
; FNATTR: Function Attrs: mustprogress nofree noinline nosync nounwind readnone willreturn uwtable
; FNATTR-LABEL: define {{[^@]+}}@call_floor
; FNATTR-SAME: (float [[A:%.*]]) #[[ATTR7:[0-9]+]] {
; FNATTR-NEXT:    [[TMP1:%.*]] = tail call float @llvm.floor.f32(float [[A]])
; FNATTR-NEXT:    ret void
;
  tail call float @llvm.floor.f32(float %a)
  ret void
}

; TEST 11 (positive case)
; Check propagation.

define void @f1() #0 {
; FNATTR: Function Attrs: nofree noinline nosync nounwind readnone uwtable
; FNATTR-LABEL: define {{[^@]+}}@f1
; FNATTR-SAME: () #[[ATTR4]] {
; FNATTR-NEXT:    tail call void @nofree_function()
; FNATTR-NEXT:    ret void
;
  tail call void @nofree_function()
  ret void
}

define void @f2() #0 {
; FNATTR: Function Attrs: nofree noinline nosync nounwind readnone uwtable
; FNATTR-LABEL: define {{[^@]+}}@f2
; FNATTR-SAME: () #[[ATTR4]] {
; FNATTR-NEXT:    tail call void @f1()
; FNATTR-NEXT:    ret void
;
  tail call void @f1()
  ret void
}


declare noalias ptr @malloc(i64)

attributes #0 = { nounwind uwtable noinline }
attributes #1 = { nounwind }
attributes #2 = { nobuiltin nounwind }