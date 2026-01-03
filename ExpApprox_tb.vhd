library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.lib.all;

entity ExpApprox_tb is
end ExpApprox_tb;

architecture behav of ExpApprox_tb is
  signal clk, start_i: std_logic := '0';
  signal rst: std_logic := '1';

  signal t_in : signed(15 downto 0) := (others => '0');
  signal N    : std_logic_vector(4 downto 0) := std_logic_vector(to_unsigned(15, 5)); -- N=15

  -- DUT <-> memory
  signal mem_read_en   : std_logic;
  signal LUT_addr      : std_logic_vector(4 downto 0);
  signal mem_read_data : signed(15 downto 0);

  --output
  signal done_o : std_logic;
  signal result_o : signed(15 downto 0);

  constant clk_period : time := 10 ns;

  constant SCALE : real := 8192.0;  -- Q3.13

  function q3_13_to_real(x : signed(15 downto 0)) return real is
  begin
    return real(to_integer(x)) / SCALE;
  end function;
  

  --list of t_in
  type vec16 is array(natural range <>) of signed(15 downto 0);
  constant T_LIST : vec16 := (
    	to_signed(-8192,16), -- = -1.0
	to_signed(-6144,16), -- = -0.75
	to_signed(-4096,16), -- = -0.5
	to_signed(-2048,16), --	= -0.25
    	to_signed(0,16),     -- = 0.0
    	to_signed(2048,16),  -- = 0.25
	to_signed(4096,16),  -- = 0.5
	to_signed(6144,16),  -- = 0.75
	to_signed(8192,16)   -- =1.0
  );

begin
  -- generate clock
  clk <= not clk after clk_period/2;

  -- DUT
  dut: ExpApprox
    port map(
      clk           => clk,
      rst           => rst,
      start_i       => start_i,
      t_in          => t_in,
      N             => N,
      mem_read_data => mem_read_data,
      LUT_addr      => LUT_addr,
      mem_read_en   => mem_read_en,
      done_o        => done_o,
      result_o      => result_o
    );

  --LUT
  mem: memory
    port map(
      clk   => clk,
      re_in => mem_read_en,
      addr  => LUT_addr,
      d_out => mem_read_data
    );

  stim: process
  begin
    -- init
    start_i <= '0';
    t_in    <= (others => '0');

    -- reset vài chu k?, nh? reset ?úng c?nh lên ?? gi?m warning U/X
    rst <= '1';
    wait for 2*clk_period;
    wait until rising_edge(clk);
    rst <= '0';

    	--test case 1: t_in = -0.5 (-4096)
   	t_in <= to_signed(-4096,16);
	wait until rising_edge(clk);
	
	start_i <= '1';
	wait until rising_edge(clk);
	
	wait until done_o = '1';
	 report "----------------------------------------";
    report "t_in     = " & real'image(q3_13_to_real(t_in));
    report "result_o = " & real'image(q3_13_to_real(result_o));
    report "exp_ref  = " & real'image(exp(q3_13_to_real(t_in)));

	start_i <= '0';
	wait until rising_edge(clk);
	wait for clk_period * 2;

	--test case 2: t_in = 0.25 (2048)
   	t_in <= to_signed(2048,16);
	wait until rising_edge(clk);
	
	start_i <= '1';
	wait until rising_edge(clk);
	
	wait until done_o = '1';
	 report "----------------------------------------";
    report "t_in     = " & real'image(q3_13_to_real(t_in));
    report "result_o = " & real'image(q3_13_to_real(result_o));
    report "exp_ref  = " & real'image(exp(q3_13_to_real(t_in)));

	start_i <= '0';
	wait until rising_edge(clk);
	wait for clk_period * 2;

	--test case 3: t_in = 0,75 (6144)
   	t_in <= to_signed(6144,16);
	wait until rising_edge(clk);
	
	start_i <= '1';
	wait until rising_edge(clk);
	
	wait until done_o = '1';
	 report "----------------------------------------";
    report "t_in     = " & real'image(q3_13_to_real(t_in));
    report "result_o = " & real'image(q3_13_to_real(result_o));
    report "exp_ref  = " & real'image(exp(q3_13_to_real(t_in)));

	start_i <= '0';
	wait until rising_edge(clk);
	wait for clk_period * 2;
    -- ch?y t?ng test vector
    --for k in T_LIST'range loop
      -- ??t input tr??c khi start
     -- t_in <= T_LIST(k);
    --  wait until rising_edge(clk);

      -- start pulse 1 chu k?
    --  start_i <= '1';
    --  wait until rising_edge(clk);
   --   start_i <= '0';

      -- ch? done (done_o th??ng lên 1 chu k?)
    --  wait until done_o = '1';
    --  wait until rising_edge(clk);

      -- ngh? vài chu k? ?? b?n d? nhìn waveform tách t?ng case
    --  wait for 5*clk_period;
  --  end loop;
    wait;
  end process;

end behav;


