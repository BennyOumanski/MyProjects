-- Optimized Address Decoder
-- The module decodes the address bus to generate chip select signals for various peripherals

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE work.aux_package.ALL;

ENTITY Optimized_Addr_Dec IS
	PORT( 

		AddressBus					: IN	STD_LOGIC_VECTOR(11 DOWNTO 0);
		reset 						: IN	STD_LOGIC;
		CS_LEDR, CS_SW, CS_KEY		: OUT 	STD_LOGIC;
		CS_HEX0, CS_HEX1, CS_HEX2	: OUT 	STD_LOGIC;
		CS_HEX3, CS_HEX4, CS_HEX5	: OUT 	STD_LOGIC
		);
END Optimized_Addr_Dec;

ARCHITECTURE structure OF Optimized_Addr_Dec IS

BEGIN
	-- Chip Select Logic
	CS_SW	<=	'0' WHEN reset = '1' ELSE '1' WHEN AddressBus = X"810" ELSE '0';
	CS_KEY	<=	'0' WHEN reset = '1' ELSE '1' WHEN AddressBus = X"814" ELSE '0';
	CS_LEDR	<=	'0' WHEN reset = '1' ELSE '1' WHEN AddressBus = X"800" ELSE '0';
	CS_HEX0	<=	'0' WHEN reset = '1' ELSE '1' WHEN AddressBus = X"804" ELSE '0';
	CS_HEX1	<=	'0' WHEN reset = '1' ELSE '1' WHEN AddressBus = X"805" ELSE '0';
	CS_HEX2	<=	'0' WHEN reset = '1' ELSE '1' WHEN AddressBus = X"808" ELSE '0';
	CS_HEX3	<=	'0' WHEN reset = '1' ELSE '1' WHEN AddressBus = X"809" ELSE '0';
	CS_HEX4	<=	'0' WHEN reset = '1' ELSE '1' WHEN AddressBus = X"80C" ELSE '0';
	CS_HEX5	<=	'0' WHEN reset = '1' ELSE '1' WHEN AddressBus = X"80D" ELSE '0';

END structure;