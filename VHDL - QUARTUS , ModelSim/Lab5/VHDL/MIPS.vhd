---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
-- Top Level Structural Model for MIPS Processor Core
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.cond_comilation_package.all;
USE work.aux_package.all;


ENTITY MIPS IS
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
	PORT(	rst_i		 		:IN	STD_LOGIC;
			clk_i				:IN	STD_LOGIC; 
			BPADD				: IN  STD_LOGIC_VECTOR( 7 DOWNTO 0 );
			-- Output important signals to pins for easy display in SignalTap
			pc_o				:OUT	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			alu_result_o 		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			read_data1_o 		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			read_data2_o 		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			write_data_o		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			instruction_top_o	:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			Branch_ctrl_o		:OUT 	STD_LOGIC;
			BranchNE_ctrl_o		:OUT 	STD_LOGIC;
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
			WBinstruction_o		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			STRIGGGER_o			:OUT	STD_LOGIC -- Trigger for SignalTap
	);		
END MIPS;
-------------------------------------------------------------------------------------
ARCHITECTURE structure OF MIPS IS
	-- declare signals used to connect VHDL components
	
	SIGNAL Branch_addr_s 	: STD_LOGIC_VECTOR(7 DOWNTO 0 );
	SIGNAL Jump_addr_s 		: STD_LOGIC_VECTOR(7 DOWNTO 0 );
	
	SIGNAL branchE_w 		: STD_LOGIC;
	SIGNAL branchNE_w 		: STD_LOGIC;

	SIGNAL pcsrc_w			: STD_LOGIC_VECTOR(1 DOWNTO 0);

	SIGNAL zero_w 			: STD_LOGIC;
	
	SIGNAL MCLK_w 			: STD_LOGIC;
	SIGNAL INSTCNT_w		: STD_LOGIC_VECTOR(INST_CNT_WIDTH-1 DOWNTO 0);
	
	---------------------------- Pipeline --------------------------
	
	------ Control ------
	-- WB -- 
	SIGNAL MemtoReg_WB, MemtoReg_MEM, MemtoReg_EX, MemtoReg_ID 	: STD_LOGIC;
	SIGNAL RegWrite_WB, RegWrite_MEM, RegWrite_EX, RegWrite_ID 	: STD_LOGIC;
	SIGNAL Jal_WB, Jal_MEM, Jal_EX, Jal_ID						: STD_LOGIC;
	
	-- MEM --
	--SIGNAL Zero_MEM, Zero_EX 						: STD_LOGIC;
	
	SIGNAL MemWrite_MEM, MemWrite_EX, MemWrite_ID 	: STD_LOGIC;
	SIGNAL MemRead_MEM, MemRead_EX, MemRead_ID 		: STD_LOGIC;
	
	SIGNAL Jump_ID				: STD_LOGIC;
	
	-- Forwarding Unit
	SIGNAL ForwardA, ForwardB						: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL ForwardA_br, ForwardB_br					: STD_LOGIC; -- Branch Forwarding
	
	-- EXEC -- 
	SIGNAL RegDst_EX, RegDst_ID 					: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL ALUSrc_EX, ALUSrc_ID 					: STD_LOGIC;
	SIGNAL ALUOp_EX, ALUOp_ID 						: STD_LOGIC_VECTOR(1 DOWNTO 0);
			
	SIGNAL PC_write_disable_w						: STD_LOGIC;
	
	
	--------------------------------------------------------
	
	-------- States ------
	-- Instruction Fetch
	SIGNAL PC_plus_4_IF		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL IR_IF		    : STD_LOGIC_VECTOR( 31 DOWNTO 0 );

	-- Instruction Decode
	SIGNAL PC_plus_4_ID				     		 				: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL IR_ID		    			  		 				: STD_LOGIC_VECTOR( 31 DOWNTO 0 ); 
	SIGNAL read_data_1_ID, read_data_2_ID 		 				: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Sign_extend_ID				 		 				: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL rt_register_ID, rd_register_ID		 				: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL rs_register_ID						 				: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL ID_write_disable_w									: STD_LOGIC;
	
																
	-- Execute                                                  
	SIGNAL PC_plus_4_EX				      						: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL IR_EX		    			  		 				: STD_LOGIC_VECTOR( 31 DOWNTO 0 ); 
	SIGNAL read_data_1_EX, read_data_2_EX 						: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Sign_extend_EX				  		 				: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL rd_register_EX, rt_register_EX, rs_register_EX 		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL Wr_reg_addr_EX						 				: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL write_data_EX										: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL ALU_Result_EX					   				    : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Opcode_EX											: STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	SIGNAL EX_write_disable_w									: STD_LOGIC;
																
	-- Memory  
	SIGNAL IR_MEM		    			  		 				: STD_LOGIC_VECTOR( 31 DOWNTO 0 );   
	SIGNAL PC_plus_4_MEM			      						: STD_LOGIC_VECTOR(7 DOWNTO 0);	
	SIGNAL ALU_Result_MEM										: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL write_data_MEM, read_data_MEM						: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Wr_reg_addr_MEM										: STD_LOGIC_VECTOR( 4 DOWNTO 0 );									    
	
	-- WriteBack
	SIGNAL IR_WB		    			  		 				: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL PC_plus_4_WB				      						: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL read_data_WB											: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL ALU_Result_WB										: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Wr_reg_addr_WB										: STD_LOGIC_VECTOR( 4 DOWNTO 0 ); 
	SIGNAL write_data_WB										: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL write_data_mux_WB									: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	
	SIGNAL BPADD_en		: STD_LOGIC;
	SIGNAL Run				: STD_LOGIC;
	SIGNAL PC_BPADD			: STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	signal pc_en_w		: STD_LOGIC; -- PC enable	

