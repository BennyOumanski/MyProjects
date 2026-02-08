-- GPIO Module

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE work.aux_package.ALL;

ENTITY GPIO IS
	GENERIC(CtrlBusSize	: integer := 8;
			AddrBusSize	: integer := 32;
			DataBusSize	: integer := 32
			);
	PORT( 
		clock						: IN 	STD_LOGIC;
		reset						: IN 	STD_LOGIC;

		MemReadBus					: IN 	STD_LOGIC;
		MemWriteBus					: IN 	STD_LOGIC;
		AddressBus					: IN	STD_LOGIC_VECTOR(AddrBusSize-1 DOWNTO 0);
		DataBus						: INOUT	STD_LOGIC_VECTOR(DataBusSize-1 DOWNTO 0);
		HEX0, HEX1					: OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX2, HEX3					: OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX4, HEX5					: OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
		LEDR						: OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
		Switches					: IN	STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
END GPIO;


ARCHITECTURE structure OF GPIO IS


    SIGNAL CS_LEDR, CS_SW, CS_KEY		: STD_LOGIC;
	SIGNAL CS_HEX0, CS_HEX1, CS_HEX2	: STD_LOGIC;
	SIGNAL CS_HEX3, CS_HEX4, CS_HEX5	: STD_LOGIC;
	
BEGIN	
	OAD : 	Optimized_Addr_Dec
	PORT MAP(	reset		=> reset,
				AddressBus	=> AddressBus(11 DOWNTO 0),
				CS_LEDR		=> CS_LEDR,
				CS_SW		=> CS_SW,
				CS_KEY		=> CS_KEY,
				CS_HEX0		=> CS_HEX0,
				CS_HEX1		=> CS_HEX1,
				CS_HEX2		=> CS_HEX2,
				CS_HEX3		=> CS_HEX3,
				CS_HEX4		=> CS_HEX4,
				CS_HEX5		=> CS_HEX5
				);

	HEX0_7SEG:	GPIO_Output_Per
	PORT MAP(	MemRead		=> MemReadBus,
				clock 		=> clock,	
				reset		=> reset,
				MemWrite	=> MemWriteBus,
				CS			=> CS_HEX0,
				Data		=> DataBus(7 DOWNTO 0),
				GPOutput	=> HEX0
			);
			
	HEX1_7SEG:	GPIO_Output_Per
	PORT MAP(	MemRead		=> MemReadBus,
				clock 		=> clock,
				reset		=> reset,
				MemWrite	=> MemWriteBus,
				CS			=> CS_HEX1,
				Data		=> DataBus(7 DOWNTO 0),
				GPOutput	=> HEX1
			);
	
	HEX2_7SEG:	GPIO_Output_Per
	PORT MAP(	MemRead		=> MemReadBus,
				clock 		=> clock,
				reset		=> reset,
				MemWrite	=> MemWriteBus,
				CS			=> CS_HEX2,
				Data		=> DataBus(7 DOWNTO 0),
				GPOutput	=> HEX2
			);
	
	HEX3_7SEG:	GPIO_Output_Per
	PORT MAP(	MemRead		=> MemReadBus,
				clock 		=> clock,
				reset		=> reset,
				MemWrite	=> MemWriteBus,
				CS			=> CS_HEX3,
				Data		=> DataBus(7 DOWNTO 0),
				GPOutput	=> HEX3
			);
			
	HEX4_7SEG:	GPIO_Output_Per
	PORT MAP(	MemRead		=> MemReadBus,
				clock 		=> clock,
				reset		=> reset,
				MemWrite	=> MemWriteBus,
				CS			=> CS_HEX4,
				Data		=> DataBus(7 DOWNTO 0),
				GPOutput	=> HEX4
			);
			

	HEX5_7SEG:	GPIO_Output_Per
	PORT MAP(	MemRead		=> MemReadBus,
				clock 		=> clock,
				reset		=> reset,
				MemWrite	=> MemWriteBus,
				CS			=> CS_HEX5,
				Data		=> DataBus(7 DOWNTO 0),
				GPOutput	=> HEX5
			);

	SW:			GPIO_Input_Per
	PORT MAP(	MemRead		=> MemReadBus,
				CS			=> CS_SW,
				Data		=> DataBus,
				GPInput		=> Switches
			);
		
	LED:	GPIO_Output_Per
	GENERIC MAP(SevenSeg => FALSE,
				IOSize	 => 8)
	PORT MAP(	MemRead		=> MemReadBus,
				clock 		=> clock,
				reset		=> reset,
				MemWrite	=> MemWriteBus,
				CS			=> CS_LEDR,
				Data		=> DataBus(7 DOWNTO 0),
				GPOutput	=> LEDR
			);
	
END structure;