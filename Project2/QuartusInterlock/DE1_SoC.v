// Top-level module that defines the I/Os for the DE1-SoC board
module DE1_SoC(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;
	input [3:0] KEY;
	input [9:0] SW;
	input CLOCK_50;
	
	// Generate clk off of CLOCK_50, whichClock picks rate
	wire [31:0] clk;
	parameter whichClock = 14;
	clock_divider cdiv(CLOCK_50, clk);
	
	wire[7:0] pressure;
	wire[7:0] fiveCount;
	assign fiveCount[7:6] = 2'b00;
	SystemInterface sInterface(LEDR[8], LEDR[9], pressure[7:0], fiveCount[5:0], LEDR[7],
			LEDR[6], SW[9], SW[8], ~KEY[2], ~KEY[3], clk[whichClock], ~KEY[0]);
			
	wire[11:0] bcd;
	con8to12 convertToBCD(pressure, bcd);
	wire[11:0] fiveBcd;
	con8to12 convertFiveToBCD(fiveCount, fiveBcd);
	
	SevenSeg seg0(fiveBcd[7:4], HEX0[6:0]);
	assign HEX1 = 7'b1111111;
	SevenSeg seg1(bcd[3:0], HEX2[6:0]);
	SevenSeg seg2(bcd[7:4], HEX3[6:0]);
	assign HEX4 = 7'b1111111;
	SevenSeg seg3(bcd[11:8], HEX5[6:0]);
endmodule

// divided_clocks[0]=25MHz, [1]=12.5Mhz, ... [23]=3Hz, [24]=1.5Hz, [25]=0.75Hz
module clock_divider(clock, divided_clocks);
	input clock;
	output reg [31:0] divided_clocks;
	initial divided_clocks = 0;
	always @(posedge clock)
		divided_clocks = divided_clocks + 1;
endmodule 
