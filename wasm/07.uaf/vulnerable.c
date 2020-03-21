#include <stdio.h>
#include <stdlib.h>

typedef struct somestruct {
  char *somestring;
  void (*func) (char *string);
} somestruct_type;

void boop(char *string) { 
  printf("boop: %s\n", string); 
}

void beep(char *string) { 
  printf("beep: %s\n", string); 
}

int main() {
  somestruct_type *a;
  a = malloc(sizeof(struct somestruct));

  a->func = boop;
  a->somestring = "beepboop";

  a->func("this print done by calling a->func() where func = boop");

  printf("freeing a without modifying it\n");
  free(a);
  a->func("this print done by calling a->func() where a was freed (use after free)");

  // free with modify
  printf("setting a to a different function\n");
  a->func = beep;
  printf("set a->func to beep\n");
  a->func("this print done by calling a->func() where func = beep");

  printf("setting a to null\n");
  a = NULL;

  printf("calling a->func() when a is null...\n");

  a->func("unreachable");

  printf("ending\n");
}
