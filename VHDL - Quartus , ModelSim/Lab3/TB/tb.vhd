library ieee;
use work.aux_package.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use IEEE.STD_LOGIC_TEXTIO.all;

---------------------------------------------------------
entity top_tb is
	constant BusSize: integer:=16;
	constant m		: integer:=16;
	constant Awidth : integer:=6;	 
	constant RegSize: integer:=4;
	constant dept   : integer:=64;

	constant dataMemResult:	 	string(1 to 41) :=
	"C:\Benny\VHDL\Lab3\output\DTCMcontent.txt";
	
	constant dataMemLocation: 	string(1 to 35) :=
	"C:\Benny\VHDL\Lab3\bin\DTCMinit.txt";
	
	constant progMemLocation: 	string(1 to 35) :=
	"C:\Benny\VHDL\Lab3\bin\ITCMinit.txt";
end top_tb;
---------------------------------------------------------
architecture rtb of top_tb is

	SIGNAL done_output:								STD_LOGIC := '0';
	SIGNAL rst, ena, clk, TBactive,
	DTCM_tb_wr_s, ITCM_tb_wr_s: 					STD_LOGIC;	
	SIGNAL DTCM_tb_in_s, DTCM_tb_out_s: 			STD_LOGIC_VECTOR (BusSize-1 downto 0); -- n
	SIGNAL ITCM_tb_in_s: 							STD_LOGIC_VECTOR (BusSize-1 downto 0); -- m (m=n?)
	SIGNAL DTCM_tb_addr_in_s, ITCM_tb_addr_in_s:  	STD_LOGIC_VECTOR (Awidth-1 DOWNTO 0);
	SIGNAL DTCM_tb_addr_out_s:						STD_LOGIC_VECTOR (Awidth-1 DOWNTO 0);
	SIGNAL PM_done, DM_done:						BOOLEAN;
	
begin
	
	top_portmap: top port map
		(
		clk => clk,
		rst => rst,
		ena =>	ena,
		DTCM_tb_out => DTCM_tb_out_s,
		DTCM_tb_wr => DTCM_tb_wr_s,
		DTCM_tb_in => DTCM_tb_in_s,
		DTCM_tb_addr_in => DTCM_tb_addr_in_s,
		DTCM_tb_addr_out => DTCM_tb_addr_out_s,
		TBactive => TBactive,
		ITCM_tb_wr => ITCM_tb_wr_s,
		ITCM_tb_in => ITCM_tb_in_s,
		ITCM_tb_addr_in => ITCM_tb_addr_in_s,
		done_output  => done_output
		);
	
    
	--------- start of stimulus section ------------------	
	
	--------- Rst
	gen_rst : process
	begin
	  rst <='1','0' after 100 ns;
	  wait;
	end process;
	
	------------ Clock
	gen_clk : process
	begin
	  clk <= '0';
	  wait for 50 ns;
	  clk <= not clk;
	  wait for 50 ns;
	end process;
	
	--------- 	TB
	gen_TB : process
        begin
		 TBactive <= '1';
		 wait until PM_done and DM_done;  
		 TBactive <= '0';
		 wait until done_output = '1';  
		 TBactive <= '1';	
        end process;	
	
				
				
	--------- --Reading from text file and initializing the data memory data--------
	LoadDataMem: process 
		file inDmemfile : text open read_mode is dataMemLocation;
		variable    linetomem			: std_logic_vector(BusSize-1 downto 0);
		variable	good				: boolean;
		variable 	L 					: line;
		variable	TempAddresses		: std_logic_vector(Awidth-1 downto 0) ; -- Awidth
	begin 
		DM_done <= false;
		TempAddresses := (others => '0');
		while not endfile(inDmemfile) loop
			readline(inDmemfile,L);
			hread(L,linetomem,good);
			next when not good;
			DTCM_tb_wr_s <= '1';
			DTCM_tb_addr_in_s <= TempAddresses;
			DTCM_tb_in_s <= linetomem;
			wait until rising_edge(clk);
			TempAddresses := TempAddresses +1;
		end loop ;
		DTCM_tb_wr_s <= '0';
		DM_done <= true;
		file_close(inDmemfile);
		wait;
	end process;
		
		
	--------- Reading from text file and initializing the program memory instructions ------
	LoadProgramMem: process 
		file inPmemfile : text open read_mode is progMemLocation;
		variable    linetomem			: std_logic_vector(BusSize-1 downto 0); 
		variable	good				: boolean;
		variable 	L 					: line;
		variable	TempAddresses		: std_logic_vector(Awidth-1 downto 0) ; -- Awidth
	begin 
		PM_done <= false;
		TempAddresses := (others => '0');
		while not endfile(inPmemfile) loop
			readline(inPmemfile,L);
			hread(L,linetomem,good);
			next when not good;
			ITCM_tb_wr_s <= '1';
			ITCM_tb_addr_in_s <= TempAddresses;
			ITCM_tb_in_s <= linetomem;
			wait until rising_edge(clk);
			TempAddresses := TempAddresses +1;
		end loop ;
		ITCM_tb_wr_s <= '0';
		PM_done <= true;
		file_close(inPmemfile);
		wait;
	end process;
	

	ena <= '1' when (DM_done and PM_done) else '0';
	
		
	--------- Writing from Data memory to external text file, after the program ends (done_output = 1). -----
	WriteToDataMem: process 
		file outDmemfile : text open write_mode is dataMemResult;
		variable    linetomem			: std_logic_vector(BusSize-1 downto 0);
		variable	good				: boolean;
		variable 	L 					: line;
		variable	TempAddresses		: std_logic_vector(Awidth-1 downto 0) ; -- Awidth
		variable 	counter				: integer;
	begin 
		wait until done_output = '1';  
		TempAddresses := (others => '0');
		counter := 1;
		while counter < 16 loop	--15 lines in file
			DTCM_tb_addr_out_s <= TempAddresses;
			wait until rising_edge(clk);
			wait until rising_edge(clk); -- added now 12/5/2023 14:48
			hwrite(L,DTCM_tb_out_s);
			writeline(outDmemfile,L);
			TempAddresses := TempAddresses +1;
			counter := counter +1;
		end loop ;
		file_close(outDmemfile);
		wait;
	end process;
		

end architecture rtb;