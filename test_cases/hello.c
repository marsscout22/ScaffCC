#include <stdio.h>

static void foo() {
  for (int i = 0; i < 10; i++) {
    printf("%d\n", i);
  }
}

int main(int argc, char *argv[]) {
  for (int i = 0; i < 10; i++) {
    printf("%d\n", i);
  }
  foo();
  return 0;
}
