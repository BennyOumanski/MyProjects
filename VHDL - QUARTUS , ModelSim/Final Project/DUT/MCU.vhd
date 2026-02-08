---  MCU.vhd ---
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.aux_package.ALL;

ENTITY MCU IS
	GENERIC(MemWidth	: INTEGER := 10;
			SIM 		: BOOLEAN := FALSE;
			CtrlBusSize	: integer := 8;
			AddrBusSize	: integer := 32;
			DataBusSize	: integer := 32;
			IrqSize		: integer := 7;
			RegSize		: integer := 8
			);
	PORT( 
			reset, clock, ena, delayed_clock : IN	STD_LOGIC;
			HEX0, HEX1, HEX2	: OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
			HEX3, HEX4, HEX5	: OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
			LEDR				: OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
			Switches			: IN	STD_LOGIC_VECTOR(7 DOWNTO 0);
			
			KEY1, KEY2, KEY3	: IN	STD_LOGIC;
			--UART_RX				: IN 	STD_LOGIC := '1';
			
			BTOUT				: OUT   STD_LOGIC
			--UART_TX				: OUT	STD_LOGIC := '1'
		);
END MCU;

ARCHITECTURE structure OF MCU IS
	SIGNAL resetSim		: STD_LOGIC;
	SIGNAL enaSim		: STD_LOGIC;

	SIGNAL PC			:	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL CLKCNT		: 	STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL STCNT		: 	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL FHCNT		: 	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL BPADD		: 	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL ST_trigger	: 	STD_LOGIC;
	
	
	
	SIGNAL MemReadBus	: 	STD_LOGIC;
	SIGNAL MemWriteBus	:	STD_LOGIC;
	SIGNAL ControlBus	: 	STD_LOGIC_VECTOR(CtrlBusSize-1 DOWNTO 0);
	SIGNAL AddressBus	: 	STD_LOGIC_VECTOR(AddrBusSize-1 DOWNTO 0);
	SIGNAL DataBus		: 	STD_LOGIC_VECTOR(DataBusSize-1 DOWNTO 0);
	
	SIGNAL BTCTL		:	STD_LOGIC_VECTOR(CtrlBusSize-1 DOWNTO 0);
	SIGNAL BTCNT		:	STD_LOGIC_VECTOR(DataBusSize-1 DOWNTO 0);
	SIGNAL BTCCR0		:	STD_LOGIC_VECTOR(DataBusSize-1 DOWNTO 0);
	SIGNAL BTCCR1		:	STD_LOGIC_VECTOR(DataBusSize-1 DOWNTO 0);
	SIGNAL BTIFG		:	STD_LOGIC;

	
	SIGNAL IntrEn		:	STD_LOGIC_VECTOR(RegSize-1 DOWNTO 0);
	SIGNAL IFG			:	STD_LOGIC_VECTOR(RegSize-1 DOWNTO 0);
	SIGNAL TypeReg		:	STD_LOGIC_VECTOR(RegSize-1 DOWNTO 0);
	SIGNAL IntrSrc		:	STD_LOGIC_VECTOR(IrqSize-1 DOWNTO 0);
	SIGNAL IRQ_OUT		:	STD_LOGIC_VECTOR(IrqSize-1 DOWNTO 0);
	SIGNAL IntrTx		:	STD_LOGIC;
	SIGNAL IntrRx		:	STD_LOGIC;
	SIGNAL INTR			:	STD_LOGIC;
	SIGNAL INTA			:	STD_LOGIC;  
	SIGNAL GIE			:	STD_LOGIC;
	SIGNAL INTR_Active	:	STD_LOGIC;
	SIGNAL CLR_IRQ		:	STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL IFG_STATUS_ERROR : STD_LOGIC;
	
	signal FIRCTL      : std_logic_vector(7 downto 0) := (others => '0');  -- control reg
	signal COEF0_reg, COEF1_reg, COEF2_reg, COEF3_reg :
		std_logic_vector(7 downto 0) := (others => '0');
	signal COEF4_reg, COEF5_reg, COEF6_reg, COEF7_reg :
		std_logic_vector(7 downto 0) := (others => '0');


