library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.lib.all;

entity ExpApprox is
	port(
	clk, rst: in std_logic;
	start_i: in std_logic;
	t_in: in signed(15 downto 0);
	N: in std_logic_vector(4 downto 0);
	mem_read_data: in signed(15 downto 0);
	LUT_addr: out std_logic_vector(4 downto 0);

	mem_read_en: out std_logic;

	done_o: out std_logic;
	result_o: out signed(15 downto 0)
	);
end ExpApprox;

architecture rtl of ExpApprox is
	signal x_sel, y_sel, z_sel: std_logic;
	signal x_next_sel, y_next_sel, z_next_sel: std_logic;
	signal x_ld, y_ld, z_ld: std_logic;
	signal x_next_ld, y_next_ld, z_next_ld: std_logic;
	signal LUT_ld, result_ld: std_logic;
	signal inc_en: std_logic;
	signal complete_tick: std_logic;
	signal i_rst: std_logic;
	signal z_ge_0: std_logic;
begin
	control_unit: controller
	port map(
	clk, rst,
	start_i,
	x_sel, y_sel, z_sel,
	x_next_sel, y_next_sel, z_next_sel,
	x_ld, y_ld, z_ld,
	x_next_ld, y_next_ld, z_next_ld,
	LUT_ld, result_ld,
	inc_en,
	complete_tick,
	i_rst,
	z_ge_0,	
	mem_read_en,
	done_o
	);

	datapath_unit: datapath
	port map(
	clk, rst,
	t_in,
	x_sel, y_sel, z_sel,
	x_next_sel, y_next_sel, z_next_sel,
	x_ld, y_ld, z_ld,
	x_next_ld, y_next_ld, z_next_ld,
	LUT_ld, result_ld,
	z_ge_0,
	inc_en,
	i_rst,
	N,	--stop=N(=15)
	complete_tick,
	mem_read_data,
	LUT_addr,
	result_o
	);
end rtl;