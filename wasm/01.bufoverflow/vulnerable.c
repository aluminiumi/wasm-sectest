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

int vulnerable() {
   int one;
   int two;
   char strfun1[] = "strfun1\n";
   char str1[] = "string1\n"; // gets overwritten with "aaaaabbbb..." in both C and Wasm (but includes truncation in Wasm)
   char dest[5];
   char str2[] = "string2\n"; // does not get overwritten in Wasm, but in C becomes "bbbbbbcccccccccc..."

   printf("\ndest is 5 characters long: ");
   puts(dest);

   printf("\nCopying 100 char string into dest...\n");
   strcpy(dest, src); // This will cause a stack-based buffer overflow in C, but not Wasm
   printf("\ndest: ");
   puts(dest);

   // This will introduce terminator (0001) at char 10 in Wasm, but not C
   printf("\nPerforming function call one ");
   one = fun1(strfun1); 

   printf("\ndest: ");
   puts(dest);

   // This will introduce terminator (0002) at char 6 in Wasm, but not C
   printf("\nPerforming function call two ");
   two = fun2(); 

   printf("\ndest: ");
   puts(dest);

   // Both Wasm and C will print chars 30-100
   printf("\ndest[30]: ");
   puts(dest+30);

   // Wasm prints up to char 6, C prints all characters from 3 onward
   printf("\ndest[3]: ");
   puts(dest+3);

   printf("\nstr1: ");
   puts(str1);
   printf("\nstr2: ");
   puts(str2);

   // Overflow in C, but not in Wasm
   return 1;
}

int main( ) {
   int result = 0; 
   result = vulnerable();
   printf("Result: %d\n", result);
   if (result == 1) {
	printf("No overflow occurred.\n");
   }
   return 0;
}

