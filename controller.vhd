library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.lib.ALL;
use IEEE.NUMERIC_STD.ALL;

entity controller is
	port(
	clk, rst: in std_logic;
	start_i: in std_logic;
	
	-- register control signal
	x_sel, y_sel, z_sel: out std_logic;
	x_next_sel, y_next_sel, z_next_sel: out std_logic;
	x_ld, y_ld, z_ld: out std_logic;
	x_next_ld, y_next_ld, z_next_ld: out std_logic;
	LUT_ld, result_ld: out std_logic;

	-- counter control signal
	inc_en: out std_logic;
	complete_tick: in std_logic;
	i_rst: out std_logic;

	--comparator signal
	z_ge_0: in std_logic;	

	--memory controll signal
	mem_read_en: out std_logic;

	done_o: out std_logic
	);
end controller;

architecture behav of controller is
	type state_type is (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12);
	signal state: state_type;
begin 
	-- state transition process
	FSM: process(clk, rst)
	begin
		if(rst = '1') then
			state <= S0;
		elsif (clk'event and clk = '1') then
		case state is
			when S0 =>
				state <= S1;
			when S1 => 
				if (start_i = '1') then
					state <= S2;
				end if;
			when S2 =>
				state <= S3;
			when S3 => 
				if (complete_tick = '1') then
					state <= S4;
				else
					state <= S10;
				end if;
			when S4 =>
				state <= S5;
			when S5 =>
				if (z_ge_0 = '1') then
					state <= S6;
				else
					state <= S7;
				end if;
			when S6 =>
				state <= S8;
			when S7 =>
				state <= S8;

			when S8 =>
				state <= S9;
			when S9 =>
				state <= S3;
			when S10 =>
				state <= S11;
			when S11 =>
				state <= S12;
			when S12 =>
				state <= S0;
			when others =>
				state <= S0;
		end case;
		end if;
	end process;

	-- //*combinational logic*// --
	 
	-- register control signal
	x_sel <= '1' when state = S2 else '0';
	x_ld <= '1' when (state = S2 or state = S8) else '0';
	y_sel <= '1' when state = S2 else '0';
	y_ld <= '1' when (state = S2 or state = S8) else '0';
	z_sel <= '1' when state = S2 else '0';
	z_ld <= '1' when (state = S2 or state = S8) else '0';
	x_next_sel <= '1' when state = S7 else '0';
	x_next_ld <= '1' when (state = S6 or state = S7) else '0';
	y_next_sel <= '1' when state = S7 else '0';
	y_next_ld <= '1' when (state = S6 or state = S7) else '0';
	z_next_sel <= '1' when state = S7 else '0';
	z_next_ld <= '1' when (state = S6 or state = S7) else '0';
	result_ld <= '1' when state = S10 else '0';

	-- counter control signal
	i_rst <= '1' when (state = S0 or state = S2) else '0';
	inc_en <= '1' when state = S9 else '0';
	

	-- memory control signal

	-- memory access
	
	done_o <= '1' when (state = S11) else '0';
	
end behav;
