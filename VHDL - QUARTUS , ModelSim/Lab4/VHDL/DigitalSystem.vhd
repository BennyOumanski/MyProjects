LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY DigitalSystem IS -- Combinatorial Digital Circuit
  GENERIC (	n	: INTEGER := 8;
			m	: INTEGER := 16;
			k	: INTEGER := 4);
			
  PORT 
  (  
	Y_i,X_i: IN STD_LOGIC_VECTOR (m-1 DOWNTO 0);
	rst_i, clk_i, en_i : in std_logic;
	ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
	ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
	Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC;
	PWM_o : out std_logic	  
	); 
END DigitalSystem;

ARCHITECTURE struct OF DigitalSystem IS 

	signal X_i_s, Y_i_s : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	signal ALUFN_i_s : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal ALUout_o_s : STD_LOGIC_VECTOR(n-1 downto 0);
	signal Nflag_o_s, Cflag_o_s, Zflag_o_s, Vflag_o_s : std_logic;

begin

	Registers_input_CDC : process(clk_i)
	begin
		if rising_edge(clk_i) then 
			X_i_s <= X_i(n-1 DOWNTO 0);
			Y_i_s <= Y_i(n-1 DOWNTO 0);
			ALUFN_i_s <= ALUFN_i;
		end if;
	end process;
	
	Registers_output_CDC : process(clk_i)
	begin
		if rising_edge(clk_i) then 
			ALUout_o <= ALUout_o_s;
			Nflag_o <= Nflag_o_s;
			Cflag_o <= Cflag_o_s;
			Zflag_o <= Zflag_o_s;
			Vflag_o <= Vflag_o_s;
		end if;
	end process;

	hivut_CDC :CDC
		generic map (n=>n, k=>k)
		
		port map(
		X_i => X_i_s, --fill to port only 8 lsb bits
		Y_i => Y_i_s,
		ALUFN_i => ALUFN_i_s,
		ALUout_o => ALUout_o_s,
		Nflag_o => Nflag_o_s,
		Cflag_o => Cflag_o_s,
		Zflag_o => Zflag_o_s,
		Vflag_o => Vflag_o_s
		);
		
	
	hivut_SDC :SDC
		generic map (m=>m)
		
		port map(
		X_i => X_i,
		Y_i => Y_i,
		rst_i => rst_i,
		clk_i => clk_i,
		en_i => en_i,
		ALUFN_i => ALUFN_i,
		PWM_o => PWM_o
		
		);
		

end struct;