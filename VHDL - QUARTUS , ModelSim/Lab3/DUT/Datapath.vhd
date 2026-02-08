library ieee;
use work.aux_package.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--------------------------------------------------------------

entity Datapath is
generic( n: integer:=16;
		 Awidth: integer:= 6
		);
port(	
		DTCM_wr, DTCM_addr_out, DTCM_addr_in, DTCM_addr_sel,
		DTCM_tb_wr, TBactive, ITCM_tb_wr,
		DTCM_out, Ain, RFin,
		IRin, PCin, Imm1_in, Imm2_in, RFout, clk, rst: in std_logic;
		
		DTCM_tb_in, ITCM_tb_in: in std_logic_vector(n-1 downto 0);
		
		DTCM_tb_addr_out, DTCM_tb_addr_in, ITCM_tb_addr_in: in std_logic_vector(Awidth-1 downto 0);
		 
		PCsel, RFaddr_rd, RFaddr_wr: in std_logic_vector(1 downto 0);
		
		ALUFN : in std_logic_vector(3 downto 0);
		
		mov, done, and_status, or_status, xor_status, jnc, jc, jmp,
		sub, add, Nflag, Zflag, Cflag, ld, st: out std_logic;
		
		DTCM_tb_out : out std_logic_vector(n-1 downto 0)
	);
end Datapath;
--------------------------------------------------------------
architecture behav of Datapath is

signal IR :std_logic_vector(n-1 DOWNTO 0); --8 BITS FOF IR FOR BRANCH PC
signal PC :std_logic_vector(n-1 DOWNTO 0);
signal RF_output :std_logic_vector(n-1 DOWNTO 0);
signal BUS_A, BUS_B :std_logic_vector(n-1 DOWNTO 0);
signal readAddr, writeAddr :std_logic_vector(3 DOWNTO 0);
signal DM_output, DM_datain: std_logic_vector(n-1 DOWNTO 0);
signal DM_writeAddr, DM_readAddr : std_logic_vector(Awidth-1 DOWNTO 0);
signal DTCM_addr_in_temp ,DTCM_addr_out_temp :std_logic_vector (n-1 downto 0); ---temp signals btetween latch to mux in data memory
signal latch_addrin, latch_addrout: std_logic_vector (n-1 downto 0);
signal DM_wr_en : std_logic;
signal REG_A : std_logic_vector(n-1 DOWNTO 0);
--signal nflag, zflag, cflag :std_logic;
signal mov_s, done_s, and_s, or_s, xor_s, jnc_s, jc_s, jmp_s,
		sub_s, add_s, ld_s, st_s: std_logic;
begin
----------------------pc------------------
	PC_portmap: ProgramCounter port map
	(
	PCin => PCin,
	PCsel => PCsel,
	IR => IR(7 downto 0),
	PC_Out => PC,
	clk => clk
	);
---------------------program_memory--------
	PM_portmap: ProgMem port map
	(
	clk => clk,
	memEn => ITCM_tb_wr,
	WmemData =>	ITCM_tb_in,
	WmemAddr => ITCM_tb_addr_in,
	RmemAddr =>	PC(Awidth-1 DOWNTO 0),
	RmemData =>	IR
	);
