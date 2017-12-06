	first_nios2_system u0 (
		.clk_clk                              (<connected-to-clk_clk>),                              //                           clk.clk
		.reset_reset_n                        (<connected-to-reset_reset_n>),                        //                         reset.reset_n
		.leds_external_connection_export      (<connected-to-leds_external_connection_export>),      //      leds_external_connection.export
		.hex2_external_connection_export      (<connected-to-hex2_external_connection_export>),      //      hex2_external_connection.export
		.hex1_external_connection_export      (<connected-to-hex1_external_connection_export>),      //      hex1_external_connection.export
		.camstate2_external_connection_export (<connected-to-camstate2_external_connection_export>), // camstate2_external_connection.export
		.camstate1_external_connection_export (<connected-to-camstate1_external_connection_export>), // camstate1_external_connection.export
		.start_external_connection_export     (<connected-to-start_external_connection_export>),     //     start_external_connection.export
		.rtd2_external_connection_export      (<connected-to-rtd2_external_connection_export>),      //      rtd2_external_connection.export
		.rtd1_external_connection_export      (<connected-to-rtd1_external_connection_export>),      //      rtd1_external_connection.export
		.camdata2_external_connection_export  (<connected-to-camdata2_external_connection_export>),  //  camdata2_external_connection.export
		.camdata1_external_connection_export  (<connected-to-camdata1_external_connection_export>),  //  camdata1_external_connection.export
		.download2_external_connection_export (<connected-to-download2_external_connection_export>), // download2_external_connection.export
		.download1_external_connection_export (<connected-to-download1_external_connection_export>), // download1_external_connection.export
		.tenout1_external_connection_export   (<connected-to-tenout1_external_connection_export>),   //   tenout1_external_connection.export
		.tenout2_external_connection_export   (<connected-to-tenout2_external_connection_export>)    //   tenout2_external_connection.export
	);

