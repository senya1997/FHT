onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fht_tb/FHT/iCLK
add wave -noupdate -format Analog-Step -height 100 -max 10000.0 -min -10000.0 -radix decimal /fht_tb/#ublk#114271906#38/disp_fht
add wave -noupdate -format Analog-Step -height 100 -max 150.0 -min -150.0 -radix decimal /fht_tb/#ublk#114271906#38/disp_ifht
add wave -noupdate -expand -group input /fht_tb/FHT/iSTART
add wave -noupdate -expand -group input -radix unsigned /fht_tb/FHT/iWE
add wave -noupdate -group BUT_BLOCK_IN -color {Medium Orchid} -radix decimal -childformat {{{/fht_tb/FHT/BUT_BLOCK/iBANK_0[19]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[18]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[17]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[16]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[15]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[14]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[13]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[12]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[11]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[10]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[9]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[8]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[7]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[6]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[5]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[4]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[3]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[2]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[1]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[0]} -radix decimal}} -subitemconfig {{/fht_tb/FHT/BUT_BLOCK/iBANK_0[19]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[18]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[17]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[16]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[15]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[14]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[13]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[12]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[11]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[10]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[9]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[8]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[7]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[6]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[5]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[4]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[3]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[2]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[1]} {-color {Medium Orchid} -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/iBANK_0[0]} {-color {Medium Orchid} -height 15 -radix decimal}} /fht_tb/FHT/BUT_BLOCK/iBANK_0
add wave -noupdate -group BUT_BLOCK_IN -color {Medium Orchid} -radix decimal /fht_tb/FHT/BUT_BLOCK/iBANK_1
add wave -noupdate -group BUT_BLOCK_IN -color {Medium Orchid} -radix decimal /fht_tb/FHT/BUT_BLOCK/iBANK_2
add wave -noupdate -group BUT_BLOCK_IN -color {Medium Orchid} -radix decimal /fht_tb/FHT/BUT_BLOCK/iBANK_3
add wave -noupdate -radix decimal -childformat {{{/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_0[0]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_0[1]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_0[2]} -radix decimal}} -subitemconfig {{/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_0[0]} {-height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_0[1]} {-height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_0[2]} {-height 15 -radix decimal}} /fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_0
add wave -noupdate -radix decimal -childformat {{{/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_1[0]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_1[1]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_1[2]} -radix decimal}} -subitemconfig {{/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_1[0]} {-height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_1[1]} {-height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_1[2]} {-height 15 -radix decimal}} /fht_tb/FHT/BUT_BLOCK/MIX_TO_BUT_1
add wave -noupdate -group BUT_0 -color {Cornflower Blue} -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/iX_0
add wave -noupdate -group BUT_0 -color {Cornflower Blue} -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/iX_1
add wave -noupdate -group BUT_0 -color {Cornflower Blue} -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/iX_2
add wave -noupdate -group BUT_0 -color {Cornflower Blue} -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/oY_0
add wave -noupdate -group BUT_0 -color {Cornflower Blue} -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/oY_1
add wave -noupdate -group BUT_1 -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_1/iX_0
add wave -noupdate -group BUT_1 -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_1/iX_1
add wave -noupdate -group BUT_1 -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_1/iX_2
add wave -noupdate -group BUT_1 -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_1/oY_0
add wave -noupdate -group BUT_1 -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_1/oY_1
add wave -noupdate -color Gold -radix decimal /fht_tb/FHT/BUT_BLOCK/iSIN_0
add wave -noupdate -color Gold -radix decimal /fht_tb/FHT/BUT_BLOCK/iCOS_0
add wave -noupdate -color Gold -radix decimal /fht_tb/FHT/BUT_BLOCK/iSIN_1
add wave -noupdate -color Gold -radix decimal /fht_tb/FHT/BUT_BLOCK/iCOS_1
add wave -noupdate -radix decimal -childformat {{{/fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX[0]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX[1]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX[2]} -radix decimal} {{/fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX[3]} -radix decimal}} -subitemconfig {{/fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX[0]} {-color Wheat -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX[1]} {-color Wheat -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX[2]} {-color Wheat -height 15 -radix decimal} {/fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX[3]} {-color Wheat -height 15 -radix decimal}} /fht_tb/FHT/BUT_BLOCK/BUT_TO_MIX
add wave -noupdate -expand -group BUT_BLOCK_OUT -color Pink -radix decimal /fht_tb/FHT/BUT_BLOCK/oY_0
add wave -noupdate -expand -group BUT_BLOCK_OUT -color Pink -radix decimal /fht_tb/FHT/BUT_BLOCK/oY_1
add wave -noupdate -expand -group BUT_BLOCK_OUT -color Pink -radix decimal /fht_tb/FHT/BUT_BLOCK/oY_2
add wave -noupdate -expand -group BUT_BLOCK_OUT -color Pink -radix decimal /fht_tb/FHT/BUT_BLOCK/oY_3
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
add wave -noupdate -expand -group CONTROL /fht_tb/FHT/CONTROL/EOF_STAGE
add wave -noupdate -expand -group CONTROL -radix unsigned /fht_tb/FHT/CONTROL/oSECTOR
add wave -noupdate -expand -group CONTROL /fht_tb/FHT/CONTROL/o2ND_PART_SUBSEC
add wave -noupdate /fht_tb/FHT/oRDY
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9574532 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 218
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
WaveRestoreZoom {0 ps} {151893 ns}