BEGIN
					-- copy important signals to output pins for easy 
					-- display in Simulator
   instruction_top_o 	<= 	IR_IF;
   alu_result_o 		<= 	ALU_Result_EX;
   read_data1_o 		<= 	read_data_1_ID;
   read_data2_o 		<= 	read_data_2_ID;
   write_data_o  		<= 	write_data_mux_WB;
   Branch_ctrl_o 		<= 	branchE_w;
   BranchNE_ctrl_o 		<= 	branchNE_w;
   Zero_o 				<= 	zero_w;
   RegWrite_ctrl_o 		<= 	RegWrite_WB;
   MemWrite_ctrl_o 		<= 	MemWrite_MEM;	

	
	-- connect the PLL component
	G0:
	if (MODELSIM = 0) generate
	  MCLK: PLL
		PORT MAP (
			inclk0 	=> clk_i,
			c0 		=> MCLK_w
		);
	else generate
		MCLK_w <= clk_i;
	end generate;
	
	
	-- connect the 5 MIPS components   
	IFE : Ifetch
	generic map(
		WORD_GRANULARITY	=> 	WORD_GRANULARITY,
		DATA_BUS_WIDTH		=> 	DATA_BUS_WIDTH, 
		PC_WIDTH			=>	PC_WIDTH,
		ITCM_ADDR_WIDTH		=>	ITCM_ADDR_WIDTH,
		WORDS_NUM			=>	DATA_WORDS_NUM,
		INST_CNT_WIDTH		=>	INST_CNT_WIDTH
	)
	PORT MAP (	
		clk_i 				=> MCLK_w,  
		rst_i 				=> rst_i, 
		Branch_addr_i 		=> Branch_addr_s,
		Jump_addr_i			=> Jump_addr_s,
		pc_en_i 			=> pc_en_w, -- PC enable
		--Branch_ctrl_i 	=> branch_w,
		--BranchNE_ctrl_i => branchNE_w,
		PCSrc_i				=> pcsrc_w,
		--zero_i 			=> zero_w,
		pc_o 				=> PC_BPADD,
		instruction_o 		=> IR_IF,
    	pc_plus4_o	 		=> PC_plus_4_IF,
		inst_cnt_o			=> INSTCNT_w,
		PC_write_disable 	=> PC_write_disable_w
	);



	ID : Idecode
   	generic map(
		DATA_BUS_WIDTH		=>  DATA_BUS_WIDTH
	)
	PORT MAP (	
			clk_i 				=> MCLK_w,  
			rst_i 				=> rst_i,
        	instruction_i 		=> IR_ID,
        	--dtcm_data_rd_i 		=> dtcm_data_rd_w,
			--alu_result_i 		=> alu_result_w,
			RegWrite_ctrl_i 	=> RegWrite_WB,
			--MemtoReg_ctrl_i 	=> MemtoReg_w,
			--RegDst_ctrl_i 		=> reg_dst_w,
			BranchE 			=> branchE_w,
			BranchNE 			=> branchNE_w,
			Jump 				=> Jump_ID,
			--Jal 				=> Jal_ID,
			ID_write_disable	=> ID_write_disable_w,
			PCplus4_i			=> PC_plus_4_ID,
			PCSrc_o				=> pcsrc_w,
			Branch_addr_o		=> Branch_addr_s,
			Jump_addr_o			=> Jump_addr_s,
			read_data1_o 		=> read_data_1_ID,
        	read_data2_o 		=> read_data_2_ID,
			sign_extend_o 		=> Sign_extend_ID,
			Write_data_i		=> write_data_mux_WB,
			Write_reg_addr_i	=> Wr_reg_addr_WB,
			rs_register_o		=> rs_register_ID,
			rt_register_o		=> rt_register_ID,
			rd_register_o		=> rd_register_ID,
			ForwardA_MEM		=> ALU_Result_MEM,
			ForwardB_MEM		=> ALU_Result_MEM,
			ForwardA_br			=> ForwardA_br,
			ForwardB_br			=> ForwardB_br
		);

	CTL:   control
	PORT MAP ( 	
			opcode_i 			=> IR_ID(DATA_BUS_WIDTH-1 DOWNTO 26),
			funct_i     		=> IR_ID( 5 DOWNTO 0 ),
			RegDst_ctrl_o 		=> RegDst_ID,
			ALUSrc_ctrl_o 		=> ALUSrc_ID,
			MemtoReg_ctrl_o 	=> MemtoReg_ID,
			RegWrite_ctrl_o 	=> RegWrite_ID,
			MemRead_ctrl_o 		=> MemRead_ID,
			MemWrite_ctrl_o 	=> MemWrite_ID,
			Jump_ctrl_o			=> Jump_ID,
			Jal_ctrl_o			=> Jal_ID,
			BranchE_ctrl_o 		=> branchE_w,
			BranchNE_ctrl_o 	=> branchNE_w,
			ALUOp_ctrl_o 		=> ALUOp_ID
		);


	EXE:  Execute
   	generic map(
		DATA_BUS_WIDTH 		=> 	DATA_BUS_WIDTH,
		FUNCT_WIDTH 		=>	FUNCT_WIDTH,
		PC_WIDTH 			=>	PC_WIDTH
	)
	PORT MAP (	
		--pc_plus4_i		=> pc_plus4_w,
		read_data1_i 		=> read_data_1_EX,
        read_data2_i 		=> read_data_2_EX,
		sign_extend_i 		=> Sign_extend_EX,
        funct_i				=> IR_EX(5 DOWNTO 0),
		ALUOp_ctrl_i 		=> ALUOp_EX,
		ALUSrc_ctrl_i 		=> ALUSrc_EX,
		Opcode				=> IR_EX(31 DOWNTO 26),
		zero_o 				=> zero_w,
        alu_res_o			=> ALU_Result_EX,
		RegDst_ctrl_i		=> RegDst_EX,
		rt_register_i		=> rt_register_EX,
		rd_register_i		=> rd_register_EX,
		Write_reg_addr_o	=> Wr_reg_addr_EX,
		Write_data_o		=> write_data_EX,
		write_data_FW_WB 	=> write_data_WB,
		write_data_FW_MEM 	=> ALU_Result_MEM,
		ForwardA			=> ForwardA,
		ForwardB			=> ForwardB
	);

	G1: 
	if (WORD_GRANULARITY = True) generate -- i.e. each WORD has a unike address
		MEM:  dmemory
			generic map(
				DATA_BUS_WIDTH		=> 	DATA_BUS_WIDTH, 
				DTCM_ADDR_WIDTH		=> 	DTCM_ADDR_WIDTH,
				WORDS_NUM			=>	DATA_WORDS_NUM
			)
			PORT MAP (	
				clk_i 				=> MCLK_w,  
				rst_i 				=> rst_i,
				dtcm_addr_i 		=> ALU_Result_MEM((DTCM_ADDR_WIDTH+2)-1 DOWNTO 2), -- increment memory address by 4
				dtcm_data_wr_i 		=> write_data_MEM,
				MemRead_ctrl_i 		=> MemRead_MEM, 
				MemWrite_ctrl_i 	=> MemWrite_MEM,
				dtcm_data_rd_o 		=> read_data_MEM 
			);	
	elsif (WORD_GRANULARITY = False) generate -- i.e. each BYTE has a unike address	
		MEM:  dmemory
			generic map(
				DATA_BUS_WIDTH		=> 	DATA_BUS_WIDTH, 
				DTCM_ADDR_WIDTH		=> 	DTCM_ADDR_WIDTH,
				WORDS_NUM			=>	DATA_WORDS_NUM
			)
			PORT MAP (	
				clk_i 				=> MCLK_w,  
				rst_i 				=> rst_i,
				dtcm_addr_i 		=> ALU_Result_MEM(DTCM_ADDR_WIDTH-1 DOWNTO 2)&"00",
				dtcm_data_wr_i 		=> write_data_MEM,
				MemRead_ctrl_i 		=> MemRead_MEM, 
				MemWrite_ctrl_i 	=> MemWrite_MEM,
				dtcm_data_rd_o 		=> read_data_MEM
			);
	end generate;
	
	WB: WRITEBACK
	PORT MAP (
		alu_res_i		=>		ALU_Result_WB,	
		Read_Data_i		=>		read_data_WB,
		PC_plus_4		=>		PC_plus_4_WB,
		MemtoReg		=>		MemtoReg_WB,
		Jal				=>		Jal_WB,
		write_data 		=>		write_data_WB,
		write_data_mux	=>		write_data_mux_WB
		);

	FU: ForwardingUnit
	Port Map (
		Write_register_MEM	=> Wr_reg_addr_MEM,
		Write_register_WB	=> Wr_reg_addr_WB,
		rs_register_ID		=> rs_register_ID,
		rt_register_ID		=> rt_register_ID,	
		rs_register_EX		=> rs_register_EX,
		rt_register_EX		=> rt_register_EX,
		RegWrite_MEM		=> RegWrite_MEM,
		RegWrite_WB			=> RegWrite_WB,
		ForwardA			=> ForwardA,
		ForwardB			=> ForwardB,
		ForwardA_br			=> ForwardA_br,
		ForwardB_br			=> ForwardB_br
	);
	
	HU: HazardUnit
	Port Map (
		PC_write_disable 	=> PC_write_disable_w,
		ID_write_disable 	=> ID_write_disable_w,
		EX_write_disable 	=> EX_write_disable_w,
		MemRead_EX 			=> MemRead_EX,
		MemRead_MEM 		=> MemRead_MEM,
		rs_register_ID 		=> IR_ID(25 DOWNTO 21),
		rt_register_ID 		=> IR_ID(20 DOWNTO 16),
		rt_register_EX 		=> rt_register_EX,
		RegWrite_MEM		=> RegWrite_MEM,
		RegWrite_EX			=> RegWrite_EX,
		write_register_MEM  => Wr_reg_addr_MEM,
		write_register_EX   => Wr_reg_addr_EX,
		BranchE_ID			=> branchE_w,
		BranchNE_ID			=> branchNE_w
	);

