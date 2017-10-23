#include <stdio.h>

int main() {
	// Part 1
	int intOne;// = 1;
	int intTwo;// = 2;
	float floatOne;// = 1.0;
	float floatTwo;// = 2.0;
	char charOne;// = 'a';
	char charTwo;// = 'b';

	int *intPointer;
	float *floatPointer;
	char *charPointer;

	intPointer = &intOne;
	printf("%d\n", *intPointer);
	intPointer = &intTwo;
	printf("%d\n", *intPointer);

	floatPointer = &floatOne;
	printf("%f\n", *floatPointer);
	floatPointer = &floatTwo;
	printf("%f\n", *floatPointer);

	charPointer = &charOne;
	printf("%c\n", *charPointer);
	charPointer = &charTwo;
	printf("%c\n", *charPointer);


	// Part 2
	int A = 22;
	int B = 17;
	int C = 6;
	int D = 4;
	int E = 9;
	int result;

	int *aPointer = &A;
	int *bPointer = &B;
	int *cPointer = &C;
	int *dPointer = &D;
	int *ePointer = &E;


	result = ((*aPointer - *bPointer) * (*cPointer + *dPointer)) / *ePointer;
	printf("%d\n", result);

}