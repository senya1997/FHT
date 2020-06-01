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
add wave -noupdate -expand -group BUT_BLOCK_IN -color {Medium Orchid} -radix decimal /fht_tb/FHT/BUT_BLOCK/iBANK_0
add wave -noupdate -expand -group BUT_BLOCK_IN -color {Medium Orchid} -radix decimal /fht_tb/FHT/BUT_BLOCK/iBANK_1
add wave -noupdate -expand -group BUT_BLOCK_IN -color {Medium Orchid} -radix decimal /fht_tb/FHT/BUT_BLOCK/iBANK_2
add wave -noupdate -expand -group BUT_BLOCK_IN -color {Medium Orchid} -radix decimal /fht_tb/FHT/BUT_BLOCK/iBANK_3
add wave -noupdate -group BUT_0 -color {Slate Blue} -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/iX_0
add wave -noupdate -group BUT_0 -color {Slate Blue} -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/iX_1
add wave -noupdate -group BUT_0 -color {Slate Blue} -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/oY_0
add wave -noupdate -group BUT_0 -color {Slate Blue} -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_0/oY_1
add wave -noupdate -group BUT_1 -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_1/iX_0
add wave -noupdate -group BUT_1 -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_1/iX_1
add wave -noupdate -group BUT_1 -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_1/oY_0
add wave -noupdate -group BUT_1 -radix decimal /fht_tb/FHT/BUT_BLOCK/BUT_1/oY_1
add wave -noupdate -expand -group BUT_BLOCK_OUT -color Pink -radix decimal /fht_tb/FHT/BUT_BLOCK/oY_0
add wave -noupdate -expand -group BUT_BLOCK_OUT -color Pink -radix decimal /fht_tb/FHT/BUT_BLOCK/oY_1
add wave -noupdate -expand -group BUT_BLOCK_OUT -color Pink -radix decimal /fht_tb/FHT/BUT_BLOCK/oY_2
add wave -noupdate -expand -group BUT_BLOCK_OUT -color Pink -radix decimal /fht_tb/FHT/BUT_BLOCK/oY_3
add wave -noupdate -expand -group CONTROL -color Gold -radix unsigned /fht_tb/FHT/CONTROL/addr_rd_cnt
add wave -noupdate -expand -group CONTROL -color Gold -radix unsigned /fht_tb/FHT/CONTROL/addr_rd_bias
add wave -noupdate -expand -group CONTROL -color Gold -radix unsigned /fht_tb/FHT/CONTROL/addr_wr_sw_0
add wave -noupdate -expand -group CONTROL -color Gold -radix unsigned /fht_tb/FHT/CONTROL/addr_wr_sw_1
add wave -noupdate -expand -group CONTROL -color Gold -radix unsigned /fht_tb/FHT/CONTROL/addr_coef
add wave -noupdate -expand -group CONTROL -color {Slate Blue} /fht_tb/FHT/CONTROL/we_a
add wave -noupdate -expand -group CONTROL -color {Slate Blue} /fht_tb/FHT/CONTROL/we_b
add wave -noupdate -expand -group CONTROL -radix unsigned /fht_tb/FHT/CONTROL/cnt_stage
add wave -noupdate -expand -group CONTROL -radix unsigned /fht_tb/FHT/CONTROL/cnt_stage_time
add wave -noupdate -expand -group CONTROL -radix unsigned /fht_tb/FHT/CONTROL/div
add wave -noupdate -expand -group CONTROL -radix unsigned /fht_tb/FHT/CONTROL/cnt_sector
add wave -noupdate -expand -group CONTROL -radix unsigned /fht_tb/FHT/CONTROL/cnt_sector_time
add wave -noupdate -expand -group CONTROL /fht_tb/FHT/CONTROL/WE_EN
add wave -noupdate -expand -group CONTROL /fht_tb/FHT/CONTROL/EOF_STAGE_1
add wave -noupdate -expand -group CONTROL /fht_tb/FHT/CONTROL/EOF_STAGE
add wave -noupdate -expand -group CONTROL /fht_tb/FHT/CONTROL/EOF_READ
add wave -noupdate -expand -group CONTROL /fht_tb/FHT/CONTROL/COEF_EN
add wave -noupdate -radix decimal {/fht_tb/FHT/FHT_RAM_B/ram_bank[3]/RAM_BANK/altsyncram_component/m_non_arria10/altsyncram_inst/mem_data}
add wave -noupdate -radix decimal {/fht_tb/FHT/FHT_RAM_B/ram_bank[2]/RAM_BANK/altsyncram_component/m_non_arria10/altsyncram_inst/mem_data}
add wave -noupdate -radix decimal {/fht_tb/FHT/FHT_RAM_B/ram_bank[1]/RAM_BANK/altsyncram_component/m_non_arria10/altsyncram_inst/mem_data}
add wave -noupdate -radix decimal {/fht_tb/FHT/FHT_RAM_B/ram_bank[0]/RAM_BANK/altsyncram_component/m_non_arria10/altsyncram_inst/mem_data}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {43080000 ps} 0}
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
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {132846 ns}
