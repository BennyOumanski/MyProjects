LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Shifter_tb IS
GENERIC (n : INTEGER := 8);
END Shifter_tb;

ARCHITECTURE behavior OF Shifter_tb IS 

  COMPONENT Shifter
  PORT(
       X,Y	: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0); -- Input
		 direction	: IN STD_LOGIC_VECTOR (2 DOWNTO 0); -- directionection Choice
         cout	: OUT STD_LOGIC; -- Carry out
         res	: OUT STD_LOGIC_VECTOR(n-1 downto 0)
      );
  END COMPONENT;

  -- Signals that are use as inputs
  signal x, y : std_logic_vector(n-1 downto 0) := (others => '0');
  signal direction : std_logic_vector(2 downto 0) := (others => '0');

  -- Signals that are use as outputs
  signal cout : std_logic;
  signal res : std_logic_vector(n-1 downto 0);

BEGIN

  uut: Shifter PORT MAP (
       X => x,
       Y => y,
       direction => direction,
       cout => cout,
       res => res
      );
	  
stim_proc: process
  begin     
    
	-- shift left 1 bit
    x <= "00000001";
    y <= "00001000";
    direction <= "000";
    wait for 10 ns;

	-- shift right 2 bits
    x <= "00000010";
    y <= "00010010";
    direction <= "001";
    wait for 10 ns;

	-- shift left 4 bits
    x <= "00000100";
    y <= "00011100";
    direction <= "000";
    wait for 10 ns;
 
	-- shift left 2 bits
	x <= "00000010";
    y <= "00100001";
    direction <= "001";
    wait for 10 ns;
    wait;
  end process;

END;	  
