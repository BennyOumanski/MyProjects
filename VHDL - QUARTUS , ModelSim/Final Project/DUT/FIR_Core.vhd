library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-------------------------------------
ENTITY FIR_Core IS
    GENERIC (
        DATA_BUS_WIDTH : INTEGER := 32;
        Q              : integer := 8;
        W              : integer := 24
    );
    PORT ( 
            DATA    : in std_logic_vector(W-1 downto 0);
            FIRCLK    : in std_logic;
            FIRRST    : in std_logic;
            FIRENA    : in std_logic;
            new_out_i   : in std_logic;
            COEF0      : in std_logic_vector(q-1 downto 0);
            COEF1      : in std_logic_vector(q-1 downto 0);
            COEF2      : in std_logic_vector(q-1 downto 0);
            COEF3      : in std_logic_vector(q-1 downto 0);
            COEF4      : in std_logic_vector(q-1 downto 0);
            COEF5      : in std_logic_vector(q-1 downto 0);
            COEF6      : in std_logic_vector(q-1 downto 0);
            COEF7      : in std_logic_vector(q-1 downto 0);
            FIRIFG_Core : out std_logic;
            FIROUT      : out std_logic_vector(DATA_BUS_WIDTH-1 downto 0)
    );
END FIR_Core;

architecture FIR_Core_arch of FIR_Core is
    signal new_out_w: std_logic := '0';
    signal ifg_w    : std_logic := '0';
    signal FIROUTut_w : std_logic_vector(DATA_BUS_WIDTH-1 downto 0) := (others=>'0');
    signal zero_vec2_w: std_logic_vector(q-1 downto 0) := (others=>'0');
    signal x1    : std_logic_vector(W-1 downto 0) := (others=>'0');
    signal x2    : std_logic_vector(W-1 downto 0) := (others=>'0');
    signal x3    : std_logic_vector(W-1 downto 0) := (others=>'0');
    signal x4   : std_logic_vector(W-1 downto 0) := (others=>'0');
    signal x5   : std_logic_vector(W-1 downto 0) := (others=>'0');
    signal x6   : std_logic_vector(W-1 downto 0) := (others=>'0');
    signal x7    : std_logic_vector(W-1 downto 0) := (others=>'0');
    signal y    : std_logic_vector(W+Q-1 downto 0) := (others=>'0');
    signal m1 : ieee.numeric_std.unsigned(W+Q-1 downto 0);
    signal m2  : ieee.numeric_std.unsigned(W+Q-1 downto 0);
    signal m3  : ieee.numeric_std.unsigned(W+Q-1 downto 0);
    signal m4  : ieee.numeric_std.unsigned(W+Q-1 downto 0);
    signal m5  : ieee.numeric_std.unsigned(W+Q-1 downto 0);
    signal m6  : ieee.numeric_std.unsigned(W+Q-1 downto 0);
    signal m7  : ieee.numeric_std.unsigned(W+Q-1 downto 0);
    signal m8  : ieee.numeric_std.unsigned(W+Q-1 downto 0);
    
begin

    m1<= (ieee.numeric_std.unsigned(DATA) * ieee.numeric_std.unsigned(COEF0));
    m2 <= (ieee.numeric_std.unsigned(x1) * ieee.numeric_std.unsigned(COEF1));
    m3 <= (ieee.numeric_std.unsigned(x2) * ieee.numeric_std.unsigned(COEF2));
    m4 <= (ieee.numeric_std.unsigned(x3) * ieee.numeric_std.unsigned(COEF3));
    m5 <= (ieee.numeric_std.unsigned(x4) * ieee.numeric_std.unsigned(COEF4));
    m6 <= (ieee.numeric_std.unsigned(x5) * ieee.numeric_std.unsigned(COEF5));
    m7 <= (ieee.numeric_std.unsigned(x6) * ieee.numeric_std.unsigned(COEF6));
    m8 <= (ieee.numeric_std.unsigned(x7) * ieee.numeric_std.unsigned(COEF7));

    y <= std_logic_vector(m1+ m2 + m3 + m4 + 
                                m5 + m6 + m7 + m8);

                                

    final_result: process (FIRCLK, FIRRST, FIRENA, new_out_i)
    begin
        if (FIRRST='1') then
            FIROUTut_w <= (others=>'0');

            x1   <= (others =>'0');
            x2   <= (others =>'0');
            x3   <= (others =>'0');
            x4  <= (others =>'0');
            x5  <= (others =>'0');
            x6  <= (others =>'0');
            x7   <= (others =>'0');
        elsif (new_out_i='1') then
            new_out_w <= '1';
            ifg_w <= '0';
        elsif (falling_edge(FIRCLK)) then
            if (FIRENA ='1') then

                FIROUTut_w <= zero_vec2_w & y(DATA_BUS_WIDTH-1 downto q);
                new_out_w <= '0';

                if (new_out_w='1') then
                    new_out_w <= '0';
                    ifg_w <= '1';

                    x1 <= DATA;
                    x2 <= x1;
                    x3 <= x2;
                    x4<= x3;
                    x5<= x4;
                    x6<= x5;
                    x7 <= x6;
                end if;
            else
                FIROUTut_w <= (others=>'0');
            end if;
        end if;
    end process;
 
    FIROUT <= FIROUTut_w;
    FIRIFG_Core <= ifg_w;

end architecture;