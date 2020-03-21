#include <stdio.h>
#include <string.h>

char src[] = "aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeeeeffffffffffgggggggggghhhhhhhhhhiiiiiiiiiijjjjjjjjjj";

int fun2() {
   char strfun2[] = "strfun2";
   printf("\nstrfun2: ");
   puts(strfun2);
   return 2;
}

int fun1(char *strfun1) {
   printf("\nstrfun1: ");
   puts(strfun1);
   return 1;
}

int vulnerable(char *mainstring) {
   int one = 0x41; // A
   int two = 0x42; // B
   char strfun1[] = "strfun1\n";
   char str1[] = "string1\n";
   char dest[5] = "cccc\0";
   char str2[] = "string2\n";

   printf("\ndest is 5 characters long: ");
   puts(dest);

   // Reveals that all variables declared before dest can be produced.
   // For Wasm, a string "./this.program" is also revealed, which is apparently argv[0] passed in by Emscripten-generated JS
   int x;
   for(x = 0; x < 512; x++) {
      printf("\ndest[%d]: ", x);
      puts(dest+x);
   }

   printf("\ndest[5]: "); // C returns "strfun1" but Wasm returns "string1"
   puts(dest+5);

   printf("\ndest[512]: ");
   puts(dest+512);

   printf("\ndest[1024]: "); 
   puts(dest+1024);

   printf("\ndest[4096]: "); // C returns shell environment variables, Wasm returns nothing
   puts(dest+4096);

   return 1;
}

int main( ) {
   int result = 0;
   char mainstring[] = "mainstring"; 
   result = vulnerable(mainstring);
   printf("Result: %d\n", result);
   return 0;
}

