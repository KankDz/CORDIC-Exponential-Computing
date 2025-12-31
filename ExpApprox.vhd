library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ExpApprox is
	port(
	clk, rst: in std_logic;
	start_i: in std_logic;
	t_in: in signed(15 downto 0);
	N: in std_logic_vector(3 downto 0);
	mem_read_data: in signed(15 downto 0);
	--LUT_addr: out std_logic_vector();
	mem_read_en: out std_logic;
	done_o: out std_logic;
	result: out signed(15 downto 0)
	);
end ExpApprox;

architecture rtl of ExpApprox is
begin

end rtl;