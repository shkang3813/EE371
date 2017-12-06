
module first_nios2_system (
	camdata1_external_connection_export,
	camdata2_external_connection_export,
	camstate1_external_connection_export,
	camstate2_external_connection_export,
	clk_clk,
	download1_external_connection_export,
	download2_external_connection_export,
	hex1_external_connection_export,
	hex2_external_connection_export,
	leds_external_connection_export,
	reset_reset_n,
	rtd1_external_connection_export,
	rtd2_external_connection_export,
	start_external_connection_export,
	tenout1_external_connection_export,
	tenout2_external_connection_export,
	dataout_external_connection_export,
	datain_external_connection_export,
	bicr_external_connection_export,
	bics_external_connection_export,
	load_external_connection_export,
	transmit_external_connection_export);	

	input	[6:0]	camdata1_external_connection_export;
	input	[6:0]	camdata2_external_connection_export;
	input	[5:0]	camstate1_external_connection_export;
	input	[5:0]	camstate2_external_connection_export;
	input		clk_clk;
	output		download1_external_connection_export;
	output		download2_external_connection_export;
	output	[6:0]	hex1_external_connection_export;
	output	[6:0]	hex2_external_connection_export;
	output	[7:0]	leds_external_connection_export;
	input		reset_reset_n;
	input		rtd1_external_connection_export;
	input		rtd2_external_connection_export;
	output		start_external_connection_export;
	input	[3:0]	tenout1_external_connection_export;
	input	[3:0]	tenout2_external_connection_export;
	output	[7:0]	dataout_external_connection_export;
	input	[7:0]	datain_external_connection_export;
	input	[3:0]	bicr_external_connection_export;
	input	[3:0]	bics_external_connection_export;
	output		load_external_connection_export;
	output		transmit_external_connection_export;
endmodule
