library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use ieee.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

package lib is
	-- register
	component reg is
	port (
	clk, rst: in std_logic;
	en: in std_logic;
	D: in signed (15 downto 0);
	Q: out signed (15 downto 0)
	);
	end component;
	
	--up counter
	component up_counter is
	port(
	clk, rst: in std_logic;
	inc_en: in std_logic;	
	stop: in  std_logic_vector(4 downto 0);	
	z: out std_logic;	
	count: out std_logic_vector(4 downto 0)
	);
	end component;

	-- datapath
	component datapath is
	port(
	clk, rst: in std_logic;
	t_in: in signed(15 downto 0);
	x_sel, y_sel, z_sel: in std_logic;
	x_next_sel, y_next_sel, z_next_sel: in std_logic;
	x_ld, y_ld, z_ld: in std_logic;
	x_next_ld, y_next_ld, z_next_ld: in std_logic;
	LUT_ld, result_ld: in std_logic;
	z_ge_0: out std_logic;	
	inc_en: in std_logic;
	i_rst: in std_logic;
	N: in std_logic_vector(4 downto 0);	--stop = N (=15)
	loop_done: out std_logic;
	mem_read_data: in signed(15 downto 0);
	LUT_addr: out std_logic_vector(4 downto 0);
	result_o: out signed(15 downto 0)
	);
	end component;

	--controller
	component controller is
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
	loop_done: in std_logic;
	i_rst: out std_logic;

	--comparator signal
	z_ge_0: in std_logic;	

	--memory controll signal
	mem_read_en: out std_logic;

	done_o: out std_logic
	);
	end component;

	--ExpApprox
	component ExpApprox is
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
	end component;

	--memory
	component memory is
	port(
	clk: in std_logic;
	re_in: in std_logic;
	addr: in std_logic_vector(4 downto 0);
	d_out: out signed(15 downto 0)
	);
	end component;
end lib;

	
