library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity up_counter is
	port(
	clk, rst: in std_logic;
	inc_en: in std_logic;	
	stop: in  std_logic_vector(4 downto 0);		
	z: out std_logic;	
	count: out std_logic_vector(4 downto 0)		
	);
end up_counter;

architecture behav of up_counter is
	constant start: std_logic_vector(4 downto 0) := "00001"; 	--initial i = 1
	signal temp_counter: std_logic_vector(4 downto 0) := start;
	signal one: std_logic_vector(4 downto 0) := "00001";
begin
	process(clk)
	begin
		if(clk'event and clk = '1') then
			if(rst = '1') then
				temp_counter <= start;
			elsif(inc_en = '1') then
				temp_counter <= temp_counter + one;
			end if;
		end if;
	end process;
	
	z <= '1' when temp_counter > stop else '0';
	count <= temp_counter;

end behav;
