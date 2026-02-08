LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.ALL;
USE work.aux_package.ALL;
--USE IEEE.std_logic_unsigned.all;

------------ EStity -----------------
ENTITY  Execute IS
	GENERIC(
		DataBusSize : INTEGER := 32
	);
	PORT(	Read_data_1 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Read_data_2 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Sign_extend 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Function_opcode : IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
			Opcode			: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
			ALUOp 			: IN 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
			ALUSrc 			: IN 	STD_LOGIC;
			Zero 			: OUT	STD_LOGIC;
			RegDst			: IN    STD_LOGIC_VECTOR( 1 DOWNTO 0 );
			ALU_Result 		: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			PC_plus_4 		: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
			Wr_reg_addr     : OUT   STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			Wr_reg_addr_0	: IN    STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			Wr_reg_addr_1	: IN    STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			Wr_data_FW_WB	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Wr_data_FW_MEM	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			ForwardA 		: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);		
			ForwardB		: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
			WriteData_EX    : OUT   STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Flush_EX		: IN 	STD_LOGIC;
			clock, reset	: IN 	STD_LOGIC );
END Execute;
------------ Architecture -----------------
ARCHITECTURE behavior OF Execute IS
SIGNAL Ainput, Binput 			  : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
SIGNAL Aforward_mux, Bforward_mux : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
SIGNAL ALU_output_mux			  : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
--SIGNAL Branch_Add 				  : STD_LOGIC_VECTOR( 7 DOWNTO 0 );
SIGNAL ALU_ctl					  : STD_LOGIC_VECTOR( 3 DOWNTO 0 );
SIGNAL write_register_address 	  : STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL write_register_address_1	  : STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL write_register_address_0	  : STD_LOGIC_VECTOR( 4 DOWNTO 0 );
BEGIN
--------------- ALU Inputs: A,B ----------------				
	------------ Forwarding ----------------
		-- Forward A
	WITH ForwardA SELECT 
			Aforward_mux <= Read_data_1    WHEN "00",
							Wr_data_FW_WB  WHEN "01",
							Wr_data_FW_MEM WHEN "10",
							X"00000000"	   WHEN OTHERS;
		-- Forward B
	WITH ForwardB SELECT 
			Bforward_mux <= Read_data_2    WHEN "00",
							Wr_data_FW_WB  WHEN "01",
							Wr_data_FW_MEM WHEN "10",
							X"00000000"	   WHEN OTHERS;
							
	-- ALU A input mux after forwarding (mux for adding shift)
	Ainput <= 	Bforward_mux WHEN (ALUOp = "11") ELSE  -- When Performing Shift, A should get data from reg2
				Aforward_mux;
	-- ALU B input mux after forwarding
	Binput <= 	Bforward_mux WHEN ( ALUSrc = '0' ) ELSE
				Sign_extend( 31 DOWNTO 0 );		
	WriteData_EX <= Bforward_mux;

-------------- Generate ALU control bits -------------
--ALUCTL: 
--	ALU_CONTROL PORT MAP(ALUOp, Function_opcode, Opcode, ALU_ctl);
----------------- Mux for Register Write Address ---------------------
	 Wr_reg_addr <= "11111"			WHEN RegDst = "10" ELSE -- jal
					Wr_reg_addr_1 	WHEN RegDst = "01" ELSE 
					Wr_reg_addr_0;
------------ Generate Zero Flag ----------------------------
	Zero <= '1' WHEN ( ALU_output_mux( 31 DOWNTO 0 ) = X"00000000"  ) ELSE	
			'0';    
------------- Select ALU output  ----------------------------      
	ALU_result <= 	X"0000000" & B"000"  & ALU_output_mux( 31 ) WHEN ALU_ctl = "0111" 	ELSE  -- For SLT
				--	X"00000000"									WHEN Flush_EX = '1' 	ELSE
					ALU_output_mux( 31 DOWNTO 0 );
		
------------ Adder to compute Branch Address ----------------
--	Branch_Add	<= PC_plus_4( 9 DOWNTO 2 ) +  Sign_extend( 7 DOWNTO 0 ) ;
--	Add_result 	<= Branch_Add( 7 DOWNTO 0 );

------------ ALU Proces -----------------------------


