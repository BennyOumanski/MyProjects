---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
USE work.cond_comilation_package.all;


package aux_package is

	COMPONENT MIPS IS
	generic( 
			WORD_GRANULARITY : boolean 	:= G_WORD_GRANULARITY;
	        MODELSIM : integer 			:= G_MODELSIM;
			DATA_BUS_WIDTH : integer 	:= 32;
			ITCM_ADDR_WIDTH : integer 	:= G_ADDRWIDTH;
			DTCM_ADDR_WIDTH : integer 	:= G_ADDRWIDTH;
			PC_WIDTH : integer 			:= 10;
			FUNCT_WIDTH : integer 		:= 6;
			DATA_WORDS_NUM : integer 	:= G_DATA_WORDS_NUM;
			CLK_CNT_WIDTH : integer 	:= 16;
			INST_CNT_WIDTH : integer 	:= 16
	);
	PORT(	rst_i		 		:IN		STD_LOGIC;
			clk_i				:IN		STD_LOGIC; 
			BPADD				:IN 	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
			-- Output important signals to pins for easy display in SignalTap
			pc_o				:OUT	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			alu_result_o 		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			read_data1_o 		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			read_data2_o 		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			write_data_o		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			instruction_top_o	:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			Branch_ctrl_o		:OUT 	STD_LOGIC;
			Zero_o				:OUT 	STD_LOGIC; 
			MemWrite_ctrl_o		:OUT 	STD_LOGIC;
			RegWrite_ctrl_o		:OUT 	STD_LOGIC;
			CLKCNT_o			:OUT	STD_LOGIC_VECTOR(CLK_CNT_WIDTH-1 DOWNTO 0);
			INSTCNT_o 			:OUT	STD_LOGIC_VECTOR(INST_CNT_WIDTH-1 DOWNTO 0);
			STCNT_o				:OUT	STD_LOGIC_VECTOR(CLK_CNT_WIDTH-1 DOWNTO 0);
			FHCNT_o				:OUT	STD_LOGIC_VECTOR(CLK_CNT_WIDTH-1 DOWNTO 0);
			IFpc_o				:OUT	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			IDpc_o				:OUT	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			EXpc_o				:OUT	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			MEMpc_o				:OUT	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			WBpc_o				:OUT	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			IFinstruction_o		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			IDinstruction_o		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			EXinstruction_o		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			MEMinstruction_o	:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			WBinstruction_o		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0)
	);		
END COMPONENT;
---------------------------------------------------------  

---------------------------------------------------------	
	COMPONENT dmemory IS
	generic(
		DATA_BUS_WIDTH : integer := 32;
		DTCM_ADDR_WIDTH : integer := 8;
		WORDS_NUM : integer := 256
	);
	PORT(	clk_i,rst_i			: IN 	STD_LOGIC;
			dtcm_addr_i 		: IN 	STD_LOGIC_VECTOR(DTCM_ADDR_WIDTH-1 DOWNTO 0);
			dtcm_data_wr_i 		: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			MemRead_ctrl_i  	: IN 	STD_LOGIC;
			MemWrite_ctrl_i 	: IN 	STD_LOGIC;
			--Write_reg_addr_i	: IN 	STD_LOGIC_VECTOR(4 DOWNTO 0);
			--Write_reg_addr_o	: OUT	STD_LOGIC_VECTOR(4 DOWNTO 0);
			dtcm_data_rd_o 		: OUT 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0) 
			
	);
