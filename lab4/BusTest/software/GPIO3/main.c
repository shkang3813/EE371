#include <system.h>
#include "unistd.h"
#include <stdio.h>

#define switches (volatile char *) SWITCH_PIO_BASE
#define leds (char *) LED_PIO_BASE

int main() {
	while (1) {
		*leds = *switches;
		usleep(1000);
	}
	return 0;
}
