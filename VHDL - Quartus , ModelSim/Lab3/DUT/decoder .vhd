library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
USE work.aux_package.all;

----------------------------
entity decoder is
	generic( RegSize: integer:=4);
	port(	OPC : in std_logic_vector(RegSize-1 downto 0);
			xor_status,or_status,and_status,
			jnc,jc,jmp,sub,add,done,mov,ld,st,str: out std_logic
);
end decoder;

architecture arch of decoder is

begin
------OPC is 4 msb bits of IR ----------------
	add 		<= '1' when  OPC  ="0000" else '0';
	sub 		<= '1' when  OPC  ="0001" else '0';
	or_status 	<= '1' when  OPC  ="0011" else '0';
	xor_status 	<= '1' when  OPC  ="0100" else '0';
	and_status 	<= '1' when  OPC  ="0010" else '0';
	jmp 		<= '1' when  OPC  ="0111" else '0';
	jc 			<= '1' when  OPC  ="1000" else '0';
	jnc 		<= '1' when  OPC  ="1001" else '0';
	mov 		<= '1' when  OPC  ="1100" else '0';
	ld 			<= '1' when  OPC  ="1101" else '0';
	st 			<= '1' when  OPC  ="1110" else '0';
	done 		<= '1' when  OPC  ="1111" else '0';

end arch;

