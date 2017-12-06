
module first_nios2_system (
	clk_clk,
	leds_external_connection_export,
	reset_reset_n,
	switches_external_connection_export);	

	input		clk_clk;
	output	[7:0]	leds_external_connection_export;
	input		reset_reset_n;
	input	[7:0]	switches_external_connection_export;
endmodule
