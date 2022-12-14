; RUN: llc < %s -O0 -verify-machineinstrs -fast-isel-abort=1 -mtriple=powerpc64-unknown-linux-gnu -mcpu=pwr7
; RUN: llc < %s -O0 -verify-machineinstrs -fast-isel-abort=1 -mtriple=powerpc64-ibm-aix-xcoff -mcpu=pwr7

; Ensure this doesn't crash.

%union.anon = type { <16 x i32> }

@__md0 = external global [137 x i8]

define internal void @stretch(ptr addrspace(1) %src, ptr addrspace(1) %dst, i32 %width, i32 %height, i32 %iLS, i32 %oLS, <2 x float> %c, <4 x float> %param) nounwind {
entry:
  ret void
}

define internal i32 @_Z13get_global_idj(i32 %dim) nounwind {
entry:
  ret i32 undef
}

define void @wrap(ptr addrspace(1) %arglist, ptr addrspace(1) %gtid) nounwind {
entry:
  call void @stretch(ptr addrspace(1) undef, ptr addrspace(1) undef, i32 undef, i32 undef, i32 undef, i32 undef, <2 x float> undef, <4 x float> undef)
  ret void
}
