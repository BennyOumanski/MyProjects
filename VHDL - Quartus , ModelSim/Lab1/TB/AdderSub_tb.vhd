LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY AdderSub_tb IS
	GENERIC (n : INTEGER := 8);
END AdderSub_tb;

ARCHITECTURE behavior OF AdderSub_tb IS 

  COMPONENT AdderSub
  PORT(
       x : IN  std_logic_vector(n-1 downto 0);
       y : IN  std_logic_vector(n-1 downto 0);
       sub_cont : IN  std_logic_vector(2 downto 0);
       cout : OUT  std_logic;
       s : OUT  std_logic_vector(n-1 downto 0)
      );
  END COMPONENT;

  -- Signals that are use as inputs
  signal x : std_logic_vector(n-1 downto 0) := (others => '0');
  signal y : std_logic_vector(n-1 downto 0) := (others => '0');
  signal sub_cont : std_logic_vector(2 downto 0) := (others => '0');

  -- Signals that are use as outputs
  signal cout : std_logic;
  signal s : std_logic_vector(n-1 downto 0);

BEGIN

  uut: AdderSub PORT MAP (
       x => x,
       y => y,
       sub_cont => sub_cont,
       cout => cout,
       s => s
      );

  stim_proc: process
  begin     
  
    -- Addition
    x <= "00010100";
    y <= "00000011";
    sub_cont <= "000";
    wait for 10 ns;

    -- Subtraction
    x <= "00001100";
    y <= "00000010";
    sub_cont <= "001";
    wait for 10 ns;

	-- Increment
    x <= "00101100";
    y <= "00010010";
    sub_cont <= "011";
    wait for 10 ns;
	  
	-- Decrement
	x <= "00001100";
    y <= "01010010";
    sub_cont <= "100";
    wait for 10 ns;

    -- Zero
    x <= "00000000";
    y <= "00000000";
    sub_cont <= "000";
    wait for 10 ns;
	  
	-- Overflow
    x <= "11111111";
    y <= "00000001";
    sub_cont <= "000";
    wait for 10 ns;
    wait;
	
  end process;

END;
