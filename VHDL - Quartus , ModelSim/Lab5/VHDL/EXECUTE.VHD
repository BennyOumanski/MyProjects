---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
--  Execute module (implements the data ALU and Branch Address Adder  
--  for the MIPS computer)
LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


ENTITY  Execute IS
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
END Execute;


ARCHITECTURE behavior OF Execute IS
SIGNAL a_input_w :STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
SIGNAL b_input_w, b_input_forward : STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
SIGNAL alu_out_mux_w				: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
SIGNAL alu_ctl_w					: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL rt_register_s				: STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL rd_register_s				: STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL write_reg_addr_s				: STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN
--------------------------------------------------------------------------------------------------------
--  Generate ALU input A
	with ForwardA select 
	a_input_w <= 	read_data1_i		when "00",
					write_data_FW_WB	when "01",
					write_data_FW_MEM	when "10",
					unaffected when others;

	with ForwardB select
	b_input_forward <= 	read_data2_i		when "00",
						write_data_FW_WB	when "01",
						write_data_FW_MEM	when "10",
						unaffected when others;
	-- MUX for ALU input B
	-- If ALUSrc_ctrl_i is 0, we use the second register read data	
	with ALUSrc_ctrl_i select 
	b_input_w <= 	b_input_forward								when '0',
					sign_extend_i(DATA_BUS_WIDTH-1 DOWNTO 0)	when '1',
					unaffected when others;
	
	
	
	rt_register_s <= rt_register_i;
	rd_register_s <= rd_register_i;
	
	-- MUX for write register destination adress
	with RegDst_ctrl_i select
    write_reg_addr_s <= rt_register_s when "00", --rt
                      rd_register_s when  "01", --rd
                      "11111" when "10", --ra
                      unaffected when others;

	
	Write_reg_addr_o <= write_reg_addr_s;

	-- Write data needs to take forward information if sw
	Write_data_o <= b_input_forward;
--------------------------------------------------------------------------------------------------------
--  Generate ALU control bits
--------------------------------------------------------------------------------------------------------
	--alu_ctl_w(0) <= (funct_i(0) OR funct_i(3)) AND ALUOp_ctrl_i(1);
	--alu_ctl_w(1) <= (not ALUOp_ctrl_i(1)) or (not funct_i(2) and not ALUOp_ctrl_i(0));
	--alu_ctl_w(2) <= (not ALUOp_ctrl_i(1) and ALUOp_ctrl_i(0)) or (funct_i(1));
	--alu_ctl_w(3) <= ALUOp_ctrl_i(2);
	
	PROCESS (ALUOp_ctrl_i, funct_i, Opcode)
	
	BEGIN
 	CASE ALUOp_ctrl_i IS
		WHEN "10" => -- r-type
			CASE funct_i IS
				WHEN "100000" => ALU_ctl_w <= "0010"; -- add
				WHEN "100001" => ALU_ctl_w <= "0010"; -- mov
				WHEN "100010" => ALU_ctl_w <= "0110"; -- sub
				WHEN "000010" => ALU_ctl_w <= "0011"; -- mul
				WHEN "100100" => ALU_ctl_w <= "0000"; -- and
				WHEN "100101" => ALU_ctl_w <= "0001"; -- or
				WHEN "100110" => ALU_ctl_w <= "0100"; -- xor
				WHEN "101010" => ALU_ctl_w <= "0111"; -- slt
				WHEN OTHERS   => ALU_ctl_w <= "1111"; -- else
			END CASE;				
		WHEN "00" => -- i-type
			CASE Opcode IS
				WHEN "100011" => ALU_ctl_w <= "0010"; -- lw
				WHEN "101011" => ALU_ctl_w <= "0010"; -- sw
				WHEN "001000" => ALU_ctl_w <= "0010"; -- addi
				WHEN "001001" => ALU_ctl_w <= "0010"; -- addiu
				WHEN "001100" => ALU_ctl_w <= "0000"; -- andi
				WHEN "001101" => ALU_ctl_w <= "0001"; -- ori
				WHEN "001110" => ALU_ctl_w <= "0100"; -- xori
				WHEN "001111" => ALU_ctl_w <= "1001"; -- lui
				WHEN "001010" => ALU_ctl_w <= "0111"; -- slti
		        WHEN OTHERS   => ALU_ctl_w <= "1111"; -- else
			END CASE;			
		WHEN "01" 	=> -- beq, bne
								 ALU_ctl_w <= "0110"; 		
 	 	when "11"   =>
			CASE funct_i IS
				WHEN "000000" => ALU_ctl_w <= "0101"; -- sll
				WHEN "000010" => ALU_ctl_w <= "1000"; -- srl
				WHEN OTHERS   => ALU_ctl_w <= "1111"; -- else
			END CASE;	
		WHEN OTHERS => ALU_ctl_w <= "1111"; -- else		
					END CASE;			

  END PROCESS;
