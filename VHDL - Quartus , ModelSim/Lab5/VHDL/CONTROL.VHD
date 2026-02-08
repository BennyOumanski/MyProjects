---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
-- control module (implements MIPS control unit)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE work.const_package.all;


ENTITY control IS
   PORT( 	
		opcode_i 			: IN 	STD_LOGIC_VECTOR(5 DOWNTO 0);
		funct_i 			: IN 	STD_LOGIC_VECTOR(5 DOWNTO 0);
		RegDst_ctrl_o 		: OUT 	STD_LOGIC_VECTOR(1 DOWNTO 0);
		ALUSrc_ctrl_o 		: OUT 	STD_LOGIC;
		MemtoReg_ctrl_o 	: OUT 	STD_LOGIC;
		RegWrite_ctrl_o 	: OUT 	STD_LOGIC;
		Jump_ctrl_o			: OUT 	STD_LOGIC;
		Jal_ctrl_o			: OUT 	STD_LOGIC;
		MemRead_ctrl_o 		: OUT 	STD_LOGIC;
		MemWrite_ctrl_o	 	: OUT 	STD_LOGIC;
		BranchE_ctrl_o 		: OUT 	STD_LOGIC;
		BranchNE_ctrl_o 	: OUT 	STD_LOGIC;
		--alu_ctl_w	 		: OUT 	STD_LOGIC;
		ALUOp_ctrl_o	 	: OUT 	STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END control;

ARCHITECTURE behavior OF control IS

	SIGNAL  rtype_w, lw_w, sw_w, beq_w, bne_w, itype_imm_w,
			itype_w, sll_w, srl_w, slti_w, jump_w,jal_w: STD_LOGIC;

BEGIN           
				-- Code to generate control signals using opcode bits
	rtype_w 			<=  '1'	WHEN	opcode_i = R_TYPE_OPC OR
										opcode_i = MUL_OPC
										ELSE '0';
	lw_w          		<=  '1'	WHEN  	opcode_i = LW_OPC  			ELSE '0';
 	sw_w          		<=  '1'	WHEN  	opcode_i = SW_OPC  			ELSE '0';
   	beq_w         		<=  '1'	WHEN  	opcode_i = BEQ_OPC  		ELSE '0';
	bne_w 				<=  '1'	WHEN  	opcode_i = BNE_OPC  		ELSE '0';
	slti_w				<=  '1'	WHEN  	opcode_i = SLTI_OPC  		ELSE '0';
	srl_w 				<=  '1'	WHEN  	(opcode_i = R_TYPE_OPC and funct_i = "000010") 
										ELSE '0';
	sll_w 				<=  '1'	WHEN  	(opcode_i = R_TYPE_OPC and funct_i = "000000") 
										ELSE '0';
	jump_w				<=  '1'	WHEN  	(opcode_i = JUMP_OPC) or (opcode_i = JAL_OPC) 
										or (opcode_i = R_TYPE_OPC and funct_i = "001000")	
										ELSE '0';
	jal_w				<=  '1'	WHEN  	(opcode_i = JAL_OPC)
								ELSE '0';
	--itype_imm_w			<=	'1'	WHEN	((opcode_i = ADDI_OPC) or 
	--									( opcode_i = ORI_OPC)  or 
	--									( opcode_i = ANDI_OPC))	or
	--									( opcode_i = XORI_OPC)   
	--									ELSE '0';  							
	itype_w			<=	'1'	WHEN		((opcode_i = ADDI_OPC) or 
										( opcode_i = ORI_OPC)  or 
										( opcode_i = ANDI_OPC))	or
										( opcode_i = XORI_OPC)  or 
										( opcode_i = LUI_OPC)  or 
										(opcode_i = SLTI_OPC) or
										(opcode_i = ADDIU_OPC)
										ELSE '0';  	
										
  	RegDst_ctrl_o(0)    <=  rtype_w; --00 rt i type, 01 rd r type, 10 jal
	RegDst_ctrl_o(1)    <=  jal_w;
 	ALUSrc_ctrl_o  		<=  lw_w OR sw_w or itype_w;
  	--ALUSrc_ctrl_o 		<=  lw_w OR sw_w or itype_imm_w;
  	--MemtoReg_ctrl_o 	<=  lw_w;
  	--RegWrite_ctrl_o 	<=  rtype_w OR lw_w or itype_imm_w or jal_w;
  	--MemRead_ctrl_o 		<=  lw_w;
  	--MemWrite_ctrl_o 	<=  sw_w; 
  	--BranchE_ctrl_o      <=  beq_w;
  	--BranchNE_ctrl_o     <=  bne_w;
	MemtoReg_ctrl_o 	<=  lw_w;
  	RegWrite_ctrl_o 	<=  rtype_w OR lw_w or itype_w or jal_w;
  	MemRead_ctrl_o 		<=  lw_w;
   	MemWrite_ctrl_o 	<=  sw_w; 
 	BranchE_ctrl_o      <=  beq_w;
 	BranchNE_ctrl_o     <=  bne_w;
	Jump_ctrl_o			<=  jump_w;
	Jal_ctrl_o			<=  jal_w;
	
	ALUOp_ctrl_o(0) 	<=  beq_w or bne_w or srl_w or sll_w;
	ALUOp_ctrl_o(1) 	<=  rtype_w;

	--ALUOp_ctrl_o <= "00" when (itype_w = '1' or lw_w = '1' or sw_w = '1') else
     --           "01" when (beq_w = '1' or bne_w = '1') else
     --           "10" when rtype_w = '1' else
     --           "11";


	

   END behavior;


