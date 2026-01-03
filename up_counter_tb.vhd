library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.lib.ALL;

entity up_counter_tb is
end up_counter_tb;

architecture behav of up_counter_tb is
    signal clk_tb           : std_logic := '0';
    signal rst_tb           : std_logic := '0';
    signal inc_en_tb        : std_logic := '0';
    signal z_tb             : std_logic;
    signal count_tb         : std_logic_vector(4 downto 0);
    signal stop_tb          : std_logic_vector(4 downto 0) := "01111"; -- 10

    constant clk_period : time := 10 ns;
begin

    uut: up_counter
        port map (
            clk            => clk_tb,
            rst            => rst_tb,
            inc_en         => inc_en_tb,
            stop           => stop_tb,
            z	  	   => z_tb,
            count          => count_tb
        );

    	-- clock generator
	clk_tb <= not clk_tb after clk_period/2;

    	-- stimulus
    	stim_proc: process
   	 begin
       		-- reset 1 cycle
        	rst_tb <= '1';
        	wait for clk_period;
        	rst_tb <= '0';

        	-- enable count for enough cycles to reach stop (start=1 -> stop=10 needs 9 increments)
        	inc_en_tb <= '1';
        	wait for clk_period * 17;
        	inc_en_tb <= '0';
        	wait;
    	end process;

end behav;

