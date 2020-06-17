onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fht_tb/FHT/iCLK
add wave -noupdate -expand -group input /fht_tb/FHT/iSTART
add wave -noupdate -expand -group input -radix decimal /fht_tb/FHT/iDATA
add wave -noupdate -expand -group input -radix unsigned /fht_tb/FHT/iADDR_WR
add wave -noupdate -expand -group input /fht_tb/FHT/iWE_0
add wave -noupdate -expand -group input /fht_tb/FHT/iWE_1
add wave -noupdate -expand -group input /fht_tb/FHT/iWE_2
add wave -noupdate -expand -group input /fht_tb/FHT/iWE_3
add wave -noupdate /fht_tb/FHT/oRDY
add wave -noupdate -expand -group BUT_BLOCK_IN -color {Medium Orchid} -radix decimal /fht_tb/FHT/BUT_BLOCK/iBANK_0
add wave -noupdate -expand -group BUT_BLOCK_IN -color {Medium Orchid} -radix decimal /fht_tb/FHT/BUT_BLOCK/iBANK_1
add wave -noupdate -expand -group BUT_BLOCK_IN -color {Medium Orchid} -radix decimal /fht_tb/FHT/BUT_BLOCK/iBANK_2
add wave -noupdate -expand -group BUT_BLOCK_IN -color {Medium Orchid} -radix decimal /fht_tb/FHT/BUT_BLOCK/iBANK_3
add wave -noupdate -radix decimal -childformat {{{/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_0[0]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_0[1]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_0[2]} -radix decimal}} -subitemconfig {{/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_0[0]} {-height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_0[1]} {-height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_0[2]} {-height 15 -radix decimal}} /fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_0
add wave -noupdate -radix decimal -childformat {{{/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_1[0]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_1[1]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_1[2]} -radix decimal}} -subitemconfig {{/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_1[0]} {-height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_1[1]} {-height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_1[2]} {-height 15 -radix decimal}} /fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_1
add wave -noupdate -expand -group BUT_0 -color {Cornflower Blue} -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/iX_0
add wave -noupdate -expand -group BUT_0 -color {Cornflower Blue} -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/iX_1
add wave -noupdate -expand -group BUT_0 -color {Cornflower Blue} -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/iX_2
add wave -noupdate -expand -group BUT_0 -color {Cornflower Blue} -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/oY_0
add wave -noupdate -expand -group BUT_0 -color {Cornflower Blue} -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/oY_1
add wave -noupdate -expand -group BUT_1 -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_1/iX_0
add wave -noupdate -expand -group BUT_1 -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_1/iX_1
add wave -noupdate -expand -group BUT_1 -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_1/iX_2
add wave -noupdate -expand -group BUT_1 -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_1/oY_0
add wave -noupdate -expand -group BUT_1 -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_1/oY_1
add wave -noupdate -radix decimal -childformat {{{/fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX[0]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX[1]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX[2]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX[3]} -radix decimal}} -expand -subitemconfig {{/fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX[0]} {-color Wheat -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX[1]} {-color Wheat -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX[2]} {-color Wheat -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX[3]} {-color Wheat -height 15 -radix decimal}} /fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX
add wave -noupdate -color Gold -radix decimal /fht_tb/FHT/BUT_BLOCK/iSIN_0
add wave -noupdate -color Gold -radix decimal /fht_tb/FHT/BUT_BLOCK/iCOS_0
add wave -noupdate -color Gold -radix decimal /fht_tb/FHT/BUT_BLOCK/iSIN_1
add wave -noupdate -color Gold -radix decimal /fht_tb/FHT/BUT_BLOCK/iCOS_1
add wave -noupdate -expand -group BUT_BLOCK_OUT -color Pink -radix decimal /fht_tb/FHT/BUT_BLOCK/oY_0
add wave -noupdate -expand -group BUT_BLOCK_OUT -color Pink -radix decimal /fht_tb/FHT/BUT_BLOCK/oY_1
add wave -noupdate -expand -group BUT_BLOCK_OUT -color Pink -radix decimal /fht_tb/FHT/BUT_BLOCK/oY_2
add wave -noupdate -expand -group BUT_BLOCK_OUT -color Pink -radix decimal /fht_tb/FHT/BUT_BLOCK/oY_3
add wave -noupdate -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/sum_mul
add wave -noupdate -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/sum_buf
add wave -noupdate -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/sub_buf
add wave -noupdate -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/EXT_SUM_MUL
add wave -noupdate -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/EXT_SUM
add wave -noupdate -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/EXT_SUB
add wave -noupdate -expand -group CONTROL -color Cyan -radix unsigned /fht_tb/FHT/CONTROL/oADDR_RD_0
add wave -noupdate -expand -group CONTROL -color Cyan -radix unsigned /fht_tb/FHT/CONTROL/oADDR_RD_1
add wave -noupdate -expand -group CONTROL -color Cyan -radix unsigned /fht_tb/FHT/CONTROL/oADDR_RD_2
add wave -noupdate -expand -group CONTROL -color Cyan -radix unsigned /fht_tb/FHT/CONTROL/oADDR_RD_3
add wave -noupdate -expand -group CONTROL -radix unsigned /fht_tb/FHT/CONTROL/addr_wr_cnt_d
add wave -noupdate -expand -group CONTROL -radix unsigned /fht_tb/FHT/CONTROL/addr_wr_bias
add wave -noupdate -expand -group CONTROL -color Gold -radix unsigned /fht_tb/FHT/CONTROL/addr_coef
add wave -noupdate -expand -group CONTROL -color {Slate Blue} /fht_tb/FHT/CONTROL/we_a
add wave -noupdate -expand -group CONTROL -color {Slate Blue} /fht_tb/FHT/CONTROL/we_b
add wave -noupdate -expand -group CONTROL -radix unsigned /fht_tb/FHT/CONTROL/cnt_stage
add wave -noupdate -expand -group CONTROL -radix unsigned /fht_tb/FHT/CONTROL/cnt_stage_time
add wave -noupdate -expand -group CONTROL -radix unsigned /fht_tb/FHT/CONTROL/cnt_sector_time
add wave -noupdate -expand -group CONTROL -radix unsigned /fht_tb/FHT/CONTROL/div
add wave -noupdate -expand -group CONTROL /fht_tb/FHT/CONTROL/WE_EN
add wave -noupdate -expand -group CONTROL /fht_tb/FHT/CONTROL/EOF_STAGE
add wave -noupdate -expand -group CONTROL /fht_tb/FHT/CONTROL/COEF_EN
add wave -noupdate -expand -group CONTROL -radix unsigned /fht_tb/FHT/CONTROL/oSECTOR
add wave -noupdate -expand -group CONTROL /fht_tb/FHT/CONTROL/o2ND_PART_SUBSEC
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17207079 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 190
configure wave -valuecolwidth 99
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
WaveRestoreZoom {0 ps} {21861 ns}
