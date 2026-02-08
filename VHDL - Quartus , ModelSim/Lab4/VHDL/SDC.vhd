LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;

-------------------------------------
ENTITY SDC IS -- Combinatorial Digital Circuit
  GENERIC (m : INTEGER := 16);
	
  PORT 	( 
		rst_i, clk_i, en_i : in std_logic;
		X_i,Y_i : in std_logic_vector(m-1 downto 0);
		ALUFN_i : std_logic_vector(4 downto 0);
		PWM_o : out std_logic
		);
		  
END SDC;

ARCHITECTURE struct OF SDC IS 

	signal X_s, Y_s : STD_LOGIC_VECTOR(m-1 DOWNTO 0) := (others => '0');
	signal en_s: std_logic := '0';
	
BEGIN

	X_s <= X_i when (ALUFN_i(4 downto 3) = "00");
	Y_s <= Y_i when (ALUFN_i(4 downto 3) = "00");
	en_s <= en_i when (ALUFN_i(4 downto 3) = "00")
			else '0';	
	
	hivut_PWM :PWM
		generic map (m=>m)
		
		port map(
		rst_i => rst_i,
		clk_i => clk_i,
		en_i => en_s,
		X_i => X_s,
		Y_i => Y_s,
		PWMmode_i => ALUFN_i(1 downto 0),
		PWM_o => PWM_o
		);
		
	
END struct;