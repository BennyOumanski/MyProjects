onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/rst
add wave -noupdate /tb/clk
add wave -noupdate /tb/repeat
add wave -noupdate -radix hexadecimal /tb/upperBound
add wave -noupdate -radix hexadecimal /tb/count
add wave -noupdate /tb/busy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4000000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {2436090 ps} {6532090 ps}
bookmark add wave bookmark3 {{0 ps} {1 ns}} 0
bookmark add wave bookmark4 {{36 ps} {116 ps}} 0
