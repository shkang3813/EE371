module DE1_SoC (CLOCK_50, KEY, LEDR, SW);
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50;
	
	wire transmit, load, loop;
	wire[3:0] bicS, bicR;
	wire[7:0] dataIn, dataOut;
	
	// generate clk off of CLOCK_50, whichClock picks rate.
	logic [31:0] clk;
	parameter whichClock = 0;
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
	
	sendblock sBlock(CLOCK_50, ~KEY[0], transmit, load, dataOut, loop, bicS);
	
	reciveblock rBlock(loop, CLOCK_50, ~KEY[0], bicR, dataIn);
	
	
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
