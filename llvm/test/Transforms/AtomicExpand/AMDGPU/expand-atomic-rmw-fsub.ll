; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -mcpu=hawaii -atomic-expand %s | FileCheck -check-prefix=GCN %s
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -atomic-expand %s | FileCheck -check-prefix=GCN %s

define float @test_atomicrmw_fsub_f32_flat(float* %ptr, float %value) {
; GCN-LABEL: @test_atomicrmw_fsub_f32_flat(
; GCN-NEXT:    [[TMP1:%.*]] = load float, float* [[PTR:%.*]], align 4
; GCN-NEXT:    br label [[ATOMICRMW_START:%.*]]
; GCN:       atomicrmw.start:
; GCN-NEXT:    [[LOADED:%.*]] = phi float [ [[TMP1]], [[TMP0:%.*]] ], [ [[TMP6:%.*]], [[ATOMICRMW_START]] ]
; GCN-NEXT:    [[NEW:%.*]] = fsub float [[LOADED]], [[VALUE:%.*]]
; GCN-NEXT:    [[TMP2:%.*]] = bitcast float* [[PTR]] to i32*
; GCN-NEXT:    [[TMP3:%.*]] = bitcast float [[NEW]] to i32
; GCN-NEXT:    [[TMP4:%.*]] = bitcast float [[LOADED]] to i32
; GCN-NEXT:    [[TMP5:%.*]] = cmpxchg i32* [[TMP2]], i32 [[TMP4]], i32 [[TMP3]] seq_cst seq_cst, align 4
; GCN-NEXT:    [[SUCCESS:%.*]] = extractvalue { i32, i1 } [[TMP5]], 1
; GCN-NEXT:    [[NEWLOADED:%.*]] = extractvalue { i32, i1 } [[TMP5]], 0
; GCN-NEXT:    [[TMP6]] = bitcast i32 [[NEWLOADED]] to float
; GCN-NEXT:    br i1 [[SUCCESS]], label [[ATOMICRMW_END:%.*]], label [[ATOMICRMW_START]]
; GCN:       atomicrmw.end:
; GCN-NEXT:    ret float [[TMP6]]
;
  %res = atomicrmw fsub float* %ptr, float %value seq_cst
  ret float %res
}

define float @test_atomicrmw_fsub_f32_global(float addrspace(1)* %ptr, float %value) {
; GCN-LABEL: @test_atomicrmw_fsub_f32_global(
; GCN-NEXT:    [[TMP1:%.*]] = load float, float addrspace(1)* [[PTR:%.*]], align 4
; GCN-NEXT:    br label [[ATOMICRMW_START:%.*]]
; GCN:       atomicrmw.start:
; GCN-NEXT:    [[LOADED:%.*]] = phi float [ [[TMP1]], [[TMP0:%.*]] ], [ [[TMP6:%.*]], [[ATOMICRMW_START]] ]
; GCN-NEXT:    [[NEW:%.*]] = fsub float [[LOADED]], [[VALUE:%.*]]
; GCN-NEXT:    [[TMP2:%.*]] = bitcast float addrspace(1)* [[PTR]] to i32 addrspace(1)*
; GCN-NEXT:    [[TMP3:%.*]] = bitcast float [[NEW]] to i32
; GCN-NEXT:    [[TMP4:%.*]] = bitcast float [[LOADED]] to i32
; GCN-NEXT:    [[TMP5:%.*]] = cmpxchg i32 addrspace(1)* [[TMP2]], i32 [[TMP4]], i32 [[TMP3]] seq_cst seq_cst, align 4
; GCN-NEXT:    [[SUCCESS:%.*]] = extractvalue { i32, i1 } [[TMP5]], 1
; GCN-NEXT:    [[NEWLOADED:%.*]] = extractvalue { i32, i1 } [[TMP5]], 0
; GCN-NEXT:    [[TMP6]] = bitcast i32 [[NEWLOADED]] to float
; GCN-NEXT:    br i1 [[SUCCESS]], label [[ATOMICRMW_END:%.*]], label [[ATOMICRMW_START]]
; GCN:       atomicrmw.end:
; GCN-NEXT:    ret float [[TMP6]]
;
  %res = atomicrmw fsub float addrspace(1)* %ptr, float %value seq_cst
  ret float %res
}

define float @test_atomicrmw_fsub_f32_local(float addrspace(3)* %ptr, float %value) {
; GCN-LABEL: @test_atomicrmw_fsub_f32_local(
; GCN-NEXT:    [[TMP1:%.*]] = load float, float addrspace(3)* [[PTR:%.*]], align 4
; GCN-NEXT:    br label [[ATOMICRMW_START:%.*]]
; GCN:       atomicrmw.start:
; GCN-NEXT:    [[LOADED:%.*]] = phi float [ [[TMP1]], [[TMP0:%.*]] ], [ [[TMP6:%.*]], [[ATOMICRMW_START]] ]
; GCN-NEXT:    [[NEW:%.*]] = fsub float [[LOADED]], [[VALUE:%.*]]
; GCN-NEXT:    [[TMP2:%.*]] = bitcast float addrspace(3)* [[PTR]] to i32 addrspace(3)*
; GCN-NEXT:    [[TMP3:%.*]] = bitcast float [[NEW]] to i32
; GCN-NEXT:    [[TMP4:%.*]] = bitcast float [[LOADED]] to i32
; GCN-NEXT:    [[TMP5:%.*]] = cmpxchg i32 addrspace(3)* [[TMP2]], i32 [[TMP4]], i32 [[TMP3]] seq_cst seq_cst, align 4
; GCN-NEXT:    [[SUCCESS:%.*]] = extractvalue { i32, i1 } [[TMP5]], 1
; GCN-NEXT:    [[NEWLOADED:%.*]] = extractvalue { i32, i1 } [[TMP5]], 0
; GCN-NEXT:    [[TMP6]] = bitcast i32 [[NEWLOADED]] to float
; GCN-NEXT:    br i1 [[SUCCESS]], label [[ATOMICRMW_END:%.*]], label [[ATOMICRMW_START]]
; GCN:       atomicrmw.end:
; GCN-NEXT:    ret float [[TMP6]]
;
  %res = atomicrmw fsub float addrspace(3)* %ptr, float %value seq_cst
  ret float %res
}

define half @test_atomicrmw_fsub_f16_flat(half* %ptr, half %value) {
; GCN-LABEL: @test_atomicrmw_fsub_f16_flat(
; GCN-NEXT:    [[RES:%.*]] = atomicrmw fsub half* [[PTR:%.*]], half [[VALUE:%.*]] seq_cst, align 2
; GCN-NEXT:    ret half [[RES]]
;
  %res = atomicrmw fsub half* %ptr, half %value seq_cst
  ret half %res
}

define half @test_atomicrmw_fsub_f16_global(half addrspace(1)* %ptr, half %value) {
; GCN-LABEL: @test_atomicrmw_fsub_f16_global(
; GCN-NEXT:    [[RES:%.*]] = atomicrmw fsub half addrspace(1)* [[PTR:%.*]], half [[VALUE:%.*]] seq_cst, align 2
; GCN-NEXT:    ret half [[RES]]
;
  %res = atomicrmw fsub half addrspace(1)* %ptr, half %value seq_cst
  ret half %res
}

define half @test_atomicrmw_fsub_f16_global_align4(half addrspace(1)* %ptr, half %value) {
; GCN-LABEL: @test_atomicrmw_fsub_f16_global_align4(
; GCN-NEXT:    [[RES:%.*]] = atomicrmw fsub half addrspace(1)* [[PTR:%.*]], half [[VALUE:%.*]] seq_cst, align 4
; GCN-NEXT:    ret half [[RES]]
;
  %res = atomicrmw fsub half addrspace(1)* %ptr, half %value seq_cst, align 4
  ret half %res
}

define half @test_atomicrmw_fsub_f16_local(half addrspace(3)* %ptr, half %value) {
; GCN-LABEL: @test_atomicrmw_fsub_f16_local(
; GCN-NEXT:    [[RES:%.*]] = atomicrmw fsub half addrspace(3)* [[PTR:%.*]], half [[VALUE:%.*]] seq_cst, align 2
; GCN-NEXT:    ret half [[RES]]
;
  %res = atomicrmw fsub half addrspace(3)* %ptr, half %value seq_cst
  ret half %res
}

define double @test_atomicrmw_fsub_f64_flat(double* %ptr, double %value) {
; GCN-LABEL: @test_atomicrmw_fsub_f64_flat(
; GCN-NEXT:    [[TMP1:%.*]] = load double, double* [[PTR:%.*]], align 8
; GCN-NEXT:    br label [[ATOMICRMW_START:%.*]]
; GCN:       atomicrmw.start:
; GCN-NEXT:    [[LOADED:%.*]] = phi double [ [[TMP1]], [[TMP0:%.*]] ], [ [[TMP6:%.*]], [[ATOMICRMW_START]] ]
; GCN-NEXT:    [[NEW:%.*]] = fsub double [[LOADED]], [[VALUE:%.*]]
; GCN-NEXT:    [[TMP2:%.*]] = bitcast double* [[PTR]] to i64*
; GCN-NEXT:    [[TMP3:%.*]] = bitcast double [[NEW]] to i64
; GCN-NEXT:    [[TMP4:%.*]] = bitcast double [[LOADED]] to i64
; GCN-NEXT:    [[TMP5:%.*]] = cmpxchg i64* [[TMP2]], i64 [[TMP4]], i64 [[TMP3]] seq_cst seq_cst, align 8
; GCN-NEXT:    [[SUCCESS:%.*]] = extractvalue { i64, i1 } [[TMP5]], 1
; GCN-NEXT:    [[NEWLOADED:%.*]] = extractvalue { i64, i1 } [[TMP5]], 0
; GCN-NEXT:    [[TMP6]] = bitcast i64 [[NEWLOADED]] to double
; GCN-NEXT:    br i1 [[SUCCESS]], label [[ATOMICRMW_END:%.*]], label [[ATOMICRMW_START]]
; GCN:       atomicrmw.end:
; GCN-NEXT:    ret double [[TMP6]]
;
  %res = atomicrmw fsub double* %ptr, double %value seq_cst
  ret double %res
}

define double @test_atomicrmw_fsub_f64_global(double addrspace(1)* %ptr, double %value) {
; GCN-LABEL: @test_atomicrmw_fsub_f64_global(
; GCN-NEXT:    [[TMP1:%.*]] = load double, double addrspace(1)* [[PTR:%.*]], align 8
; GCN-NEXT:    br label [[ATOMICRMW_START:%.*]]
; GCN:       atomicrmw.start:
; GCN-NEXT:    [[LOADED:%.*]] = phi double [ [[TMP1]], [[TMP0:%.*]] ], [ [[TMP6:%.*]], [[ATOMICRMW_START]] ]
; GCN-NEXT:    [[NEW:%.*]] = fsub double [[LOADED]], [[VALUE:%.*]]
; GCN-NEXT:    [[TMP2:%.*]] = bitcast double addrspace(1)* [[PTR]] to i64 addrspace(1)*
; GCN-NEXT:    [[TMP3:%.*]] = bitcast double [[NEW]] to i64
; GCN-NEXT:    [[TMP4:%.*]] = bitcast double [[LOADED]] to i64
; GCN-NEXT:    [[TMP5:%.*]] = cmpxchg i64 addrspace(1)* [[TMP2]], i64 [[TMP4]], i64 [[TMP3]] seq_cst seq_cst, align 8
; GCN-NEXT:    [[SUCCESS:%.*]] = extractvalue { i64, i1 } [[TMP5]], 1
; GCN-NEXT:    [[NEWLOADED:%.*]] = extractvalue { i64, i1 } [[TMP5]], 0
; GCN-NEXT:    [[TMP6]] = bitcast i64 [[NEWLOADED]] to double
; GCN-NEXT:    br i1 [[SUCCESS]], label [[ATOMICRMW_END:%.*]], label [[ATOMICRMW_START]]
; GCN:       atomicrmw.end:
; GCN-NEXT:    ret double [[TMP6]]
;
  %res = atomicrmw fsub double addrspace(1)* %ptr, double %value seq_cst
  ret double %res
}

define double @test_atomicrmw_fsub_f64_local(double addrspace(3)* %ptr, double %value) {
; GCN-LABEL: @test_atomicrmw_fsub_f64_local(
; GCN-NEXT:    [[TMP1:%.*]] = load double, double addrspace(3)* [[PTR:%.*]], align 8
; GCN-NEXT:    br label [[ATOMICRMW_START:%.*]]
; GCN:       atomicrmw.start:
; GCN-NEXT:    [[LOADED:%.*]] = phi double [ [[TMP1]], [[TMP0:%.*]] ], [ [[TMP6:%.*]], [[ATOMICRMW_START]] ]
; GCN-NEXT:    [[NEW:%.*]] = fsub double [[LOADED]], [[VALUE:%.*]]
; GCN-NEXT:    [[TMP2:%.*]] = bitcast double addrspace(3)* [[PTR]] to i64 addrspace(3)*
; GCN-NEXT:    [[TMP3:%.*]] = bitcast double [[NEW]] to i64
; GCN-NEXT:    [[TMP4:%.*]] = bitcast double [[LOADED]] to i64
; GCN-NEXT:    [[TMP5:%.*]] = cmpxchg i64 addrspace(3)* [[TMP2]], i64 [[TMP4]], i64 [[TMP3]] seq_cst seq_cst, align 8
; GCN-NEXT:    [[SUCCESS:%.*]] = extractvalue { i64, i1 } [[TMP5]], 1
; GCN-NEXT:    [[NEWLOADED:%.*]] = extractvalue { i64, i1 } [[TMP5]], 0
; GCN-NEXT:    [[TMP6]] = bitcast i64 [[NEWLOADED]] to double
; GCN-NEXT:    br i1 [[SUCCESS]], label [[ATOMICRMW_END:%.*]], label [[ATOMICRMW_START]]
; GCN:       atomicrmw.end:
; GCN-NEXT:    ret double [[TMP6]]
;
  %res = atomicrmw fsub double addrspace(3)* %ptr, double %value seq_cst
  ret double %res
}