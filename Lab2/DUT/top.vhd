LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
------------------------------------------------------------------
entity top is
	generic ( n : positive := 8 ); 
	port( rst_i, clk_i, repeat_i : in std_logic;
		  upperBound_i : in std_logic_vector(n-1 downto 0);
		  count_o : out std_logic_vector(n-1 downto 0);
		  busy_o : out std_logic);
end top;
------------------------------------------------------------------
architecture arc_sys of top is
	-- We'll use 4 signals:
	-- control_fast_w,control_slow_w that go from control to slow\fast counter 
	-- cnt_slow_q from slow counter to control
	-- cnt_fast_q from fast counter to control and output
	signal cnt_fast_q, cnt_slow_q : std_logic_vector(n-1 downto 0);
	signal control_fast_w :std_logic_vector(n downto 0);
	signal control_slow_w :std_logic;
begin
	----------------------------------------------------------------
	----------------------- fast counter process -------------------
	----------------------------------------------------------------
	
	proc1 : process(clk_i,rst_i)
	begin
		-- Here we set the reset setting in the flipflop
		if (rst_i = '1') then
			cnt_fast_q <= (others => '0');
		-- Each clock rise we determine if we need to continue the count, reset or stop
		-- control_fast_w is a vector of n+1 bits where n-1 downto 0 is the limit 
		-- we get from the control (from slow counter originally)
		-- the last bit (n) tells fast counter if it should continue (1):
		-- if the count is less then than the limit than add 1
		-- else if we reached the limit (or even exceeded it if the limit was changed)
		-- than we start the count again by counting from 0 again
		elsif (clk_i'event and clk_i= '1') then 
			if ((control_fast_w(n) = '1') or -- this is the "green light" from control
			((control_fast_w(n) = '0') and (cnt_fast_q < control_fast_w(n-1 downto 0)))) then -- if there is no "green light" to continue then we just finish our count to the current limit we get from control
				cnt_fast_q <= cnt_fast_q + 1; -- the count itself
				if (cnt_fast_q >= control_fast_w(n-1 downto 0)) then -- here we check if we need to start from zero again	
					cnt_fast_q <= (others => '0');
				end if;
			end if;
		end if;
	end process;
	
	----------------------------------------------------------------
	---------------------- slow counter process --------------------
	----------------------------------------------------------------
	
	-- The slow counter gets 1 bit from control 
	-- It's purpose is to tell slow counter if it can continue on counting
	-- * if it equals '1' and the slow count is less then the upper bound than we add 1 to the count
	-- ** if it equals '1' and the slow count >= upper bound then we reset the count
	-- otherwise it does nothing
	proc2 : process(clk_i,rst_i)
	begin
		-- Here we set the reset setting in the flipflop
		if (rst_i = '1') then
			cnt_slow_q <= (others => '0');
		elsif (clk_i'event and clk_i= '1') then -- on each clock rise do the following:
			if ((control_slow_w = '1') and (cnt_slow_q < upperBound_i)) then -- here we check if the signal from control equals '1' and slow count is less then the upper bound
				cnt_slow_q <= cnt_slow_q + 1; -- continue counting
			elsif ((control_slow_w = '1') and (cnt_slow_q >= upperBound_i)) then -- check if the signal from control equals '1' and slow count >= upper bound
				cnt_slow_q <= (others => '0'); -- in that case reset the count
			end if;
		end if;
		
	end process;
	---------------------------------------------------------------
	--------------------- combinational part ----------------------
	---------------------------------------------------------------
	
	-- The control is the combinational part of the system 
	-- it connects between slow counter and fast counter
	
	-- Here we set the first n bits that fast counter gets from control to be the slow counter current count
	-- It will act as a limit to which the fast counter can count
	control_fast_w(n-1 downto 0) <= cnt_slow_q;
	
	-- Here we set the last bit that fast counter gets from control
	-- It is the "green light" for fast counter to continue on 
	-- It will only be zero if the slow counter exceeded the upper bound (or reached it) and repeat input is zero
	control_fast_w(n) <= 	'0' when ((cnt_slow_q >= upperBound_i) and (repeat_i = '0')) 
							else '1';
	
	-- Set the signal to slow counter to be '1' if:
	-- fast coutner has reached slow counter and slow counter hasn't reached the upper bound
	-- or if fast coutner has reached slow counter and slow counter exceeded (or equals) the upper bound and repeat is on
	-- That's because in the last case we want slow counter to reset because the repeat is on
	control_slow_w <= 	'1' when ((cnt_fast_q = cnt_slow_q) and (cnt_slow_q < upperBound_i)) else
						'1' when ((cnt_fast_q = cnt_slow_q) and (cnt_slow_q >= upperBound_i) and (repeat_i = '1'))
						else '0';
	
	-- Set busy if fast counter reached slow counter and slow counter exceeded (or equals) the upper bound and repeat is off ('0')
	busy_o <= 	'0' when ((cnt_fast_q = cnt_slow_q) and (cnt_slow_q >= upperBound_i) and (repeat_i = '0'))
				else '1';
	
	-- Update the output to be fast counter's count
	count_o <= cnt_fast_q;
	----------------------------------------------------------------
end arc_sys;







