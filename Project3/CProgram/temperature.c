#include <stdio.h>
#include <string.h>

int main() {
	double value;
	char currentScale[2];
	char outputScale[2];

	printf("Enter Temperature Value: \n");
	scanf("%lf", &value);

	printf("Enter Temperature Scale (C, F, K): \n");
    scanf("%s", currentScale);

    printf("Enter Conversion Scale (C, F, K): \n");
    scanf("%s", outputScale);

    char f[2] = "F";
    int selection = strcmp(currentScale, f);
    int next = strcmp(outputScale, f);
    // current is Celsius
    printf("Converted Value: ");
    if (selection < 0) {
    	if (next < 0) {
    		printf("%f", value);
    	} else if (next == 0) {
    		printf("%f", (value * 1.8) + 32);
    	} else {
    		printf("%f", value + 273.15);
    	}
    } else if (selection == 0) { // current is Fahrenheit
    	if (next < 0) {
    		printf("%f", (value - 32) / 1.8);
    	} else if (next == 0) {
    		printf("%f", value);
    	} else {
    		printf("%f", (value + 459.67) / 1.8);
    	}
    } else { // current is Kelvin
    	if (next < 0) {
    		printf("%f", value - 273.15);
    	} else if (next == 0) {
    		printf("%f", (value * 1.8) - 459.67);
    	} else {
    		printf("%f", value);
    	}
    }
    printf("\n");
    
}