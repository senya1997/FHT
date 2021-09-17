/*****************************************************************************************************************/
/*												auto generated defines (do not modify):												  */
/*****************************************************************************************************************/
 
`define N 1024
`define Nx 514
`define Nh 511
`define BANK_SIZE 256
`define WIDTH_RAM 10
`define DEPTH_ROM 64
`define LAST_STAGE 9
`define LAST_STAGE_ODD
 
`define ADC_WIDTH 16
`define D_BIT 24
`define A_BIT 8
`define W_BIT 13
`define CONV_BIT 28
`define IMP_BIT 17
 
`define MAX_ADC_D 32768
`define MAX_D 8388608
`define MAX_W 2048
`define MAX_CONV 134217728
`define MAX_IMP 32768
 
/*****************************************************************************************************************/
/*																	work directories:															  */
/*****************************************************************************************************************/

`define FHT_INIT_RAM	"../../fht/matlab/init_ram.txt" // define by choosed test in matlab
`define FHT_DONE_RAM	"fht_ram.txt" // FHT output from tb save in current dir of modelsim project, also save 'reg' version of RAM - prescript 'reg' is added to the entered name

`define MATLAB_DONE_RAM	"../../fht/matlab/ram.txt" // math model FHT out RAM for compare
`define MATLAB_ADDR_RD	"../../fht/matlab/addr_rd.txt" // addr of math model RAM on different stages FHT for compare
`define MATLAB_ADDR_WR	"../../fht/matlab/addr_wr.txt"

`define CONV_FHT_INIT_RAM	"../../fht_conv/matlab/reg_fht_ram.txt" // input for conv tb, generated by 'fht.m' in test 'imp' and 'signal' modes
`define CONV_IMP_P_INIT_RAM	"../../fht_conv/matlab/reg_imp_p_ram.txt"
`define CONV_IMP_N_INIT_RAM	"../../fht_conv/matlab/reg_imp_n_ram.txt"
`define CONV_DONE_RAM		"conv_ram.txt"  // CONV output (ready IFHT RAM) from tb save in current dir of modelsim project, also save 'reg' version of RAM

`ifdef MODEL_TECH
	`define MIF_SIN "../../fht/sin.mif"
	`define MIF_COS "../../fht/cos.mif"
`else
	`define MIF_SIN "./sin.mif"
	`define MIF_COS "./cos.mif"
`endif

/*****************************************************************************************************************/
/*													variable defines for testbench and rtl:											  */
/*****************************************************************************************************************/

// `define TEST_MIXER // check only 'top' + 'control', RAM data (0..N) "avoid" butterfly and multipliers
// `define EN_BREAKPOINT
`define COMPARE_WITH_MATLAB

// if modelsim issue error 'Unresolved reference to...' try to switch this define:
	// `define RAM_ACCESS_TB altsyncram_component.mem_data
	`define RAM_ACCESS_TB altsyncram_component.m_default.altsyncram_inst.mem_data
	// `define RAM_ACCESS_TB altsyncram_component.m_non_arria10.altsyncram_inst.mem_data

`define ROUND_FHT			// enable round in FHT butterfly
`define ROUND_FHT_CONV	// enable round in conv calc
// `define USE_2_RAM_FOR_COEF	// formula conv: Z(i) = 0.5*(X(i)*(I(i) + I(-i)) + X(-i)*(I(i) - I(-i)))
										// '(I(i) + I(-i))' and '(I(i) - I(-i))' can be calc in advance but it 
										// require 2 RAM N point, or use 1 RAM but requre direct calc coef and
										//	use more resources with 1 tact delay in calc module (don't use)

`define CLK_FREQ 100 // MHz

`define TACT		$ceil(1000/`CLK_FREQ) // ns
`define HALF_TACT	$ceil(`TACT/2)
/*
`define TACT 21
`define HALF_TACT `TACT/2 
*/
`define NUM_OF_RPT 50	// number of repeat butterfly test
`define ACCURACY 0.001	// for all tests (butterfly, FHT)