signal FIFORST   : STD_LOGIC;
-- signal FIFOCLK   : STD_LOGIC;
signal FIFOWEN   : STD_LOGIC;
-- signal FIRCLK    : STD_LOGIC;
signal FIRRST    : STD_LOGIC;
signal FIRENA    : STD_LOGIC;
signal FIRIN_reg     : STD_LOGIC_VECTOR(31 downto 0);  -- 32-bit


signal FIRIFG    : STD_LOGIC;                      

-- signal FIFOEMPTY : STD_LOGIC;
signal FIROUT_Core_s  : STD_LOGIC;
signal FIROUT_reg    : STD_LOGIC_VECTOR(31 downto 0);

signal clockMASTER_S : STD_LOGIC;	
--signal delayed_clock : STD_LOGIC;


------delay clock for the FIR core
--  signal DIV		: STD_LOGIC_VECTOR(3 DOWNTO 0); -- 4-bit divider
--  signal delayed_clock : STD_LOGIC ;
BEGIN	
	resetSim 	<= reset WHEN SIM ELSE not reset;
	clockMASTER_S <= clock;

-- pll_masterclock :  PLL 
--   PORT MAP
--   (
-- 	inclk0 => clock,
-- 	c0		=> clockMASTER_S
--   );

-- 	pll_delayedclock :  PLL 
-- 	generic map (
-- 		divide_clk => 2000
-- 	)
-- 	port map(
-- 		inclk0		=> clock,
-- 		c0			=> delayed_clock

-- 	);

	CPU: MIPS
		GENERIC MAP(
					MemWidth	=> MemWidth,
					SIM 		=> SIM)
		PORT MAP(
					reset		=> resetSim,
					clock		=> clockMASTER_S,
					-- clock		=> clock,
					ena			=> ena,
					PC			=> PC,
					CLKCNT		=> CLKCNT,
					STCNT		=> STCNT,
					FHCNT		=> FHCNT,
					BPADD		=> BPADD,
					ST_trigger	=> ST_trigger,
					ControlBus	=> ControlBus,
					MemReadBus	=> MemReadBus,
					MemWriteBus	=> MemWriteBus,
					AddressBus	=> AddressBus,
					GIE			=> GIE,
					INTR		=> INTR,
					INTA		=> INTA,
					INTR_Active	=> INTR_Active,
					CLR_IRQ		=> CLR_IRQ,
					DataBus		=> DataBus
		);
		
	
	IO_interface: GPIO
		PORT MAP(
			--INTA		=> INTA,
			MemReadBus	=> MemReadBus,
			clock		=> clockMASTER_S,
					-- clock		=> clock,
			reset		=> resetSim,
			MemWriteBus	=> MemWriteBus,
			AddressBus	=> AddressBus,
			DataBus		=> DataBus,
			HEX0		=> HEX0,
			HEX1		=> HEX1,
			HEX2		=> HEX2,
			HEX3		=> HEX3,
			HEX4		=> HEX4,
			HEX5		=> HEX5,
			LEDR		=> LEDR,
			Switches	=> Switches
			-- CS_LEDR		=> CS_LEDR,
			-- CS_SW		=> CS_SW,
			-- CS_HEX0		=> CS_HEX0,
			-- CS_HEX1		=> CS_HEX1,
			-- CS_HEX2		=> CS_HEX2,
			-- CS_HEX3		=> CS_HEX3,
			-- CS_HEX4		=> CS_HEX4,
			-- CS_HEX5		=> CS_HEX5
		);
		PROCESS(clock)
