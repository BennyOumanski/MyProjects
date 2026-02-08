Text description of lab1


Inputs: 
- signal`X`
- signal`Y`
- control signal `ALUFN`:
 *ALUFN[4:3]-  selected module: 
 "01"- AdderSub. "10" Shifter. "11"  Logic. 
 *ALUFN[2:0]- choose functio in the module.

OUTPUTS : 
-ALUout - the 'top' output base to module that selected.
 Flags:
-`Z`(Zero).`C`(Carry).`N`(Negative) .

#the moudels:
Selected  according to ALUFN
*AdderSub (`AdderSub.vhd`)
 According to alufn[0:2] : add or sub between 2  X, Y with (length of n)  by 'n'FA  . 
 when sub_cont control  ('1' - SUB`, '0' - ADD`).
 The NEG function: we also perform sub function , but define y to be vectorn of zeros with length of 'n' so the result is 0-x.


* Shifter (`Shifter.vhd`)
TIts barrel shifter based shift.
 when  `ALUFN[2:0] = 000` then  shift left and if `ALUFN[2:0] = 001`  shift  right.
 We  construct the module by iterating  all  layers, num of layers : k=log⁡2n.
 At each layer, we check the corresponding bit in the input value x. If the bit is 0- no shift  and the layer retains the same origin as the input. If the bit is 1- a shift is performed based on the specific layer, updating the origin accordingly.
# Logic (`Logic.vhd`)
This module do 7 logical operation ,we creat new operation that no in the originial package Nand Xnor and nor based on or , xor ,and .

# Top (`top.vhd`)
The module that wraps the  system.
The input is X ,Y ,ALUNFN  and the output is the flag and the output of the moudle we chose based on alufn[4:5]

#FullAdder (`FA.vhd`)

#FA

# Package (`aux_package.vhd`)
The file packages together all the elements we plan to utilize across the lab .



