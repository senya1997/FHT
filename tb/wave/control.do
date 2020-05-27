onerror {resume}
quietly virtual signal -install /fht_control_tb/CONTROL { /fht_control_tb/CONTROL/BIAS_RD[7:0]} BIAS_RD_BYTE
quietly WaveActivateNextPane {} 0
add wave -noupdate /fht_control_tb/CONTROL/iCLK
add wave -noupdate /fht_control_tb/CONTROL/clk_2
add wave -noupdate /fht_control_tb/CONTROL/iSTART
add wave -noupdate /fht_control_tb/CONTROL/ZERO_STAGE
add wave -noupdate /fht_control_tb/CONTROL/LAST_STAGE
add wave -noupdate /fht_control_tb/CONTROL/EOF_STAGE
add wave -noupdate /fht_control_tb/CONTROL/EOF_READ
add wave -noupdate /fht_control_tb/CONTROL/SEC_PART_SUBSEC
add wave -noupdate /fht_control_tb/CONTROL/EOF_SECTOR
add wave -noupdate /fht_control_tb/CONTROL/EOF_SECTOR_BEHIND_NEG
add wave -noupdate -color Tan /fht_control_tb/CONTROL/EOF_SECTOR_BEHIND_POS
add wave -noupdate -color Tan /fht_control_tb/CONTROL/NEW_BIAS_RD
add wave -noupdate -color {Medium Orchid} -radix unsigned /fht_control_tb/CONTROL/stage
add wave -noupdate -radix unsigned /fht_control_tb/CONTROL/cnt_stage_time
add wave -noupdate -color {Slate Blue} -radix unsigned /fht_control_tb/CONTROL/cnt_sector
add wave -noupdate -color {Slate Blue} -radix unsigned /fht_control_tb/CONTROL/cnt_sector_time
add wave -noupdate -radix unsigned /fht_control_tb/CONTROL/div
add wave -noupdate -radix unsigned /fht_control_tb/CONTROL/div_2
add wave -noupdate -color Gold -radix unsigned /fht_control_tb/CONTROL/addr_rd
add wave -noupdate -color Gold -radix unsigned /fht_control_tb/CONTROL/addr_rd_bias
add wave -noupdate /fht_control_tb/CONTROL/rdy
add wave -noupdate -radix decimal /fht_control_tb/CONTROL/cnt_bias_rd
add wave -noupdate -radix unsigned /fht_control_tb/CONTROL/size_bias_rd
add wave -noupdate /fht_control_tb/CONTROL/BIAS_RD_BYTE
add wave -noupdate -radix decimal -childformat {{{/fht_control_tb/CONTROL/BIAS_RD[9]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[8]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[7]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[6]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[5]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[4]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[3]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[2]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[1]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[0]} -radix decimal}} -subitemconfig {{/fht_control_tb/CONTROL/BIAS_RD[9]} {-radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[8]} {-radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[7]} {-radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[6]} {-radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[5]} {-radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[4]} {-radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[3]} {-radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[2]} {-radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[1]} {-radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[0]} {-radix decimal}} /fht_control_tb/CONTROL/BIAS_RD
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {95638 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 237
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
WaveRestoreZoom {95099 ns} {95756 ns}
