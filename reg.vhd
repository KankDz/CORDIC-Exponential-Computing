library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg is
	port (
	clk, rst: in std_logic;
	en: in std_logic;
	D: in signed (15 downto 0);
	Q: out signed (15 downto 0)
	);
end reg;

architecture rtl of reg is
begin
	process(clk, rst)
	begin
	if(rst = '1') then
		Q <= (others => '0');
	elsif(clk'event and clk = '1') then
		if(en = '1') then
			Q <= D;
		end if;
	end if;
	end process;
end rtl;
