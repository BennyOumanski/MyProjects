---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;


package cond_comilation_package is
---------------------------------------------------------
--	List of 4 local constants
---------------------------------------------------------
	constant MODELSIM_M9K_ADDRWIDTH : integer := 8;
	constant M4K_ADDRWIDTH : integer := 10;
	constant M4K_MEM_WORDS_NUM : integer := 1024;
	constant MODELSIM_M9K_MEM_WORDS_NUM : integer := 256;
--------------------------------------------------------	
	
	
	

	constant G_MODELSIM	: integer 			:= 1;
	constant G_WORD_GRANULARITY : boolean 	:= true;
	constant G_ADDRWIDTH : integer 			:= MODELSIM_M9K_ADDRWIDTH;
	constant G_DATA_WORDS_NUM : integer 	:= MODELSIM_M9K_MEM_WORDS_NUM;
--------------------------------------------------------

end cond_comilation_package;

