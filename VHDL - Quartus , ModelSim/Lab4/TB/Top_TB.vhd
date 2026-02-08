library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
---------------------------------------------------------
entity Top_TB is
	generic ( n : integer := 8;
			m : integer := 16;
			k : integer := 4);
	
end Top_TB;
-------------------------------------------------------------------------------
architecture Top_TB_arc of Top_TB is

	signal X_i, Y_i: STD_LOGIC_VECTOR(m-1 DOWNTO 0);
	signal ALUout_o : STD_LOGIC_VECTOR(n-1 DOWNTO 0); --alu 8 bits
	signal ALUFN_i : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal Nflag_o, Cflag_o, Zflag_o, Vflag_o: std_logic;
	signal rst_i, clk_i, en_i, PWM_o : std_logic;
begin
    
	hivut_Top :DigitalSystem
		generic map (n=>n,m=>m, k=>k)
		
		port map(
		X_i => X_i,
		Y_i => Y_i,
		rst_i => rst_i,
		clk_i => clk_i,
		en_i => en_i,
		ALUFN_i => ALUFN_i,
		ALUout_o => ALUout_o,
		Nflag_o => Nflag_o,
		Cflag_o => Cflag_o,
		Zflag_o => Zflag_o,
		Vflag_o => Vflag_o,
		PWM_o => PWM_o
		);
		
		gen_XY : process
        begin
		  X_i <= "0000000000000100";
		  Y_i <= "0000000000001000";
		  wait;
        end process;
		
		gen_ALUFN : process
		begin 
			ALUFN_i <= "00000";
			wait for 1000 ns;
			ALUFN_i <= "00001";
			wait for 2000 ns;
			ALUFN_i <= "00010";
			wait for 3000 ns;
			ALUFN_i <= "01000";
			wait for 4000 ns;
			ALUFN_i <= "01001";
			wait for 5000 ns;
			ALUFN_i <= "01010";
			wait for 6000 ns;
			ALUFN_i <= "01011";
			wait for 7000 ns;
			ALUFN_i <= "01101";
			wait for 8000 ns;
			ALUFN_i <= "10000";
			wait for 9000 ns;
			ALUFN_i <= "01101";
			wait for 10000 ns;
			ALUFN_i <= "11001";
			
			
			wait;
		end process;
		
        gen_clk : process
        begin
		  clk_i <= '0';
		  wait for 50 ns;
		  clk_i <= not clk_i;
		  wait for 50 ns;
        end process;	
		  
		gen_rst : process
        begin
		  rst_i <='1'; wait for 150 ns;
		  rst_i <='0';
		  wait;
        end process;
		
		gen_en_i : process
        begin
		  en_i <=	'1',
					'0' after 11000 ns;
		  wait;
        end process;
  
end architecture Top_TB_arc;
