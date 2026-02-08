library ieee;
use work.aux_package.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--------------------------------------------------------------
entity ALU is
generic( n: integer:=16
		);
port(	A, B: in std_logic_vector(n-1 downto 0);	
		ALUFN: in std_logic_vector(3 downto 0);
		C : out std_logic_vector(n-1 downto 0);
		Cflag, Zflag, Nflag: out std_logic
	);
end ALU;
--------------------------------------------------------------
architecture behav of ALU is

signal a_s, b_s, c_s: std_logic_vector(n-1 downto 0);
SIGNAL cin, cout : std_logic;
signal reg, s: std_logic_vector(n-1 downto 0);
signal zero_vector : STD_LOGIC_VECTOR(n-1 DOWNTO 0) := (  others => '0');

begin	
		   
	cin <= 	'0' when (ALUFN="0000")ELSE	-- cin=0 when add
			'1' when (ALUFN="0001")		-- cin=1 when sub
			else '0';
  --------xor for sub ----------
	a_gen  : for i in 0 to n-1 generate
	a_s(i) <= 	(A(i) xor '1') WHEN (ALUFN="0001") else
			'0' WHEN (ALUFN="1011")  -- C=B
			else A(i);
	end generate a_gen;
	
	--------mapping of FA and ripple adder-sub
	b_gen  : for i in 0 to n-1 generate
	b_s(i) <= 	B(i);
	end generate b_gen;
	
	first: FA port map(
	xi => a_s(0),
	yi => b_s(0),
	cin => cin,
	s => s(0),
	cout => reg(0)
	);
	
	rest : for i in 1 to n-1 generate
	chain : FA port map(
	xi => a_s(i),
	yi => b_s(i),
	cin => reg(i-1),
	s => s(i),
	cout => reg(i)
	);
	end generate rest;

	cout <= reg(n-1);
	-------c(i) per alu function 
	C_gen  : for i in 0 to n-1 generate
	c_s(i) <= a_s(i) and b_s(i) when ( ALUFN="0010") ELSE 
			a_s(i) OR b_s(i) when ( ALUFN="0011") ELSE
			a_s(i) XOR b_s(i) when ( ALUFN="0100") ELSE
			s(i) when (ALUFN = "0000" OR ALUFN="0001" or ALUFN="1011");
	end generate C_gen;
	
	--------------flags outputs------------
	C_flag: with ALUFN select
		Cflag <= cout when ("0000" or "0001"),
				'0' when others;
				
	Nflag <= 	'1' when (c_s(n-1)='1')
				else '0';
				
	Zflag <=	'1' when (c_s=zero_vector)
				else '0';
				
	C <= c_s;
end behav;
