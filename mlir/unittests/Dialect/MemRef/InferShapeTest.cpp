//===- InferShapeTest.cpp - unit tests for shape inference ----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/IR/AffineMap.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinTypes.h"
#include "gtest/gtest.h"

using namespace mlir;
using namespace mlir::memref;

// Source memref has identity layout.
TEST(InferShapeTest, inferRankReducedShapeIdentity) {
  MLIRContext ctx;
  OpBuilder b(&ctx);
  auto sourceMemref = MemRefType::get({10, 5}, b.getIndexType());
  auto reducedType = SubViewOp::inferRankReducedResultType(
      /*resultShape=*/{2}, sourceMemref, {2, 3}, {1, 2}, {1, 1});
  auto expectedType = MemRefType::get(
      {2}, b.getIndexType(),
      StridedLayoutAttr::get(&ctx, /*offset=*/13, /*strides=*/{1}));
  EXPECT_EQ(reducedType, expectedType);
}

// Source memref has non-identity layout.
TEST(InferShapeTest, inferRankReducedShapeNonIdentity) {
  MLIRContext ctx;
  OpBuilder b(&ctx);
  AffineExpr dim0, dim1;
  bindDims(&ctx, dim0, dim1);
  auto sourceMemref = MemRefType::get({10, 5}, b.getIndexType(),
                                      AffineMap::get(2, 0, 1000 * dim0 + dim1));
  auto reducedType = SubViewOp::inferRankReducedResultType(
      /*resultShape=*/{2}, sourceMemref, {2, 3}, {1, 2}, {1, 1});
  auto expectedType = MemRefType::get(
      {2}, b.getIndexType(),
      StridedLayoutAttr::get(&ctx, /*offset=*/2003, /*strides=*/{1}));
  EXPECT_EQ(reducedType, expectedType);
}

TEST(InferShapeTest, inferRankReducedShapeToScalar) {
  MLIRContext ctx;
  OpBuilder b(&ctx);
  AffineExpr dim0, dim1;
  bindDims(&ctx, dim0, dim1);
  auto sourceMemref = MemRefType::get({10, 5}, b.getIndexType(),
                                      AffineMap::get(2, 0, 1000 * dim0 + dim1));
  auto reducedType = SubViewOp::inferRankReducedResultType(
      /*resultShape=*/{}, sourceMemref, {2, 3}, {1, 1}, {1, 1});
  auto expectedType = MemRefType::get(
      {}, b.getIndexType(),
      StridedLayoutAttr::get(&ctx, /*offset=*/2003, /*strides=*/{}));
  EXPECT_EQ(reducedType, expectedType);
}
