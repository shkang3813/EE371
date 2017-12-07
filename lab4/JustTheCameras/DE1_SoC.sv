// GPIO 19 is OUT
// GPIO 16 is IN

module DE1_SoC (CLOCK_50, KEY, LEDR, SW, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, GPIO);
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50;
	output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	inout logic [19:16] GPIO;
	
	// Processor UART wires
	wire transmit, load, loop;
	wire[3:0] bicS, bicR;
	wire[7:0] dataIn, dataOut;
	
	// generate clk off of CLOCK_50, whichClock picks rate.
	logic [31:0] clk;
	parameter whichClock = 5;
	clock_dividerA cdiv (CLOCK_50, clk);
	
	first_nios2_system sys(
		.bicr_external_connection_export(bicR),     //     bicr_external_connection.export
		.bics_external_connection_export(bicS),     //     bics_external_connection.export
		.clk_clk(CLOCK_50),                             //                          clk.clk
		.datain_external_connection_export(dataIn),   //   datain_external_connection.export
		.dataout_external_connection_export(dataOut),  //  dataout_external_connection.export
		.load_external_connection_export(load),     //     load_external_connection.export
		.reset_reset_n(KEY[0]),                       //                        reset.reset_n
		.transmit_external_connection_export(transmit)  // transmit_external_connection.export
	);
	
	// Camera UART wires
	logic camTransmit, camLoad;
	logic [3:0] camBicS, camBicR;
	logic [7:0] camDataIn, camDataOut;
	
	// For display purposes
	logic [6:0] datacam1n, datacam2n;
	logic [7:0] datacam1nn, datacam2nn;
	logic [11:0] HEXwritecam1, HEXwritecam2;
	
	assign datacam1nn[6:0] = datacam1n;
	assign datacam2nn[6:0] = datacam2n;
	assign datacam1nn[7] = 0;
	assign datacam2nn[7] = 0;
	logic bicRis9;
	assign LEDR[5] = bicRis9;
	logic [6:0] camData1, camData2;
	logic [5:0] cam1stn, cam2stn;
	
	newcamproject proj(clk[whichClock], ~KEY[0], camBicS, camDataIn, camDataOut, camTransmit, camLoad, datacam1n, datacam2n, cam1stn, cam2stn);
	
	con8to12 convertcam1 (.numberin(datacam1nn), .HEXwrite(HEXwritecam1));
	con8to12 convertcam2 (.numberin(datacam2nn), .HEXwrite(HEXwritecam2));
	
	// interface wires
	logic processorOut, processorIn;
	sendblock sBlockStation(CLOCK_50, ~KEY[0], transmit, load, dataOut, GPIO[19], bicS);
	reciveblock rBlockStation(GPIO[16], CLOCK_50, ~KEY[0], bicR, dataIn);
	
	logic dummy1, dummy2;
	sendblock sBlockCamera(CLOCK_50, ~KEY[0], camTransmit, camLoad, camDataOut, dummy2, camBicS);
	reciveblock rBlockCamera(dummy1, CLOCK_50, ~KEY[0], camBicR, camDataIn);
	
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
