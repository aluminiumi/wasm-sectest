#include <stdio.h>
#include <stdlib.h>

typedef struct somestruct {
  char *somestring;
  void (*func) (char *string);
  void (*func2) ();
} somestruct_type;

void boop(char *string) { 
  printf("boop: %s\n", string); 
}

void beep(char *string) { 
  printf("beep: %s\n", string); 
}

void bop() { 
  printf("bop: bop\n"); 
}

int main() {
  somestruct_type *a;
  a = malloc(sizeof(struct somestruct));

  printf("a->func == %p\n", a->func);
  a->func = boop;
  printf("assigned a->func to boop; a->func == %p\n", a->func);

  a->somestring = "beepboop";

  a->func("this print done by calling a->func() where func = boop");

  printf("freeing a without modifying it\n");
  free(a);
  a->func("this print done by calling a->func() where a was freed (use after free)");

  // free with modify
  printf("setting a to a different function\n");
  a->func = beep;
  printf("set a->func to beep; a->func == %p\n", a->func);
  a->func("this print done by calling a->func() where func = beep");

  a->func2 = beep;
  printf("set a->func2 to beep; a->func2 == %p\n", a->func);
  a->func("this print done by calling a->func2() where func2 = beep");

  a->func = bop;
  printf("set a->func to bop; a->func == %p\n", a->func);
  //a->func("this print done by calling a->func() where func = bop"); // Wasm won't execute this
  
  a->func2 = 14;
  printf("set a->func2 to 14; a->func2 == %p\n", a->func2);
  //a->func2(); // Wasm won't execute; C segfaults

  a->func = 14;
  printf("set a->func to 14; a->func == %p\n", a->func);
  //a->func("this print done by calling a->func() where func = bop"); // Wasm won't execute; C segfaults

  printf("setting a to null\n");
  a = NULL;

  printf("calling a->func() when a is null...\n");

  a->func("unreachable"); // wasm won't execute; c segfaults

  printf("ending\n");
}
