---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
--  Idecode module (implements the register file for the MIPS computer
LIBRARY IEEE; 		
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY Idecode IS
	generic(
		DATA_BUS_WIDTH : integer := 32
	);
	PORT(	clk_i,rst_i		: IN 	STD_LOGIC;
			instruction_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			PCplus4_i		: IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
			--dtcm_data_rd_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			--alu_result_i	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			RegWrite_ctrl_i : IN 	STD_LOGIC;
			Write_data_i	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Write_reg_addr_i: IN 	STD_LOGIC_VECTOR(4 DOWNTO 0);
			--MemtoReg_ctrl_i : IN 	STD_LOGIC;
			--RegDst_ctrl_i 	: IN 	STD_LOGIC;
			BranchE 		: IN 	STD_LOGIC;
			BranchNE 		: IN 	STD_LOGIC;
			Jump 			: IN 	STD_LOGIC;
			--JAL 			: IN 	STD_LOGIC;
			ID_write_disable	: IN STD_LOGIC;
			Branch_addr_o	: OUT 	STD_LOGIC_VECTOR(7 DOWNTO 0);
			Jump_addr_o		: OUT 	STD_LOGIC_VECTOR(7 DOWNTO 0);
			PCSrc_o			: OUT   STD_LOGIC_VECTOR(1 DOWNTO 0);
			read_data1_o	: OUT 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			read_data2_o	: OUT 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			sign_extend_o 	: OUT 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			rs_register_o	: OUT 	STD_LOGIC_VECTOR(4 DOWNTO 0);
			rt_register_o	: OUT 	STD_LOGIC_VECTOR(4 DOWNTO 0);
			rd_register_o	: OUT 	STD_LOGIC_VECTOR(4 DOWNTO 0);
			ForwardA_br		: IN 	STD_LOGIC;
			ForwardB_br		: IN 	STD_LOGIC;
			ForwardA_MEM    : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			ForwardB_MEM    : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 )
	);
END Idecode;


ARCHITECTURE behavior OF Idecode IS
TYPE register_file IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);

	SIGNAL RF_q					: register_file;
	--SIGNAL write_reg_addr_w 	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	--SIGNAL write_data_w		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL rs_register_w		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL rt_register_w		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL rd_register_w		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL imm_value_w			: STD_LOGIC_VECTOR( 15 DOWNTO 0 );
	SIGNAL read_data1_s			: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0); 
	SIGNAL read_data2_s 		: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0); 
	SIGNAL sign_extend_s		: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0); 
	SIGNAL OPCODE				: STD_LOGIC_VECTOR(5 DOWNTO 0); 
	SIGNAL branch_compare1_s	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL branch_compare2_s	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
BEGIN
	rs_register_w 			<= instruction_i(25 DOWNTO 21);
   	rt_register_w 			<= instruction_i(20 DOWNTO 16);
   	rd_register_w			<= instruction_i(15 DOWNTO 11);
   	imm_value_w 			<= instruction_i(15 DOWNTO 0);
	OPCODE					<= instruction_i(31 DOWNTO 26 );
	
	rt_register_o <= rt_register_w;
	rd_register_o <= rd_register_w;
	rs_register_o <= rs_register_w;
	
	-- Read Register 1 Operation
	read_data1_s <= RF_q(CONV_INTEGER(rs_register_w));
	read_data1_o <= read_data1_s;
	
	-- Read Register 2 Operation
	read_data2_s <= RF_q(CONV_INTEGER(rt_register_w));
	read_data2_o <= read_data2_s;
	
	-- Mux for Register Write Address
	--write_reg_addr_w <= Write_reg_addr_i;
	--rd_register_w WHEN RegDst_ctrl_i = '1' ELSE 
	--					rt_register_w;
	
	--write_data_w <= Write_data_i;
	
	-- Mux to bypass data memory for Rformat instructions
	--write_reg_data_w <= alu_result_i(DATA_BUS_WIDTH-1 DOWNTO 0) WHEN (MemtoReg_ctrl_i = '0') ELSE 
	--					dtcm_data_rd_i;
	
	Branch_addr_o <= PCplus4_i + sign_extend_s(7 DOWNTO 0);
	
	Jump_addr_o <=  sign_extend_s(7 DOWNTO 0) 	when (OPCODE(1 DOWNTO 0) = "10") ELSE --jump
					sign_extend_s(7 DOWNTO 0)	when (OPCODE(1 DOWNTO 0) = "11") ELSE -- jal
					read_data1_s(7 DOWNTO 0); --jr

	branch_compare1_s <= read_data1_s when ForwardA_br = '0' ELSE
						ForwardA_MEM;
						
	branch_compare2_s <= read_data2_s when ForwardB_br = '0' ELSE
						ForwardB_MEM;

	-- PCSrc = 00 if pc+4, PCSrc = 01 if branch(eq/ne), PCSrc = 10 if jump
	PCSrc_o(0) <= 	BranchE when ((branch_compare1_s = branch_compare2_s) and ID_write_disable = '0') else
					BranchNE when ((branch_compare1_s /= branch_compare2_s) and ID_write_disable = '0')
					else '0';
	PCSrc_o(1) <= 	'1' when (Jump = '1') 
					else '0';
					
	
	-- Sign Extend 16-bits to 32-bits
    sign_extend_s <= 	X"0000" & imm_value_w WHEN imm_value_w(15) = '0' ELSE
						X"FFFF" & imm_value_w;
						
	sign_extend_o <= sign_extend_s;

	process(clk_i,rst_i)
	begin
		if (rst_i='1') then
			FOR i IN 0 TO 31 LOOP
				-- RF_q(i) <= CONV_STD_LOGIC_VECTOR(i,32);
				RF_q(i) <= CONV_STD_LOGIC_VECTOR(0,32);
			END LOOP;
		elsif (clk_i'event and clk_i='0') then
			if (RegWrite_ctrl_i = '1' AND Write_reg_addr_i /= 0) then
				RF_q(CONV_INTEGER(Write_reg_addr_i)) <= Write_data_i;
				-- index is integer type so we must use conv_integer for type casting
			end if;
		end if;
end process;

END behavior;





