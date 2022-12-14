; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu -O2 \
; RUN:     -ppc-asm-full-reg-names -mcpu=pwr10 < %s | FileCheck %s \
; RUN:     --check-prefixes=CHECK,CHECK-LE
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu -O2 \
; RUN:     -ppc-asm-full-reg-names -mcpu=pwr10 < %s | FileCheck %s \
; RUN:     --check-prefixes=CHECK,CHECK-BE

; This file does not contain many test cases involving comparisons and logical
; comparisons (cmplwi, cmpldi). This is because alternative code is generated
; when there is a compare (logical or not), followed by a sign or zero extend.
; This codegen will be re-evaluated at a later time on whether or not it should
; be emitted on P10.

@globalVal = common dso_local local_unnamed_addr global i8 0, align 1
@globalVal2 = common dso_local local_unnamed_addr global i32 0, align 4
@globalVal3 = common dso_local local_unnamed_addr global i64 0, align 8
@globalVal4 = common dso_local local_unnamed_addr global i16 0, align 2

define dso_local signext i32 @setnbc1(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: setnbc1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp slt i32 %a, %b
  %conv = sext i1 %cmp to i32
  ret i32 %conv
}

define dso_local signext i32 @setnbc2(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: setnbc2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i32 %a, %b
  %conv = sext i1 %cmp to i32
  ret i32 %conv
}

define dso_local signext i32 @setnbc3(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: setnbc3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sgt i32 %a, %b
  %conv = sext i1 %cmp to i32
  ret i32 %conv
}

define dso_local signext i32 @setnbc4(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: setnbc4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i8 %a, %b
  %conv = sext i1 %cmp to i32
  ret i32 %conv
}

; function attrs: norecurse nounwind
define dso_local void @setnbc5(i8 signext %a, i8 signext %b) {
; CHECK-LE-LABEL: setnbc5:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, eq
; CHECK-LE-NEXT:    pstb r3, globalVal@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc5:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal@toc@ha
; CHECK-BE-NEXT:    setnbc r3, eq
; CHECK-BE-NEXT:    stb r3, globalVal@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp eq i8 %a, %b
  %conv3 = sext i1 %cmp to i8
  store i8 %conv3, ptr @globalVal, align 1
  ret void
}

define dso_local void @setnbc6(i32 signext %a, i32 signext %b) {
; CHECK-LE-LABEL: setnbc6:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, eq
; CHECK-LE-NEXT:    pstw r3, globalVal2@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc6:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal2@toc@ha
; CHECK-BE-NEXT:    setnbc r3, eq
; CHECK-BE-NEXT:    stw r3, globalVal2@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp eq i32 %a, %b
  %conv = sext i1 %cmp to i32
  store i32 %conv, ptr @globalVal2, align 4
  ret void
}

define dso_local signext i32 @setnbc7(i64 %a, i64 %b) {
; CHECK-LABEL: setnbc7:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    setnbc r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i64 %a, %b
  %conv = sext i1 %cmp to i32
  ret i32 %conv
}

define signext i64 @setnbc8(i64 %a, i64 %b) {
; CHECK-LABEL: setnbc8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    setnbc r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i64 %a, %b
  %conv = sext i1 %cmp to i64
  ret i64 %conv
}

define dso_local void @setnbc9(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setnbc9:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpd r3, r4
; CHECK-LE-NEXT:    setnbc r3, eq
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc9:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpd r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal3@toc@ha
; CHECK-BE-NEXT:    setnbc r3, eq
; CHECK-BE-NEXT:    std r3, globalVal3@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp eq i64 %a, %b
  %conv1 = sext i1 %cmp to i64
  store i64 %conv1, ptr @globalVal3, align 8
  ret void
}

define dso_local signext i32 @setnbc10(i16 signext %a, i16 signext %b) {
; CHECK-LABEL: setnbc10:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i16 %a, %b
  %conv = sext i1 %cmp to i32
  ret i32 %conv
}

