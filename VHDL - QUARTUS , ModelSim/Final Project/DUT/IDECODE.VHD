--- IDECODE.VHD
LIBRARY IEEE; 			
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Idecode IS
	  PORT(	read_data_1						: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			read_data_2						: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			write_register_address_0 		: OUT   STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			write_register_address_1 		: OUT   STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			write_register_address      	: IN    STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			Instruction 					: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			PC_plus_4_shifted				: IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
			RegWrite						: IN 	STD_LOGIC;
			ForwardA_ID, ForwardB_ID		: IN 	STD_LOGIC;
			BranchBeq, BranchBne, Jump, JAL	: IN 	STD_LOGIC; -- NEW Added JAL
			Stall_ID						: IN    STD_LOGIC;
			write_data						: IN	STD_LOGIC_VECTOR( 31 DOWNTO 0 ); -- NEW changed name from write_data to write_data_wb
			Branch_read_data_FW				: IN	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Sign_extend 					: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			PCSrc		 					: OUT 	STD_LOGIC_VECTOR(1 DOWNTO 0);
			JumpAddr						: OUT   STD_LOGIC_VECTOR( 7 DOWNTO 0 );
			PCBranch_addr 					: OUT 	STD_LOGIC_VECTOR(7 DOWNTO 0);
			GIE								: OUT 	STD_LOGIC;
			Read_ISR_PC						: IN	STD_LOGIC;
			EPC								: IN	STD_LOGIC_VECTOR(7 DOWNTO 0);
			INTR							: IN	STD_LOGIC;
			INTR_Active						: IN	STD_LOGIC;
			CLR_IRQ							: IN	STD_LOGIC_VECTOR(6 DOWNTO 0);
			clock,reset						: IN 	STD_LOGIC );
END Idecode;

ARCHITECTURE behavior OF Idecode IS
TYPE register_file IS ARRAY ( 0 TO 31 ) OF STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL register_array					: register_file;
	SIGNAL read_register_1_address			: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL read_register_2_address			: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL Instruction_immediate_value		: STD_LOGIC_VECTOR( 15 DOWNTO 0 );
	SIGNAL read_data_1_sig, read_data_2_sig	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL read_data_comp_input_1, read_data_comp_input_2	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL Opcode							: STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL Sign_extend_sig 					: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL write_data_mux_out			    : STD_LOGIC_VECTOR( 31 DOWNTO 0 ); -- Added NEW 14:15
	SIGNAL Ori								: STD_LOGIC;
BEGIN
	Opcode					    <= Instruction(31 DOWNTO 26 );
	read_register_1_address 	<= Instruction( 25 DOWNTO 21 );
   	read_register_2_address 	<= Instruction( 20 DOWNTO 16 );
   	write_register_address_1	<= Instruction( 15 DOWNTO 11 );
   	write_register_address_0 	<= Instruction( 20 DOWNTO 16 );
   	Instruction_immediate_value <= Instruction( 15 DOWNTO 0 );
	

	read_data_comp_input_1  <=  read_data_1_sig WHEN ForwardA_ID = '0' ELSE Branch_read_data_FW;
	read_data_1_sig			<= register_array(CONV_INTEGER(read_register_1_address));
	read_data_1 			<= read_data_1_sig;

	read_data_comp_input_2 <= read_data_2_sig WHEN ForwardB_ID = '0' ELSE Branch_read_data_FW;
	read_data_2_sig <= register_array(CONV_INTEGER(read_register_2_address));
	read_data_2 	<= read_data_2_sig;

	PCSrc(1) 		<= Jump;
	PCSrc(0) 		<= BranchBeq WHEN ((read_data_comp_input_1 = read_data_comp_input_2) AND Stall_ID = '0') ELSE 
					   BranchBne WHEN ((read_data_comp_input_1 /= read_data_comp_input_2) AND Stall_ID = '0') ELSE '0';  -- Branch Comperator (For bne chen inequality)
	

	PCBranch_addr <= PC_plus_4_shifted +  Sign_extend_sig(7 DOWNTO 0);
	JumpAddr	  <= Sign_extend_sig(7 DOWNTO 0) WHEN Opcode(1 DOWNTO 0) = "10" OR Opcode(1 DOWNTO 0) = "11" ELSE
					 read_data_1_sig(7 DOWNTO 0); -- For JR instruction

	Ori				<=  '1' WHEN Opcode = "001101" ELSE '0';
    Sign_extend_sig <= 	X"0000" & Instruction_immediate_value WHEN (Instruction_immediate_value(15) = '0' OR Ori = '1') ELSE
						X"FFFF" & Instruction_immediate_value;
	Sign_extend 	<=	Sign_extend_sig;
	
	GIE				<= register_array(26)(0);

					
	PROCESS
		VARIABLE INTR_Active_delayed : 	STD_LOGIC;
	BEGIN
		WAIT UNTIL clock'EVENT AND clock = '0';  
		IF reset = '1' THEN
			INTR_Active_delayed := '0';
					
			FOR i IN 0 TO 31 LOOP
				register_array(i) <= CONV_STD_LOGIC_VECTOR( i, 32 );
 			END LOOP;
					
  		ELSIF RegWrite = '1' AND write_register_address /= 0 THEN
		      register_array( CONV_INTEGER( write_register_address)) <= write_data;  
		END IF;
		
		
		IF (INTR = '1') THEN
			register_array(26)(0) <= '0';  
		ELSIF (read_register_1_address = "11011" AND Jump = '1') THEN
	
			register_array(26)(0) <= '1';  
		END IF;
		
		-- IF (INTR_Active = '1' ) THEN 
		-- 	INTR_Active_delayed := '1';
		-- ELSE
		-- 	INTR_Active_delayed := '0';
		-- END IF;
		
		------ Edit $k1 section ------
		IF (Read_ISR_PC = '1') THEN
			register_array(27) <= X"000000" & EPC;
		END IF;
	END PROCESS;
END behavior;


