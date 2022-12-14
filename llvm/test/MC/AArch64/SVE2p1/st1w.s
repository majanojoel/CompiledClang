// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sme2 < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve2p1 < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sme2 < %s \
// RUN:        | llvm-objdump -d --mattr=+sme2 --no-print-imm-hex - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sme2 < %s \
// RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sme2 < %s \
// RUN:        | sed '/.text/d' | sed 's/.*encoding: //g' \
// RUN:        | llvm-mc -triple=aarch64 -mattr=+sme2 -disassemble -show-encoding \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST

st1w    {z0.s-z1.s}, pn8, [x0, x0, lsl #2]  // 10100000-00100000-01000000-00000000
// CHECK-INST: st1w    { z0.s, z1.s }, pn8, [x0, x0, lsl #2]
// CHECK-ENCODING: [0x00,0x40,0x20,0xa0]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: a0204000 <unknown>

st1w    {z20.s-z21.s}, pn13, [x10, x21, lsl #2]  // 10100000-00110101-01010101-01010100
// CHECK-INST: st1w    { z20.s, z21.s }, pn13, [x10, x21, lsl #2]
// CHECK-ENCODING: [0x54,0x55,0x35,0xa0]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: a0355554 <unknown>

st1w    {z22.s-z23.s}, pn11, [x13, x8, lsl #2]  // 10100000-00101000-01001101-10110110
// CHECK-INST: st1w    { z22.s, z23.s }, pn11, [x13, x8, lsl #2]
// CHECK-ENCODING: [0xb6,0x4d,0x28,0xa0]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: a0284db6 <unknown>

st1w    {z30.s-z31.s}, pn15, [sp, xzr, lsl #2]  // 10100000-00111111-01011111-11111110
// CHECK-INST: st1w    { z30.s, z31.s }, pn15, [sp, xzr, lsl #2]
// CHECK-ENCODING: [0xfe,0x5f,0x3f,0xa0]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: a03f5ffe <unknown>

st1w    {z0.s-z1.s}, pn8, [x0]  // 10100000-01100000-01000000-00000000
// CHECK-INST: st1w    { z0.s, z1.s }, pn8, [x0]
// CHECK-ENCODING: [0x00,0x40,0x60,0xa0]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: a0604000 <unknown>

st1w    {z20.s-z21.s}, pn13, [x10, #10, mul vl]  // 10100000-01100101-01010101-01010100
// CHECK-INST: st1w    { z20.s, z21.s }, pn13, [x10, #10, mul vl]
// CHECK-ENCODING: [0x54,0x55,0x65,0xa0]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: a0655554 <unknown>

st1w    {z22.s-z23.s}, pn11, [x13, #-16, mul vl]  // 10100000-01101000-01001101-10110110
// CHECK-INST: st1w    { z22.s, z23.s }, pn11, [x13, #-16, mul vl]
// CHECK-ENCODING: [0xb6,0x4d,0x68,0xa0]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: a0684db6 <unknown>

st1w    {z30.s-z31.s}, pn15, [sp, #-2, mul vl]  // 10100000-01101111-01011111-11111110
// CHECK-INST: st1w    { z30.s, z31.s }, pn15, [sp, #-2, mul vl]
// CHECK-ENCODING: [0xfe,0x5f,0x6f,0xa0]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: a06f5ffe <unknown>

st1w    {z0.s-z3.s}, pn8, [x0, x0, lsl #2]  // 10100000-00100000-11000000-00000000
// CHECK-INST: st1w    { z0.s - z3.s }, pn8, [x0, x0, lsl #2]
// CHECK-ENCODING: [0x00,0xc0,0x20,0xa0]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: a020c000 <unknown>

st1w    {z20.s-z23.s}, pn13, [x10, x21, lsl #2]  // 10100000-00110101-11010101-01010100
// CHECK-INST: st1w    { z20.s - z23.s }, pn13, [x10, x21, lsl #2]
// CHECK-ENCODING: [0x54,0xd5,0x35,0xa0]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: a035d554 <unknown>

st1w    {z20.s-z23.s}, pn11, [x13, x8, lsl #2]  // 10100000-00101000-11001101-10110100
// CHECK-INST: st1w    { z20.s - z23.s }, pn11, [x13, x8, lsl #2]
// CHECK-ENCODING: [0xb4,0xcd,0x28,0xa0]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: a028cdb4 <unknown>

st1w    {z28.s-z31.s}, pn15, [sp, xzr, lsl #2]  // 10100000-00111111-11011111-11111100
// CHECK-INST: st1w    { z28.s - z31.s }, pn15, [sp, xzr, lsl #2]
// CHECK-ENCODING: [0xfc,0xdf,0x3f,0xa0]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: a03fdffc <unknown>

st1w    {z0.s-z3.s}, pn8, [x0]  // 10100000-01100000-11000000-00000000
// CHECK-INST: st1w    { z0.s - z3.s }, pn8, [x0]
// CHECK-ENCODING: [0x00,0xc0,0x60,0xa0]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: a060c000 <unknown>

st1w    {z20.s-z23.s}, pn13, [x10, #20, mul vl]  // 10100000-01100101-11010101-01010100
// CHECK-INST: st1w    { z20.s - z23.s }, pn13, [x10, #20, mul vl]
// CHECK-ENCODING: [0x54,0xd5,0x65,0xa0]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: a065d554 <unknown>

st1w    {z20.s-z23.s}, pn11, [x13, #-32, mul vl]  // 10100000-01101000-11001101-10110100
// CHECK-INST: st1w    { z20.s - z23.s }, pn11, [x13, #-32, mul vl]
// CHECK-ENCODING: [0xb4,0xcd,0x68,0xa0]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: a068cdb4 <unknown>

st1w    {z28.s-z31.s}, pn15, [sp, #-4, mul vl]  // 10100000-01101111-11011111-11111100
// CHECK-INST: st1w    { z28.s - z31.s }, pn15, [sp, #-4, mul vl]
// CHECK-ENCODING: [0xfc,0xdf,0x6f,0xa0]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: a06fdffc <unknown>
