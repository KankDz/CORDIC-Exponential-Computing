library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memory is
	port(
	clk: in std_logic;
	re_in: in std_logic;
	addr: in std_logic_vector(4 downto 0);
	d_out: out signed(15 downto 0)
	);
end memory;

architecture behav of memory is
	type lut_data is array(0 to 31)of signed(15 downto 0);
	signal lut_array: lut_data := (
	-- 
	1 => to_signed(4500, 16), 
	2 => to_signed(2092, 16),
        3 => to_signed(1029, 16), 
	4 => to_signed(513, 16),
        5 => to_signed(256, 16),  
	6 => to_signed(128, 16),
        7 => to_signed(64, 16),   
	8 => to_signed(32, 16),
        9 => to_signed(16, 16),   
	10 => to_signed(8, 16),
        11 => to_signed(4, 16),    
	12 => to_signed(2, 16),
        13 => to_signed(1, 16),    
	14 => to_signed(1, 16),
	15 => to_signed(0, 16),
	others => (others => '0')
	);
begin
	process(clk)
	begin
		if(clk'event and clk = '1') then
			if(re_in = '1') then
				d_out <= lut_array(to_integer(unsigned(addr)));
			else
				d_out <= (others => '0');
			end if;
		end if;
	end process;
end behav;
