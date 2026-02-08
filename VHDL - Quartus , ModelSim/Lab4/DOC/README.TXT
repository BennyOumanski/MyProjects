LAB4 



The Digital System Module (cdc) 
INPUTS - 
- input signal X
- input signal Y
- control signal ALUFN:
 ALUFN[4:3]: choose the selected module
 ALUFN[2:0]:selecet function in the moudle 

OUTPUTS - 
- Flags Z, C, N,V
-ALUout -  output according to the module 

** AdderSub (`AdderSub.vhd`)
  perofrm addition or subtraction, inc , dec , neg , swap


** Shifter (`Shifter.vhd`)
 a barrel-shifter-based shift. if `ALUFN[2:0] = 000` then we will shift to the left and if `ALUFN[2:0] = 001` we will shift to the right. 

** Logic (`Logic.vhd`)
 logical operations on the X, Y signals according to the `ALUFN` input: and , or ,xor ,not,nor,nand,nor


** FullAdder (`FA.vhd`)
full adder component from lab 1 

**pwn (pwn.vhd)
component that creat the pwm signal based on logical method on the timer.

**sdc (sdc.vhd)
a "top" moudle to warp the pwn 

**digitaSystem(digitaSystem.vhd)
a top moudle that warp the 'sdc' and 'cdc'

**SevSegDec(SevSegDec.vhd)
a compopnend that decode  5 bits to 7 bits , to show hex on the hexes leds on the fpga

**pll(pll.vhl)
componenet that given us , that creat the frequncy for the fpga

**Top(Top.vhd)
The top moudle that warp CDC and SDC and connect and mapping  it to the hardware of the fpga (switches,leds,hexes,keys)





#


#