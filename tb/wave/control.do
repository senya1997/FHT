onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fht_control_tb/CONTROL/iCLK
add wave -noupdate /fht_control_tb/CONTROL/iSTART
add wave -noupdate /fht_control_tb/CONTROL/EOF_STAGE
add wave -noupdate /fht_control_tb/CONTROL/LAST_STAGE
add wave -noupdate -radix unsigned /fht_control_tb/CONTROL/addr_rd
add wave -noupdate -radix unsigned /fht_control_tb/CONTROL/addr_rd_bias
add wave -noupdate -radix unsigned /fht_control_tb/CONTROL/cnt_stage_time
add wave -noupdate -radix unsigned /fht_control_tb/CONTROL/sector_num
add wave -noupdate -radix unsigned /fht_control_tb/CONTROL/stage_num
add wave -noupdate -radix unsigned /fht_control_tb/CONTROL/subsector_num
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {64 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 188
configure wave -valuecolwidth 100
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
configure wave -timelineunits us
update
WaveRestoreZoom {0 ns} {977 ns}