BEGIN
    if (falling_edge(clock)) then
        -- Basic Timer Control
        if(AddressBus(11 DOWNTO 0) = X"81C" AND MemWriteBus = '1') then
            BTCTL <= DataBus(7 DOWNTO 0);
        END IF;

        if(AddressBus(11 DOWNTO 0) = X"824" AND MemWriteBus = '1') then
            BTCCR0 <= DataBus;
        END IF;
        if(AddressBus(11 DOWNTO 0) = X"828" AND MemWriteBus = '1') then
            BTCCR1 <= DataBus;
        END IF;
        
        -- FIRCTL no writing to fifofull and fifoempty
        if(AddressBus(11 DOWNTO 0) = X"82C" AND MemWriteBus = '1') then
            FIRCTL(7 downto 4) <= DataBus(7 DOWNTO 4);
            FIRCTL(1 downto 0) <= DataBus(1 DOWNTO 0);
        else
            FIRCTL(5) <= '0';
        END IF;

        -- COEF writes
        if(AddressBus(11 DOWNTO 0) = X"838" AND MemWriteBus = '1') then
            COEF0_reg <= DataBus(7 downto 0);
			COEF1_reg <= DataBus(15 downto 8);
			COEF2_reg <= DataBus(23 downto 16);
			COEF3_reg <= DataBus(31 downto 24);
        END IF;
        
        if(AddressBus(11 DOWNTO 0) = X"83C" AND MemWriteBus = '1') then
            COEF4_reg <= DataBus(7 downto 0);
			COEF5_reg <= DataBus(15 downto 8);
			COEF6_reg <= DataBus(23 downto 16);
			COEF7_reg <= DataBus(31 downto 24);
        END IF;
        

        -- FIRIN write
        if(AddressBus(11 DOWNTO 0) = X"830" AND MemWriteBus = '1') then
            FIRIN_reg <= DataBus;
        END IF;

        -- BTCNT Write - Only drive when writing, else high-impedance
        if (AddressBus(11 DOWNTO 0) = X"820" AND MemWriteBus = '1') THEN
            BTCNT <= DataBus;
        else
            BTCNT <= (OTHERS => 'Z');  -- High impedance when not writing
        END IF;

        -- ============ DATABUS READ SECTION - WITH TRI-STATE ============
        -- Only one DataBus assignment with proper tri-state logic
        if MemReadBus = '1' then
            case AddressBus(11 DOWNTO 0) is
                when X"838" => 
                    DataBus <= X"000000" & COEF0_reg;  -- Pad to 32 bits
                when X"839" => 
                    DataBus <= X"000000" & COEF1_reg;
                when X"83A" => 
                    DataBus <= X"000000" & COEF2_reg;
                when X"83B" => 
                    DataBus <= X"000000" & COEF3_reg;
                when X"83C" => 
                    DataBus <= X"000000" & COEF4_reg;
				when X"82C" =>
					DataBus <= X"000000" & FIRCTL;
                when X"83D" => 
                    DataBus <= X"000000" & COEF5_reg;
                when X"83E" => 
                    DataBus <= X"000000" & COEF6_reg;
                when X"83F" => 
                    DataBus <= X"000000" & COEF7_reg;
                when X"834" => 
                    DataBus <= FIROUT_reg;
                when X"820" => 
                    DataBus <= BTCNT;
                when others =>
                    DataBus <= (OTHERS => 'Z');  -- High impedance for other addresses
            end case;
        else
            DataBus <= (OTHERS => 'Z');  -- High impedance when not reading
        end if;
    END IF;
END PROCESS;
	
	
	----
	-- PROCESS (clock) BEGIN
	-- 	IF (falling_edge(clock)) THEN
	-- 		FIRCTL(5) <= '0';
	-- 	END IF;
	-- END PROCESS;			



	
	Basic_Timer: BTIMER
		PORT MAP(
			Addr	=> AddressBus(11 DOWNTO 0),
			BTRead	=> MemReadBus,
			BTWrite	=> MemWriteBus,
			MCLK	=> clockMASTER_S,
			-- MCLK => clock,
			reset	=> resetSim,
			BTCTL	=> BTCTL,
			BTCCR0	=> BTCCR0,
			BTCCR1	=> BTCCR1,
			BTCNT_io=> BTCNT,
			IRQ_OUT => IRQ_OUT(2),
			BTIFG	=> BTIFG,
			BTOUT	=> BTOUT
		);
		
