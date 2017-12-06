	component first_nios2_system is
		port (
			camdata1_external_connection_export  : in  std_logic_vector(6 downto 0) := (others => 'X'); -- export
			camdata2_external_connection_export  : in  std_logic_vector(6 downto 0) := (others => 'X'); -- export
			camstate1_external_connection_export : in  std_logic_vector(5 downto 0) := (others => 'X'); -- export
			camstate2_external_connection_export : in  std_logic_vector(5 downto 0) := (others => 'X'); -- export
			clk_clk                              : in  std_logic                    := 'X';             -- clk
			download1_external_connection_export : out std_logic;                                       -- export
			download2_external_connection_export : out std_logic;                                       -- export
			hex1_external_connection_export      : out std_logic_vector(6 downto 0);                    -- export
			hex2_external_connection_export      : out std_logic_vector(6 downto 0);                    -- export
			leds_external_connection_export      : out std_logic_vector(7 downto 0);                    -- export
			reset_reset_n                        : in  std_logic                    := 'X';             -- reset_n
			rtd1_external_connection_export      : in  std_logic                    := 'X';             -- export
			rtd2_external_connection_export      : in  std_logic                    := 'X';             -- export
			start_external_connection_export     : out std_logic;                                       -- export
			tenout1_external_connection_export   : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			tenout2_external_connection_export   : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			dataout_external_connection_export   : out std_logic_vector(7 downto 0);                    -- export
			datain_external_connection_export    : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			bicr_external_connection_export      : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			bics_external_connection_export      : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			load_external_connection_export      : out std_logic;                                       -- export
			transmit_external_connection_export  : out std_logic                                        -- export
		);
	end component first_nios2_system;

	u0 : component first_nios2_system
		port map (
			camdata1_external_connection_export  => CONNECTED_TO_camdata1_external_connection_export,  --  camdata1_external_connection.export
			camdata2_external_connection_export  => CONNECTED_TO_camdata2_external_connection_export,  --  camdata2_external_connection.export
			camstate1_external_connection_export => CONNECTED_TO_camstate1_external_connection_export, -- camstate1_external_connection.export
			camstate2_external_connection_export => CONNECTED_TO_camstate2_external_connection_export, -- camstate2_external_connection.export
			clk_clk                              => CONNECTED_TO_clk_clk,                              --                           clk.clk
			download1_external_connection_export => CONNECTED_TO_download1_external_connection_export, -- download1_external_connection.export
			download2_external_connection_export => CONNECTED_TO_download2_external_connection_export, -- download2_external_connection.export
			hex1_external_connection_export      => CONNECTED_TO_hex1_external_connection_export,      --      hex1_external_connection.export
			hex2_external_connection_export      => CONNECTED_TO_hex2_external_connection_export,      --      hex2_external_connection.export
			leds_external_connection_export      => CONNECTED_TO_leds_external_connection_export,      --      leds_external_connection.export
			reset_reset_n                        => CONNECTED_TO_reset_reset_n,                        --                         reset.reset_n
			rtd1_external_connection_export      => CONNECTED_TO_rtd1_external_connection_export,      --      rtd1_external_connection.export
			rtd2_external_connection_export      => CONNECTED_TO_rtd2_external_connection_export,      --      rtd2_external_connection.export
			start_external_connection_export     => CONNECTED_TO_start_external_connection_export,     --     start_external_connection.export
			tenout1_external_connection_export   => CONNECTED_TO_tenout1_external_connection_export,   --   tenout1_external_connection.export
			tenout2_external_connection_export   => CONNECTED_TO_tenout2_external_connection_export,   --   tenout2_external_connection.export
			dataout_external_connection_export   => CONNECTED_TO_dataout_external_connection_export,   --   dataout_external_connection.export
			datain_external_connection_export    => CONNECTED_TO_datain_external_connection_export,    --    datain_external_connection.export
			bicr_external_connection_export      => CONNECTED_TO_bicr_external_connection_export,      --      bicr_external_connection.export
			bics_external_connection_export      => CONNECTED_TO_bics_external_connection_export,      --      bics_external_connection.export
			load_external_connection_export      => CONNECTED_TO_load_external_connection_export,      --      load_external_connection.export
			transmit_external_connection_export  => CONNECTED_TO_transmit_external_connection_export   --  transmit_external_connection.export
		);

