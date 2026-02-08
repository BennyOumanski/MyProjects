onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/Y
add wave -noupdate /tb/X
add wave -noupdate /tb/ALUFN
add wave -noupdate /tb/ALUout
add wave -noupdate /tb/Nflag
add wave -noupdate /tb/Cflag
add wave -noupdate /tb/Zflag
add wave -noupdate /tb/Vflag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1999456 ps} 0}
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
configure wave -timeline 1
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {512 ns}
