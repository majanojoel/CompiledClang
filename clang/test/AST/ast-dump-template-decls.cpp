// Test without serialization:
// RUN: %clang_cc1 -std=c++17 -triple x86_64-unknown-unknown -ast-dump %s \
// RUN: | FileCheck -strict-whitespace %s
//
// Test with serialization:
// RUN: %clang_cc1 -std=c++17 -triple x86_64-unknown-unknown -emit-pch -o %t %s
// RUN: %clang_cc1 -x c++ -std=c++17 -triple x86_64-unknown-unknown -include-pch %t -ast-dump-all /dev/null \
// RUN: | sed -e "s/ <undeserialized declarations>//" -e "s/ imported//" \
// RUN: | FileCheck --strict-whitespace %s

template <typename Ty>
// CHECK: FunctionTemplateDecl 0x{{[^ ]*}} <{{.*}}:1, line:[[@LINE+2]]:10> col:6 a
// CHECK-NEXT: TemplateTypeParmDecl 0x{{[^ ]*}} <line:[[@LINE-2]]:11, col:20> col:20 referenced typename depth 0 index 0 Ty
void a(Ty);

template <typename... Ty>
// CHECK: FunctionTemplateDecl 0x{{[^ ]*}} <line:[[@LINE-1]]:1, line:[[@LINE+2]]:13> col:6 b
// CHECK-NEXT: TemplateTypeParmDecl 0x{{[^ ]*}} <line:[[@LINE-2]]:11, col:23> col:23 referenced typename depth 0 index 0 ... Ty
void b(Ty...);

template <typename Ty, typename Uy>
// CHECK: FunctionTemplateDecl 0x{{[^ ]*}} <line:[[@LINE-1]]:1, line:[[@LINE+3]]:14> col:6 c
// CHECK-NEXT: TemplateTypeParmDecl 0x{{[^ ]*}} <line:[[@LINE-2]]:11, col:20> col:20 referenced typename depth 0 index 0 Ty
// CHECK-NEXT: TemplateTypeParmDecl 0x{{[^ ]*}} <col:24, col:33> col:33 referenced typename depth 0 index 1 Uy
void c(Ty, Uy);

template <>
void c<float, int>(float, int);
// CHECK: FunctionDecl 0x{{[^ ]*}} prev 0x{{[^ ]*}} <line:[[@LINE-2]]:1, line:[[@LINE-1]]:30> col:6 c 'void (float, int)'
// CHECK: TemplateArgument type 'float'
// CHECK: TemplateArgument type 'int'

template <typename Ty, template<typename> typename Uy>
// CHECK: FunctionTemplateDecl 0x{{[^ ]*}} <line:[[@LINE-1]]:1, line:[[@LINE+4]]:18> col:6 d
// CHECK-NEXT: TemplateTypeParmDecl 0x{{[^ ]*}} <line:[[@LINE-2]]:11, col:20> col:20 referenced typename depth 0 index 0 Ty
// CHECK-NEXT: TemplateTemplateParmDecl 0x{{[^ ]*}} <col:24, col:52> col:52 depth 0 index 1 Uy
// CHECK-NEXT: TemplateTypeParmDecl 0x{{[^ ]*}} <col:33> col:41 typename depth 1 index 0
void d(Ty, Uy<Ty>);

template <class Ty>
// CHECK: FunctionTemplateDecl 0x{{[^ ]*}} <line:[[@LINE-1]]:1, line:[[@LINE+2]]:10> col:6 e
// CHECK-NEXT: TemplateTypeParmDecl 0x{{[^ ]*}} <line:[[@LINE-2]]:11, col:17> col:17 referenced class depth 0 index 0 Ty
void e(Ty);

template <int N>
// CHECK: FunctionTemplateDecl 0x{{[^ ]*}} <line:[[@LINE-1]]:1, line:[[@LINE+2]]:17> col:6 f
// CHECK-NEXT: NonTypeTemplateParmDecl 0x{{[^ ]*}} <line:[[@LINE-2]]:11, col:15> col:15 referenced 'int' depth 0 index 0 N
void f(int i = N);

template <typename Ty = int>
// CHECK: FunctionTemplateDecl 0x{{[^ ]*}} <line:[[@LINE-1]]:1, line:[[@LINE+3]]:10> col:6 g
// CHECK-NEXT: TemplateTypeParmDecl 0x{{[^ ]*}} <line:[[@LINE-2]]:11, col:25> col:20 referenced typename depth 0 index 0 Ty
// CHECK-NEXT: TemplateArgument type 'int'
void g(Ty);

