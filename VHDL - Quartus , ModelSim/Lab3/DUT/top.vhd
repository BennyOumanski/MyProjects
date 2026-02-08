library ieee;
use work.aux_package.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--------------------------------------------------------------
ENTITY top IS
	generic( 
		 n: integer:=16;	-- Data Memory In Data Size
		 Awidth:  integer:=6
		 );  	
PORT(  -----------PORTS OF TOP----------------
		clk, rst, ena  : in STD_LOGIC;	
		DTCM_tb_wr, TBactive, ITCM_tb_wr: in std_logic;
		
		DTCM_tb_in, ITCM_tb_in: in std_logic_vector(n-1 downto 0);
		
		DTCM_tb_addr_out, DTCM_tb_addr_in, ITCM_tb_addr_in: in std_logic_vector(Awidth-1 downto 0);

		DTCM_tb_out: out std_logic_vector(n-1  downto 0);
		done_output : out std_logic
		);
END top;


ARCHITECTURE behav OF top IS
----------signals for conection between the ports---------------
----GREEN LINES:
signal  clk_s, rst_s, ena_s , DTCM_tb_wr_s,
		TBactive_s,ITCM_tb_wr_s,
		done_output_s: std_logic;
		
signal	DTCM_tb_in_s, ITCM_tb_in_s, DTCM_tb_out_s: std_logic_vector(n-1  downto 0);

signal	DTCM_tb_addr_in_s, DTCM_tb_addr_out_s,
		ITCM_tb_addr_in_s: std_logic_vector(Awidth-1  downto 0);

---STATUS LINES :
SIGNAL mov,done, and_s, or_s, xor_s, jnc, jc, jmp, sub, add,
		Nflag, Zflag, Cflag, ld, st :std_logic;

----CONTROL LINES:
SIGNAL  IRin, Imm1_in, Imm2_in, RFin,
		RFout, PCin, Ain, Cin, Cout, DTCM_out,
		DTCM_addr_sel,DTCM_addr_in,DTCM_addr_out,DTCM_wr :std_logic;
SIGNAL ALUFN : std_logic_vector(3 downto 0);------outputs control lines
SIGNAL PCsel, RFaddr_rd, RFaddr_wr : std_logic_vector(1 downto 0);

		
begin


------------connect signals to ports of the "top"----------------

		clk_s <= clk;
		rst_s <= rst;
		ena_s <= ena;
		DTCM_tb_out <= DTCM_tb_out_s;
		DTCM_tb_wr_s <= DTCM_tb_wr;
		DTCM_tb_in_s <= DTCM_tb_in;
		DTCM_tb_addr_in_s <= DTCM_tb_addr_in;
		DTCM_tb_addr_out_s <= DTCM_tb_addr_out;
		TBactive_s <= TBactive;
		ITCM_tb_wr_s <= ITCM_tb_wr;
		ITCM_tb_in_s <= ITCM_tb_in;
		ITCM_tb_addr_in_s <= ITCM_tb_addr_in;
		done_output <= done_output_s ;

-------------control mapping-------------
control_portmap: Control port map
		(
		clk => clk_s,
		rst => rst_s,
		ena => ena_s,
		----STATUS(input of control)
		mov => mov,
		done => done,
		and_status => and_s,
		or_status => or_s,
		xor_status => xor_s,
		jnc => jnc,
		jc => jc,
		jmp => jmp,
		sub => sub,
		add => add,
		Nflag => Nflag,
		Zflag => Zflag,
		Cflag => Cflag,
		ld => ld,
		st => st,
		---------control line(output of control)------------
		IRin => IRin,
		Imm1_in => Imm1_in,
		Imm2_in => Imm2_in,
		RFin => RFin,
		RFout => RFout,
		PCin => PCin,
		Ain => Ain,
		Cin => Cin,
		Cout => Cout,
		DTCM_addr_sel => DTCM_addr_sel,
		DTCM_addr_in => DTCM_addr_in,
		DTCM_addr_out => DTCM_addr_out,
		DTCM_wr=> DTCM_wr,
		DTCM_out => DTCM_out,
		ALUFN => ALUFN,
		PCsel=> PCsel,
		RFaddr_rd=> RFaddr_rd,
		RFaddr_wr => RFaddr_wr,
		done_output => done_output_s
		);
		
------------data_path mapping-------------
datapath_portmap: datapath port map
		(
		
--------------------green ports -------------------------------		
		DTCM_tb_out =>DTCM_tb_out_s,
		DTCM_tb_wr =>DTCM_tb_wr_s,
		DTCM_tb_in =>DTCM_tb_in_s,
		DTCM_tb_addr_in =>DTCM_tb_addr_in_s,
		DTCM_tb_addr_out=>DTCM_tb_addr_out_s,
		TBactive=>TBactive_s,
		ITCM_tb_wr=>ITCM_tb_wr_s,
		ITCM_tb_in=>ITCM_tb_in_s,
		ITCM_tb_addr_in=>ITCM_tb_addr_in_s,
		clk=>clk_s,
		rst=>rst_s,
	
		DTCM_out=>DTCM_out,
		DTCM_addr_out=>DTCM_addr_out,
		DTCM_addr_in =>DTCM_addr_in,
		DTCM_wr => DTCM_wr,
		DTCM_addr_sel =>DTCM_addr_sel,
		Ain=>Ain,
		RFin=>RFin,
		IRin=>IRin,
		PCin=>PCin,
		Imm1_in=>Imm1_in,
		Imm2_in=>Imm2_in,
		RFout=>RFout,
		PCsel=>PCsel,
		RFaddr_rd=>RFaddr_rd,
		RFaddr_wr=>RFaddr_wr,
		ALUFN =>ALUFN,
		mov=>mov,
		done=>done,
		and_status=>and_s,
		or_status=>or_s,
		xor_status=>xor_s,
		jnc=>jnc,
		jc=>jc,
		jmp=>jmp,
		sub=>sub,
		add=>add,
		Nflag=>Nflag,
		Zflag=>Zflag,
		Cflag=>Cflag,
		ld=>ld,
		st=>st
		);
		
end behav;