-description:
In this lab we  focus on serial code in VHDL. We’ll build a synchronous digital system with four inputs—an n-bit UpperBound vector [n-1:0], a reset signal rst, a clock clk and a repeat control—and two outputs: a busy flag (asserted while counting) and an n-bit count value [n-1:0].
The design uses two  counters:

*Fast counter: the limit is the output of the slow counter , the fast counter counts each time until it reaches the value of the slow counter, so until the slow counter reaches the upper limit of the entire system.
The fast counter receives information from the control block which determines its operation .
The output of the fast counter is also the output of the whole.

*Slow counter:The slow counter counts up to the upperbound and advances by 1 each time the fast counter reaches it. If it reaches the upperbound (or exceeds it), it resets itself depending on the repeat bit and the information from the Control block that determines its operation.

The slow counter advances dynamically each cycle until it reaches the specified UpperBound. If repeat is high once that limit is hit, the slow counter—and thus the system—resets and begins counting again from zero.
control: 
The control unit synchronizes a fast and a slow counter by relaying the slow counter’s value to the fast one and managing start/stop or reset behavior via one-bit control signals.
For the fast counter, a flag dictates whether to reset or halt upon matching the slow counter.
For the slow counter, another flag—determined by whether the fast counter has caught up, the configured limit, and a repeat setting—decides whether to stop at the limit or restart counting.

The moudules :
#System top entity:

Inputs: 
-Repeat 
-Rst
-Clk
-Upperbound 

Outputs:
-Count 
-Busy

#Fast counter : 
-Input :  
-Clk
-rst
Output : 
-Count 
#slow counter :
Input : 
-Clk
-rst
-upperbound 
Output:
-Cnt_slow

#control:
input:
repeat
-upperbound
output:
-busy
-*control outputs for the counters

also we have package :
contains  the components that we want to use.
#Package (`aux_package.vhd`)