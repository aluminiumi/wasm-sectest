#include <stdio.h>
#include <string.h>

char src[] = "aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeeeeffffffffffgggggggggghhhhhhhhhhiiiiiiiiiijjjjjjjjjj";

int fun2() {
   char strfun2[] = "strfun2";
   printf("stack string: %s\n", strfun2);
   return 2;
}

int fun1(char *strfun1) {
   printf("ptr string: %s\n", strfun1);
   return 1;
}

int vulnerable() {
   // establish some variables on the stack frame
   int one;
   int two;
   char strfun1[] = "strfun1\n";
   char str1[] = "string1\n"; // gets overwritten with "aaaaabbbb..." in both C and Wasm
   char dest[5];
   char str2[] = "string2\n"; // does not get overwritten in Wasm, but in C becomes "bbbbbbcccccccccc..."

   // print out uninitialized dest data
   printf("dest is 5 characters long: %s\n", dest);

   // copy 100 chars into 5-char buffer
   printf("Copying 100 char string into dest...\n");
   strcpy(dest, src); // This will cause a stack-based buffer overflow in C, but not Wasm
   printf("dest: %s\n", dest);

   // This will introduce terminator (0001) at char 10 in Wasm, but not C
   printf("Performing function call one\n");
   one = fun1(strfun1); 
   printf("dest: %s\n", dest);

   // This will introduce terminator (0002) at char 6 in Wasm, but not C
   printf("Performing function call two\n");
   two = fun2(); 
   printf("dest: %s\n", dest);

   // Both Wasm and C will print chars 30-100
   printf("dest[30]: %s\n", dest+30);

   // Wasm prints up to char 6, C prints all characters from 3 onward
   printf("dest[3]: %s\n", dest+3);

   printf("str1: %s\n", str1);
   printf("str2: %s\n", str2);

   // Stack smashing in C, but not in Wasm
   return 1;
}

int main( ) {
   int result = 0; 
   result = vulnerable();
   printf("Result: %d\n", result);
   if (result == 1) {
	printf("No stack smashing occurred.\n");
   }
   return 0;
}

