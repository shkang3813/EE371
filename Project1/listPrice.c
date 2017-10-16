#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

static bool isInteger(char *input);

int main(int argc, char **argv) {
	// Initially declare all inputs as strings
	char *manufacturerCostString;
	char *markupCostString;
	char *salesTaxString;
	char *discountString;

	printf("Enter Manufacturer's Cost: \n");
	scanf("%s", &manufacturerCostString);
	printf("Enter Dealer's Markup Cost: \n");
	scanf("%s", &markupCostString);
	printf("Enter Local Sales Tax Percentage (0.0 - 100.0): \n");
	scanf("%s", &salesTaxString);
	printf("Enter Pre Tax Discount Percentage (0.0 - 100.0): \n");
	scanf("%s", &discountString);
	printf("\n");

	// Check if the inputs are valid
	if (!isInteger(manufacturerCostString)) {
		return EXIT_FAILURE;
	}
	if (!isInteger(markupCostString)) {
		return EXIT_FAILURE;
	}

	int manufacturerCost = atoi(manufacturerCostString);
	int markupCost = atoi(markupCostString);
	double salesTax = atof(salesTaxString);
	double discount = atof(discountString);

	double finalPrice;

	finalPrice = (manufacturerCost + markupCost) * (1.0 - (discount / 100.0)) * (1.0 + (salesTax / 100.0)) ;
	printf("Final Estimated Price: %f \n",finalPrice);

	return EXIT_SUCCESS;
}

// Checks whether the given string represents an integer
// Returns true if the given string represents an integer
static bool isInteger(char *input) {
    int length = strlen(input);
    for (int index = 0; index < length; index++) {
        char current = input[index];
        if (!isdigit(current)) {
            return 0;
        }
    }
    return 1;
}