template <typename = void>
// CHECK: FunctionTemplateDecl 0x{{[^ ]*}} <line:[[@LINE-1]]:1, line:[[@LINE+3]]:8> col:6 h
// CHECK-NEXT: TemplateTypeParmDecl 0x{{[^ ]*}} <line:[[@LINE-2]]:11, col:22> col:20 typename depth 0 index 0
// CHECK-NEXT: TemplateArgument type 'void'
void h();

template <typename Ty>
// CHECK: ClassTemplateDecl 0x{{[^ ]*}} <line:[[@LINE-1]]:1, line:[[@LINE+3]]:11> col:8 R
// CHECK-NEXT: TemplateTypeParmDecl 0x{{[^ ]*}} <line:[[@LINE-2]]:11, col:20> col:20 typename depth 0 index 0 Ty
// CHECK: ClassTemplateSpecialization 0x{{[^ ]*}} 'R'
struct R {};

template <>
// CHECK: ClassTemplateSpecializationDecl 0x{{[^ ]*}} <line:[[@LINE-1]]:1, line:[[@LINE+2]]:16> col:8 struct R definition
// CHECK: TemplateArgument type 'int'
struct R<int> {};

template <typename Ty, class Uy>
// CHECK: ClassTemplateDecl 0x{{[^ ]*}} <line:[[@LINE-1]]:1, line:[[@LINE+3]]:11> col:8 S
// CHECK-NEXT: TemplateTypeParmDecl 0x{{[^ ]*}} <line:[[@LINE-2]]:11, col:20> col:20 typename depth 0 index 0 Ty
// CHECK-NEXT: TemplateTypeParmDecl 0x{{[^ ]*}} <col:24, col:30> col:30 class depth 0 index 1 Uy
struct S {};

template <typename Ty>
// CHECK: ClassTemplatePartialSpecializationDecl 0x{{[^ ]*}} <line:[[@LINE-1]]:1, line:[[@LINE+4]]:20> col:8 struct S definition
// CHECK: TemplateArgument type 'type-parameter-0-0'
// CHECK: TemplateArgument type 'int'
// CHECK: TemplateTypeParmDecl 0x{{[^ ]*}} <line:[[@LINE-4]]:11, col:20> col:20 referenced typename depth 0 index 0 Ty
struct S<Ty, int> {};

template <auto>
// CHECK: ClassTemplateDecl 0x{{[^ ]*}} <line:[[@LINE-1]]:1, line:[[@LINE+2]]:11> col:8 T
// CHECK-NEXT: NonTypeTemplateParmDecl 0x{{[^ ]*}} <line:[[@LINE-2]]:11> col:15 'auto' depth 0 index 0
struct T {};

template <decltype(auto)>
// CHECK: ClassTemplateDecl 0x{{[^ ]*}} <line:[[@LINE-1]]:1, line:[[@LINE+2]]:11> col:8 U
// CHECK-NEXT: NonTypeTemplateParmDecl 0x{{[^ ]*}} <line:[[@LINE-2]]:11, col:24> col:25 'decltype(auto)' depth 0 index 0
struct U {};

template <typename Ty>
// CHECK: ClassTemplateDecl 0x{{[^ ]*}} <line:[[@LINE-1]]:1, line:[[@LINE+7]]:1> line:[[@LINE+2]]:8 V
// CHECK-NEXT: TemplateTypeParmDecl 0x{{[^ ]*}} <line:[[@LINE-2]]:11, col:20> col:20 typename depth 0 index 0 Ty
struct V {
  template <typename Uy>
  // CHECK: FunctionTemplateDecl 0x{{[^ ]*}} <line:[[@LINE-1]]:3, line:[[@LINE+2]]:10> col:8 f
  // CHECK-NEXT: TemplateTypeParmDecl 0x{{[^ ]*}} <line:[[@LINE-2]]:13, col:22> col:22 typename depth 1 index 0 Uy
  void f();
};

template <typename Ty>
template <typename Uy>
// CHECK: FunctionTemplateDecl 0x{{[^ ]*}} parent 0x{{[^ ]*}} prev 0x{{[^ ]*}} <line:[[@LINE-1]]:1, line:[[@LINE+2]]:18> col:13 f
// CHECK-NEXT: TemplateTypeParmDecl 0x{{[^ ]*}} <line:[[@LINE-2]]:11, col:20> col:20 typename depth 1 index 0 Uy
void V<Ty>::f() {}

