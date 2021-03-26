/*****************************************************************************************************************/
/*												auto generated defines (do not modify):												  */
/*****************************************************************************************************************/
 
`define N 2048
`define Nx 1026
`define Nh 1023
`define BANK_SIZE 512
`define WIDTH_RAM 11
`define DEPTH_ROM 128
`define LAST_STAGE 10
`define LAST_STAGE_EVEN
 
`define ADC_WIDTH 16
`define D_BIT 27
`define A_BIT 9
`define W_BIT 13
 
`define MAX_ADC_D 32768
`define MAX_D 67108864
`define MAX_W 2048
 





/*****************************************************************************************************************/
/*																	work directories:															  */
/*****************************************************************************************************************/

// default value of file names:
/* 
`define FHT_INIT_RAM	"../../fht/matlab/init_ram.txt"
`define FHT_DONE_RAM	"fht_ram.txt" // also save 'reg' version of RAM - prescript 'reg' is added to the entered name

`define CONV_FHT_INIT_RAM	"../../modelsim/fht/reg_fht_ram.txt"
`define CONV_IMP_INIT_RAM	"../../modelsim/fht/reg_imp_ram.txt"

`define CONV_DONE_REAL_RAM	"../../modelsim/fht/ifht_ram.txt"
`define CONV_DONE_REG_RAM	"../../modelsim/fht/reg_ifht_ram.txt"
*/

`define FHT_INIT_RAM	"../../fht/matlab/init_ram.txt"
`define FHT_DONE_RAM	"fht_ram.txt" // save in current dir of modelsim project

`define CONV_FHT_INIT_RAM	"../../modelsim/fht/reg_fht_ram.txt"
`define CONV_IMP_INIT_RAM	"../../modelsim/fht/reg_imp_ram.txt"

`define CONV_DONE_REAL_RAM	"../../modelsim/fht/ifht_ram.txt"
`define CONV_DONE_REG_RAM	"../../modelsim/fht/reg_ifht_ram.txt"

`ifdef MODEL_TECH
	`define MIF_SIN "../../fht/sin.mif"
	`define MIF_COS "../../fht/cos.mif"
// `define MIF_IMP "../../conv/imp.mif"
`else
	`define MIF_SIN "./sin.mif"
	`define MIF_COS "./cos.mif"
// `define MIF_IMP "./imp.mif"
`endif

/*****************************************************************************************************************/
/*													variable defines for testbench and rtl:											  */
/*****************************************************************************************************************/

//`define TEST_MIXER // check only 'top' + 'control', RAM data (0..N) "avoid" butterfly and multipliers
//`define EN_BREAKPOINT
`define COMPARE_WITH_MATLAB

//`define RAM_BUG // if modelsim issue error 'Unresolved reference to...' try to switch this define

`define ROUND_FHT			// enable round in FHT butterfly
`define ROUND_FHT_CONV	// enable round in conv calc
//`define USE_2_RAM_FOR_COEF	// formula conv: Z(i) = 0.5*(X(i)*(I(i) + I(-i)) + X(-i)*(I(i) - I(-i)))
										// '(I(i) + I(-i))' and '(I(i) - I(-i))' can be calc in advance but it 
										// require 2 RAM N point, or use 1 RAM but requre direct calc coef and
										//	use more resources with 1 tact delay in calc module (don't use)

`define TACT 20
`define HALF_TACT `TACT/2 

`define NUM_OF_RPT 30	// number of repeat butterfly test
`define ACCURACY 0.0001	// for all tests (butterfly, FHT)