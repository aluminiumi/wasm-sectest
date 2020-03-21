#include <stdio.h>

int main( ) {
   unsigned int ffffffff = 0xFFFFFFFF;
   printf("uint: %u\n", ffffffff);
   ffffffff++;
   printf("uint after incrementing by 1: %u\n", ffffffff);

   int s = 0x7fffffff;
   printf("int: %d\n", s);
   s++;
   printf("int after incrementing by 1: %d\n", s);

   return 0;
}

