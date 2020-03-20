#include <stdio.h>
#include <string.h>

char src[] = "aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeeeeffffffffffgggggggggghhhhhhhhhhiiiiiiiiiijjjjjjjjjj";

int fun2() {
   return 2;
}

int fun1() {
   return 1;
}

int vulnerable() {
   int one;
   int two;
   char dest[5];

   printf("\ndest is 5 characters long: ");
   puts(dest);

   printf("\nCopying 100 char string into dest...\n");
   strcpy(dest, src); // This will cause a stack-based buffer overflow in C, but not Wasm
   printf("\ndest: ");
   puts(dest);

   // This will introduce terminator (0001) at char 10 in Wasm, but not C
   printf("\nPerforming function call one ");
   one = fun1(); 

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

