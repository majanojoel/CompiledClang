; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu -mcpu=pwr7 < %s
target triple = "powerpc64-unknown-linux-gnu"

define void @autogen_SD156869(ptr, ptr) {
BB:
  %A3 = alloca <2 x i1>
  %A2 = alloca <8 x i32>
  br label %CF

CF:                                               ; preds = %CF85, %CF, %BB
  br i1 undef, label %CF, label %CF82.critedge

CF82.critedge:                                    ; preds = %CF
  store i8 -59, ptr %0
  br label %CF82

CF82:                                             ; preds = %CF82, %CF82.critedge
  %L17 = load i8, ptr %0
  %E18 = extractelement <2 x i64> undef, i32 0
  br i1 undef, label %CF82, label %CF84.critedge

CF84.critedge:                                    ; preds = %CF82
  store i64 455385, ptr %A3
  br label %CF84

CF84:                                             ; preds = %CF84, %CF84.critedge
  %L40 = load i64, ptr %A3
  store i64 -1, ptr %A3
  %Sl46 = select i1 undef, i1 undef, i1 false
  br i1 %Sl46, label %CF84, label %CF85

CF85:                                             ; preds = %CF84
  %L47 = load i64, ptr %A3
  store i64 %E18, ptr %A3
  store ppc_fp128 0xM4D436562A0416DE00000000000000000, ptr %A2
  %Cmp61 = icmp slt i64 %L47, %L40
  br i1 %Cmp61, label %CF, label %CF77

CF77:                                             ; preds = %CF77, %CF85
  br i1 undef, label %CF77, label %CF81

CF81:                                             ; preds = %CF77
  store i8 %L17, ptr %1
  ret void
}
