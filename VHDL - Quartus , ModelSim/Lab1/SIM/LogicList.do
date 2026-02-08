onerror {resume}
add list -width 13 /logic_tb/x
add list /logic_tb/y
add list /logic_tb/alufn_logic
add list /logic_tb/res_logic
configure list -usestrobe 0
configure list -strobestart {0 ps} -strobeperiod {0 ps}
configure list -usesignaltrigger 1
configure list -delta collapse
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
