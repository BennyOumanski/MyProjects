-- WriteBack module 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.aux_package.ALL;
-------------- ENTITY --------------------
ENTITY ForwardingUnit IS
	PORT( 
		Write_register_MEM 	: IN  STD_LOGIC_VECTOR( 4 DOWNTO 0 );
		Write_register_WB 	: IN  STD_LOGIC_VECTOR( 4 DOWNTO 0 );
		rs_register_ID		: IN STD_LOGIC_VECTOR( 4 DOWNTO 0 );
		rt_register_ID		: IN STD_LOGIC_VECTOR( 4 DOWNTO 0 );
		rs_register_EX		: IN STD_LOGIC_VECTOR( 4 DOWNTO 0 );
		rt_register_EX		: IN STD_LOGIC_VECTOR( 4 DOWNTO 0 );
		RegWrite_MEM		: IN STD_LOGIC;
		RegWrite_WB			: IN STD_LOGIC;
		ForwardA			: OUT STD_LOGIC_VECTOR( 1 DOWNTO 0 );
		ForwardB			: OUT STD_LOGIC_VECTOR( 1 DOWNTO 0 );
		ForwardA_br			: OUT STD_LOGIC;
		ForwardB_br			: OUT STD_LOGIC
		);
END 	ForwardingUnit;
------------ ARCHITECTURE ----------------
ARCHITECTURE structure OF ForwardingUnit IS
	
	
BEGIN

	ForwardA <= "10" when ((rs_register_EX = Write_register_MEM) and (RegWrite_MEM = '1') and (Write_register_MEM /= "00000")) ELSE
				"01" when (rs_register_EX = Write_register_WB and RegWrite_WB = '1' and Write_register_WB /= "00000"
					and (not(rs_register_EX = Write_register_MEM and RegWrite_MEM = '1' and Write_register_MEM /= "00000"))) 
				ELSE "00";
	
	ForwardB <= "10" when (rt_register_EX = Write_register_MEM and RegWrite_MEM = '1' and Write_register_MEM /= "00000") ELSE
				"01" when (rt_register_EX = Write_register_WB and RegWrite_WB = '1' and Write_register_WB /= "00000"
					and (not(rt_register_EX = Write_register_MEM and RegWrite_MEM = '1' and Write_register_MEM /= "00000")))
				ELSE "00";
	
	ForwardA_br <= '1' when (rs_register_ID = Write_register_MEM and RegWrite_MEM = '1' and rs_register_ID /= "00000") ELSE '0';
	ForwardB_br <= '1' when (rt_register_ID = Write_register_MEM and RegWrite_MEM = '1' and rt_register_ID /= "00000") ELSE '0';

END structure;