define dso_local void @setnbc11(i16 signext %a, i16 signext %b) {
; CHECK-LE-LABEL: setnbc11:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, eq
; CHECK-LE-NEXT:    psth r3, globalVal4@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc11:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal4@toc@ha
; CHECK-BE-NEXT:    setnbc r3, eq
; CHECK-BE-NEXT:    sth r3, globalVal4@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp eq i16 %a, %b
  %conv3 = sext i1 %cmp to i16
  store i16 %conv3, ptr @globalVal4, align 2
  ret void
}

define dso_local signext i32 @setnbc12(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LABEL: setnbc12:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i8 %a, %b
  %conv = sext i1 %cmp to i32
  ret i32 %conv
}

define dso_local void @setnbc13(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LE-LABEL: setnbc13:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, eq
; CHECK-LE-NEXT:    pstb r3, globalVal@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc13:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal@toc@ha
; CHECK-BE-NEXT:    setnbc r3, eq
; CHECK-BE-NEXT:    stb r3, globalVal@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp eq i8 %a, %b
  %conv3 = sext i1 %cmp to i8
  store i8 %conv3, ptr @globalVal, align 1
  ret void
}

define dso_local signext i32 @setnbc14(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LABEL: setnbc14:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i32 %a, %b
  %conv = sext i1 %cmp to i32
  ret i32 %conv
}

define dso_local void @setnbc15(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LE-LABEL: setnbc15:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, eq
; CHECK-LE-NEXT:    pstw r3, globalVal2@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc15:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal2@toc@ha
; CHECK-BE-NEXT:    setnbc r3, eq
; CHECK-BE-NEXT:    stw r3, globalVal2@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp eq i32 %a, %b
  %conv = sext i1 %cmp to i32
  store i32 %conv, ptr @globalVal2, align 4
  ret void
}

define dso_local signext i32 @setnbc16(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LABEL: setnbc16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i16 %a, %b
  %conv = sext i1 %cmp to i32
  ret i32 %conv
}

define dso_local void @setnbc17(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LE-LABEL: setnbc17:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, eq
; CHECK-LE-NEXT:    psth r3, globalVal4@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc17:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal4@toc@ha
; CHECK-BE-NEXT:    setnbc r3, eq
; CHECK-BE-NEXT:    sth r3, globalVal4@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp eq i16 %a, %b
  %conv3 = sext i1 %cmp to i16
  store i16 %conv3, ptr @globalVal4, align 2
  ret void
}

