// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sme2 < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve2p1 < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sme2 < %s \
// RUN:        | llvm-objdump -d --mattr=+sme2 - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sme2 < %s \
// RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sme2 < %s \
// RUN:        | sed '/.text/d' | sed 's/.*encoding: //g' \
// RUN:        | llvm-mc -triple=aarch64 -mattr=+sme2 -disassemble -show-encoding \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST

whilels pn8.h, x0, x0, vlx2  // 00100101-01100000-01001100-00011000
// CHECK-INST: whilels pn8.h, x0, x0, vlx2
// CHECK-ENCODING: [0x18,0x4c,0x60,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25604c18 <unknown>

whilels pn13.h, x10, x21, vlx2  // 00100101-01110101-01001101-01011101
// CHECK-INST: whilels pn13.h, x10, x21, vlx2
// CHECK-ENCODING: [0x5d,0x4d,0x75,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25754d5d <unknown>

whilels pn15.h, x13, x8, vlx4  // 00100101-01101000-01101101-10111111
// CHECK-INST: whilels pn15.h, x13, x8, vlx4
// CHECK-ENCODING: [0xbf,0x6d,0x68,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25686dbf <unknown>

whilels pn15.h, xzr, xzr, vlx4  // 00100101-01111111-01101111-11111111
// CHECK-INST: whilels pn15.h, xzr, xzr, vlx4
// CHECK-ENCODING: [0xff,0x6f,0x7f,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 257f6fff <unknown>

whilels {p0.h, p1.h}, x0, x0  // 00100101-01100000-01011100-00010001
// CHECK-INST: whilels { p0.h, p1.h }, x0, x0
// CHECK-ENCODING: [0x11,0x5c,0x60,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25605c11 <unknown>

whilels {p4.h, p5.h}, x10, x21  // 00100101-01110101-01011101-01010101
// CHECK-INST: whilels { p4.h, p5.h }, x10, x21
// CHECK-ENCODING: [0x55,0x5d,0x75,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25755d55 <unknown>

whilels {p6.h, p7.h}, x13, x8  // 00100101-01101000-01011101-10110111
// CHECK-INST: whilels { p6.h, p7.h }, x13, x8
// CHECK-ENCODING: [0xb7,0x5d,0x68,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25685db7 <unknown>

whilels {p14.h, p15.h}, xzr, xzr  // 00100101-01111111-01011111-11111111
// CHECK-INST: whilels { p14.h, p15.h }, xzr, xzr
// CHECK-ENCODING: [0xff,0x5f,0x7f,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 257f5fff <unknown>

whilels pn8.s, x0, x0, vlx2  // 00100101-10100000-01001100-00011000
// CHECK-INST: whilels pn8.s, x0, x0, vlx2
// CHECK-ENCODING: [0x18,0x4c,0xa0,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25a04c18 <unknown>

whilels pn13.s, x10, x21, vlx2  // 00100101-10110101-01001101-01011101
// CHECK-INST: whilels pn13.s, x10, x21, vlx2
// CHECK-ENCODING: [0x5d,0x4d,0xb5,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25b54d5d <unknown>

whilels pn15.s, x13, x8, vlx4  // 00100101-10101000-01101101-10111111
// CHECK-INST: whilels pn15.s, x13, x8, vlx4
// CHECK-ENCODING: [0xbf,0x6d,0xa8,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25a86dbf <unknown>

whilels pn15.s, xzr, xzr, vlx4  // 00100101-10111111-01101111-11111111
// CHECK-INST: whilels pn15.s, xzr, xzr, vlx4
// CHECK-ENCODING: [0xff,0x6f,0xbf,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25bf6fff <unknown>

whilels {p0.s, p1.s}, x0, x0  // 00100101-10100000-01011100-00010001
// CHECK-INST: whilels { p0.s, p1.s }, x0, x0
// CHECK-ENCODING: [0x11,0x5c,0xa0,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25a05c11 <unknown>

whilels {p4.s, p5.s}, x10, x21  // 00100101-10110101-01011101-01010101
// CHECK-INST: whilels { p4.s, p5.s }, x10, x21
// CHECK-ENCODING: [0x55,0x5d,0xb5,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25b55d55 <unknown>

whilels {p6.s, p7.s}, x13, x8  // 00100101-10101000-01011101-10110111
// CHECK-INST: whilels { p6.s, p7.s }, x13, x8
// CHECK-ENCODING: [0xb7,0x5d,0xa8,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25a85db7 <unknown>

whilels {p14.s, p15.s}, xzr, xzr  // 00100101-10111111-01011111-11111111
// CHECK-INST: whilels { p14.s, p15.s }, xzr, xzr
// CHECK-ENCODING: [0xff,0x5f,0xbf,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25bf5fff <unknown>

