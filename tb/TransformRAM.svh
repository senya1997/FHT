
class TransformRAM;
	local bit signed [`D_BIT - 1 : 0] RAM_buf [0 : 3];
	
	extern function new();

// private:
	extern local function automatic BitReverse();
	extern local function automatic AbsData();
	extern local function automatic Reg2Real();
	
// public:
	extern function automatic void InitRAM(input string name); // line by line from file
	
	extern function automatic void SaveRAMdata(string name, bit ram_sel); // 0 - RAM(A), 1 - RAM(B)
	
	extern function automatic void CompareWithMatlab(input string name_ref, name);
	
	extern function automatic void Bitrev2NormRAM(input string name); // convert bit reverse to normal RAM
	
endclass
