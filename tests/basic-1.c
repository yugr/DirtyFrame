#include <stdio.h>

__attribute__((noinline, noclone))
int foo() {
  int x;
  int *p = &x;
  asm("" :: "r"(p));
  return *p;
}

int main() {
  int x = foo();
  printf("0x%x\n", x);
  return 0;
}
