`include "defines_tb.svh"

class TransformRAM #(uint16_t D_BIT = 24, INT_BIT = 16, A_BIT = 8, BANK_SIZE = 256, N_BANK = 4); // 'D_BIT' <= 32;

// main types:
	typedef bit signed		[D_BIT - 1 : 0] dbit_t;
	//typedef bit unsigned	[D_BIT - 1 : 0] udbit_t;

	typedef logic signed	[D_BIT - 1 : 0] dlogic_t;
	//typedef logic unsigned	[D_BIT - 1 : 0] udlogic_t;
	
// main vars:
	local dbit_t tran_ram [0 : BANK_SIZE - 1][0 : N_BANK - 1]; // RAM imitation
	local dbit_t disp_data; // data that display RAM content on wave window
	
// static vars:
	local static uint32_t	tact = 20; // in ns
	local static uint32_t	cnt_all_er = 0;
	local static float32_t	max_er = 0;
	local static float32_t	av_er = 0;

// private:
	
	
// protected:
	extern protected function automatic float32_t	AbsData(float32_t data);
	extern protected function automatic uint32_t	BitReverse(uint16_t width, uint32_t data);
	extern protected function automatic float32_t	Reg2Real(dbit_t data);
	
// public:
	extern function new();
	extern function void SetPeriod(uint32_t tact);
	
	extern function automatic void UpdBankRAM(uint16_t bunk_num, dlogic_t ext_ram [0 : BANK_SIZE - 1]); // run always when required copy external RAM in class 
	
	extern function automatic void SaveRAMdata(string name);
	
	extern function automatic void CompareWithMatlab(string name_ref, name);
	
	extern function automatic void Bitrev2NormalRAM(string name); // convert bit reverse to normal sequence points in RAM
	
	extern task automatic InitRAM(
								input string name,
								input bit fixed_point, // 1 - add '0' in fract part of data before write, 0 - add data in RAM as is
								output bit signed [D_BIT - 1 : 0] oDATA,
								output bit [A_BIT - 1 : 0] oADDR_WR,
								output bit oWE
							); // line by line from file
endclass
