
module first_nios2_system (
	clk_clk,
	reset_reset_n,
	load_external_connection_export,
	bicr_external_connection_export,
	bics_external_connection_export,
	transmit_external_connection_export,
	datain_external_connection_export,
	dataout_external_connection_export);	

	input		clk_clk;
	input		reset_reset_n;
	output		load_external_connection_export;
	input	[3:0]	bicr_external_connection_export;
	input	[3:0]	bics_external_connection_export;
	output		transmit_external_connection_export;
	input	[7:0]	datain_external_connection_export;
	output	[7:0]	dataout_external_connection_export;
endmodule
