
module first_nios2_system (
	clk_clk,
	reset_reset_n,
	leds_external_connection_export,
	hex2_external_connection_export,
	hex1_external_connection_export,
	camstate2_external_connection_export,
	camstate1_external_connection_export,
	start_external_connection_export,
	rtd2_external_connection_export,
	rtd1_external_connection_export,
	camdata2_external_connection_export,
	camdata1_external_connection_export,
	download2_external_connection_export,
	download1_external_connection_export,
	tenout1_external_connection_export,
	tenout2_external_connection_export);	

	input		clk_clk;
	input		reset_reset_n;
	output	[7:0]	leds_external_connection_export;
	output	[6:0]	hex2_external_connection_export;
	output	[6:0]	hex1_external_connection_export;
	input	[5:0]	camstate2_external_connection_export;
	input	[5:0]	camstate1_external_connection_export;
	output		start_external_connection_export;
	input		rtd2_external_connection_export;
	input		rtd1_external_connection_export;
	input	[6:0]	camdata2_external_connection_export;
	input	[6:0]	camdata1_external_connection_export;
	output		download2_external_connection_export;
	output		download1_external_connection_export;
	input	[3:0]	tenout1_external_connection_export;
	input	[3:0]	tenout2_external_connection_export;
endmodule
