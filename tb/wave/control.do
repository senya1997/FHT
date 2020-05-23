onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fht_control_tb/CONTROL/iCLK
add wave -noupdate /fht_control_tb/CONTROL/clk_2
add wave -noupdate /fht_control_tb/CONTROL/iSTART
add wave -noupdate /fht_control_tb/CONTROL/AFTER_ZERO_STAGE
add wave -noupdate /fht_control_tb/CONTROL/ZERO_STAGE
add wave -noupdate /fht_control_tb/CONTROL/LAST_STAGE
add wave -noupdate /fht_control_tb/CONTROL/EOF_STAGE
add wave -noupdate /fht_control_tb/CONTROL/EOF_SECTOR
add wave -noupdate /fht_control_tb/CONTROL/SEC_PART_SUBSEC
add wave -noupdate /fht_control_tb/CONTROL/stage
add wave -noupdate -radix unsigned /fht_control_tb/CONTROL/cnt_stage_time
add wave -noupdate /fht_control_tb/CONTROL/sector
add wave -noupdate /fht_control_tb/CONTROL/cnt_sector
add wave -noupdate /fht_control_tb/CONTROL/cnt_sector_time
add wave -noupdate /fht_control_tb/CONTROL/sector_size
add wave -noupdate /fht_control_tb/CONTROL/div
add wave -noupdate /fht_control_tb/CONTROL/cnt_addr
add wave -noupdate /fht_control_tb/CONTROL/rdy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18470 ns} 0}
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
WaveRestoreZoom {0 ns} {47250 ns}
