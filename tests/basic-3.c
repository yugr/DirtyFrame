// Detect use-after-return

#include <stdio.h>
#include <string.h>

#define NOINLINE __attribute__((noinline, noclone))

NOINLINE
int check(int *p, size_t n) {
  size_t i;
  for(i = 0; i < n; ++i)
    if(p[i] != 0xcdcdcdcd)
      return 0;
  return 1;
}

NOINLINE
void fill(void *p, size_t n) {
  memset(p, 0, n);
}

NOINLINE
void *foo(size_t *n) {
  int buf[120];
  fill(buf, sizeof(buf));
  *n = sizeof(buf) / sizeof(buf[0]);
  int * volatile p = buf; // Silence compiler
  return p;
}

int main() {
  size_t n, i;
  int *p = foo(&n);
  for(i = 0; i < n; ++i) {
    if(p[i] != 0xcdcdcdcd) {
      printf("FAIL\n");
      return 1;
    }
  }
  printf("SUCCESS\n");
  return 1;
}
