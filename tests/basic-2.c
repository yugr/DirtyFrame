#include <stdio.h>

__attribute__((noinline, noclone))
int check(int *p, size_t n) {
  size_t i;
  for(i = 0; i < n; ++i)
    if(p[i] != 0xcdcdcdcd)
      return 0;
  return 1;
}

int foo() {
  int buf[120];
  return check(buf, sizeof(buf) / sizeof(buf[0]));
}

int main() {
  int good = foo();
  printf("%d", good);
  return good ? 0 : 1;
}
