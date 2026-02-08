LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY Top IS -- Combinatorial Digital Circuit
  GENERIC (	n	: INTEGER := 8;
			m	: INTEGER := 16;
			k	: INTEGER := 4);
			
  PORT 
  (
     sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9 : in std_logic ;
	key0,key1,key2,key3: in std_logic;
	HEX0,HEX1,HEX2,HEX3 :out std_logic_VECTOR (6 DOWNTO 0);
	
	clk: in std_logic;
	PWMout_gpio: out std_logic;
	HEX4,HEX5 :out std_logic_VECTOR (6 DOWNTO 0);
	LEDR0,LEDR1,LEDR2,LEDR3: out  std_logic;
	LEDR5,LEDR6,LEDR7,LEDR8,LEDR9:OUT std_logic
	);
end Top;
-----------------------------------------------------------
ARCHITECTURE struct OF Top IS 
signal X, Y : std_logic_VECTOR(m-1 downto 0);
signal ALUout : 	std_logic_vector(n-1 downto 0);
signal ALUFN: std_logic_vector(4 downto 0);
signal Nflag, Cflag, Zflag, Vflag: STD_LOGIC;
SIGNAL HEX0_L ,HEX1_L,HEX2_L,HEX3_L,
	   HEX0_H ,HEX1_H,HEX2_H,HEX3_H : std_logic_VECTOR(6 DOWNTO 0);
signal nkey3: std_logic;	
signal PLLout: std_logic;
begin
	------mapping inner signals----- 
	portmap_top :Digitalsystem
		generic map (n=>n,m=>m, k=>k)
		
		port map(
		X_i => X,
		Y_i => Y,
		ALUFN_i => ALUFN,
		ALUout_o => ALUout,
		Nflag_o => Nflag,
		Cflag_o => Cflag,
		Zflag_o => Zflag,
		Vflag_o => Vflag,
		PWM_o => PWMout_gpio,
		en_i => sw8,
		rst_i => nkey3,
		clk_i => PLLout
		);
	--------mapping hexes to 8 bits of x ,y and the output 
	Decoder_0_L: 	SevSegDec	port map(X(3 downto 0) , HEX0_L);
	Decoder_1_L: 	SevSegDec	port map(X(7 downto 4) , HEX1_L);
	Decoder_0_H: 	SevSegDec	port map(X(11 downto 8) , HEX0_H);
	Decoder_1_H: 	SevSegDec	port map(X(15 downto 12) , HEX1_H);
	
	Decoder_2_L: 	SevSegDec	port map(Y(3 downto 0) , HEX2_L);
	Decoder_3_L: 	SevSegDec	port map(Y(7 downto 4) , HEX3_L);
	Decoder_2_H: 	SevSegDec	port map(Y(11 downto 8) , HEX2_H);
	Decoder_3_H: 	SevSegDec	port map(Y(15 downto 12) , HEX3_H);
	
	-----MAPPING ALOUT TO HEX4 HEX5-----------
	Decoder_4_L: 	SevSegDec	port map(ALUout(3 downto 0) , HEX4);
	Decoder_5_L: 	SevSegDec	port map(ALUout(7 downto 4) , HEX5);
	
	------------define_innerX -----------------
	X(7 downto 0) <= (7 => sw7, 6 => sw6,5 => sw5,4 => sw4,
					3 => sw3,2 => sw2, 1 => sw1, 0 => sw0) when (key1='0' and sw9 ='0')
					else unaffected;
					
	X(15 downto 8) <= (15 => sw7, 14 => sw6,13 => sw5,12 => sw4,
					11 => sw3,10 => sw2, 9 => sw1, 8 => sw0) when (key1='0' and sw9 = '1')
					else unaffected;
						
	Y(7 downto 0) <= (7 => sw7, 6 => sw6,5 => sw5,4 => sw4,
					3 => sw3,2 => sw2, 1 => sw1, 0 => sw0) when (key0='0' and sw9 ='0')
					else unaffected;
					
	Y(15 downto 8) <= (15 => sw7, 14 => sw6,13 => sw5,12 => sw4,
					11 => sw3,10 => sw2, 9 => sw1, 8 => sw0) when (key0='0' and sw9='1')
					else unaffected;

	-------- insert to alufn the switchers when key 2 is set----
	ALUFN <=(4 => sw4,3 => sw3,2 => sw2, 1 => sw1, 0 => sw0)
			when (key2='0')	else unaffected	;
	------ leds of alufn 5 to 9
	LEDR5 <= ALUFN(0);
	LEDR6<= ALUFN(1); 
	LEDR7<= ALUFN(2);
	LEDR8<= ALUFN(3);
	LEDR9<= ALUFN(4);
	
	-----------insert leds of the carry flag-----------
	LEDR0 <= Vflag ;
	LEDR1 <= Zflag;
	LEDR2<= Cflag;
	LEDR3<= Nflag;
	
	nkey3 <= not(key3);


	with sw9 select
	HEX0 <= HEX0_L when '0',
			HEX0_H WHEN '1',
			unaffected when others;
	with sw9 select
	HEX1 <= HEX1_L when '0',
			HEX1_H WHEN '1',
			unaffected when others;
	with sw9 select
	HEX2 <= HEX2_L when '0',
			HEX2_H WHEN '1',
			unaffected when others;
	with sw9 select
	HEX3 <= HEX3_L when '0',
			HEX3_H WHEN '1',
			unaffected when others;
		
	hivutPLL: PLL port map(
	inclk0 => clk,
	c0 => PLLout
	);
	
end struct;
	
			