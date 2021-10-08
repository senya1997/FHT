import common_types_pkg::*;

class TransformRAM #(uint16_t	D_BIT = 24,			// 'D_BIT' <= 32;
								INT_BIT = 16,		// number bit of integer part of data
								A_BIT = 8,			// log2(rows)
								BANK_SIZE = 256,	// num of rows
								N_BANK = 4			// num of columns
					);

typedef bit signed		[D_BIT - 1 : 0] dbit_t;
typedef logic signed	[D_BIT - 1 : 0] dlogic_t;
	
typedef bit				[A_BIT - 1 : 0] abit_t;
typedef bit				[N_BANK - 1 : 0] nbit_t;

// main vars:
	local dbit_t tran_ram [0 : BANK_SIZE - 1][0 : N_BANK - 1]; // RAM imitation
	local dbit_t disp_data; // data that display RAM content on wave window
	
// static vars:
	local static uint32_t	tact = 20; // in ns
	local static uint32_t	cnt_all_er = 0;
	local static float32_t	max_er = 0;
	local static float32_t	sum_er = 0;

// private:
	
	
// protected:
	extern protected function float32_t	AbsData(float32_t data); // static ? (enable calling without making instance)
	extern protected function float32_t	Reg2Real(dbit_t data); // -//-
	
	protected function abit_t AddrBitReverse(abit_t addr); // -//-
		abit_t addr_buf;
		
		for(uchar_t i = 0; i < A_BIT; i++) 
			addr_buf[A_BIT - 1 - i] = addr[i];
		
		AddrBitReverse = addr_buf; // unsigned cast
	endfunction

	protected function nbit_t BankBitReverse(nbit_t bank); // -//-
		nbit_t bank_buf;
		
		for(uchar_t i = 0; i < N_BANK; i++) 
			bank_buf[N_BANK - 1 - i] = bank[i];
		
		BankBitReverse = bank_buf; // unsigned cast
	endfunction
	
// public:
	extern function new();
	
	extern function void SetPeriod(uint32_t tact);
	
	extern function uint32_t	GetAllErr();
	extern function float32_t	GetMaxErr();
	extern function float32_t	GetAvErr();
	
	extern function void UpdBankRAM(uint16_t bunk_num, dlogic_t ext_ram [0 : BANK_SIZE - 1]); // run always when required copy external RAM in class 
	
	extern function void SaveRAMdata(string name);
	
	extern function void CompareWithFile(string name_ref, float32_t accuracy);
	
	extern function void Bitrev2NormalRAM(); // convert bit reverse to normal sequence points in RAM
	
	extern task DisplayRAM(output dbit_t oDATA);
	
	extern task InitRAM(
						input string name,
						input bit fixed_point, // 1 - add '0' in fract part of data before write, 0 - add data in RAM as is
						input bit from_file, // 1 - init external RAM and RAM in class from file, 0 - init external ram from class RAM
						output dbit_t oDATA,
						output abit_t oADDR_WR,
						output nbit_t oWE
					); // line by line from file
endclass