module DE1_SoC (CLOCK_50, KEY, LEDR, SW, HEX5, HEX2);
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50;
	input logic [6:0] HEX5, HEX2;
	
	logic rtd1, rtd2, start, download1, download2;
	logic [5:0] camState1, camState2;
	logic [6:0] camData1, camData2;
	logic [3:0] tenOut1, tenOut2;
	
	// Generate clk off of CLOCK_50, whichClock picks rate
	wire [31:0] clk;
	parameter whichClock = 0;
	clock_divider cdiv(CLOCK_50, clk);
	
	first_nios2_system sys(
		.camdata1_external_connection_export(camData1),  //  camdata1_external_connection.export
		.camdata2_external_connection_export(camData2),  //  camdata2_external_connection.export
		.camstate1_external_connection_export(camState1), // camstate1_external_connection.export
		.camstate2_external_connection_export(camState2), // camstate2_external_connection.export
		.clk_clk(CLOCK_50),                    //                           clk.clk
		.download1_external_connection_export(download1), // download1_external_connection.export
		.download2_external_connection_export(download2), // download2_external_connection.export
		.hex1_external_connection_export(HEX5),      //      hex1_external_connection.export
		.hex2_external_connection_export(HEX2),      //      hex2_external_connection.export
		.leds_external_connection_export(LEDR[7:0]),      //      leds_external_connection.export
		.reset_reset_n(KEY[0]),                        //                         reset.reset_n
		.rtd1_external_connection_export(rtd1),      //      rtd1_external_connection.export
		.rtd2_external_connection_export(rtd2),      //      rtd2_external_connection.export
		.start_external_connection_export(start),      //     start_external_connection.export
		.tenout1_external_connection_export(tenOut1),
		.tenout2_external_connection_export(tenOut2)
	);
	
	cameramanager manager(start, download1, download2, clk[whichClock], ~KEY[0], camState1, camState2,
								rtd1, rtd2, camData1, camData2, tenOut1, tenOut2);
endmodule

// divided_clocks[0]=25MHz, [1]=12.5Mhz, ... [23]=3Hz, [24]=1.5Hz, [25]=0.75Hz
module clock_divider(clock, divided_clocks);
	input clock;
	output reg [31:0] divided_clocks;
	initial divided_clocks = 0;
	always @(posedge clock)
		divided_clocks = divided_clocks + 1;
endmodule 
