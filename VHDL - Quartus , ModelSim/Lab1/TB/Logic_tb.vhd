LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY logic_tb IS
	GENERIC (n : INTEGER := 8);
END logic_tb;

ARCHITECTURE behavior OF logic_tb IS 

  COMPONENT logic
  PORT ( x,y	:	IN STD_LOGIC_VECTOR (n-1 downto 0);
		 alufn_logic :	IN STD_LOGIC_VECTOR(2 downto 0);
		 res_logic	:	OUT STD_LOGIC_VECTOR (n-1 downto 0)
		 );
         
  END COMPONENT;

	-- signals that are used as inputs
	SIGNAL x, y: std_logic_vector    (n-1 downto 0) := (others => '0');
	SIGNAL res_logic : std_logic_vector (n-1 downto 0) := (others => '0');
	SIGNAL alufn_logic : std_logic_vector (2 downto 0) := (others => '0');
 

BEGIN

  uut: logic PORT MAP (
       x => x,
       y => y,
       res_logic => res_logic,
	   alufn_logic => alufn_logic
      );
	  


stim_proc: process
  begin     
  
	-- not
    x <= "00000100";
    y <= "00000010";
    alufn_logic <= "000";
    wait for 10 ns;
    
	-- or
    x <= "00000010";
    y <= "00001100";
    alufn_logic <= "001";
    wait for 10 ns;
    
	-- and  
	x <= "00100100";
    y <= "00001010";
    alufn_logic <= "010";
    wait for 10 ns;
    
	-- xor
	x <= "00000011";
    y <= "00001111";
    alufn_logic <= "011";
    wait for 10 ns;

	-- nor
	x <= "11000100";
    y <= "01000010";
    alufn_logic <= "100";
    wait for 10 ns;

	-- nand
	x <= "00010100";
    y <= "00000011";
    alufn_logic <= "101";
    wait for 10 ns;
 
    -- xnor
    x <= "11111111";
    y <= "00000001";
    alufn_logic <= "111";
    wait for 10 ns;
    
    -- Zero
    x <= "00000000";
    y <= "00000000";
    alufn_logic <= "000";
    wait for 10 ns;
    
    wait;
  end process;

END;

  
