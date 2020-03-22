#include <stdio.h>
#include <string.h>

int main( ) {
   int a = 2;
   int b, c;
   int *ptr;
   int *ptr2;

   printf("a: %d, b: %d, c: %d, *ptr: %d, ptr: %p, *ptr2: %d\n", a,b,c,*ptr,ptr,*ptr2);
   printf("setting ptr to address of a\n");
   ptr = &a;
   printf("a: %d, b: %d, c: %d, *ptr: %d, *ptr2: %d\n", a,b,c,*ptr,*ptr2);
   printf("setting b to value pointed to by ptr\n");
   b = *ptr;
   printf("a: %d, b: %d, c: %d, *ptr: %d, *ptr2: %d\n", a,b,c,*ptr,*ptr2);
   printf("setting ptr to null\n");
   ptr = NULL;
   printf("setting c to value pointed to by ptr (null pointer dereference)\n");
   c = *ptr;

   return 0;
}

