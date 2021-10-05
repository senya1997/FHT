`include "defines_tb.svh"

typedef bit signed		[D_BIT - 1 : 0] bit_t;
typedef bit unsigned	[D_BIT - 1 : 0] ubit_t;

class TransformRAM #(uint16_t D_BIT = 24, BANK_SIZE = 256, N_BANK = 4);
	local bit_t tran_ram [0 : BANK_SIZE - 1][0 : N_BANK - 1];
	
	local static uint32_t	cnt_all_er;
	local static float32_t	max_er;
	local static float32_t	av_er;
	
	extern function new();

// private:
	extern local function automatic float32_t	AbsData(float32_t data);
	extern local function automatic bit_t		BitReverse(bit_t data);
	extern local function automatic float32_t	Reg2Real(uint16_t int_bit, bit_t data);
	
// public:
	extern function automatic void UpdRAM(bit_t ext_ram [0 : BANK_SIZE][0 : N_BANK - 1]); // run always when required copy external RAM in class 
	
	extern function automatic void InitRAM(input string name); // line by line from file
	
	extern function automatic void SaveRAMdata(string name);
	
	extern function automatic void CompareWithMatlab(input string name_ref, name);
	
	extern function automatic void Bitrev2NormalRAM(input string name); // convert bit reverse to normal sequence points in RAM
	
endclass
