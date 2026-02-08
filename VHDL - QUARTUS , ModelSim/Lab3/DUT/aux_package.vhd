library IEEE;
use ieee.std_logic_1164.all;

package aux_package is
--------------------------------------------------------
	component dataMem is
		generic	( 
					Dwidth: integer:=16;
					Awidth: integer:=6;
					dept:   integer:=64
				);
		port(
				clk,memEn:		 	in std_logic;	
				WmemData:			in std_logic_vector(Dwidth-1 downto 0);
				WmemAddr,RmemAddr:	in std_logic_vector(Awidth-1 downto 0);
				RmemData: 			out std_logic_vector(Dwidth-1 downto 0)
			);
	end component;
---------------------------------------------------------
	component progMem is
		generic	( 
					Dwidth: integer:=16;
					Awidth: integer:=6;
					dept:   integer:=64
				);
		port(
				clk,memEn:			in std_logic;	
				WmemData:			in std_logic_vector(Dwidth-1 downto 0);
				WmemAddr,RmemAddr:	in std_logic_vector(Awidth-1 downto 0);
				RmemData: 			out std_logic_vector(Dwidth-1 downto 0)
			);
	end component;
---------------------------------------------------------
	component BidirPin is
		generic( width: integer:=16 );
		port( 
				Dout: 	in 		std_logic_vector(width-1 downto 0);
				en:		in 		std_logic;
				Din:	out		std_logic_vector(width-1 downto 0);
				IOpin: 	inout 	std_logic_vector(width-1 downto 0)
		);
	end component;
---------------------------------------------------------
	component RF is
		generic(
				Dwidth: integer:=16;
				Awidth: integer:=4
				);
		port(
				clk,rst,WregEn:		in std_logic;	
				WregData:			in std_logic_vector(Dwidth-1 downto 0);
				WregAddr,RregAddr:	in std_logic_vector(Awidth-1 downto 0);
				RregData: 			out std_logic_vector(Dwidth-1 downto 0)
			);
	end component;
---------------------------------------------------------
	component ALU is
		generic( n: integer:=16
		);
	port(	A, B: in std_logic_vector(n-1 downto 0);	
			ALUFN: in std_logic_vector(3 downto 0);
			C : out std_logic_vector(n-1 downto 0);
			Cflag, Zflag, Nflag: out std_logic
		);
	end component;
---------------------------------------------------------
	component ProgramCounter is
	generic	( 
			n: integer:= 16
			);
	port
		(	
			PCin: 		in std_logic;
			PCsel: 		in std_logic_vector(1 downto 0);
			IR:			in std_logic_vector(7 downto 0);
			PC_Out:  	out std_logic_vector(n-1 downto 0);
			clk:            in std_logic
		);
	end component;
---------------------------------------------------------
	component FA is
		PORT (xi, yi, cin: IN std_logic;
			      s, cout: OUT std_logic);
	end component;
---------------------------------------------------------
	component decoder is
	generic( 
			RegSize: integer:=4
			);
	port(	
			OPC : in std_logic_vector(RegSize-1 downto 0);
			xor_status,or_status,and_status,jnc,jc,jmp,sub,add,done,mov,ld,st,str: out std_logic
		);
	END component;
---------------------------------------------------------
	component top is
	generic( 	n: integer:=16;
				Awidth:  integer:=6
			);
	port(	
		clk, rst, ena  : in STD_LOGIC;	
		DTCM_tb_wr, TBactive, ITCM_tb_wr: in std_logic;
		
		DTCM_tb_in, ITCM_tb_in: in std_logic_vector(n-1 downto 0);
		
		DTCM_tb_addr_out, DTCM_tb_addr_in, ITCM_tb_addr_in: in std_logic_vector(Awidth-1 downto 0);

		DTCM_tb_out: out std_logic_vector(n-1  downto 0);
		done_output : out std_logic
		);
	END component;
---------------------------------------------------------	
	component control is
	port(	
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
	END component;
---------------------------------------------------------
component datapath is

	generic( 
			n: integer:=16;
			Awidth:  integer:=6
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
	END component;
---------------------------------------------------------
end aux_package;

