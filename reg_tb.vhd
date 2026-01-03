library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.lib.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_tb is
end reg_tb;

architecture behav of reg_tb is
	signal clk_tb : std_logic := '0';
	signal rst_tb : std_logic := '0';
    	signal en_tb  : std_logic := '0';
    	signal d_tb   : signed(15 downto 0) := (others => '0');
    	signal q_tb   : signed(15 downto 0);

	constant clk_period : time := 10 ns;
begin
	dut: reg port map(
	clk => clk_tb,
	rst => rst_tb,
        en  => en_tb,
        D => d_tb,
        Q => q_tb
	);

	--generate clock signal
	clk_tb <= not clk_tb after clk_period/2;

	stim_process : process
	begin
  		rst_tb <= '1';
       		wait for clk_period;
        	rst_tb <= '0';
        	wait for clk_period;

        	en_tb <= '1';
		d_tb <= to_signed(1, 16);
		wait for clk_period;

		en_tb <= '0';
		d_tb <= to_signed(255, 16);
		wait for clk_period;

		en_tb <= '1';
		d_tb <= to_signed(6, 16);
		wait for clk_period;

        	rst_tb <= '1';
        	wait for clk_period;
        	rst_tb <= '0';
        	wait;
	end process;
end behav;
