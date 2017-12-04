module DE1_SoC (CLOCK_50, KEY, LEDR, SW);
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50;
	
	first_nios2_system sys(
		.clk_clk(CLOCK_50),                          //                       clk.clk
		.led_pio_external_connection_export(LEDR[7:0]), // pio_0_external_connection.export
		.reset_reset_n(KEY[0]),
		.switch_pio_external_connection_export(SW[7:0]) //                     reset.reset_n
	);
	
	
endmodule
