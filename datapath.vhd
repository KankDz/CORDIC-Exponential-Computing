library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use ieee.STD_LOGIC_ARITH.ALL;
use work.lib.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
	port(
	clk, rst: in std_logic;
	t_in: in signed(15 downto 0);
	

	--register control signal
	x_sel, y_sel, z_sel: in std_logic;
	x_next_sel, y_next_sel, z_next_sel: in std_logic;
	x_ld, y_ld, z_ld: in std_logic;
	x_next_ld, y_next_ld, z_next_ld: in std_logic;
	LUT_ld, result_ld: in std_logic;

	--comparator signal
	z_ge_0: out std_logic;	

	--counter control signal
	inc_en: in std_logic;
	i_rst: in std_logic;
	N: in std_logic_vector(3 downto 0);	--stop = N (=15)
	complete_tick: out std_logic;
	
	--memory signal
	mem_read_data: in signed(15 downto 0);
	--LUT_addr: out std_logic_vector

	result: out signed(15 downto 0)
	);

end datapath;

architecture rtl of datapath is
	signal x_src, y_src, z_src: signed(15 downto 0);
	signal x_next, y_next, z_next: signed(15 downto 0);
	signal x_next_src, y_next_src, z_next_src: signed(15 downto 0);
	signal X_sub_Yshift, X_add_Yshift: signed(15 downto 0);	--signal for x_next
	signal Y_sub_Xshift, Y_add_Xshift: signed(15 downto 0);	--signal for y_next
	signal Z_add_LUTval, Z_sub_LUTval: signed(15 downto 0);	--signal for z_next
	signal X_add_Y: signed(15 downto 0);		--signal for result

	signal X, Y, Z: signed(15 downto 0);	
	signal temp_count: std_logic_vector(3 downto 0);
	signal Xshift, Yshift: signed(15 downto 0);
	
	signal LUTval: signed(15 downto 0);
	
	signal i_cnt: std_logic_vector(3 downto 0);
begin

	-- 2x1 Multiplexer for X
	x_src <= x"FFFF" when x_sel = '1' else x_next;

	-- 2x1 Multiplexer for Y
	y_src <= x"0000" when y_sel = '1' else y_next;
	
	-- 2x1 Multiplexer for Z
	z_src <= t_in when z_sel = '1' else z_next;

	-- 2x1 Multiplexer for X_next
	x_next_src <= X_sub_Yshift when x_next_sel = '1' else X_add_Yshift;

	-- 2x1 Multiplexer for Y_next
	y_next_src <= Y_sub_Xshift when y_next_sel = '1' else Y_add_Xshift;

	-- 2x1 Multiplexer for Z_next
	z_next_src <= Z_add_LUTval when z_next_sel = '1' else Z_sub_LUTval;

	-- compare Z greater than or equal 0 or not?
	z_ge_0 <= '1' when (Z >= 0) else '0';

	-- compare count (i) less than or equal N (15) or not?
	--cnt_le_N <= '1' when (temp_count <= N) else '0';

	-- X + Yshift
	X_add_Yshift <= (X + Yshift);

	-- X - Yshift
	X_sub_Yshift <= (X - Yshift);

	-- Y + Xshift
	Y_add_Xshift <= (Y + Xshift);

	-- Y - Xshift
	Y_sub_Xshift <= (Y - Xshift);

	-- Z + LUT
	Z_add_LUTval <= (Z + LUTval);

	-- Z - LUT
	Z_sub_LUTval <= (Z - LUTval);	

	--Register X
	reg_X: reg
	port map(clk, rst, x_ld, x_src, X);

	--Register Y
	reg_Y: reg
	port map(clk, rst, y_ld, y_src, Y);

	--Register Z
	reg_Z: reg
	port map(clk, rst, z_ld, z_src, Z);

	--Register X_next
	reg_X_next: reg
	port map(clk, rst, x_next_ld, x_next_src, x_next);

	--Register Y_next
	reg_Y_next: reg
	port map(clk, rst, y_next_ld, y_next_src, y_next);

	--Register Z_next
	reg_Z_next: reg
	port map(clk, rst, z_next_ld, z_next_src, z_next);

	--Register LUT
	reg_LUT: reg
	port map(clk, rst, LUT_ld, mem_read_data, LUTval);
	
	--Register Result
	reg_Result: reg
	port map(clk, rst, result_ld, X_add_Y, result);

	-- Up counter for i
	up_counter_i: up_counter
	port map(clk, rst, inc_en, N, complete_tick, i_cnt);

	--X shift
	--Xshift <= (X >> i_cnt);
	--Xshift <= std_logic_vector(shift_right(signed(X), to_integer(unsigned(i_cnt))));
	Xshift <= shift_right(X, to_integer(unsigned(i_cnt)));

	--Y shift
	--Yshift <= (Y >> i_cnt);	
	--Yshift <= std_logic_vector( shift_right( signed(Y), to_integer(unsigned(i_cnt)) ) );
	Yshift <= shift_right(Y, to_integer(unsigned(i_cnt)));

	
end rtl;