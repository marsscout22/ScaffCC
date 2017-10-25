#include <stdio.h>

void foo() {
}

void bar() {
  printf("Hello world\n");
}

int main(int argc, char *argv[]) {
  for (int i = 0; i < 10; i++) {
    printf("%d\n", i);
  }
  bar();
  return 0;
}
