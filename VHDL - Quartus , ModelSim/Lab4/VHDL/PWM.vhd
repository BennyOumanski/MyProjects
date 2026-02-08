LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
------------------------------------------------------------------
entity PWM is
	generic ( m : integer := 16 ); 
	port( rst_i, clk_i, en_i : in std_logic;
		  X_i,Y_i : in std_logic_vector(m-1 downto 0);
		  PWMmode_i : std_logic_vector(1 downto 0);
		  PWM_o : out std_logic
		  );
		  
end PWM;
------------------------------------------------------------------
architecture arc_sys of PWM is
	
	signal tmr_q: std_logic_vector(m-1 downto 0);
	signal EQUY: std_logic;
	signal gtx: std_logic;
	--signal mode2_s: std_logic := '0';
	signal PWM_o_s: std_logic := '0';
	
begin
	------------------16-bit Timer-------------------
	Timer : process(clk_i,rst_i, en_i)
	begin
		-- Here we set the reset setting in the flipflop
		if (rst_i = '1') then
			tmr_q <= (others => '0');
		
		elsif rising_edge(clk_i) then 
			if (en_i='1') then
				if (EQUY='1') then
					tmr_q <= (others => '0');
				else 
					tmr_q <= tmr_q + 1;
				end if;
			end if;
		end if;
	end process;
	
	---------------------Digital Circuit----------------------
	
			
	DigitalCircuit : process(clk_i,rst_i, en_i)
	begin
		-- Here we set the reset setting in the flipflop
		if falling_edge(clk_i) then 
			if (en_i='1') then
				----------mode 2 signal update---------------
				--if (tmr_q = X_i) then
				--	mode2_s <= not (mode2_s);
				--end if;
				------------------EQUY-----------------------
				if (tmr_q >= Y_i) then
					EQUY <= '1';
				else 
					EQUY <= '0';
				end if;
				-------incorrect X,Y input (X>Y)-------------
				if (X_i > Y_i) then
					PWM_o_s <= '0';
				-----------------Mode 0----------------------
				elsif (PWMmode_i = "00") then
					if (tmr_q >= X_i and tmr_q <= Y_i) then
						PWM_o_s <= '1';
					else 
						PWM_o_s <= '0';
					end if;
				-----------------Mode 1----------------------
				elsif (PWMmode_i = "01") then
					if (tmr_q >= X_i and tmr_q <= Y_i) then
						PWM_o_s <= '0';
					else 
						PWM_o_s <= '1';
					end if;
				-----------------Mode 2----------------------
				elsif (PWMmode_i = "10") then
					if (tmr_q = X_i) then
						PWM_o_s <= not (PWM_o_s);
					end if;
				end if;
			end if;
		end if;
	end process;
	
PWM_o <= PWM_o_s;	
	----------------------------------------------------------------
end arc_sys;