define dso_local signext i32 @setnbc18(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: setnbc18:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sgt i8 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define dso_local void @setnbc19(i8 signext %a, i8 signext %b) {
; CHECK-LE-LABEL: setnbc19:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, gt
; CHECK-LE-NEXT:    pstb r3, globalVal@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc19:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal@toc@ha
; CHECK-BE-NEXT:    setnbc r3, gt
; CHECK-BE-NEXT:    stb r3, globalVal@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sgt i8 %a, %b
  %conv3 = sext i1 %cmp to i8
  store i8 %conv3, ptr @globalVal, align 1
  ret void
}

define dso_local void @setnbc20(i32 signext %a, i32 signext %b) {
; CHECK-LE-LABEL: setnbc20:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, gt
; CHECK-LE-NEXT:    pstw r3, globalVal2@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc20:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal2@toc@ha
; CHECK-BE-NEXT:    setnbc r3, gt
; CHECK-BE-NEXT:    stw r3, globalVal2@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sgt i32 %a, %b
  %sub = sext i1 %cmp to i32
  store i32 %sub, ptr @globalVal2, align 4
  ret void
}

define dso_local signext i32 @setnbc21(i64 %a, i64 %b) {
; CHECK-LABEL: setnbc21:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    setnbc r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sgt i64 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define dso_local void @setnbc22(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setnbc22:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpd r3, r4
; CHECK-LE-NEXT:    setnbc r3, gt
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc22:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpd r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal3@toc@ha
; CHECK-BE-NEXT:    setnbc r3, gt
; CHECK-BE-NEXT:    std r3, globalVal3@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sgt i64 %a, %b
  %conv1 = sext i1 %cmp to i64
  store i64 %conv1, ptr @globalVal3, align 8
  ret void
}

define dso_local signext i32 @setnbc23(i16 signext %a, i16 signext %b) {
; CHECK-LABEL: setnbc23:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sgt i16 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define dso_local void @setnbc24(i16 signext %a, i16 signext %b) {
; CHECK-LE-LABEL: setnbc24:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, gt
; CHECK-LE-NEXT:    psth r3, globalVal4@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc24:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal4@toc@ha
; CHECK-BE-NEXT:    setnbc r3, gt
; CHECK-BE-NEXT:    sth r3, globalVal4@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sgt i16 %a, %b
  %conv3 = sext i1 %cmp to i16
  store i16 %conv3, ptr @globalVal4, align 2
  ret void
}

define dso_local signext i32 @setnbc25(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LABEL: setnbc25:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmplw r3, r4
; CHECK-NEXT:    setnbc r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ugt i8 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define dso_local void @setnbc26(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LE-LABEL: setnbc26:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmplw r3, r4
; CHECK-LE-NEXT:    setnbc r3, gt
; CHECK-LE-NEXT:    pstb r3, globalVal@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc26:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmplw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal@toc@ha
; CHECK-BE-NEXT:    setnbc r3, gt
; CHECK-BE-NEXT:    stb r3, globalVal@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ugt i8 %a, %b
  %conv3 = sext i1 %cmp to i8
  store i8 %conv3, ptr @globalVal, align 1
  ret void
}

define dso_local signext i32 @setnbc27(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LABEL: setnbc27:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmplw r3, r4
; CHECK-NEXT:    setnbc r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ugt i32 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define dso_local void @setnbc28(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LE-LABEL: setnbc28:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmplw r3, r4
; CHECK-LE-NEXT:    setnbc r3, gt
; CHECK-LE-NEXT:    pstw r3, globalVal2@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc28:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmplw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal2@toc@ha
; CHECK-BE-NEXT:    setnbc r3, gt
; CHECK-BE-NEXT:    stw r3, globalVal2@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ugt i32 %a, %b
  %sub = sext i1 %cmp to i32
  store i32 %sub, ptr @globalVal2, align 4
  ret void
}

define dso_local signext i32 @setnbc29(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LABEL: setnbc29:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmplw r3, r4
; CHECK-NEXT:    setnbc r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ugt i16 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define dso_local void @setnbc30(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LE-LABEL: setnbc30:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmplw r3, r4
; CHECK-LE-NEXT:    setnbc r3, gt
; CHECK-LE-NEXT:    psth r3, globalVal4@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc30:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmplw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal4@toc@ha
; CHECK-BE-NEXT:    setnbc r3, gt
; CHECK-BE-NEXT:    sth r3, globalVal4@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ugt i16 %a, %b
  %conv3 = sext i1 %cmp to i16
  store i16 %conv3, ptr @globalVal4, align 2
  ret void
}

define dso_local signext i32 @setnbc31(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: setnbc31:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp slt i8 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define dso_local void @setnbc32(i8 signext %a, i8 signext %b) {
; CHECK-LE-LABEL: setnbc32:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, lt
; CHECK-LE-NEXT:    pstb r3, globalVal@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc32:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal@toc@ha
; CHECK-BE-NEXT:    setnbc r3, lt
; CHECK-BE-NEXT:    stb r3, globalVal@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp slt i8 %a, %b
  %conv3 = sext i1 %cmp to i8
  store i8 %conv3, ptr @globalVal, align 1
  ret void
}

define dso_local void @setnbc33(i32 signext %a, i32 signext %b) {
; CHECK-LE-LABEL: setnbc33:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, lt
; CHECK-LE-NEXT:    pstw r3, globalVal2@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc33:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal2@toc@ha
; CHECK-BE-NEXT:    setnbc r3, lt
; CHECK-BE-NEXT:    stw r3, globalVal2@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp slt i32 %a, %b
  %sub = sext i1 %cmp to i32
  store i32 %sub, ptr @globalVal2, align 4
  ret void
}

define dso_local signext i32 @setnbc34(i64 %a, i64 %b) {
; CHECK-LABEL: setnbc34:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    setnbc r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp slt i64 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define signext i64 @setnbc35(i64 %a, i64 %b) {
; CHECK-LABEL: setnbc35:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    setnbc r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp slt i64 %a, %b
  %sub = sext i1 %cmp to i64
  ret i64 %sub
}

define dso_local void @setnbc36(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setnbc36:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpd r3, r4
; CHECK-LE-NEXT:    setnbc r3, lt
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc36:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpd r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal3@toc@ha
; CHECK-BE-NEXT:    setnbc r3, lt
; CHECK-BE-NEXT:    std r3, globalVal3@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp slt i64 %a, %b
  %conv1 = sext i1 %cmp to i64
  store i64 %conv1, ptr @globalVal3, align 8
  ret void
}

define dso_local signext i32 @setnbc37(i16 signext %a, i16 signext %b) {
; CHECK-LABEL: setnbc37:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp slt i16 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define dso_local void @setnbc38(i16 signext %a, i16 signext %b) {
; CHECK-LE-LABEL: setnbc38:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, lt
; CHECK-LE-NEXT:    psth r3, globalVal4@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc38:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal4@toc@ha
; CHECK-BE-NEXT:    setnbc r3, lt
; CHECK-BE-NEXT:    sth r3, globalVal4@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp slt i16 %a, %b
  %conv3 = sext i1 %cmp to i16
  store i16 %conv3, ptr @globalVal4, align 2
  ret void
}

define dso_local signext i32 @setnbc39(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LABEL: setnbc39:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmplw r3, r4
; CHECK-NEXT:    setnbc r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ult i8 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define dso_local void @setnbc40(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LE-LABEL: setnbc40:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmplw r3, r4
; CHECK-LE-NEXT:    setnbc r3, lt
; CHECK-LE-NEXT:    pstb r3, globalVal@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc40:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmplw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal@toc@ha
; CHECK-BE-NEXT:    setnbc r3, lt
; CHECK-BE-NEXT:    stb r3, globalVal@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ult i8 %a, %b
  %conv3 = sext i1 %cmp to i8
  store i8 %conv3, ptr @globalVal, align 1
  ret void
}

define dso_local signext i32 @setnbc41(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LABEL: setnbc41:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmplw r3, r4
; CHECK-NEXT:    setnbc r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ult i32 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define dso_local void @setnbc42(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LE-LABEL: setnbc42:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmplw r3, r4
; CHECK-LE-NEXT:    setnbc r3, lt
; CHECK-LE-NEXT:    pstw r3, globalVal2@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc42:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmplw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal2@toc@ha
; CHECK-BE-NEXT:    setnbc r3, lt
; CHECK-BE-NEXT:    stw r3, globalVal2@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ult i32 %a, %b
  %sub = sext i1 %cmp to i32
  store i32 %sub, ptr @globalVal2, align 4
  ret void
}

define dso_local signext i32 @setnbc43(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LABEL: setnbc43:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmplw r3, r4
; CHECK-NEXT:    setnbc r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ult i16 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define dso_local void @setnbc44(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LE-LABEL: setnbc44:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmplw r3, r4
; CHECK-LE-NEXT:    setnbc r3, lt
; CHECK-LE-NEXT:    psth r3, globalVal4@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc44:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmplw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal4@toc@ha
; CHECK-BE-NEXT:    setnbc r3, lt
; CHECK-BE-NEXT:    sth r3, globalVal4@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ult i16 %a, %b
  %conv3 = sext i1 %cmp to i16
  store i16 %conv3, ptr @globalVal4, align 2
  ret void
}

define i64 @setnbc45(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: setnbc45:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i8 %a, %b
  %conv3 = sext i1 %cmp to i64
  ret i64 %conv3
}

define dso_local void @setnbc46(i8 signext %a, i8 signext %b) {
; CHECK-LE-LABEL: setnbc46:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, eq
; CHECK-LE-NEXT:    pstb r3, globalVal@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc46:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal@toc@ha
; CHECK-BE-NEXT:    setnbc r3, eq
; CHECK-BE-NEXT:    stb r3, globalVal@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp eq i8 %a, %b
  %conv3 = sext i1 %cmp to i8
  store i8 %conv3, ptr @globalVal, align 1
  ret void
}

define i64 @setnbc47(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: setnbc47:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i32 %a, %b
  %conv1 = sext i1 %cmp to i64
  ret i64 %conv1
}

define dso_local void @setnbc48(i32 signext %a, i32 signext %b) {
; CHECK-LE-LABEL: setnbc48:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, eq
; CHECK-LE-NEXT:    pstw r3, globalVal2@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc48:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal2@toc@ha
; CHECK-BE-NEXT:    setnbc r3, eq
; CHECK-BE-NEXT:    stw r3, globalVal2@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp eq i32 %a, %b
  %sub = sext i1 %cmp to i32
  store i32 %sub, ptr @globalVal2, align 4
  ret void
}

define dso_local void @setnbc49(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setnbc49:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpd r3, r4
; CHECK-LE-NEXT:    setnbc r3, eq
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc49:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpd r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal3@toc@ha
; CHECK-BE-NEXT:    setnbc r3, eq
; CHECK-BE-NEXT:    std r3, globalVal3@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp eq i64 %a, %b
  %conv1 = sext i1 %cmp to i64
  store i64 %conv1, ptr @globalVal3, align 8
  ret void
}

define i64 @setnbc50(i16 signext %a, i16 signext %b) {
; CHECK-LABEL: setnbc50:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i16 %a, %b
  %conv3 = sext i1 %cmp to i64
  ret i64 %conv3
}

define dso_local void @setnbc51(i16 signext %a, i16 signext %b) {
; CHECK-LE-LABEL: setnbc51:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, eq
; CHECK-LE-NEXT:    psth r3, globalVal4@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc51:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal4@toc@ha
; CHECK-BE-NEXT:    setnbc r3, eq
; CHECK-BE-NEXT:    sth r3, globalVal4@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp eq i16 %a, %b
  %conv3 = sext i1 %cmp to i16
  store i16 %conv3, ptr @globalVal4, align 2
  ret void
}

define i64 @setnbc52(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LABEL: setnbc52:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i8 %a, %b
  %conv3 = sext i1 %cmp to i64
  ret i64 %conv3
}

define dso_local void @setnbc53(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LE-LABEL: setnbc53:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, eq
; CHECK-LE-NEXT:    pstb r3, globalVal@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc53:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal@toc@ha
; CHECK-BE-NEXT:    setnbc r3, eq
; CHECK-BE-NEXT:    stb r3, globalVal@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp eq i8 %a, %b
  %conv3 = sext i1 %cmp to i8
  store i8 %conv3, ptr @globalVal, align 1
  ret void
}

define i64 @setnbc54(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LABEL: setnbc54:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i32 %a, %b
  %conv1 = sext i1 %cmp to i64
  ret i64 %conv1
}

define dso_local void @setnbc55(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LE-LABEL: setnbc55:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, eq
; CHECK-LE-NEXT:    pstw r3, globalVal2@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc55:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal2@toc@ha
; CHECK-BE-NEXT:    setnbc r3, eq
; CHECK-BE-NEXT:    stw r3, globalVal2@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp eq i32 %a, %b
  %sub = sext i1 %cmp to i32
  store i32 %sub, ptr @globalVal2, align 4
  ret void
}

define i64 @setnbc56(i64 %a, i64 %b) {
; CHECK-LABEL: setnbc56:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    setnbc r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i64 %a, %b
  %conv1 = sext i1 %cmp to i64
  ret i64 %conv1
}

define dso_local void @setnbc57(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setnbc57:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpd r3, r4
; CHECK-LE-NEXT:    setnbc r3, eq
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc57:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpd r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal3@toc@ha
; CHECK-BE-NEXT:    setnbc r3, eq
; CHECK-BE-NEXT:    std r3, globalVal3@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp eq i64 %a, %b
  %conv1 = sext i1 %cmp to i64
  store i64 %conv1, ptr @globalVal3, align 8
  ret void
}

define i64 @setnbc58(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LABEL: setnbc58:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setnbc r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i16 %a, %b
  %conv3 = sext i1 %cmp to i64
  ret i64 %conv3
}

define dso_local void @setnbc59(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LE-LABEL: setnbc59:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setnbc r3, eq
; CHECK-LE-NEXT:    psth r3, globalVal4@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc59:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal4@toc@ha
; CHECK-BE-NEXT:    setnbc r3, eq
; CHECK-BE-NEXT:    sth r3, globalVal4@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp eq i16 %a, %b
  %conv3 = sext i1 %cmp to i16
  store i16 %conv3, ptr @globalVal4, align 2
  ret void
}

define i64 @setnbc60(i64 %a, i64 %b) {
; CHECK-LABEL: setnbc60:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    setnbc r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sgt i64 %a, %b
  %conv1 = sext i1 %cmp to i64
  ret i64 %conv1
}

define dso_local void @setnbc61(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setnbc61:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpd r3, r4
; CHECK-LE-NEXT:    setnbc r3, gt
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc61:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpd r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal3@toc@ha
; CHECK-BE-NEXT:    setnbc r3, gt
; CHECK-BE-NEXT:    std r3, globalVal3@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sgt i64 %a, %b
  %conv1 = sext i1 %cmp to i64
  store i64 %conv1, ptr @globalVal3, align 8
  ret void
}

define i64 @setnbc62(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LABEL: setnbc62:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmplw r3, r4
; CHECK-NEXT:    setnbc r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ugt i8 %a, %b
  %conv3 = sext i1 %cmp to i64
  ret i64 %conv3
}

define dso_local void @setnbc63(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LE-LABEL: setnbc63:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmplw r3, r4
; CHECK-LE-NEXT:    setnbc r3, gt
; CHECK-LE-NEXT:    pstb r3, globalVal@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc63:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmplw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal@toc@ha
; CHECK-BE-NEXT:    setnbc r3, gt
; CHECK-BE-NEXT:    stb r3, globalVal@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ugt i8 %a, %b
  %conv3 = sext i1 %cmp to i8
  store i8 %conv3, ptr @globalVal, align 1
  ret void
}

define i64 @setnbc64(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LABEL: setnbc64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmplw r3, r4
; CHECK-NEXT:    setnbc r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ugt i32 %a, %b
  %conv1 = sext i1 %cmp to i64
  ret i64 %conv1
}

define dso_local void @setnbc65(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LE-LABEL: setnbc65:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmplw r3, r4
; CHECK-LE-NEXT:    setnbc r3, gt
; CHECK-LE-NEXT:    pstw r3, globalVal2@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc65:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmplw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal2@toc@ha
; CHECK-BE-NEXT:    setnbc r3, gt
; CHECK-BE-NEXT:    stw r3, globalVal2@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ugt i32 %a, %b
  %sub = sext i1 %cmp to i32
  store i32 %sub, ptr @globalVal2, align 4
  ret void
}

define i64 @setnbc66(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LABEL: setnbc66:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmplw r3, r4
; CHECK-NEXT:    setnbc r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ugt i16 %a, %b
  %conv3 = sext i1 %cmp to i64
  ret i64 %conv3
}

define dso_local void @setnbc67(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LE-LABEL: setnbc67:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmplw r3, r4
; CHECK-LE-NEXT:    setnbc r3, gt
; CHECK-LE-NEXT:    psth r3, globalVal4@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc67:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmplw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal4@toc@ha
; CHECK-BE-NEXT:    setnbc r3, gt
; CHECK-BE-NEXT:    sth r3, globalVal4@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ugt i16 %a, %b
  %conv3 = sext i1 %cmp to i16
  store i16 %conv3, ptr @globalVal4, align 2
  ret void
}

define i64 @setnbc68(i64 %a, i64 %b) {
; CHECK-LABEL: setnbc68:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    setnbc r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp slt i64 %a, %b
  %conv1 = sext i1 %cmp to i64
  ret i64 %conv1
}

define dso_local void @setnbc69(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setnbc69:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpd r3, r4
; CHECK-LE-NEXT:    setnbc r3, lt
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc69:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpd r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal3@toc@ha
; CHECK-BE-NEXT:    setnbc r3, lt
; CHECK-BE-NEXT:    std r3, globalVal3@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp slt i64 %a, %b
  %conv1 = sext i1 %cmp to i64
  store i64 %conv1, ptr @globalVal3, align 8
  ret void
}

define i64 @setnbc70(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LABEL: setnbc70:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmplw r3, r4
; CHECK-NEXT:    setnbc r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ult i8 %a, %b
  %conv3 = sext i1 %cmp to i64
  ret i64 %conv3
}

define dso_local void @setnbc71(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LE-LABEL: setnbc71:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmplw r3, r4
; CHECK-LE-NEXT:    setnbc r3, lt
; CHECK-LE-NEXT:    pstb r3, globalVal@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc71:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmplw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal@toc@ha
; CHECK-BE-NEXT:    setnbc r3, lt
; CHECK-BE-NEXT:    stb r3, globalVal@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ult i8 %a, %b
  %conv3 = sext i1 %cmp to i8
  store i8 %conv3, ptr @globalVal, align 1
  ret void
}

define i64 @setnbc72(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LABEL: setnbc72:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmplw r3, r4
; CHECK-NEXT:    setnbc r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ult i32 %a, %b
  %conv1 = sext i1 %cmp to i64
  ret i64 %conv1
}

define dso_local void @setnbc73(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LE-LABEL: setnbc73:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmplw r3, r4
; CHECK-LE-NEXT:    setnbc r3, lt
; CHECK-LE-NEXT:    pstw r3, globalVal2@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc73:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmplw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal2@toc@ha
; CHECK-BE-NEXT:    setnbc r3, lt
; CHECK-BE-NEXT:    stw r3, globalVal2@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ult i32 %a, %b
  %sub = sext i1 %cmp to i32
  store i32 %sub, ptr @globalVal2, align 4
  ret void
}

define i64 @setnbc74(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LABEL: setnbc74:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmplw r3, r4
; CHECK-NEXT:    setnbc r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ult i16 %a, %b
  %conv3 = sext i1 %cmp to i64
  ret i64 %conv3
}

define dso_local void @setnbc75(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LE-LABEL: setnbc75:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmplw r3, r4
; CHECK-LE-NEXT:    setnbc r3, lt
; CHECK-LE-NEXT:    psth r3, globalVal4@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setnbc75:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmplw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, globalVal4@toc@ha
; CHECK-BE-NEXT:    setnbc r3, lt
; CHECK-BE-NEXT:    sth r3, globalVal4@toc@l(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ult i16 %a, %b
  %conv3 = sext i1 %cmp to i16
  store i16 %conv3, ptr @globalVal4, align 2
  ret void
}