--------------------RF_addr----------------
	WITH RFaddr_rd select
		readAddr <= IR(3 downto 0)	 	WHEN "00", --rc
					IR(7 downto 4)  	WHEN "01", --rb
					IR(11 downto 8)  	WHEN "10", --ra
					unaffected when others;
	
	WITH RFaddr_wr select
		writeAddr <= IR(11 downto 8) 	WHEN "10", --ra
					IR(3 downto 0)	 	WHEN "00", --rc
					IR(7 downto 4)  	WHEN "01", --rb
					unaffected when others;
					
	RF_portmap: RF port map
	(
	clk => clk,
	rst => rst,
	WregEn => RFin,
	WregAddr => writeAddr,
	RregAddr => readAddr,
	RregData => RF_output,
	WregData => BUS_A
	);
	---------------------decoder--------------------
	
	-------------------BUS_B_tristates-----------------------------
	BUS_B <= 	RF_output 				when (RFout = '1') else
				SXT(IR(7 downto 0), n) 	when Imm1_in ='1' else
				SXT(IR(3 downto 0), n) 	when Imm2_in ='1' else
				DM_output 				when DTCM_out='1' else
				BUS_B;
				
	process (BUS_B)
	begin
	end process;	
	
	
	process (BUS_A)
	begin
	end process;
	-------------------alu-----------------
	alu_portmap: ALU port map
	(	
		A => REG_A,
		B => BUS_B,
		ALUFN => ALUFN,
		C => BUS_A,
		Cflag => cflag,
		Zflag => zflag,
		Nflag => nflag
		);
	----------------register a-------------------
	registerA_process : process(clk)
	begin
	if (clk'EVENT AND clk='1' and Ain = '1') then
			REG_A <= BUS_A;
		end if;
	end process;
	---------------data_memory-------------------
	decoder_portmap:decoder PORT MAP
	(
	OPC => IR(15 downto 12),
	mov => mov_s,
	and_status => and_s,
	or_status => or_s,
	xor_status =>  xor_s,
	jnc => jnc_s,
	jc => jc_s,
	jmp => jmp_s,
	sub => sub_s,
	add => add_s,
	ld => ld_s,
	st => st_s,
	done => done_s
	);
	
	
	--------------- datapath ports -----------------
	mov <= mov_s;
	and_status <= and_s;
	or_status <= or_s;
	xor_status <=  xor_s;
	jnc <= jnc_s;
	jc <= jc_s;
	jmp <= jmp_s;
	sub <= sub_s;
	add <= add_s;
	ld <= ld_s;
	st <= st_s;
	done <= done_s;
	
 ------------------------data_memory--------------------------

datamemory_portmap:dataMem PORT MAP
	(
	clk => clk ,
	memEn => DM_wr_en	,				-------wren---------
	WmemData =>  DM_datain  ,            -------data in---------
	WmemAddr =>	DM_writeAddr ,				------write adder------
	RmemAddr =>	DM_readAddr	,			-----read adder-----
	RmemData => DM_output                  ----data out----
	);
--------------------- wren_data_memory---------------------
DM_wr_en <= DTCM_wr when (TBactive = '0') else
			DTCM_tb_wr when (TBactive = '1');
			
-----------------------datain_data_memory-----------------		
DM_datain <= BUS_B when (TBactive = '0') else
			 DTCM_tb_in when (TBactive = '1');

-----------------------datain_data_memory-----------------
DM_writeAddr <= DTCM_tb_addr_in when ( TBactive='1') else 
				DTCM_addr_in_temp(Awidth-1 downto 0) when ( TBactive='0') ;
				
-----------------------datain_data_memory-----------------
DM_readAddr <= DTCM_tb_addr_out when ( TBactive='1') else 
				DTCM_addr_out_temp(Awidth-1 downto 0) when ( TBactive='0') ;
				
-------------------latch_addrin_in_signal_datamemory---------
latch_addrin <= BUS_B when (DTCM_addr_sel = '0') else
				BUS_A when (DTCM_addr_sel = '1');

-------------------latch_addrout_out_signal_datamemory---------
latch_addrout <= BUS_B when (DTCM_addr_sel = '0') else
				BUS_A when (DTCM_addr_sel = '1');	
				
-------------------latch_addrin_in_datamemory---------				
DTCM_addr_in_temp  <= latch_addrin when (DTCM_addr_in='1') else DTCM_addr_in_temp;
-------------------latch_addrout_out_datamemory---------	
DTCM_addr_out_temp <= latch_addrout when (DTCM_addr_out='1') else DTCM_addr_out_temp;


DTCM_tb_out <= DM_output;

			
end behav;