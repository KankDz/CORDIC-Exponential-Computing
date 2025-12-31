library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use ieee.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

package lib is
	-- register
	component reg is
	port (
	clk, clr: in std_logic;
	en: in std_logic;
	D: in signed (15 downto 0);
	Q: out signed (15 downto 0)
	);
	end component;
	
	--up counter
	component up_counter is
	port(
	clk, rst: in std_logic;
	inc_en: in std_logic;	--enable
	stop: in  std_logic_vector(3 downto 0);		--value dich
	complete_tick: out std_logic;	--flag da dat stop
	count: out std_logic_vector(3 downto 0)		--gia tri hien tai cua counter
	);
	end component;

	-- datapath
	component datapath is
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
	end component;

	--controller
end lib;

	