END COMPONENT;
---------------------------------------------------------		
	COMPONENT  Execute IS
	generic(
		DATA_BUS_WIDTH : integer := 32;
		FUNCT_WIDTH : integer := 6;
		PC_WIDTH : integer := 10
	);
	PORT(	read_data1_i 		: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			read_data2_i 		: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			sign_extend_i 		: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			funct_i 			: IN 	STD_LOGIC_VECTOR(FUNCT_WIDTH-1 DOWNTO 0);
			ALUOp_ctrl_i 		: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
			ALUSrc_ctrl_i 		: IN 	STD_LOGIC;
			--pc_plus4_i 		: IN 	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			Opcode				: IN 	STD_LOGIC_VECTOR(5 DOWNTO 0);
			RegDst_ctrl_i		: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
			rt_register_i		: IN 	STD_LOGIC_VECTOR(4 DOWNTO 0);
			rd_register_i		: IN 	STD_LOGIC_VECTOR(4 DOWNTO 0);
			write_data_FW_WB	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			write_data_FW_MEM	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			ForwardA			: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
			ForwardB			: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
			Write_reg_addr_o	: OUT 	STD_LOGIC_VECTOR(4 DOWNTO 0);
			Write_data_o 		: OUT 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			zero_o 				: OUT	STD_LOGIC;--needed???
			alu_res_o 			: OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0)
			
			
	);
END COMPONENT;
---------------------------------------------------------		
	component Idecode is
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
			ForwardA_MEM	: IN STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			ForwardB_MEM	: IN STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			ForwardA_br		: IN STD_LOGIC;
			ForwardB_br		: IN STD_LOGIC

	);
	end component;
---------------------------------------------------------		
	COMPONENT Ifetch IS
	generic(
		WORD_GRANULARITY : boolean 	:= true;
		DATA_BUS_WIDTH : integer 	:= 32;
		PC_WIDTH : integer 			:= 10;
		NEXT_PC_WIDTH : integer 	:= 8; -- NEXT_PC_WIDTH = PC_WIDTH-2
		ITCM_ADDR_WIDTH : integer 	:= 8;
		WORDS_NUM : integer 		:= 256;
		INST_CNT_WIDTH : integer 	:= 16
	);
	PORT(	
		clk_i, rst_i 		: IN 	STD_LOGIC;
		Branch_addr_i 		: IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
		Jump_addr_i 		: IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
		pc_en_i 			: IN 	STD_LOGIC; -- PC enable
        --Branch_ctrl_i 	: IN 	STD_LOGIC;
        --BranchNE_ctrl_i : IN 	STD_LOGIC;
		PCSrc_i				: IN    STD_LOGIC_VECTOR(1 DOWNTO 0);
        --zero_i 			: IN 	STD_LOGIC;	
		PC_write_disable	: IN STD_LOGIC;
		pc_o 				: OUT	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
		pc_plus4_o 			: OUT	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
		instruction_o 		: OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
		inst_cnt_o 			: OUT	STD_LOGIC_VECTOR(INST_CNT_WIDTH-1 DOWNTO 0)	
	);
END COMPONENT;
---------------------------------------------------------
	COMPONENT PLL port(
	    areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0     		: OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC );
    END COMPONENT;
---------------------------------------------------------	
COMPONENT ForwardingUnit IS
	PORT( 
		Write_register_MEM 	: IN  STD_LOGIC_VECTOR( 4 DOWNTO 0 );
		Write_register_WB 	: IN  STD_LOGIC_VECTOR( 4 DOWNTO 0 );
		rs_register_ID		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		rt_register_ID 		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		rs_register_EX		: IN STD_LOGIC_VECTOR( 4 DOWNTO 0 );
		rt_register_EX		: IN STD_LOGIC_VECTOR( 4 DOWNTO 0 );
		RegWrite_MEM		: IN STD_LOGIC;
		RegWrite_WB			: IN STD_LOGIC;
		ForwardA			: OUT STD_LOGIC_VECTOR( 1 DOWNTO 0 );
		ForwardB			: OUT STD_LOGIC_VECTOR( 1 DOWNTO 0 );
		ForwardA_br			: OUT  STD_LOGIC;
		ForwardB_br			: OUT  STD_LOGIC
		);
END 	COMPONENT;
---------------------------------------------------------------
component control IS
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
END component;
-----------------------------------------------------------------
component HazardUnit IS
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
END 	component;
---------------------------------------------------------------------------------
component WRITEBACK IS
	PORT( 
		alu_res_i				: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		Read_Data_i				: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		PC_plus_4				: IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		MemtoReg				: IN  STD_LOGIC;
		Jal						: IN  STD_LOGIC;
		write_data 				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		write_data_mux			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
END 	component;
--------------------------------------------------------


end aux_package;

