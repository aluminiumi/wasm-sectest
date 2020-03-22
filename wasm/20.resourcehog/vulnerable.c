#include <stdio.h>
#include <stdlib.h>

int main( ) {
   int x;
   char *c;
   for(x = 0; x < 2000000; x++) {
      c = malloc(65535);
      printf("%p\n", c);
   }

   return 0;
}