-- ALU Control
PROCESS (ALUOp, Function_opcode, Opcode)
	
	BEGIN
 	CASE ALUOp IS
		WHEN "10" => -- r-type
			CASE Function_opcode IS
				WHEN "100000" => ALU_ctl <= "0010"; -- add
				WHEN "100001" => ALU_ctl <= "0010"; -- mov
				WHEN "100010" => ALU_ctl <= "0110"; -- sub
				WHEN "000010" => ALU_ctl <= "0011"; -- mul
				WHEN "100100" => ALU_ctl <= "0000"; -- and
				WHEN "100101" => ALU_ctl <= "0001"; -- or
				WHEN "100110" => ALU_ctl <= "0100"; -- xor
				WHEN "101010" => ALU_ctl <= "0111"; -- slt
				WHEN OTHERS   => ALU_ctl <= "1111"; -- else
			END CASE;				
		WHEN "00" => -- i-type
			CASE Opcode IS
				WHEN "100011" => ALU_ctl <= "0010"; -- lw
				WHEN "101011" => ALU_ctl <= "0010"; -- sw
				WHEN "001000" => ALU_ctl <= "0010"; -- addi
				WHEN "001001" => ALU_ctl <= "0010"; -- addiu
				WHEN "001100" => ALU_ctl <= "0000"; -- andi
				WHEN "001101" => ALU_ctl <= "0001"; -- ori
				WHEN "001110" => ALU_ctl <= "0100"; -- xori
				WHEN "001111" => ALU_ctl <= "1001"; -- lui
				WHEN "001010" => ALU_ctl <= "0111"; -- slti
		        WHEN OTHERS   => ALU_ctl <= "1111"; -- else
			END CASE;			
		WHEN "01" 	=> -- beq, bne
								 ALU_ctl <= "0110"; 		
 	 	when "11"   =>
			CASE Function_opcode IS
				WHEN "000000" => ALU_ctl <= "0101"; -- sll
				WHEN "000010" => ALU_ctl <= "1000"; -- srl
				WHEN OTHERS   => ALU_ctl <= "1111"; -- else
			END CASE;	
		WHEN OTHERS => ALU_ctl <= "1111"; -- else		
					END CASE;			

  END PROCESS;

  --ALUProc:  ALU PORT MAP(Ainput, Binput, ALU_ctl, ALU_output_mux);

-- ALU
PROCESS (ALU_ctl, Ainput, Binput)
	VARIABLE mul : STD_LOGIC_VECTOR(63 DOWNTO 0);
	BEGIN		
 	CASE ALU_ctl IS	-- Select ALU operation
						-- ALU performs ALUresult = Ainput AND Binput
		WHEN "0000" 	=>	ALU_output_mux 	<= Ainput AND Binput; 
						-- ALU performs ALUresult = Ainput OR Binput
     	WHEN "0001" 	=>	ALU_output_mux 	<= Ainput OR Binput;
						-- ALU performs ALUresult = Ainput + Binput
	 	WHEN "0010" 	=>	ALU_output_mux 	<= Ainput + Binput;
						-- ALU performs MUL
 	 	WHEN "0011" 	=> mul := std_logic_vector(unsigned(Ainput) * unsigned(Binput));
						   ALU_output_mux    <= mul(31 DOWNTO 0);
						-- ALU performs XOR 
 	 	WHEN "0100" 	=>	ALU_output_mux 	<= Ainput xor Binput;
						-- ALU performs SLL
 	 	WHEN "0101" 	=>	ALU_output_mux 	<= std_logic_vector(shift_left(unsigned(Ainput),to_integer(unsigned(Binput(10 downto 6)))));
						-- ALU performs SRL
		WHEN "1000" 	=>	ALU_output_mux 	<= std_logic_vector(shift_right(unsigned(Ainput),to_integer(unsigned(Binput(10 downto 6)))));
						-- ALU performs LUI
		WHEN "1001"		=> ALU_output_mux <=  Binput(DataBusSize-1 DOWNTO DataBusSize/2) & X"0000";
						-- ALU performs ALUresult = Ainput -Binput
 	 	WHEN "0110" 	=>	ALU_output_mux 	<= Ainput - Binput;
						-- ALU performs SLT
  	 	WHEN "0111" 	=>	ALU_output_mux 	<= Ainput - Binput ;
 	 	WHEN OTHERS	=>	ALU_output_mux 	<= X"00000000" ;
  	END CASE;
  END PROCESS;
  

END behavior;

