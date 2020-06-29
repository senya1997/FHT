onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fht_but_tb/BUT/iCLK
add wave -noupdate -radix decimal /fht_but_tb/BUT/iX_0
add wave -noupdate -radix decimal /fht_but_tb/BUT/iX_1
add wave -noupdate -radix decimal /fht_but_tb/BUT/iX_2
add wave -noupdate -radix decimal /fht_but_tb/BUT/iSIN
add wave -noupdate -radix decimal /fht_but_tb/BUT/iCOS
add wave -noupdate -radix decimal /fht_but_tb/BUT/oY_0
add wave -noupdate -radix decimal /fht_but_tb/BUT/oY_1
add wave -noupdate -radix decimal /fht_but_tb/BUT/EXT_SUM_MUL
add wave -noupdate -radix decimal /fht_but_tb/BUT/ROUND_SUM_MUL
add wave -noupdate -radix decimal /fht_but_tb/BUT/EXT_SUM
add wave -noupdate -radix decimal /fht_but_tb/BUT/EXT_SUB
add wave -noupdate -radix decimal /fht_but_tb/BUT/ROUND_SUM
add wave -noupdate -radix decimal /fht_but_tb/BUT/ROUND_SUB
add wave -noupdate -radix decimal /fht_but_tb/BUT/sub_buf
add wave -noupdate -radix decimal /fht_but_tb/BUT/sum_buf
add wave -noupdate -radix decimal /fht_but_tb/BUT/sum_mul
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {157628 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 199
configure wave -valuecolwidth 97
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
WaveRestoreZoom {0 ns} {276950 ns}
