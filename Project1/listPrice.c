#include <stdio.h>

int main() {
	int manufacturerCost;
	int markupCost;
	double salesTax;
	double discount;

	double finalPrice;
	
	// Gets the Manufacturer's Cost positive integer value
	printf("Enter Manufacturer's Cost: \n");
	scanf("%d", &manufacturerCost);

	// Gets the Dealer's Markup Cost positive integer value
	printf("Enter Dealer's Markup Cost: \n");
	scanf("%d", &markupCost);

	// Gets the local Sales Tax double ranging from 0.0 to 100.0
	printf("Enter Local Sales Tax Percentage (0.0 - 100.0): \n");
	scanf("%lf", &salesTax);

	// Gets the pretaxed Discount Percentage double ranging from 0.0 to 100.0
	printf("Enter Pre Tax Discount Percentage (0.0 - 100.0): \n");
	scanf("%lf", &discount);

	printf("\n");
	
	// Performs Calculation
	// Note: we tax on the discounted amount
	finalPrice = (manufacturerCost + markupCost) * (1.0 - (discount / 100.0)) * (1.0 + (salesTax / 100.0)) ;
	printf("Final Estimated Price: %f \n",finalPrice);
	
	// Exits program
	return 0;

}