------sample the FIRCTL's elements to control the FIR fifo array(the FIR FIFO component inputs )------- FIRENA <= FIRCTL(0);  -- enable FIR processing
--FIRRST <= FIRCTL(1); -- reset for the FIFO	
--FIFOEMPTY <= FIRCTL(2); -- FIFO empty status
--FIFOFULL <= FIRCTL(3);  -- FIFO full status
--FIFORST <= FIRCTL(4); -- reset for the FIR logic
--FIFOWEN <= FIRCTL(5); -- write enable for the FIFO



	fir: FIR_Filter
    PORT MAP (
        FIFORST   => FIRCTL(4),      -- reset for the FIR FIFO
        FIFOCLK   => clockMASTER_S,         -- clock domain for FIFO writes
		-- FIFOCLK   => clock,
        FIFOWEN   => FIRCTL(5),       -- write enable from MCU
		FIFOFULL  => FIRCTL(3),        -- FIFO full status to MCU
        FIFOEMPTY => FIRCTL(2),       -- FIFO empty status to MCU
		FIROUT_Core => FIROUT_Core_s, -- FIR output status to MCU

        FIROUT    => FIROUT_reg,     -- filtered 32-bit output		
		FIRCLK    => delayed_clock,
        FIRRST    => FIRCTL(1),      -- reset for FIR logic
        FIRENA    => FIRCTL(0),           -- enable FIR calculation
        FIRIN     => FIRIN_reg,      -- 32-bit input sample
        FIRIFG    => FIRIFG,          -- interrupt flag to MCU
        COEF0     => COEF0_reg,        -- coefficients from MCU
        COEF1     => COEF1_reg,
        COEF2     => COEF2_reg,
        COEF3     => COEF3_reg,
        COEF4     => COEF4_reg,
        COEF5     => COEF5_reg,
        COEF6     => COEF6_reg,
        COEF7     => COEF7_reg
    );
		


	IntrSrc	<= FIRIFG & (NOT KEY3) & (NOT KEY2) & (NOT KEY1) & BTIFG & IntrTx & IntrRx;

	Intr_Controller: InterruptController
		GENERIC MAP(
			DataBusSize	=> DataBusSize,
			AddrBusSize	=> AddrBusSize,
			IrqSize		=> IrqSize,
			RegSize 	=> RegSize
		)
		PORT MAP(
			reset		=> resetSim,
		    clock		=> clockMASTER_S,
					-- clock		=> clock,
		    MemReadBus	=> MemReadBus,
		    MemWriteBus	=> MemWriteBus,
		    AddressBus	=> AddressBus,
		    DataBus		=> DataBus,
		    IntrSrc		=> IntrSrc,
		    ChipSelect	=> '0',
			FIRIFG_Core	=> FIROUT_Core_s,
			FIFOEMPTY	=> FIRCTL(2),
		    INTR		=> INTR,
		    INTA		=> INTA,
			IRQ_OUT		=> IRQ_OUT,
			INTR_Active	=> INTR_Active,
			CLR_IRQ_OUT	=> CLR_IRQ,
			IFG_STATUS_ERROR => IFG_STATUS_ERROR,
		    GIE			=> GIE
		);
		
		
	-- -- Uart Support
	-- UsartSupport: USART
	-- 	GENERIC MAP(
	-- 		DataBusSize	=> DataBusSize,
	-- 		AddrBusSize	=> 12,
	-- 		IrqSize		=> IrqSize,
	-- 		RegSize 	=> RegSize			
	-- 	)
	-- 	PORT MAP(
	-- 		clock		=> clockMASTER_S,
	-- 				-- clock		=> clock,
	-- 		reset		 	=> resetSim,
	-- 		RXIFG			=> IntrRx,
	-- 		TXIFG			=> IntrTx,
	-- 		B_RX			=> UART_RX,
	-- 		B_TX			=> UART_TX,
	-- 		IFG_STATUS_ERROR=> IFG_STATUS_ERROR,
	-- 		AddressBus		=> AddressBus(11 DOWNTO 0),
	-- 		DataBus			=> DataBus,
	-- 		MemReadBus		=> MemReadBus,
	-- 	    MemWriteBus		=> MemWriteBus
	-- 	);

	-- 	-- clk_sim : clock_simulation
	-- 	-- port map (
	-- 	-- 	Clock => clockMASTER_S,
	-- 	-- 	Clock2 => delayed_clock
		-- );

END structure;