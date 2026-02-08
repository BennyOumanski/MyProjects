--- FIR_Filter.vhd ---
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE work.aux_package.ALL;

ENTITY FIR_Filter IS
	PORT( 
		FIFORST : IN STD_LOGIC;
        FIFOCLK : IN STD_LOGIC;
        FIFOWEN : IN STD_LOGIC;
        FIRCLK : IN STD_LOGIC;
        FIRRST : IN STD_LOGIC;
        FIRENA : IN STD_LOGIC;
        FIRIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        COEF0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        COEF1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        COEF2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        COEF3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        COEF4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        COEF5 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        COEF6 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        COEF7 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

        FIFOFULL : OUT STD_LOGIC;
        FIFOEMPTY : OUT STD_LOGIC;
        FIROUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        FIRIFG : OUT STD_LOGIC;
        FIROUT_Core : OUT STD_LOGIC
		);
END FIR_Filter;

architecture structure of FIR_Filter is
  signal dataout_s : std_logic_vector(31 downto 0);
  signal fiforen_s : std_logic;  
  signal FIRIFG_Core : std_logic;
  signal fifoempty_s : std_logic;
  signal fifofull_s  : std_logic;
  signal new_out_w   : std_logic;

begin

  -- FIFO (runs on FIFOCLK)
  FIFO_i : Sync_FIFO
    port map (
      FIFORST   => FIFORST,
      FIFOREN   => fiforen_s,
      FIFOWEN   => FIFOWEN,
      FIFOCLK   => FIFOCLK,
      FIFOEMPTY => fifoempty_s,
      FIFOFULL  => fifofull_s,
      FIFOIN     => "00000000" & FIRIN(23 downto 0),  -- pack to 32b
      DATAOUT   => dataout_s,
      new_out_o => new_out_w
    );

  -- Pulse sync (to generate FIFO read enable)
  Pulse_i : Pulse_Sync
    port map (
      FIFOCLK   => FIFOCLK,
      FIRCLK    => FIRCLK,
      FIRENA    => FIRENA,
      FIFORST   => FIFORST,
      FIRRST    => FIRRST,
      FIFOEMPTY => fifoempty_s,
      FIFOREN   => fiforen_s
    );

  -- FIR core (runs on FIRCLK)
  Core_i : FIR_Core
    port map (
      DATA   => dataout_s(23 downto 0),
      FIRCLK => FIRCLK,
      FIRRST => FIRRST,
      FIRENA => FIRENA,
      COEF0  => COEF0, COEF1 => COEF1, COEF2 => COEF2, COEF3 => COEF3,
      COEF4  => COEF4, COEF5 => COEF5, COEF6 => COEF6, COEF7 => COEF7,
      FIROUT => FIROUT,
      FIRIFG_Core => FIRIFG_Core,
      new_out_i   => new_out_w
    );

  FIROUT_Core <= FIRIFG_Core;
  FIRIFG <= FIRIFG_Core or fifoempty_s;
  FIFOEMPTY<= fifoempty_s;
  FIFOFULL<= fifofull_s;
  

END structure;