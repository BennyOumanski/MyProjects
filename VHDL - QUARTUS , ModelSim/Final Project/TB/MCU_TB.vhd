-- ============================================================
-- mcu_fir_tb.vhd
-- Simple top-level testbench for MCU focusing on FIR_Filter path.
-- - NO ITCM/DTCM loading here (assumed handled inside your memory models)
-- - Generates clock/reset/ena
-- - Leaves UART_RX idle high
-- - Provides optional KEY pulses (active-low) for interrupt-driven flows
-- - Prints HEX/LED changes to the transcript for quick sanity checks
-- - Ends after RUN_TIME
-- ============================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mcu_fir_tb is
end entity;

architecture tb of mcu_fir_tb is
  ----------------------------------------------------------------
  -- Clock / Reset
  ----------------------------------------------------------------
  constant Tclk     : time := 20 ns;     -- 50 MHz system clock
  signal   clock    : std_logic  := '0' ;
  signal   reset    : std_logic ;
  signal   ena      : std_logic ;

  constant RUN_TIME : time := 5 ms;      -- sim duration

  ----------------------------------------------------------------
  -- DUT ports
  ----------------------------------------------------------------
  signal HEX0,HEX1,HEX2 : std_logic_vector(6 downto 0);
  signal HEX3,HEX4,HEX5 : std_logic_vector(6 downto 0);
  signal LEDR           : std_logic_vector(7 downto 0);
  signal Switches       : std_logic_vector(7 downto 0) := (others => '0');
  signal BTOUT          : std_logic;
  signal KEY1, KEY2, KEY3 : std_logic := '1';  -- active-low keys
  signal UART_RX        : std_logic := '1';    -- idle high
  signal UART_TX        : std_logic;
  signal delayed_clock_s  : std_logic :='0' ;  -- delayed clock for FIR core
  -- -- simple helpers
  -- impure function slv_to_string(s: std_logic_vector) return string is
  --   variable r : string(1 to s'length);
  -- begin
  --   for i in s'range loop
  --     r(s'length - i) := character'VALUE( '0' + integer'VALUE(s(i) = '1') );
  --   end loop;
  --   return r;
  -- end function;

  -- procedure press_key(signal key: out std_logic; low_cycles: natural := 2) is
  -- begin
  --   key <= '0';
  --   for i in 1 to low_cycles loop
  --     wait until rising_edge(clock);
  --   end loop;
  --   key <= '1';
  -- end procedure;

begin
  ----------------------------------------------------------------
  -- Clock + reset/enable sequencing
  ----------------------------------------------------------------
  --clock <= not clock after Tclk/2;

gen_clk1:
  process
  begin
  clock <= '1';
  wait for 10 ns ;
  clock <= not clock ;
  wait for 10 ns ;
  end process ;
  --delayed_clock <= not clock after Tclk/2;

gen_clk2:
  process
  begin
  delayed_clock_s <= '1';
  wait for 10000 ns ;
  delayed_clock_s <= not delayed_clock_s ;
  wait for 10000 ns ;
  end process ;

  reset_proc : process
  begin
    -- hold reset a bit, then release and enable core
    reset <= '1';
    ena   <= '0';
    wait for 200 ns;
    reset <= '0';
    wait for 10 ns;
    ena   <= '1';
    wait;
  end process;

  ----------------------------------------------------------------
  -- DUT
  ----------------------------------------------------------------
  U_MCU : entity work.MCU
    generic map (
      MemWidth    => 10,
      SIM         => TRUE,   -- important: lets internal models use sim init paths
      CtrlBusSize => 8,
      AddrBusSize => 32,
      DataBusSize => 32,
      IrqSize     => 7,
      RegSize     => 8
    )
    port map (
      reset    => reset,
      clock    => clock,
      delayed_clock => delayed_clock_s,
      ena      => ena,
      HEX0     => HEX0, HEX1 => HEX1, HEX2 => HEX2,
      HEX3     => HEX3, HEX4 => HEX4, HEX5 => HEX5,
      LEDR     => LEDR,
      Switches => Switches,
      BTOUT    => BTOUT,
      KEY1     => KEY1,
      KEY2     => KEY2,
      KEY3     => KEY3
      --UART_RX  => UART_RX,
      --UART_TX  => UART_TX
    );

  ----------------------------------------------------------------
  -- Stimulus
  ----------------------------------------------------------------
  -- stim : process
  -- begin
  --   -- wait for reset to deassert and a few clocks
  --   wait until reset = '0';
  --   for i in 1 to 5 loop
  --     wait until rising_edge(clock);
  --   end loop;

  --   -- optional: set some switches if your firmware reads them
  --   Switches <= x"A5";

  --   -- OPTIONAL: generate key pulses (active-low) if your program
  --   -- uses keypad IRQs to kick off FIR or to step phases.
  --   wait for 50 us;  press_key(KEY1, 2);
  --   wait for 50 us;  press_key(KEY2, 2);
  --   wait for 50 us;  press_key(KEY3, 2);

  --   -- let the program run
  --   wait for RUN_TIME;
  --   report "MCU FIR test completed (time limit reached)" severity note;
  --   std.env.finish;
  -- end process;

  ----------------------------------------------------------------
  -- Monitors (print on change for quick feedback)
  ----------------------------------------------------------------
  -- mon_led : process
  --   variable last_led : std_logic_vector(7 downto 0) := (others => 'X');
  -- begin
  --   wait until rising_edge(clock);
  --   if LEDR /= last_led then
  --     report "LEDR <= 0x" & to_hstring(LEDR);
  --     last_led := LEDR;
  --   end if;
  -- end process;

  -- mon_hex : process
  --   variable h0,h1,h2,h3,h4,h5 : std_logic_vector(6 downto 0) := (others=>'X');
  -- begin
  --   wait until rising_edge(clock);
  --   if HEX0 /= h0 then report "HEX0 = " & slv_to_string(HEX0); h0 := HEX0; end if;
  --   if HEX1 /= h1 then report "HEX1 = " & slv_to_string(HEX1); h1 := HEX1; end if;
  --   if HEX2 /= h2 then report "HEX2 = " & slv_to_string(HEX2); h2 := HEX2; end if;
  --   if HEX3 /= h3 then report "HEX3 = " & slv_to_string(HEX3); h3 := HEX3; end if;
  --   if HEX4 /= h4 then report "HEX4 = " & slv_to_string(HEX4); h4 := HEX4; end if;
  --   if HEX5 /= h5 then report "HEX5 = " & slv_to_string(HEX5); h5 := HEX5; end if;
  -- end process;

  -- -- quick edge monitor on BTOUT (unrelated to FIR, but useful heartbeat)
  -- mon_btout : process
  --   variable last : std_logic := 'X';
  -- begin
  --   wait until rising_edge(clock);
  --   if BTOUT /= last then
  --     report "BTOUT toggled to " & std_logic'image(BTOUT);
  --     last := BTOUT;
  --   end if;
  -- end process;

  -- -- UART activity monitor (counts edges on TX)
  -- mon_uart : process
  --   variable cnt : integer := 0;
  --   variable prev: std_logic := '1';
  -- begin
  --   wait until rising_edge(clock);
  --   if UART_TX /= prev then
  --     cnt  := cnt + 1;
  --     prev := UART_TX;
  --     report "UART_TX edge count = " & integer'image(cnt);
  --   end if;
  -- end process;


  -- gen_clk :
  -- process
  -- begin 
  -- clock<= '1';
  -- wait for 10 ns ;
  -- clock <= not clock ;
  -- wait for 10 ns ;
  -- end process ;


  -- gen_clk2:
  -- process
  -- begin
  -- clock2 <= '1';
  -- wait for 10030 ns ;
  -- clock2 <= not clock2 ;
  -- wait for 10030 ns ;
  -- end process ;

end architecture;
