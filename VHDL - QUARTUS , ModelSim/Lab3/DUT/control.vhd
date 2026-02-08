LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;

-- Inputs: Clk, Rst, Ena, Status signals
-- Output: Control signals, done flag
-- PCsel: 00 -  unaffected; 01 - PC + 1; 10 - PC + 1 + offset; 11 - zeros
-- RFAddr: 00 - rc; 01 - rb; 10 - ra; 11 - unaffected
---------------------------------------------------------------
ENTITY Control IS
generic( 
			n: integer:=16
			);
	PORT(
		clk, rst, ena : in STD_LOGIC; ---inputs from tb
		
		mov, done, and_status, or_status, xor_status, jnc, jc, jmp, sub, add,
		Nflag, Zflag, Cflag, ld, st : in std_logic; --- status inputs from decoder
		
		IRin, Imm1_in, Imm2_in, RFin,
		RFout, PCin, Ain, Cin, Cout : out std_logic;
		
		DTCM_addr_sel,DTCM_addr_in,DTCM_addr_out,DTCM_wr, DTCM_out : out std_logic;
		
		ALUFN : out std_logic_vector(3 downto 0);------outputs control lines
		
		PCsel, RFaddr_rd, RFaddr_wr : out std_logic_vector(1 downto 0);
		
		done_output : out std_logic ----output to tb
	);
END Control;

ARCHITECTURE arch_control OF Control IS
------creat type of state

	TYPE state IS (	R_type_state0,R_type_state1,ld_st_state,ld_state0,ld_state1,st_state0,st_state1,
					mov_state,J_type_state0,Fetch, Decode, Reset,Done_state);
	SIGNAL current_state, next_state: state;
	SIGNAL temp: STD_LOGIC;
	

BEGIN


-- SEQUENTIAL synchronic process for move from state to state
--define when to reset
---- current state is the the state we check , and next state is the state will be in next rise clock
	state_process : process(clk, rst)
	begin
		if (rst='1') then
			current_state <= Reset;
		elsif (clk'EVENT AND clk='1' and ena = '1') then
			current_state <= next_state;
		end if;
	end process;
	
 ---- CONCURRENT:
 ------next‐state logic
 
  next_state <= Fetch 			when (current_state = Reset or  current_state = J_type_state0 or current_state = ld_state1 
					or current_state = st_state1 or current_state = mov_state or current_state = R_type_state1) else
                Decode   		when current_state = Fetch  else
                R_type_state0   when ((current_state = Decode) and  
				(and_status='1' or or_status='1'or xor_status='1' or add='1' or sub='1')) else  
				R_type_state1 	when current_state =R_type_state0 else
                mov_state 		when (mov='1' and  current_state =Decode) else  
                ld_st_state 	when (ld='1' or st='1' )and (current_state=Decode) else  
                ld_state0  		when (current_state = ld_st_state and ld='1') else
				ld_state1  		when  current_state =ld_state0  else 
				st_state0  		when (current_state = ld_st_state and st='1') else
				st_state1 		when  current_state =st_state0 else 
				J_type_state0 	when ((jnc='1' and Cflag = '0') OR (jc='1' and Cflag = '1') OR jmp='1')AND current_state=Decode ELSE
				Done_state 		when (done= '1')AND current_state=Decode;
				
				  
				  
---------------------------------------------------------
---- CONCURRENT: control‐line outputs

    -- program‐counter enable (fetch,decode,branches(jtype,reset)
    PCin <= '1' when (
    current_state = Reset or
    current_state = R_type_state1 or
    current_state = ld_state1 or
    current_state = st_state1 or
    current_state = mov_state or
    current_state = J_type_state0
	) else '0';

	PCsel <= "00" when current_state = Reset else
         "01" when (
             current_state = R_type_state1 or
             current_state = ld_state1 or
             current_state = st_state1 or
             current_state = mov_state
         ) else
         "10" when current_state = J_type_state0 else
         "00";  -- default


    -- instuction memory read and  write‐enable
    RFaddr_rd  <=  	"00" when (current_state = R_type_state1) else -- rc
					"01" when (current_state=R_type_state0 or current_state= ld_st_state )  else --rb
					"10" when (current_state=st_state1) --ra
					else "11" ; ---(for uneffcted)
					
    RFaddr_wr <= 	"10" when (current_state=R_type_state1 or current_state=ld_state1 or current_state=mov_state)--ra
					else "11";---(for uneffcted)
					
    IRin  <= 		'1' when current_state = Fetch    else '0';

    -- ALU  selects
    ALUFN <="0000" when ((current_state=R_type_state1 and add =  '1')
	or current_state= ld_state0 or current_state=st_state0) else 
			"0001" when (current_state=R_type_state1 and sub = '1')  else
			"0010" when (current_state=R_type_state1 and (and_status = '1')) else
			"0011" when (current_state=R_type_state1 and (or_status = '1')) else
			"0100" when (current_state=R_type_state1 and (xor_status = '1')) else
			"1011" when (current_state=ld_st_state or current_state = mov_state
			or current_state = R_type_state0 or current_state = ld_state1)
			else unaffected;
			

    -- Ain 
    Ain <= '1' when current_state=ld_st_state else '0';
	
	--imm1 , Imm2
	Imm1_in <= '1' when current_state=mov_state else '0';
	Imm2_in <= '1' when (current_state=ld_state0 or current_state=st_state0 )else '0';

    -- register‐file write and read
    RFout<= '1' when (current_state = R_type_state0 or current_state= R_type_state1 or
	current_state=ld_st_state or current_state=st_state1 ) else '0';
	
    RFin <= '1'  when (current_state = R_type_state1 or current_state=ld_state1 or current_state=mov_state)
	else '0';

    --  (Register_file <===>  data_memory)
   DTCM_addr_sel <= '1'; --when (current_state =ld_state0 OR current_state =st_state0) ELSE '0';
   DTCM_addr_in <= '1' when (current_state = st_state0)  ELSE '0';
   DTCM_addr_out <= '1' when (current_state =ld_state0  )	  ELSE '0';
   DTCM_wr  <= '1' when (current_state =st_state1)	 ELSE '0';
	DTCM_out <= '1' when (current_state = ld_state1) else '0';

-------------update done_output--------------
done_output <= '1'when current_state=Done_state else '0' ;

end arch_control;

 
