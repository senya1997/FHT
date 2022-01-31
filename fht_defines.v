/*****************************************************************************************************************/
/*												auto generated defines (do not modify):												  */
/*****************************************************************************************************************/
 
`define N 2048
`define Nx 64
`define Nh 1984
`define BANK_SIZE 512
`define WIDTH_RAM 11
`define DEPTH_ROM 128
`define LAST_STAGE 10
`define LAST_STAGE_EVEN
 
`define ADC_WIDTH 16
`define D_BIT 24
`define A_BIT 9
`define W_BIT 16
`define CONV_BIT 28
`define IMP_BIT 16
 
`define MAX_ADC_D 32768
`define MAX_D 8388608
`define MAX_W 16384
`define MAX_CONV 134217728
`define MAX_IMP 32768
 
/*****************************************************************************************************************/
/*																	work directories:															  */
/*****************************************************************************************************************/
// init RAM files for FPGA in reg type:
	`define INIT_FHT_RAM	"../../fht/matlab/init_fht_ram.txt"			// input for FHT, defined by choosed test in matlab
	`define INIT_CONV_RAM	"../../fht_conv/matlab/init_conv_ram.txt"	// input for conv tb (signal after FHT), generated by 'fht.m' in test 'imp' and 'signal' modes
	
	`define INIT_IMP_P_RAM	"../../fht_conv/matlab/init_imp_p_ram.txt"
	`define INIT_IMP_N_RAM	"../../fht_conv/matlab/init_imp_n_ram.txt"
	
 	`define INIT_IMP_SDRAM	"../../fht_conv/matlab/init_imp_sdram.txt"	// check convolution with SRAM imit

// output MATH files for compare in real type (for data):
 	// math model FHT out RAM for compare
		`define MATH_FHT_RAM	"../../fht/matlab/math_fht_ram.txt"			
		`define MATH_ADDR_RD	"../../fht/matlab/math_addr_rd.txt" // addr of math model RAM on different stages FHT for compare
		`define MATH_ADDR_WR	"../../fht/matlab/math_addr_wr.txt"
 	
 	// math model CONV for compare:
		`define MATH_CONV_RAM		"../../fht_conv/matlab/math_conv_ram.txt"
		`define MATH_CONV_ADDR_RD	"../../fht_conv/matlab/math_conv_addr_rd.txt"
	 	`define MATH_CONV_ADDR_WR	"../../fht_conv/matlab/math_conv_addr_wr.txt"
	
// output FPGA file for compare in real and reg type (save 'reg' version of RAM - prescript 'reg' is added to the entered name automatic):
	`define FPGA_FHT_RAM	"fpga_fht_ram.txt"	// FHT output from tb save in current dir of modelsim project
	`define FPGA_CONV_RAM	"fpga_conv_ram.txt"	// CONV output (ready for IFHT RAM) from tb save in current dir of modelsim project

`ifdef MODEL_TECH
	`define MIF_SIN "../../fht/sin.mif"
	`define MIF_COS "../../fht/cos.mif"
`else
	`define MIF_SIN "./sin.mif"
	`define MIF_COS "./cos.mif"
`endif

/*****************************************************************************************************************/
/*													variable defines RTL:																  */
/*****************************************************************************************************************/

//`define TEST_MIXER // check only 'top' + 'control', RAM data (0..N) "avoid" butterfly and multipliers
`define COMPARE_WITH_MATLAB

`define ROUND_FHT		// enable round in FHT butterfly
//`define ROUND_FHT_CONV	// enable round in conv calc
	
`timescale 1ns/1ns

// if modelsim issue error 'Unresolved reference to...' try to switch this define:
	//`define RAM_ACCESS_TB altsyncram_component.mem_data
	//`define RAM_ACCESS_TB altsyncram_component.m_default.altsyncram_inst.mem_data
	`define RAM_ACCESS_TB altsyncram_component.m_non_arria10.altsyncram_inst.mem_data
/*
`define CLK_FREQ 100 // MHz

`define TACT		$ceil(1000/`CLK_FREQ) // ns
`define HALF_TACT	$ceil(`TACT/2)
 */
`define TACT 10ns // already boosted clock (attention on test with RAM controller and imit!)
`define HALF_TACT 5ns

`define NUM_OF_RPT 100	// number of repeat butterfly test
`define ACCURACY 0.001	// for all tests (butterfly, FHT)
