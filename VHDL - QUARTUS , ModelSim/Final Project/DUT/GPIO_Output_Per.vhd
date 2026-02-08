LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE work.aux_package.ALL;

ENTITY GPIO_Output_Per IS
	GENERIC (SevenSeg	: BOOLEAN := TRUE;
			 IOSize		: INTEGER := 7); 
	PORT( 
		MemRead		: IN	STD_LOGIC;
		clock		: IN 	STD_LOGIC;
		reset		: IN 	STD_LOGIC;
		MemWrite	: IN	STD_LOGIC;
		Data		: INOUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
		CS			: IN 	STD_LOGIC;
		GPOutput	: OUT	STD_LOGIC_VECTOR(IOSize-1 DOWNTO 0)
		);
END GPIO_Output_Per; 
 
ARCHITECTURE structure OF GPIO_Output_Per IS
	SIGNAL Latch_o	: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

PROCESS(clock)
	BEGIN
	IF (reset = '1') THEN
		Latch_o	<= X"00";
	ELSIF (falling_edge(clock)) THEN
		IF (MemWrite = '1' AND CS = '1') THEN
			Latch_o <= Data;
		END IF;
	END IF;
	END PROCESS;

	Data	<=	Latch_o WHEN (MemRead = '1' AND CS = '1') 	ELSE (others => 'Z');

	SevSEG: 
		IF (SevenSeg = TRUE) GENERATE
			SevSegDec: 	SevenSegDecoder
							PORT MAP
                            (	
                            data	=> Latch_o(3 DOWNTO 0),
							seg	=> GPOutput
                            );
		END GENERATE SevSEG;

	NO_SEG:
		IF (SevenSeg = FALSE) GENERATE
			GPOutput <= Latch_o;
		END GENERATE NO_SEG;
	
END structure;