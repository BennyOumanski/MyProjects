-- basic timer module
-- Implements a simple up counter with PWM output and interrupt generation
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.aux_package.ALL;

ENTITY BTIMER IS
	GENERIC(DataBusSize	: integer := 32);
	PORT( 
		BTCNT_io: INOUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
		IRQ_OUT : IN	STD_LOGIC;
		Addr	: IN	STD_LOGIC_VECTOR(11 DOWNTO 0);
		BTRead	: IN	STD_LOGIC;
		BTWrite	: IN	STD_LOGIC;
		MCLK	: IN 	STD_LOGIC;
		reset	: IN 	STD_LOGIC;
		BTCTL	: IN 	STD_LOGIC_VECTOR(7 DOWNTO 0); -- This register defines the operation of the basic counter
		BTCCR0	: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
		BTCCR1	: IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
		BTIFG	: OUT 	STD_LOGIC;
		BTOUT	: OUT	STD_LOGIC
		);
END BTIMER;

ARCHITECTURE structure OF BTIMER IS
	SIGNAL BTCL0	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL BTCL1	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	SIGNAL PWM, NPWM		: STD_LOGIC;
	SIGNAL CLK		: STD_LOGIC;
	SIGNAL DIV		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL BTCNT	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL HEU0 		: STD_LOGIC;

	ALIAS BTIPx		IS BTCTL(1 DOWNTO 0);
	ALIAS BTCLR     IS BTCTL(2);
	ALIAS BTSSEL	IS BTCTL(4 DOWNTO 3);
	ALIAS BTHOLD	IS BTCTL(5);
	ALIAS BTOUTEN	IS BTCTL(6);
	ALIAS BTOUTMD   IS BTCTL(7);
	
BEGIN
	-- Data Memory Mapped I/O for BTCNT register at address 0x820
	-- Read and Write operations
	BTCNT_io <= BTCNT WHEN (Addr = X"820" AND BTRead = '1') ELSE (OTHERS => 'Z');	

	
	PROCESS (MCLK) BEGIN
		IF (falling_edge(MCLK)) THEN
				BTCL0 <= BTCCR0;
				BTCL1 <= BTCCR1;
		END IF;
	END PROCESS;

	
	
	PROCESS (CLK, Addr) BEGIN
		IF reset = '1' THEN
			PWM <= '1';
		ELSIF (falling_edge(CLK)) THEN
			IF (BTOUTEN = '0') THEN
				PWM	<= '1';
			ELSIF (BTCNT = BTCL0 OR BTCNT = BTCL1) THEN
				PWM	<= NOT PWM;
			END IF;
		END IF;
	END PROCESS;

	NPWM <= NOT PWM;

	with BTOUTMD SELECT BTOUT <=
		PWM WHEN '0',
		NPWM WHEN '1',
		'0'	WHEN OTHERS;

	-- Select the clock division based on BTSSEL
	WITH BTSSEL SELECT DIV	<=
		"0001"	WHEN "00", -- 1
		"0010"	WHEN "01", -- 2
		"0100"	WHEN "10", -- 4
		"1000"	WHEN "11", -- 8
		"0001"	WHEN OTHERS;
		
	-- Clock division process
	PROCESS(MCLK, reset, CLK)
		VARIABLE DIV_CNT	: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	BEGIN
		IF reset = '1' THEN
			CLK 	<= '0';
			DIV_CNT := "0000";
		ELSIF(rising_edge(MCLK)) THEN
			IF(DIV = X"1") THEN
				DIV_CNT := "0000";
				CLK <= NOT CLK;
			ELSE
				DIV_CNT := DIV_CNT + 1;
				IF (DIV_CNT = DIV) THEN
					DIV_CNT := "0000";
					CLK <= NOT CLK;	
				END IF;
			END IF;
		END IF;
	END PROCESS;
		
	 PROCESS(CLK, reset, IRQ_OUT)
    BEGIN
        IF (reset = '1' OR IRQ_OUT = '1') THEN
            BTCNT <= X"00000000";
            HEU0 <= '0';
        ELSIF (rising_edge(CLK)) THEN
            IF(BTCNT >= BTCL0-1 AND BTOUTEN = '1') THEN
                HEU0 <= '1';
            END IF;
            
            IF(Addr = X"820" AND BTWrite = '1') THEN
                BTCNT <= BTCNT_io;  
            ELSIF(BTCNT >= BTCL0 AND BTOUTEN = '1') THEN
                BTCNT <= X"00000000";  
            ELSIF(BTHOLD = '0') THEN 
                BTCNT <= BTCNT + 1; 
            END IF;
        END IF;
    END PROCESS;
	
	WITH BTIPx SELECT BTIFG <= 
		BTCNT(31)	WHEN	"11",
		BTCNT(27) 	WHEN	"10",
		BTCNT(23) 	WHEN	"01",
		HEU0 		WHEN	"00",
		'0'		  	WHEN	OTHERS;

END structure;