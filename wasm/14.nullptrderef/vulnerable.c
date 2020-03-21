#include <stdio.h>
#include <string.h>

int main( ) {
   int a = 2;
   int b, c;
   int *ptr;

   printf("a: %d, b: %d, c: %d, *ptr: %d\n", a,b,c,*ptr);
   printf("setting ptr to address of a\n");
   ptr = &a;
   printf("a: %d, b: %d, c: %d, *ptr: %d\n", a,b,c,*ptr);
   printf("setting b to value pointed to by ptr\n");
   b = *ptr;
   printf("a: %d, b: %d, c: %d, *ptr: %d\n", a,b,c,*ptr);
   printf("setting ptr to null\n");
   ptr = NULL;
   printf("setting c to value pointed to by ptr (null pointer dereference)\n");
   c = *ptr;

   return 0;
}

