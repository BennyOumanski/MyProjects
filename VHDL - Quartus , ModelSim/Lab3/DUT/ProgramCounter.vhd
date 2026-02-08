library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--------------------------------------------------------------
entity ProgramCounter is
generic	( 
			n: integer:= 16
		);
port(	PCin: in std_logic;
		PCsel: 	in std_logic_vector (1 downto 0);
		IR:				in std_logic_vector (7 downto 0);
		PC_Out:  		out std_logic_vector (n-1 downto 0);
		clk:            in std_logic
	);
end ProgramCounter;
--------------------------------------------------------------
architecture behav of ProgramCounter is

signal pc_out_signal, pc_in_signal: std_logic_vector(n-1 downto 0);

begin	
		   
  process(clk)
  begin
	if (clk'event and clk='1') then
		if (PCin = '1') then 
		pc_out_signal <= pc_in_signal;
		end if;
	end if;
  end process;
--------------------------------------------------------------
WITH PCsel select
		pc_in_signal <=	(others => '0') 		WHEN "00",
						pc_out_signal + 1		WHEN "01", 
						pc_out_signal + 1 + SXT(IR, n)	WHEN "10",
						unaffected when others;
						
PC_Out <= pc_out_signal;
--------------------------------------------------------------
end behav;