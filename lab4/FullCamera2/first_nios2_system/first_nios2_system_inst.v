	first_nios2_system u0 (
		.clk_clk                             (<connected-to-clk_clk>),                             //                          clk.clk
		.reset_reset_n                       (<connected-to-reset_reset_n>),                       //                        reset.reset_n
		.load_external_connection_export     (<connected-to-load_external_connection_export>),     //     load_external_connection.export
		.bicr_external_connection_export     (<connected-to-bicr_external_connection_export>),     //     bicr_external_connection.export
		.bics_external_connection_export     (<connected-to-bics_external_connection_export>),     //     bics_external_connection.export
		.transmit_external_connection_export (<connected-to-transmit_external_connection_export>), // transmit_external_connection.export
		.datain_external_connection_export   (<connected-to-datain_external_connection_export>),   //   datain_external_connection.export
		.dataout_external_connection_export  (<connected-to-dataout_external_connection_export>)   //  dataout_external_connection.export
	);

