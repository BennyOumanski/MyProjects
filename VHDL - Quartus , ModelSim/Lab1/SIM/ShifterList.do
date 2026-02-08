onerror {resume}
add list -width 15 /shifter_tb/x
add list /shifter_tb/y
add list /shifter_tb/direction
add list /shifter_tb/cout
add list /shifter_tb/res
configure list -usestrobe 0
configure list -strobestart {0 ps} -strobeperiod {0 ps}
configure list -usesignaltrigger 1
configure list -delta collapse
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
