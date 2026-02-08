-- Pulse_Sync: generate one FIFOCLK-cycle pulse (FIFOREN) per FIRCLK tick while FIRENA=1
-- Clocks are asynchronous. Assumption: FIFOCLK is >= a few times FIRCLK.

library ieee;
use ieee.std_logic_1164.all;

entity Pulse_Sync is
  port (
    FIRENA  	: in  std_logic;   -- if '1': request one read per FIRCLK tick
    FIFOCLK 	: in  std_logic;   -- FIFO domain clock (read side)
    FIRCLK  	: in  std_logic;   -- FIR domain clock
    FIRRST  	: in  std_logic;   -- FIR reset
	FIFORST 	: in  std_logic;   -- FIFO reset
	FIFOREN 	: out std_logic;  -- one-cycle pulse in FIFOCLK domain
		FIFOEMPTY 	: in  std_logic -- FIFO empty flag

    
  );
end entity;

architecture structure of Pulse_Sync is
  -- FIR domain: request encoded as a TOGGLE
  signal req_tgl : std_logic := '0';

  -- FIFO domain: two-FF synchronizer and edge detector
  signal req_s1, req_s2, req_s2_d : std_logic := '0';
begin
  -----------------------------------------------------------------------------
  -- FIR domain: on each FIRCLK when enabled, toggle the request bit
  -----------------------------------------------------------------------------
  process (FIRCLK)
  begin
    if rising_edge(FIRCLK) then
      if FIRENA = '1' then
        req_tgl <= not req_tgl;       -- one toggle == ask for exactly one read
      end if;
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- FIFO domain: synchronise the toggle and produce a 1-cycle pulse
  -----------------------------------------------------------------------------
  process (FIFOCLK)
  begin
    if rising_edge(FIFOCLK) then
      req_s1   <= req_tgl;            -- FF#1 (may go metastable)
      req_s2   <= req_s1;             -- FF#2 (stable in FIFO domain)
      req_s2_d <= req_s2;             -- delayed copy for edge detect

      FIFOREN  <= ((req_s2 xor req_s2_d) and (not FIFOEMPTY) and (not FIFORST) and (not FIRRST));  -- 1-cycle pulse for each new toggle
    end if;
  end process;
end architecture;
