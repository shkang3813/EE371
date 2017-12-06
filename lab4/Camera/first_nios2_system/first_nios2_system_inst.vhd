	component first_nios2_system is
		port (
			clk_clk                              : in  std_logic                    := 'X';             -- clk
			reset_reset_n                        : in  std_logic                    := 'X';             -- reset_n
			leds_external_connection_export      : out std_logic_vector(7 downto 0);                    -- export
			hex2_external_connection_export      : out std_logic_vector(6 downto 0);                    -- export
			hex1_external_connection_export      : out std_logic_vector(6 downto 0);                    -- export
			camstate2_external_connection_export : in  std_logic_vector(5 downto 0) := (others => 'X'); -- export
			camstate1_external_connection_export : in  std_logic_vector(5 downto 0) := (others => 'X'); -- export
			start_external_connection_export     : out std_logic;                                       -- export
			rtd2_external_connection_export      : in  std_logic                    := 'X';             -- export
			rtd1_external_connection_export      : in  std_logic                    := 'X';             -- export
			camdata2_external_connection_export  : in  std_logic_vector(6 downto 0) := (others => 'X'); -- export
			camdata1_external_connection_export  : in  std_logic_vector(6 downto 0) := (others => 'X'); -- export
			download2_external_connection_export : out std_logic;                                       -- export
			download1_external_connection_export : out std_logic;                                       -- export
			tenout1_external_connection_export   : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			tenout2_external_connection_export   : in  std_logic_vector(3 downto 0) := (others => 'X')  -- export
		);
	end component first_nios2_system;

	u0 : component first_nios2_system
		port map (
			clk_clk                              => CONNECTED_TO_clk_clk,                              --                           clk.clk
			reset_reset_n                        => CONNECTED_TO_reset_reset_n,                        --                         reset.reset_n
			leds_external_connection_export      => CONNECTED_TO_leds_external_connection_export,      --      leds_external_connection.export
			hex2_external_connection_export      => CONNECTED_TO_hex2_external_connection_export,      --      hex2_external_connection.export
			hex1_external_connection_export      => CONNECTED_TO_hex1_external_connection_export,      --      hex1_external_connection.export
			camstate2_external_connection_export => CONNECTED_TO_camstate2_external_connection_export, -- camstate2_external_connection.export
			camstate1_external_connection_export => CONNECTED_TO_camstate1_external_connection_export, -- camstate1_external_connection.export
			start_external_connection_export     => CONNECTED_TO_start_external_connection_export,     --     start_external_connection.export
			rtd2_external_connection_export      => CONNECTED_TO_rtd2_external_connection_export,      --      rtd2_external_connection.export
			rtd1_external_connection_export      => CONNECTED_TO_rtd1_external_connection_export,      --      rtd1_external_connection.export
			camdata2_external_connection_export  => CONNECTED_TO_camdata2_external_connection_export,  --  camdata2_external_connection.export
			camdata1_external_connection_export  => CONNECTED_TO_camdata1_external_connection_export,  --  camdata1_external_connection.export
			download2_external_connection_export => CONNECTED_TO_download2_external_connection_export, -- download2_external_connection.export
			download1_external_connection_export => CONNECTED_TO_download1_external_connection_export, -- download1_external_connection.export
			tenout1_external_connection_export   => CONNECTED_TO_tenout1_external_connection_export,   --   tenout1_external_connection.export
			tenout2_external_connection_export   => CONNECTED_TO_tenout2_external_connection_export    --   tenout2_external_connection.export
		);