---------------------------PipeLine Process---------------------------------------
PROCESS(MCLK_w, rst_i)
BEGIN
	IF  (BPADD_en = '0') THEN
		--IF rst_i = '1' THEN
		IF rising_edge(MCLK_w) then
			----------------------Fetch tO Decode ------------------
			IF ID_write_disable_w = '0' THEN 
				IR_ID <= IR_IF;	
				PC_plus_4_ID <= PC_plus_4_IF(9 DOWNTO 2); -- 8 bits
			END IF;
			
			-------------- Check if Branch or Jump, if so flush Decode register----
			IF (pcsrc_w(0) = '1' OR pcsrc_w(1) = '1')  THEN -- CLR IF_ID
				PC_plus_4_ID <= "00000000";
				IR_ID 		 <= X"00000000";			
			END IF;
			-------------------- Decode tO Execute -------------------- 
			IF EX_write_disable_w = '1' THEN -- CLR ID_IF register
				----- Control Reg ----
				--Branch_EX 	     <= '0';
				MemtoReg_EX      <= '0';
				RegWrite_EX      <= '0';
				MemWrite_EX      <= '0';
				MemRead_EX	     <= '0';
				RegDst_EX 	     <= "00";  
				ALUSrc_EX	     <= '0';
				ALUOp_EX 	     <= "00";
				Opcode_EX		 <= "000000";--??
				--BranchBeq_EX	 <= '0';
				--BranchBne_EX	 <= '0';
				--Jump_EX			 <= '0';
				Jal_EX			 <= '0';   
				----- State Reg -----
				PC_plus_4_EX     <= "00000000";
				IR_EX			 <= X"00000000";
				read_data_1_EX   <= X"00000000";
				read_data_2_EX   <= X"00000000";
				Sign_extend_EX   <= X"00000000";
				rt_register_EX <= "00000";
				rd_register_EX <= "00000";
				-----
				--pc_plus4_i		=> pc_plus4_w,
		
			ELSE 
				----- Control Reg -----
				--Branch_EX 	     <= Branch_ID;
				MemtoReg_EX      <= MemtoReg_ID;
				RegWrite_EX      <= RegWrite_ID;
				MemWrite_EX      <= MemWrite_ID;
				MemRead_EX	     <= MemRead_ID;		
				RegDst_EX 	     <= RegDst_ID;
				ALUSrc_EX	     <= ALUSrc_ID;
				ALUOp_EX 	     <= ALUOp_ID;
				Opcode_EX		 <= IR_ID(31 DOWNTO 26);
				--BranchBeq_EX	 <= BranchBeq_ID;
				--BranchBne_EX	 <= BranchBne_ID;
				--Jump_EX			 <= Jump_ID;
				Jal_EX			 <= Jal_ID;   
				----- State Reg -----
				PC_plus_4_EX     <= PC_plus_4_ID;	
				IR_EX			 <= IR_ID;
				read_data_1_EX   <= read_data_1_ID;  
				read_data_2_EX   <= read_data_2_ID;	 
				Sign_extend_EX   <= Sign_extend_ID;
				rs_register_EX 	<= rs_register_ID;
				rt_register_EX 	<= rt_register_ID;
				rd_register_EX 	<= rd_register_ID;
			END IF;
			
			-------------------------- Execute TO Memory --------------------------- 
			----- Control Reg -----
			--Branch_MEM		<= Branch_EX;
			--Zero_MEM		<= Zero_EX;
			MemtoReg_MEM    <= MemtoReg_EX;
			RegWrite_MEM    <= RegWrite_EX;
			MemWrite_MEM    <= MemWrite_EX;
			MemRead_MEM	    <= MemRead_EX;	
			--BranchBeq_MEM	<= BranchBeq_EX;
			--BranchBne_MEM	<= BranchBne_EX;
			--Jump_MEM		<= Jump_EX;
			Jal_MEM			<= Jal_EX;
			----- State Reg -----
			PC_plus_4_MEM	<= PC_plus_4_EX;
			IR_MEM			<= IR_EX;
			--Add_Result_MEM  <= Add_Result_EX;
			ALU_Result_MEM  <= ALU_Result_EX;
			write_data_MEM	<= write_data_EX;   -- was read_data_2_EX
			Wr_reg_addr_MEM	<= Wr_reg_addr_EX;

			
			------------------------- Memory TO WriteBack ------------------------- 
			----- Control Reg -----
			MemtoReg_WB		<= MemtoReg_MEM;
			RegWrite_WB		<= RegWrite_MEM;
			Jal_WB			<= Jal_MEM;
			
			----- State Reg -----
			PC_plus_4_WB	<= PC_plus_4_MEM;
			IR_WB			<= IR_MEM;
			read_data_WB	<= read_data_MEM;
			ALU_Result_WB	<= ALU_Result_MEM;
			Wr_reg_addr_WB	<= Wr_reg_addr_MEM;
		END IF;
	END IF; -- BPADD_en = '0'
	-- If BPADD_en = '1', then the process is blocked, and the pipeline
	-- registers are not updated. This is used to prevent the pipeline from
	-- updating when the BPADD is active
	end process;




