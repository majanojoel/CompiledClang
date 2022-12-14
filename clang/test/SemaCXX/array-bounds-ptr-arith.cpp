// RUN: %clang_cc1 -verify -Wno-string-plus-int -Warray-bounds-pointer-arithmetic %s

void swallow (const char *x) { (void)x; }
void test_pointer_arithmetic(int n) {
  const char hello[] = "Hello world!"; // expected-note 2 {{declared here}}
  const char *helloptr = hello;

  swallow("Hello world!" + 6); // no-warning
  swallow("Hello world!" - 6); // expected-warning {{the pointer decremented by 6 refers before the beginning of the array}}
  swallow("Hello world!" + 14); // expected-warning {{the pointer incremented by 14 refers past the end of the array (that has type 'const char[13]')}}
  swallow("Hello world!" + 13); // no-warning

  swallow(hello + 6); // no-warning
  swallow(hello - 6); // expected-warning {{the pointer decremented by 6 refers before the beginning of the array}}
  swallow(hello + 14); // expected-warning {{the pointer incremented by 14 refers past the end of the array (that has type 'const char[13]')}}
  swallow(hello + 13); // no-warning

  swallow(helloptr + 6); // no-warning
  swallow(helloptr - 6); // no-warning
  swallow(helloptr + 14); // no-warning
  swallow(helloptr + 13); // no-warning

  double numbers[2]; // expected-note {{declared here}}
  swallow((char*)numbers + sizeof(double)); // no-warning
  swallow((char*)numbers + 60); // expected-warning {{the pointer incremented by 60 refers past the end of the array (that has type 'double[2]')}}

  char buffer[5]; // expected-note 2 {{declared here}}
  // TODO: Add FixIt notes for adding parens around non-ptr part of arith expr
  swallow(buffer + sizeof("Hello")-1); // expected-warning {{the pointer incremented by 6 refers past the end of the array (that has type 'char[5]')}}
  swallow(buffer + (sizeof("Hello")-1)); // no-warning
  if (n > 0 && n <= 6) swallow(buffer + 6 - n); // expected-warning {{the pointer incremented by 6 refers past the end of the array (that has type 'char[5]')}}
  if (n > 0 && n <= 6) swallow(buffer + (6 - n)); // no-warning
}
