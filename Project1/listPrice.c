#include <stdio.h>

int main() {
	int manufacturerCost;
	int markupCost;
	double salesTax;
	double discount;

	double finalPrice;

	printf("Enter Manufacturer's Cost: \n");
	scanf("%d", &manufacturerCost);
	printf("Enter Dealer's Markup Cost: \n");
	scanf("%d", &markupCost);
	printf("Enter Local Sales Tax Percentage (0.0 - 100.0): \n");
	scanf("%lf", &salesTax);
	printf("Enter Pre Tax Discount Percentage (0.0 - 100.0): \n");
	scanf("%lf", &discount);

	printf("\n");

	finalPrice = (manufacturerCost + markupCost) * (1.0 - (discount / 100.0)) * (1.0 + (salesTax / 100.0)) ;
	printf("Final Estimated Price: %f \n",finalPrice);

	return 0;

}

