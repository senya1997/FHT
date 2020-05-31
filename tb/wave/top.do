onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fht_tb/FHT/iCLK
add wave -noupdate /fht_tb/FHT/iSTART
add wave -noupdate -radix decimal /fht_tb/FHT/iDATA
add wave -noupdate -radix unsigned /fht_tb/FHT/iADDR_WR
add wave -noupdate /fht_tb/FHT/iWE_0
add wave -noupdate /fht_tb/FHT/iWE_1
add wave -noupdate /fht_tb/FHT/iWE_2
add wave -noupdate /fht_tb/FHT/iWE_3
add wave -noupdate /fht_tb/FHT/oRDY
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 2
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {23682 ps}