BPADD_en 	<= '1' WHEN (BPADD <= PC_BPADD(9 DOWNTO 2) AND BPADD /= X"00") 
				ELSE '0';
STRIGGGER_o 	<= BPADD_en;
pc_en_w		<= '1' WHEN (BPADD_en = '0') ELSE '0'; -- PC enable
pc_o 		<= PC_BPADD;
---------------------------------------------------------------------------------------
--									IPC - MCLK counter register
---------------------------------------------------------------------------------------
process (MCLK_w , rst_i, BPADD_en, PC_write_disable_w, ID_write_disable_w, EX_write_disable_w, pcsrc_w)
variable CLKCNT_w			: STD_LOGIC_VECTOR(CLK_CNT_WIDTH-1 DOWNTO 0);
variable FHCNT_w			: STD_LOGIC_VECTOR(CLK_CNT_WIDTH-1 DOWNTO 0);
variable STCNT_w			: STD_LOGIC_VECTOR(CLK_CNT_WIDTH-1 DOWNTO 0);
begin
	if rst_i = '1' then
		CLKCNT_w	:=	(others	=> '0');
		FHCNT_w		:=	(others	=> '0');
		STCNT_w		:=	(others	=> '0');
	elsif (rising_edge(MCLK_w) and BPADD_en = '0') then
		CLKCNT_w	:=	CLKCNT_w + '1';
		if (PC_write_disable_w='1' or ID_write_disable_w='1' or EX_write_disable_w='1') then
			STCNT_w	:=	STCNT_w + '1';
    	end if;
		if (pcsrc_w(0) = '1' OR pcsrc_w(1) = '1') then
			FHCNT_w	:=	FHCNT_w + '1';
		end if;
	end if;
	CLKCNT_o	<=	CLKCNT_w;
	FHCNT_o		<=	FHCNT_w;
	STCNT_o		<=	STCNT_w;
end process;

INSTCNT_o	<=	INSTCNT_w;
IFpc_o		<=	(PC_plus_4_IF-4); -- PC_BPADD is already incremented by 4
IDpc_o(9 downto 2)		<=	(PC_plus_4_ID - 1);
IDpc_o(1 downto 0)		<=	"00"; -- 2 LSBs are always 0
EXpc_o(9 downto 2)		<=	(PC_plus_4_EX - 1);
EXpc_o(1 downto 0)		<=	"00"; -- 2 LSBs are always 0
MEMpc_o(9 downto 2)		<=	(PC_plus_4_MEM - 1);
MEMpc_o(1 downto 0)		<=	"00"; -- 2 LSBs are always 0
WBpc_o(9 downto 2)		<=	(PC_plus_4_WB - 1);
WBpc_o(1 downto 0)		<=	"00"; -- 2 LSBs are always 0
IFinstruction_o	<=	IR_IF;
IDinstruction_o	<=	IR_ID;
EXinstruction_o	<=	IR_EX;
MEMinstruction_o<=	IR_MEM;
WBinstruction_o	<=	IR_WB;
---------------------------------------------------------------------------------------
END structure;

