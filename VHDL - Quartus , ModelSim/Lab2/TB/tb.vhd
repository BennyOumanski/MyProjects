library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
---------------------------------------------------------
entity tb is
	constant n : integer := 8;
end tb;
---------------------------------------------------------
architecture rtb of tb is
	signal rst, clk, repeat : std_logic;
	signal upperBound : std_logic_vector(n-1 downto 0);
	signal count : std_logic_vector(n-1 downto 0);
	signal busy	: std_logic;
begin
	L0 : top generic map (n) port map(rst,clk,repeat,upperBound,count,busy);
    
	-- clock process
        gen_clk : process
        begin
		  clk <= '0';
		  wait for 50 ns;
		  clk <= not clk;
		  wait for 50 ns;
        end process;
				
	-- Here we change upperBound 
	-- Starts as 3 and then 5 then 7 then 
		gen_upperBound : process
        begin
			upperBound <= (1=>'1',0=>'1',others => '0');
			for i in 0 to 1 loop
				wait for 800 ns;
				upperBound <= upperBound+2;
			end loop;
			wait for 800 ns;
        end process;
	
	-- turn repeat off after 1500ns
		gen_repeat : process
        begin
			repeat <='1'; wait for 1500 ns;
			repeat <='0'; wait for 1300 ns;
			repeat <='1'; wait for 2000 ns;
			repeat <='0'; wait;
        end process;  
	
	-- change reset intput:
		gen_rst : process
        begin
		  rst <='1'; wait for 150 ns;
		  rst <='0'; wait for 800 ns;
		  rst <='1'; wait for 300 ns;
		  rst <='0'; wait;
        end process;
		
		
		
end architecture rtb;