--------------------------------------------------------------------------------------------------------
	
	-- Generate Zero Flag
	zero_o <= 	'1' WHEN (alu_out_mux_w(DATA_BUS_WIDTH-1 DOWNTO 0) = X"00000000") ELSE
				'0';    
	
	-- Select ALU output    output will be 1 or 0 if we perform slt or slti    
	alu_res_o <= 	X"0000000" & B"000"  & alu_out_mux_w(31) WHEN  alu_ctl_w = "0111" ELSE 
					alu_out_mux_w(DATA_BUS_WIDTH-1 DOWNTO 0);
					
	-- Adder to compute Branch Address
	

--only for R-type operations:
PROCESS (alu_ctl_w, a_input_w, b_input_w)
	VARIABLE mul : STD_LOGIC_VECTOR(63 DOWNTO 0);
	BEGIN		
 	CASE alu_ctl_w IS	-- Select ALU operation
						-- ALU performs ALUresult = A_input AND B_input
		WHEN "0000" 	=>	alu_out_mux_w 	<= a_input_w AND b_input_w; 
						-- ALU performs ALUresult = A_input OR B_input
     	WHEN "0001" 	=>	alu_out_mux_w 	<= a_input_w OR b_input_w;
						-- ALU performs ALUresult = A_input + B_input
	 	WHEN "0010" 	=>	alu_out_mux_w 	<= a_input_w + b_input_w;
						-- ALU performs MUL
 	 	WHEN "0011" 	=> mul := std_logic_vector(unsigned(a_input_w) * unsigned(b_input_w));
						   alu_out_mux_w    <= mul(31 DOWNTO 0);
						-- ALU performs XOR 
 	 	WHEN "0100" 	=>	alu_out_mux_w 	<= a_input_w xor b_input_w;
						-- ALU performs SLL
 	 	WHEN "0101" 	=>	alu_out_mux_w 	<= std_logic_vector(shift_left(unsigned(a_input_w),to_integer(unsigned(b_input_w(10 downto 6)))));
						-- ALU performs SRL
		WHEN "1000" 	=>	alu_out_mux_w 	<= std_logic_vector(shift_right(unsigned(a_input_w),to_integer(unsigned(b_input_w(10 downto 6)))));
						-- ALU performs LUI
		WHEN "1001"		=> alu_out_mux_w <=  b_input_w(DATA_BUS_WIDTH-1 DOWNTO DATA_BUS_WIDTH/2) & X"0000";
						-- ALU performs ALUresult = A_input -B_input
 	 	WHEN "0110" 	=>	alu_out_mux_w 	<= a_input_w - b_input_w;
						-- ALU performs SLT
  	 	WHEN "0111" 	=>	alu_out_mux_w 	<= a_input_w - b_input_w ;
 	 	WHEN OTHERS	=>	alu_out_mux_w 	<= X"00000000" ;
  	END CASE;
  END PROCESS;
  
END behavior;

