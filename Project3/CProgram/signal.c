#include <stdio.h>

int main() {
	int devices;

	printf("Enter Number of Logic Devices in Path: \n");
	scanf("%d", &devices);

	double deviceDelay = 5 * devices;
	// number of gaps = number of devices - 1
	double gapDelay = .180 * .1 * (devices - 1);

	printf("%lf Picoseconds of Delay", deviceDelay + gapDelay);
	printf("\n");
}