LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY logic IS
  GENERIC (n : INTEGER := 8);
  PORT ( 	
			x,y  : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			alufn_logic : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			res_logic  : OUT STD_LOGIC_VECTOR(n-1 downto 0)
		);
END logic;

ARCHITECTURE la OF logic IS
	signal res_local : std_logic_vector(n-1 DOWNTO 0);
BEGIN
	
	-- Here we perform logic operators on the input y according to ALUFN[2:0] 
	the_logic_functions  : for i in 0 to n-1 generate
	res_local(i) <= not y(i) when (alufn_logic="000") else					-- not
					x(i) or y(i) when (alufn_logic="001") else				-- or
					x(i) and y(i) when (alufn_logic="010") else				-- and
					x(i) xor y(i) when (alufn_logic="011") else				-- xor
					not (x(i) or y(i)) when (alufn_logic="100") else		-- nor
					not (x(i) and y(i)) when (alufn_logic="101") else		-- nand
					not (x(i) xor y(i)) when (alufn_logic="111") else '0';	-- xnor
	end generate;

	-- then we make sure to save it to the output
	res_logic <= res_local;


END la;
