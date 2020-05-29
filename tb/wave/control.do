onerror {resume}
quietly virtual signal -install /fht_control_tb/CONTROL { /fht_control_tb/CONTROL/BIAS_RD[7:0]} BIAS_RD_BYTE
quietly WaveActivateNextPane {} 0
add wave -noupdate /fht_control_tb/CONTROL/iCLK
add wave -noupdate /fht_control_tb/CONTROL/iSTART
add wave -noupdate /fht_control_tb/CONTROL/ZERO_STAGE
add wave -noupdate /fht_control_tb/CONTROL/LAST_STAGE
add wave -noupdate /fht_control_tb/CONTROL/EOF_STAGE
add wave -noupdate /fht_control_tb/CONTROL/EOF_READ
add wave -noupdate /fht_control_tb/CONTROL/SEC_PART_SUBSEC
add wave -noupdate -radix binary -childformat {{{/fht_control_tb/CONTROL/sec_part_subsec_d[4]} -radix binary} {{/fht_control_tb/CONTROL/sec_part_subsec_d[3]} -radix binary} {{/fht_control_tb/CONTROL/sec_part_subsec_d[2]} -radix binary} {{/fht_control_tb/CONTROL/sec_part_subsec_d[1]} -radix binary} {{/fht_control_tb/CONTROL/sec_part_subsec_d[0]} -radix binary}} -expand -subitemconfig {{/fht_control_tb/CONTROL/sec_part_subsec_d[4]} {-height 15 -radix binary} {/fht_control_tb/CONTROL/sec_part_subsec_d[3]} {-height 15 -radix binary} {/fht_control_tb/CONTROL/sec_part_subsec_d[2]} {-height 15 -radix binary} {/fht_control_tb/CONTROL/sec_part_subsec_d[1]} {-height 15 -radix binary} {/fht_control_tb/CONTROL/sec_part_subsec_d[0]} {-height 15 -radix binary}} /fht_control_tb/CONTROL/sec_part_subsec_d
add wave -noupdate /fht_control_tb/CONTROL/EOF_SECTOR
add wave -noupdate -color Tan /fht_control_tb/CONTROL/NEW_BIAS_RD
add wave -noupdate /fht_control_tb/CONTROL/RESET_CNT_RD
add wave -noupdate /fht_control_tb/CONTROL/RESET_CNT_WR
add wave -noupdate -radix unsigned /fht_control_tb/CONTROL/cnt_stage
add wave -noupdate -radix unsigned /fht_control_tb/CONTROL/cnt_stage_time
add wave -noupdate -expand -group sector -color {Slate Blue} -radix unsigned /fht_control_tb/CONTROL/cnt_sector
add wave -noupdate -expand -group sector -color {Slate Blue} -radix unsigned /fht_control_tb/CONTROL/cnt_sector_time
add wave -noupdate -expand -group sector -radix unsigned /fht_control_tb/CONTROL/div
add wave -noupdate -expand -group sector -radix unsigned /fht_control_tb/CONTROL/div_2
add wave -noupdate -expand -group addr_rd -color Gold -radix unsigned /fht_control_tb/CONTROL/addr_rd_cnt
add wave -noupdate -expand -group addr_rd -color Gold -radix unsigned /fht_control_tb/CONTROL/addr_rd_bias
add wave -noupdate -expand -group addr_rd -radix decimal /fht_control_tb/CONTROL/cnt_bias_rd
add wave -noupdate -expand -group addr_rd -radix unsigned /fht_control_tb/CONTROL/size_bias_rd
add wave -noupdate -expand -group addr_rd -radix unsigned /fht_control_tb/CONTROL/BIAS_RD_BYTE
add wave -noupdate -expand -group addr_rd -radix decimal -childformat {{{/fht_control_tb/CONTROL/BIAS_RD[9]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[8]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[7]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[6]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[5]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[4]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[3]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[2]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[1]} -radix decimal} {{/fht_control_tb/CONTROL/BIAS_RD[0]} -radix decimal}} -subitemconfig {{/fht_control_tb/CONTROL/BIAS_RD[9]} {-height 15 -radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[8]} {-height 15 -radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[7]} {-height 15 -radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[6]} {-height 15 -radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[5]} {-height 15 -radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[4]} {-height 15 -radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[3]} {-height 15 -radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[2]} {-height 15 -radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[1]} {-height 15 -radix decimal} {/fht_control_tb/CONTROL/BIAS_RD[0]} {-height 15 -radix decimal}} /fht_control_tb/CONTROL/BIAS_RD
add wave -noupdate -expand -group addr_wr -radix unsigned /fht_control_tb/CONTROL/addr_wr_cnt
add wave -noupdate -expand -group addr_wr -color Gold -radix unsigned /fht_control_tb/CONTROL/addr_wr_sw_0
add wave -noupdate -expand -group addr_wr -color Gold -radix unsigned /fht_control_tb/CONTROL/addr_wr_sw_1
add wave -noupdate -expand -group addr_wr -color {Slate Blue} /fht_control_tb/CONTROL/we_a
add wave -noupdate -expand -group addr_wr -color {Slate Blue} /fht_control_tb/CONTROL/we_b
add wave -noupdate -expand -group addr_wr /fht_control_tb/CONTROL/WE_EN
add wave -noupdate /fht_control_tb/CONTROL/rdy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {57028 ns} 0}
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
WaveRestoreZoom {141 ns} {59382 ns}
