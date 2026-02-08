-- WriteBack module 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE work.aux_package.ALL;
-------------- ENTITY --------------------
ENTITY HazardUnit IS
	PORT( 
		MemRead_EX :IN STD_LOGIC;
		MemRead_MEM :IN STD_LOGIC;
		RegWrite_MEM :IN STD_LOGIC;
		RegWrite_EX :IN STD_LOGIC;
		BranchE_ID : IN STD_LOGIC;
		BranchNE_ID : IN STD_LOGIC;
		rs_register_ID : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		rt_register_ID : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		rt_register_EX : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		write_register_MEM : in STD_LOGIC_VECTOR(4 DOWNTO 0);
		write_register_EX : in STD_LOGIC_VECTOR(4 DOWNTO 0);
		PC_write_disable: OUT STD_LOGIC;
		ID_write_disable: OUT STD_LOGIC;
		EX_write_disable: OUT STD_LOGIC
		);
END 	HazardUnit;
------------ ARCHITECTURE ----------------
ARCHITECTURE structure OF HazardUnit IS
	signal stall_lw_EX :STD_LOGIC;
	signal stall_branch_if_lw_MEM :STD_LOGIC;
	signal stall_branch :STD_LOGIC;
BEGIN

	--lw stall
	stall_lw_EX <= '1' 	when (MemRead_EX = '1' 
					and (rt_register_EX = rs_register_ID or rt_register_EX = rt_register_ID))
					else '0';

	stall_branch <= '1' when ((BranchE_ID = '1' or BranchNE_ID = '1') and (write_register_EX = rs_register_ID or write_register_EX = rt_register_ID) and RegWrite_EX = '1')
					else '0';

	stall_branch_if_lw_MEM <= '1' when ((BranchE_ID = '1' or BranchNE_ID = '1') and MemRead_MEM = '1' and (write_register_MEM = rs_register_ID or write_register_MEM = rt_register_ID))
					else '0';			
	PC_write_disable 	<= stall_lw_EX or stall_branch_if_lw_MEM or stall_branch;
	ID_write_disable 	<= stall_lw_EX or stall_branch_if_lw_MEM or stall_branch;
	EX_write_disable	<= stall_lw_EX or stall_branch_if_lw_MEM or stall_branch;


	
	--
	
	
	
	
END structure;