	component first_nios2_system is
		port (
			clk_clk                             : in  std_logic                    := 'X';             -- clk
			reset_reset_n                       : in  std_logic                    := 'X';             -- reset_n
			load_external_connection_export     : out std_logic;                                       -- export
			bicr_external_connection_export     : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			bics_external_connection_export     : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			transmit_external_connection_export : out std_logic;                                       -- export
			datain_external_connection_export   : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			dataout_external_connection_export  : out std_logic_vector(7 downto 0)                     -- export
		);
	end component first_nios2_system;

	u0 : component first_nios2_system
		port map (
			clk_clk                             => CONNECTED_TO_clk_clk,                             --                          clk.clk
			reset_reset_n                       => CONNECTED_TO_reset_reset_n,                       --                        reset.reset_n
			load_external_connection_export     => CONNECTED_TO_load_external_connection_export,     --     load_external_connection.export
			bicr_external_connection_export     => CONNECTED_TO_bicr_external_connection_export,     --     bicr_external_connection.export
			bics_external_connection_export     => CONNECTED_TO_bics_external_connection_export,     --     bics_external_connection.export
			transmit_external_connection_export => CONNECTED_TO_transmit_external_connection_export, -- transmit_external_connection.export
			datain_external_connection_export   => CONNECTED_TO_datain_external_connection_export,   --   datain_external_connection.export
			dataout_external_connection_export  => CONNECTED_TO_dataout_external_connection_export   --  dataout_external_connection.export
		);

