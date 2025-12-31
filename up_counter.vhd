library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity up_counter is
	port(
	clk, rst: in std_logic;
	inc_en: in std_logic;	--enable
	stop: in  std_logic_vector(3 downto 0);		--value dich
	complete_tick: out std_logic;	--flag da dat stop
	count: out std_logic_vector(3 downto 0)		--gia tri hien tai cua counter
	);
end up_counter;

architecture behav of up_counter is
	constant start: std_logic_vector(3 downto 0) := "0001"; 	--initial i = 1
	signal temp_counter: std_logic_vector(3 downto 0) := start;
	signal one: std_logic_vector(3 downto 0) := "0001";
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
	
	complete_tick <= '1' when temp_counter = stop else '0';
	count <= temp_counter;

end behav;
