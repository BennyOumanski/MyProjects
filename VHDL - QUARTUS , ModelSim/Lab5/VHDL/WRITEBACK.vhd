-- WriteBack module 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE work.aux_package.ALL;
-------------- ENTITY --------------------
ENTITY WRITEBACK IS
	PORT( 
		alu_res_i				: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		Read_Data_i				: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		PC_plus_4				: IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		MemtoReg				: IN  STD_LOGIC;
		Jal						: IN  STD_LOGIC;
		write_data 				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		write_data_mux			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
END 	WRITEBACK;
------------ ARCHITECTURE ----------------
ARCHITECTURE structure OF WRITEBACK IS
	SIGNAL write_data_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN

	write_data_sig	<= alu_res_i WHEN MemtoReg = '0' 
						ELSE Read_Data_i;
	--write_data 			<= ALU_Result WHEN MemtoReg = '0' ELSE read_data; -- NEW 14:15
	write_data 		<= write_data_sig;
	write_data_mux 	<= write_data_sig WHEN Jal = '0' 
						ELSE "000000000000000000000000" & PC_plus_4;

END structure;