/* 
 * "Small Hello World" example. 
 * 
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example 
 * designs. It requires a STDOUT  device in your system's hardware. 
 *
 * The purpose of this example is to demonstrate the smallest possible Hello 
 * World application, using the Nios II HAL library.  The memory footprint
 * of this hosted application is ~332 bytes by default using the standard 
 * reference design.  For a more fully featured Hello World application
 * example, see the example titled "Hello World".
 *
 * The memory footprint of this example has been reduced by making the
 * following changes to the normal "Hello World" example.
 * Check in the Nios II Software Developers Manual for a more complete 
 * description.
 * 
 * In the SW Application project (small_hello_world):
 *
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 * In System Library project (small_hello_world_syslib):
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 *    - Define the preprocessor option ALT_NO_INSTRUCTION_EMULATION 
 *      This removes software exception handling, which means that you cannot 
 *      run code compiled for Nios II cpu with a hardware multiplier on a core 
 *      without a the multiply unit. Check the Nios II Software Developers 
 *      Manual for more details.
 *
 *  - In the System Library page:
 *    - Set Periodic system timer and Timestamp timer to none
 *      This prevents the automatic inclusion of the timer driver.
 *
 *    - Set Max file descriptors to 4
 *      This reduces the size of the file handle pool.
 *
 *    - Check Main function does not exit
 *    - Uncheck Clean exit (flush buffers)
 *      This removes the unneeded call to exit when main returns, since it
 *      won't.
 *
 *    - Check Don't use C++
 *      This builds without the C++ support code.
 *
 *    - Check Small C library
 *      This uses a reduced functionality C library, which lacks  
 *      support for buffering, file IO, floating point and getch(), etc. 
 *      Check the Nios II Software Developers Manual for a complete list.
 *
 *    - Check Reduced device drivers
 *      This uses reduced functionality drivers if they're available. For the
 *      standard design this means you get polled UART and JTAG UART drivers,
 *      no support for the LCD driver and you lose the ability to program 
 *      CFI compliant flash devices.
 *
 *    - Check Access device drivers directly
 *      This bypasses the device file system to access device drivers directly.
 *      This eliminates the space required for the device file system services.
 *      It also provides a HAL version of libc services that access the drivers
 *      directly, further reducing space. Only a limited number of libc
 *      functions are available in this configuration.
 *
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
 */

#include "sys/alt_stdio.h"
#include <system.h>
#include "altera_avalon_pio_regs.h"
#include <stdio.h>

char getChar(int ten) {
	if (ten == 0) {
		return '-';
	}
	return (char) (ten - 1 + 48);
}

int display(char data) {
	if (data == '-') {
		return 64;
	} else if (data == '0') {
		return 63;
	} else if (data == '1') {
		return 6;
	} else if (data == '2') {
		return 91;
	} else if (data == '3') {
		return 79;
	} else if (data == '4') {
		return 102;
	} else if (data == '5') {
		return 109;
	} else if (data == '6') {
		return 125;
	} else if (data == '7') {
		return 7;
	} else if (data == '8') {
		return 127;
	} else {
		return 103;
	}
}

int main() {
	alt_putstr("Welcome! Type \'S\' to start the camera system...");
	char in = alt_getchar();
	while (in != 'S') {
		in = alt_getchar();
	}
	IOWR_ALTERA_AVALON_PIO_DATA(START_BASE, 1);
	IOWR_ALTERA_AVALON_PIO_DATA(DOWNLOAD1_BASE, 1);
	IOWR_ALTERA_AVALON_PIO_DATA(DOWNLOAD2_BASE, 1);

	char data1 = '-', data2 = '-';
	IOWR_ALTERA_AVALON_PIO_DATA(HEX1_BASE, ~display(data1));
	IOWR_ALTERA_AVALON_PIO_DATA(HEX2_BASE, ~display(data2));
	printf("Buffer 1: %c   Buffer 2: %c\n", data1, data2);
	while (1) {
		char cur1 = getChar(IORD_ALTERA_AVALON_PIO_DATA(TENOUT1_BASE));
		char cur2 = getChar(IORD_ALTERA_AVALON_PIO_DATA(TENOUT2_BASE));
		if (cur1 != data1 || cur2 != data2) {
			printf("Buffer 1: %c   Buffer 2: %c\n", cur1, cur2);
			data1 = cur1;
			data2 = cur2;
		}
		IOWR_ALTERA_AVALON_PIO_DATA(HEX1_BASE, ~display(data1));
		IOWR_ALTERA_AVALON_PIO_DATA(HEX2_BASE, ~display(data2));
	}
	return 0;
}



