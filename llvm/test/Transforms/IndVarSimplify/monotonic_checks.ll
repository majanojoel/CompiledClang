; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=indvars -S < %s | FileCheck %s

; Monotonic decrementing iv. we should be able to prove that %iv.next <s len
; basing on its nsw and the fact that its starting value <s len.
define i32 @test_01(i32* %p) {
; CHECK-LABEL: @test_01(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, i32* [[P:%.*]], align 4, [[RNG0:!range !.*]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[LEN]], [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[IV_NEXT]] = add nsw i32 [[IV]], -1
; CHECK-NEXT:    br i1 true, label [[BACKEDGE]], label [[FAIL:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    [[LOOP_COND:%.*]] = icmp ne i32 [[IV]], 0
; CHECK-NEXT:    br i1 [[LOOP_COND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       fail:
; CHECK-NEXT:    ret i32 -1
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
;
entry:
  %len = load i32, i32* %p, !range !0
  br label %loop

loop:
  %iv = phi i32 [%len, %entry], [%iv.next, %backedge]
  %iv.next = add i32 %iv, -1
  %rc = icmp slt i32 %iv.next, %len
  br i1 %rc, label %backedge, label %fail

backedge:
  %loop.cond = icmp ne i32 %iv, 0
  br i1 %loop.cond, label %loop, label %exit

fail:
  ret i32 -1

exit:
  ret i32 0
}

; We should not remove this range check because signed overflow is possible here (start at len = 0).
define i32 @test_01_neg(i32* %p) {
; CHECK-LABEL: @test_01_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, i32* [[P:%.*]], align 4, [[RNG0]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[LEN]], [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], -1
; CHECK-NEXT:    [[RC:%.*]] = icmp slt i32 [[IV_NEXT]], [[LEN]]
; CHECK-NEXT:    br i1 [[RC]], label [[BACKEDGE]], label [[FAIL:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    [[LOOP_COND:%.*]] = icmp ne i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[LOOP_COND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       fail:
; CHECK-NEXT:    ret i32 -1
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
;
entry:
  %len = load i32, i32* %p, !range !0
  br label %loop

loop:
  %iv = phi i32 [%len, %entry], [%iv.next, %backedge]
  %iv.next = add i32 %iv, -1
  %rc = icmp slt i32 %iv.next, %len
  br i1 %rc, label %backedge, label %fail

backedge:
  %loop.cond = icmp ne i32 %iv, 1
  br i1 %loop.cond, label %loop, label %exit

fail:
  ret i32 -1

exit:
  ret i32 0
}

; Monotonic incrementing iv. we should be able to prove that %iv.next >s len
; basing on its nsw and the fact that its starting value >s len.
define i32 @test_02(i32* %p) {
; CHECK-LABEL: @test_02(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, i32* [[P:%.*]], align 4, [[RNG1:!range !.*]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[LEN]], [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 true, label [[BACKEDGE]], label [[FAIL:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    [[LOOP_COND:%.*]] = icmp ne i32 [[IV]], 0
; CHECK-NEXT:    br i1 [[LOOP_COND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       fail:
; CHECK-NEXT:    ret i32 -1
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
;
entry:
  %len = load i32, i32* %p, !range !1
  br label %loop

loop:
  %iv = phi i32 [%len, %entry], [%iv.next, %backedge]
  %iv.next = add i32 %iv, 1
  %rc = icmp sgt i32 %iv.next, %len
  br i1 %rc, label %backedge, label %fail

backedge:
  %loop.cond = icmp ne i32 %iv, 0
  br i1 %loop.cond, label %loop, label %exit

fail:
  ret i32 -1

exit:
  ret i32 0
}

; We should not remove this range check because signed overflow is possible here (start at len = -1).
define i32 @test_02_neg(i32* %p) {
; CHECK-LABEL: @test_02_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, i32* [[P:%.*]], align 4, [[RNG1]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[LEN]], [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    [[RC:%.*]] = icmp sgt i32 [[IV_NEXT]], [[LEN]]
; CHECK-NEXT:    br i1 [[RC]], label [[BACKEDGE]], label [[FAIL:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    [[LOOP_COND:%.*]] = icmp ne i32 [[IV]], -2
; CHECK-NEXT:    br i1 [[LOOP_COND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       fail:
; CHECK-NEXT:    ret i32 -1
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
;
entry:
  %len = load i32, i32* %p, !range !1
  br label %loop

loop:
  %iv = phi i32 [%len, %entry], [%iv.next, %backedge]
  %iv.next = add i32 %iv, 1
  %rc = icmp sgt i32 %iv.next, %len
  br i1 %rc, label %backedge, label %fail

backedge:
  %loop.cond = icmp ne i32 %iv, -2
  br i1 %loop.cond, label %loop, label %exit

fail:
  ret i32 -1

exit:
  ret i32 0
}

define i32 @test_03(i32* %p) {
; CHECK-LABEL: @test_03(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, i32* [[P:%.*]], align 4, [[RNG2:!range !.*]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[LEN]], [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    br i1 true, label [[BACKEDGE]], label [[FAIL:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    [[LOOP_COND:%.*]] = icmp ne i32 [[IV]], 1000
; CHECK-NEXT:    br i1 [[LOOP_COND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       fail:
; CHECK-NEXT:    ret i32 -1
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
;
entry:
  %len = load i32, i32* %p, !range !2
  br label %loop

loop:
  %iv = phi i32 [%len, %entry], [%iv.next, %backedge]
  %iv.next = add i32 %iv, 1
  %rc = icmp sgt i32 %iv.next, %len
  br i1 %rc, label %backedge, label %fail

backedge:
  %loop.cond = icmp ne i32 %iv, 1000
  br i1 %loop.cond, label %loop, label %exit

fail:
  ret i32 -1

exit:
  ret i32 0
}

define i32 @test_04(i32* %p) {
; CHECK-LABEL: @test_04(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, i32* [[P:%.*]], align 4, [[RNG2]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[LEN]], [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[IV_NEXT]] = add nsw i32 [[IV]], -1
; CHECK-NEXT:    br i1 true, label [[BACKEDGE]], label [[FAIL:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    [[LOOP_COND:%.*]] = icmp ne i32 [[IV]], 0
; CHECK-NEXT:    br i1 [[LOOP_COND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       fail:
; CHECK-NEXT:    ret i32 -1
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
;
entry:
  %len = load i32, i32* %p, !range !2
  br label %loop

loop:
  %iv = phi i32 [%len, %entry], [%iv.next, %backedge]
  %iv.next = add i32 %iv, -1
  %rc = icmp slt i32 %iv.next, %len
  br i1 %rc, label %backedge, label %fail

backedge:
  %loop.cond = icmp ne i32 %iv, 0
  br i1 %loop.cond, label %loop, label %exit

fail:
  ret i32 -1

exit:
  ret i32 0
}

!0 = !{i32 0, i32 2147483647}
!1 = !{i32 -2147483648, i32 0}
!2 = !{i32 0, i32 1000}
