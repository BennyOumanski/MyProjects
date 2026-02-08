---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
-- Ifetch module (provides the PC and instruction 
--memory for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;


ENTITY Ifetch IS
	generic(
		WORD_GRANULARITY : boolean 	:= TRUE;
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
		--BranchE_ctrl_i 	: IN 	STD_LOGIC;	
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
END Ifetch;


ARCHITECTURE behavior OF Ifetch IS
	SIGNAL pc_q				  	: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
	SIGNAL pc_plus4_r 			: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
	SIGNAL itcm_addr_w 			: STD_LOGIC_VECTOR(ITCM_ADDR_WIDTH-1 DOWNTO 0);
	SIGNAL next_pc_w  			: STD_LOGIC_VECTOR(NEXT_PC_WIDTH-1 DOWNTO 0);
	SIGNAL rst_flag_q			: STD_LOGIC;
	SIGNAL inst_cnt_q 			: STD_LOGIC_VECTOR(INST_CNT_WIDTH-1 DOWNTO 0);
	SIGNAL pc_prev_q			: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0); 
	SIGNAL nclk_i				: STD_LOGIC; -- clock for instruction memory
BEGIN

--ROM for Instruction Memory
	inst_memory: altsyncram
	GENERIC MAP (
		operation_mode => "ROM",
		width_a => DATA_BUS_WIDTH,
		widthad_a => ITCM_ADDR_WIDTH,
		numwords_a => WORDS_NUM,
		lpm_hint => "ENABLE_RUNTIME_MOD = YES,INSTANCE_NAME = ITCM",
		lpm_type => "altsyncram",
		outdata_reg_a => "UNREGISTERED",
		init_file => "C:\LAB5 -H\test2\ITCM.hex",
		intended_device_family => "Cyclone"
	)
	PORT MAP (
		clock0     => nclk_i,
		address_a  => itcm_addr_w, 
		q_a 	   => instruction_o 
	);
	
	-- clock for instruction memory
	nclk_i <= NOT clk_i;	-- Load memory address register with write clock
	-- Instructions always start on word address - not byte
	pc_q(1 DOWNTO 0) 	<= "00";
	
	-- send address to inst. memory address register
	G1: 
	if (WORD_GRANULARITY = True) generate 		-- i.e. each WORD has unike address
		itcm_addr_w <= pc_q(9 DOWNTO 2);	-- PC_WIDTH = 10, ITCM_ADDR_WIDTH = 8
	elsif (WORD_GRANULARITY = False) generate 	-- i.e. each BYTE has unike address
		itcm_addr_w <= pc_q;
	end generate;
		
	-- Adder to increment PC by 4
	pc_plus4_r( 1 DOWNTO 0 )  <= "00";
    pc_plus4_r(PC_WIDTH-1 DOWNTO 2)  <= pc_q(PC_WIDTH-1 DOWNTO 2) + 1;

	-- Mux to select Branch Address or PC + 4
	------------------------------------------------------------------------------------
	next_pc_w  <= 	(others => '0') WHEN rst_flag_q = '1' ELSE
					Branch_addr_i  	WHEN (PCSrc_i = "01") ELSE
					Jump_addr_i		WHEN (PCSrc_i = "10") ELSE
					pc_plus4_r(PC_WIDTH-1 DOWNTO 2);				
	-------------------------------------------------------------------------------------
	process (clk_i)
	BEGIN
		IF(clk_i'EVENT  AND clk_i='1') THEN
			rst_flag_q <= rst_i;
		end if;
	end process;
	-------------------------------------------------------------------------------------
	PROCESS (clk_i, rst_i)
	BEGIN
		IF rst_i = '1' THEN
			pc_q(PC_WIDTH-1 DOWNTO 2) <= (OTHERS => '0') ; 
		ELSIF(clk_i'EVENT  AND clk_i='1' and PC_write_disable = '0' and pc_en_i='1') THEN
			pc_q(PC_WIDTH-1 DOWNTO 2) <= next_pc_w;	
		END IF;
	END PROCESS;
---------------------------------------------------------------------------------------
--						IPC - instruction counter register
---------------------------------------------------------------------------------------
process (clk_i , rst_i)
begin
	if rst_i = '1' then
		pc_prev_q	<=	(others	=> '0');
	elsif falling_edge(clk_i) then
		pc_prev_q	<=	pc_q;
	end if;
end process;
---------------------------------------------------------------------------------------
process (clk_i , rst_i)
begin
	if rst_i = '1' then
		inst_cnt_q	<=	(others	=> '0');
	elsif (rising_edge(clk_i) and pc_en_i='1') then
		if pc_prev_q = pc_q then
			inst_cnt_q	<=	inst_cnt_q + '1';
		end if;
	end if;
end process;
---------------------------------------------------------------------------------------
	-- copy output signals - allows read inside module
	pc_o 				<= 	pc_q;
	pc_plus4_o 			<= 	pc_plus4_r;
	inst_cnt_o			<=	inst_cnt_q;
END behavior;