namespace PR55886 {
template <class T> struct C {
  template <class U> using type1 = U(T);
};
using type2 = typename C<int>::type1<void>;
// CHECK:      TypeAliasDecl 0x{{[^ ]*}} <line:[[@LINE-1]]:1, col:42> col:7 type2 'typename C<int>::type1<void>':'void (int)'
// CHECK-NEXT: ElaboratedType 0x{{[^ ]*}} 'typename C<int>::type1<void>' sugar
// CHECK-NEXT: TemplateSpecializationType 0x{{[^ ]*}} 'type1<void>' sugar alias type1
// CHECK-NEXT: TemplateArgument type 'void'
// CHECK-NEXT: BuiltinType 0x{{[^ ]*}} 'void'
// CHECK-NEXT: FunctionProtoType 0x{{[^ ]*}} 'void (int)' cdecl
// CHECK-NEXT: BuiltinType 0x{{[^ ]*}} 'void'
// CHECK-NEXT: SubstTemplateTypeParmType 0x{{[^ ]*}} 'int' sugar class depth 0 index 0 T
// CHECK-NEXT: ClassTemplateSpecialization 0x{{[^ ]*}} 'C'
// CHECK-NEXT: BuiltinType 0x{{[^ ]*}} 'int'
} // namespace PR55886

namespace PR56099 {
template <typename... T> struct D {
  template <typename... U> struct bind {
    using bound_type = int(int (*...p)(T, U));
  };
};
template struct D<float, char>::bind<int, short>;
// CHECK:      TypeAliasDecl 0x{{[^ ]*}} <line:{{[1-9]+}}:5, col:45> col:11 bound_type 'int (int (*)(float, int), int (*)(char, short))'
// CHECK:      FunctionProtoType 0x{{[^ ]*}} 'int (int (*)(float, int), int (*)(char, short))' cdecl
// CHECK:      FunctionProtoType 0x{{[^ ]*}} 'int (float, int)' cdecl
// CHECK:      SubstTemplateTypeParmType 0x{{[^ ]*}} 'float' sugar typename depth 0 index 0 ... T pack_index 1
// CHECK-NEXT: ClassTemplateSpecialization 0x{{[^ ]*}} 'D'
// CHECK:      SubstTemplateTypeParmType 0x{{[^ ]*}} 'int' sugar typename depth 0 index 0 ... U pack_index 1
// CHECK-NEXT: ClassTemplateSpecialization 0x{{[^ ]*}} 'bind'
// CHECK:      FunctionProtoType 0x{{[^ ]*}} 'int (char, short)' cdecl
// CHECK:      SubstTemplateTypeParmType 0x{{[^ ]*}} 'char' sugar typename depth 0 index 0 ... T pack_index 0
// CHECK-NEXT: ClassTemplateSpecialization 0x{{[^ ]*}} 'D'
// CHECK:      SubstTemplateTypeParmType 0x{{[^ ]*}} 'short' sugar typename depth 0 index 0 ... U pack_index 0
// CHECK-NEXT: ClassTemplateSpecialization 0x{{[^ ]*}} 'bind'
} // namespace PR56099

namespace subst_default_argument {
template<class A1> class A {};
template<template<class C1, class C2 = A<C1>> class D1, class D2> using D = D1<D2>;

template<class E1, class E2> class E {};
using test1 = D<E, int>;
// CHECK:      TypeAliasDecl 0x{{[^ ]*}} <line:{{[1-9]+}}:1, col:23> col:7 test1 'D<subst_default_argument::E, int>':'subst_default_argument::E<int, subst_default_argument::A<int>>'
// CHECK:      TemplateSpecializationType 0x{{[^ ]*}} 'A<int>' sugar A
// CHECK-NEXT: |-TemplateArgument type 'int'
// CHECK-NEXT: | `-BuiltinType 0x{{[^ ]*}} 'int'
// CHECK-NEXT: `-RecordType 0x{{[^ ]*}} 'subst_default_argument::A<int>'
// CHECK-NEXT:   `-ClassTemplateSpecialization 0x{{[^ ]*}} 'A'
} // namespace subst_default_argument