library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg is
-- generic (DATA_WIDTH : integer := 16);
	port (
	clk, clr: in std_logic;
	en: in std_logic;
	D: in std_logic_vector (15 downto 0);
	Q: out std_logic_vector (15 downto 0)
	);
end reg;

architecture rtl of reg is
begin
	process(clk, clr)
	begin
	if(clr = '1') then
		Q <= (others => '0');
	elsif(clk'event and clk = '1') then
		if(en = '1') then
			Q <= D;
		end if;
	end if;
	end process;
end rtl;
