// Top-level module that defines the I/Os for the DE1-SoC board
module DE1_SoC(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;
	input [3:0] KEY;
	input [9:0] SW;
	input CLOCK_50;
	
	// Generate clk off of CLOCK_50, whichClock picks rate
	wire [31:0] clk;
	parameter whichClock = 25;
	clock_divider cdiv(CLOCK_50, clk);
	
	JohnsonCounter dut(LEDR[3:0], clk[whichClock], KEY[0]);
	assign HEX0 = 'b1;
	assign HEX1 = 'b1;
	assign HEX2 = 'b1;
	assign HEX3 = 'b1;
	assign HEX4 = 'b1;
	assign HEX5 = 'b1;
endmodule

// divided_clocks[0]=25MHz, [1]=12.5Mhz, ... [23]=3Hz, [24]=1.5Hz, [25]=0.75Hz
module clock_divider(clock, divided_clocks);
	input clock;
	output reg [31:0] divided_clocks;
	initial divided_clocks = 0;
	always @(posedge clock)
		divided_clocks = divided_clocks + 1;
endmodule 
