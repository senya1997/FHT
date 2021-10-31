import common_types_pkg::*;

class TransformRAM #(uint16_t	D_BIT = 24,			// 'D_BIT' <= 32;
								INT_BIT = 16,		// number bit of integer part of data
								BANK_SIZE = 256,	// num of rows
								A_BIT = 8,			// log2(BANK_SIZE)
								N_BANK = 4,			// num of columns
								N_BIT = 2			// log2(N_BANK)
					);

typedef bit signed	[D_BIT - 1 : 0] dbit_t;
typedef reg			[D_BIT - 1 : 0] dlogic_t;

typedef bit	[A_BIT - 1 : 0]		abit_t;
typedef bit	[N_BIT - 1 : 0]		nbit_t;
typedef bit	[N_BANK - 1 : 0]	webit_t;

// main vars:
	local dbit_t tran_ram [0 : BANK_SIZE - 1][0 : N_BANK - 1]; // RAM imitation
	
// static vars:
	local static time		tact = 20ns; // in ns
	local static uint32_t	cnt_all_er = 0;
	local static float32_t	max_er = 0;
	local static float32_t	sum_er = 0;

// private:

// protected:	
	static protected function abit_t AddrBitReverse(abit_t addr); // -//-
		abit_t addr_buf;
		
		for(uchar_t i = 0; i < A_BIT; i++) 
			addr_buf[A_BIT - 1 - i] = addr[i];
		
		AddrBitReverse = addr_buf; // unsigned cast
	endfunction

	static protected function nbit_t BankBitReverse(nbit_t bank); // -//-
		nbit_t bank_buf;
		
		for(uchar_t i = 0; i < N_BIT; i++) 
			bank_buf[N_BIT - 1 - i] = bank[i];
		
		BankBitReverse = bank_buf; // unsigned cast
	endfunction
	
// public:
	extern function new();
	
	extern function void SetPeriod(time tact);
	
	extern function uint32_t	GetAllErr();
	extern function float32_t	GetMaxErr();
	extern function float32_t	GetAvErr();
	
	extern function float32_t	GetMaxDataRam();
	extern function float32_t	GetMinDataRam();
	extern function float32_t	GetMeanDataRam();
	
	extern static function float32_t AbsData(float32_t data); // static ? (enable calling without making instance)
	extern static function float32_t Reg2Float(dbit_t data); // -//-
	
	extern function void UpdBankRAM(uint16_t bunk_num, dlogic_t ext_ram [0 : BANK_SIZE - 1]); // run always when required copy external RAM in class 
	extern function void SaveRAMdata(string name);
	
	extern function e_comp CompareBankRAM(uint16_t bunk_num, float32_t accuracy, dlogic_t ext_ram [0 : BANK_SIZE - 1]);
	extern function e_comp CompareWithFile(string name_ref, float32_t accuracy);
	
	extern function void Bitrev2NormalRAM(); // convert bit reverse to normal sequence points in RAM
	
	extern task DisplayRAM(ref dbit_t data_disp);
	
	extern task InitRAM(
						string name,
						bit fixed_point, // 1 - add '0' in fract part of data before write, 0 - add data in RAM as is
						bit from_file, // 1 - init external RAM and RAM in class from file, 0 - init external ram from class RAM
						ref dbit_t out_data,
						ref abit_t out_addr,
						ref webit_t out_we
					); // line by line from file
endclass