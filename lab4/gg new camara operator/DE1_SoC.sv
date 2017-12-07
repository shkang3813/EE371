
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic				CLOCK_50; // 50MHz clock.
	output logic [6:0] 	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0]	LEDR;
	input logic	 [3:0]	KEY; //true when not pressed, false when pressed
	input logic  [9:0]	SW;

	
	
	
	


	// generate clk off of CLOCK_50, whichClock picks rate.
	logic [31:0] clk;
	parameter whichClock = 0;
	clock_dividerA cdiv (CLOCK_50, clk);
	

	//logic for meta
	logic [3:0] KEYin, KEYmeta;
	logic [9:0] SWin, SWmeta;
	

	//fix metaS
	always_ff @(posedge clk[whichClock]) begin
		KEYin <= KEY;
		SWin <= SW;
		
	end
	always_ff @(posedge clk[whichClock]) begin
		KEYmeta <= KEYin;
		SWmeta <= SWin;
	end
	
	//reset
	//logic reset;
	//assign reset = SW[8];
	
	logic dosomething1, dosomething2;
	assign dosomething1 = ~KEYmeta[2];
	assign dosomething2 = ~KEYmeta[1];
	
	logic ReToDload1, ReToDload2; 
	logic [5:0] cam1stn, cam2stn;
	logic [6:0] datacam1n, datacam2n;
	logic [7:0] datacam1nn, datacam2nn;
	logic [11:0] HEXwritecam1, HEXwritecam2;
	
	assign datacam1nn[6:0] = ~datacam1n;
	assign datacam2nn[6:0] = ~datacam2n;
	assign datacam1nn[7] = 0;
	assign datacam2nn[7] = 0;
	

	cameramanager thecams (.startsys(~KEYmeta[0]), .downloadresponce1(dosomething1), .downloadresponce2(dosomething2), 
									.clk(clk[whichClock]), .reset(~KEYmeta[3]), .cam1stn, .cam2stn, .ReToDload1, .ReToDload2,
									.datacam1n, .datacam2n);
	con8to12 convertcam1 (.numberin(datacam1nn), .HEXwrite(HEXwritecam1));
	con8to12 convertcam2 (.numberin(datacam2nn), .HEXwrite(HEXwritecam2));
	
	assign LEDR[5] = ~ReToDload1;
	assign LEDR[4] = ~ReToDload2;
	
	assign LEDR[0] = ~cam2stn[1] | ~cam2stn[3] | ~cam2stn[5];
	assign LEDR[1] = ~cam2stn[2] | ~cam2stn[3];
	assign LEDR[2] = ~cam2stn[4] | ~cam2stn[5];
	
	assign LEDR[7] = ~cam1stn[1] | ~cam1stn[3] | ~cam1stn[5];
	assign LEDR[8] = ~cam1stn[2] | ~cam1stn[3];
	assign LEDR[9] = ~cam1stn[4] | ~cam1stn[5];
	
	seg7 h0 (.bcd(HEXwritecam2[3:0]), .leds(HEX0));
	seg7 h1 (.bcd(HEXwritecam2[7:4]), .leds(HEX1));
	seg7 h2 (.bcd(HEXwritecam2[11:8]), .leds(HEX2));
	
	seg7 h3 (.bcd(HEXwritecam1[3:0]), .leds(HEX3));
	seg7 h4 (.bcd(HEXwritecam1[7:4]), .leds(HEX4));
	seg7 h5 (.bcd(HEXwritecam1[11:8]), .leds(HEX5));
	
	
	
endmodule	

// divided_closks[0] = 25MHz, [1] = 12.5MHz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...
module clock_dividerA (clock, divided_clocks);
	input logic				clock;
	output logic [31:0] 	divided_clocks;
	
	initial
		divided_clocks <= 0;
	
	always_ff @(posedge clock)
		divided_clocks <= divided_clocks + 1;
endmodule


module seg7 (bcd, leds);
	input logic [3:0] bcd;
	output logic [6:0] leds;

	//all led combinations for binary 0-9
	always_comb	
		case (bcd)
			//			   Light: 6543210
			4'b0000: leds = 7'b1000000; // 0
			4'b0001: leds = 7'b1111001; // 1
			4'b0010: leds = 7'b0100100; // 2
			4'b0011: leds = 7'b0110000; // 3
			4'b0100: leds = 7'b0011001; // 4
			4'b0101: leds = 7'b0010010; // 5
			4'b0110: leds = 7'b0000010; // 6
			4'b0111: leds = 7'b1111000; // 7
			4'b1000: leds = 7'b0000000; // 8
			4'b1001: leds = 7'b0010000; // 9
			default: leds = 7'bxxxxxxx;
		endcase
endmodule 