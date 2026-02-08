library IEEE;
use ieee.std_logic_1164.all;

package aux_package is
--------------------------------------------------------
	component CDC is
	GENERIC (n : INTEGER := 8;
		   k : integer := 3);   -- k=log2(n)
  PORT 
  (  
	Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		  Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC  
  );
	end component;
---------------------------------------------------------  
	component FA is
		PORT (xi, yi, cin: IN std_logic;
			      s, cout: OUT std_logic);
	end component;
---------------------------------------------------------	
	component AdderSub is
	GENERIC (n : INTEGER := 8);
  PORT (
		x,y  		: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		sub_cont 	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        cout  		: OUT STD_LOGIC;
        s  			: OUT STD_LOGIC_VECTOR(n-1 downto 0));
	end component;
---------------------------------------------------------
	component Logic is 
	GENERIC (n : INTEGER := 8);
  PORT ( 	
			x,y  : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			alufn_logic : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			res_logic  : OUT STD_LOGIC_VECTOR(n-1 downto 0)
		);
	end component;
---------------------------------------------------------
	component Shifter is
	GENERIC (	n	: INTEGER := 8; -- Input size
			k	: INTEGER := 3); -- Number of steps Log(n)
  PORT ( X,Y	: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		 direction	: IN STD_LOGIC_VECTOR (2 DOWNTO 0); -- directionection: left or right
         res	: OUT STD_LOGIC_VECTOR(n-1 downto 0); -- shifted vector as the output
		 cout	: OUT STD_LOGIC
	    );
	end component;
	---------------------------------------------------------
	component PWM is
	generic ( m : integer := 16 ); 
	port( rst_i, clk_i, en_i : in std_logic;
		  X_i,Y_i : in std_logic_vector(m-1 downto 0);
		  PWMmode_i : std_logic_vector(1 downto 0);
		  PWM_o : out std_logic
		  );
	end component;	
---------------------------------------------------------
	component SDC is
	GENERIC (m : INTEGER := 16);
	
  PORT 	( 
		rst_i, clk_i, en_i : in std_logic;
		X_i,Y_i : in std_logic_vector(m-1 downto 0);
		ALUFN_i : std_logic_vector(4 downto 0);
		PWM_o : out std_logic
		);
	end component;	
---------------------------------------------------------
	component DigitalSystem IS -- Combinatorial Digital Circuit
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
END component;
---------------------------------------------------------
	component SevSegDec is
	  
	  PORT (data		: in STD_LOGIC_VECTOR (3 DOWNTO 0);
		seg   		: out STD_LOGIC_VECTOR (6 downto 0));
	end component;	
---------------------------------------------------------
	component PLL is
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC 
	);
	end component;
end aux_package;