whilels pn8.d, x0, x0, vlx2  // 00100101-11100000-01001100-00011000
// CHECK-INST: whilels pn8.d, x0, x0, vlx2
// CHECK-ENCODING: [0x18,0x4c,0xe0,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25e04c18 <unknown>

whilels pn13.d, x10, x21, vlx2  // 00100101-11110101-01001101-01011101
// CHECK-INST: whilels pn13.d, x10, x21, vlx2
// CHECK-ENCODING: [0x5d,0x4d,0xf5,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25f54d5d <unknown>

whilels pn15.d, x13, x8, vlx4  // 00100101-11101000-01101101-10111111
// CHECK-INST: whilels pn15.d, x13, x8, vlx4
// CHECK-ENCODING: [0xbf,0x6d,0xe8,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25e86dbf <unknown>

whilels pn15.d, xzr, xzr, vlx4  // 00100101-11111111-01101111-11111111
// CHECK-INST: whilels pn15.d, xzr, xzr, vlx4
// CHECK-ENCODING: [0xff,0x6f,0xff,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25ff6fff <unknown>

whilels {p0.d, p1.d}, x0, x0  // 00100101-11100000-01011100-00010001
// CHECK-INST: whilels { p0.d, p1.d }, x0, x0
// CHECK-ENCODING: [0x11,0x5c,0xe0,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25e05c11 <unknown>

whilels {p4.d, p5.d}, x10, x21  // 00100101-11110101-01011101-01010101
// CHECK-INST: whilels { p4.d, p5.d }, x10, x21
// CHECK-ENCODING: [0x55,0x5d,0xf5,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25f55d55 <unknown>

whilels {p6.d, p7.d}, x13, x8  // 00100101-11101000-01011101-10110111
// CHECK-INST: whilels { p6.d, p7.d }, x13, x8
// CHECK-ENCODING: [0xb7,0x5d,0xe8,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25e85db7 <unknown>

whilels {p14.d, p15.d}, xzr, xzr  // 00100101-11111111-01011111-11111111
// CHECK-INST: whilels { p14.d, p15.d }, xzr, xzr
// CHECK-ENCODING: [0xff,0x5f,0xff,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25ff5fff <unknown>

whilels pn8.b, x0, x0, vlx2  // 00100101-00100000-01001100-00011000
// CHECK-INST: whilels pn8.b, x0, x0, vlx2
// CHECK-ENCODING: [0x18,0x4c,0x20,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25204c18 <unknown>

whilels pn13.b, x10, x21, vlx2  // 00100101-00110101-01001101-01011101
// CHECK-INST: whilels pn13.b, x10, x21, vlx2
// CHECK-ENCODING: [0x5d,0x4d,0x35,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25354d5d <unknown>

whilels pn15.b, x13, x8, vlx4  // 00100101-00101000-01101101-10111111
// CHECK-INST: whilels pn15.b, x13, x8, vlx4
// CHECK-ENCODING: [0xbf,0x6d,0x28,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25286dbf <unknown>

whilels pn15.b, xzr, xzr, vlx4  // 00100101-00111111-01101111-11111111
// CHECK-INST: whilels pn15.b, xzr, xzr, vlx4
// CHECK-ENCODING: [0xff,0x6f,0x3f,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 253f6fff <unknown>

whilels {p0.b, p1.b}, x0, x0  // 00100101-00100000-01011100-00010001
// CHECK-INST: whilels { p0.b, p1.b }, x0, x0
// CHECK-ENCODING: [0x11,0x5c,0x20,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25205c11 <unknown>

whilels {p4.b, p5.b}, x10, x21  // 00100101-00110101-01011101-01010101
// CHECK-INST: whilels { p4.b, p5.b }, x10, x21
// CHECK-ENCODING: [0x55,0x5d,0x35,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25355d55 <unknown>

whilels {p6.b, p7.b}, x13, x8  // 00100101-00101000-01011101-10110111
// CHECK-INST: whilels { p6.b, p7.b }, x13, x8
// CHECK-ENCODING: [0xb7,0x5d,0x28,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 25285db7 <unknown>

whilels {p14.b, p15.b}, xzr, xzr  // 00100101-00111111-01011111-11111111
// CHECK-INST: whilels { p14.b, p15.b }, xzr, xzr
// CHECK-ENCODING: [0xff,0x5f,0x3f,0x25]
// CHECK-ERROR: instruction requires: sme2 or sve2p1
// CHECK-UNKNOWN: 253f5fff <unknown>
