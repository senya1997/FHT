#include <iostream>

#include "../obj_dir/Vfht_top.h"

#include <verilated.h> // Defines common routines
#include <verilated_vcd_c.h>

#include "../inc/defines.h"

int main(int argc, char **argv) {

// init Verilators vars:
	Verilated::commandArgs(argc, argv);
	Verilated::traceEverOn(true);  // Verilator must compute traced signals

// create instance of DUT:
	Vfht_top *top_module = new Vfht_top;
	VerilatedVcdC *vcd = new VerilatedVcdC;

	top_module->trace(vcd, 99);	// trace 99 levels of hierarchy
	vcd->open("out.vcd");		// open the dump file

	#ifdef PROGRESS_BAR
		const uchar_t bar_width = 70;

		uchar_t pos;
		float prog = 0.0f;
	#endif

	const uchar_t half_per = 10; // ns
	const uint64_t finish_time = 1'000'000; // ns

// vars:
	uchar_t cnt_clk = 0;
	uint64_t vtime = 0;

// ports:
	uint32_t clock = 0;
	uint32_t rst = 1;

	std::cout << "\n\tStart FHT tb\n";
	std::cout << "\nProgress:\n\n";

// init:
	top_module->iCLK = clock;
	top_module->iRESET = rst;

// reset:
	while(vtime < 70)
	{
		if(cnt_clk == half_per) clock ^= 1;

		if((vtime >= 5*half_per) & (vtime < 7*half_per)) rst = 0;
		else rst = 1;

		top_module->iCLK = clock;
		top_module->iRESET = rst;

		vtime++;
		cnt_clk++;
	}

// main:
	while(vtime < finish_time)
	{
		if(cnt_clk == half_per) clock ^= 1;

		top_module->iCLK = clock;
		top_module->iRESET = rst;

		top_module->eval(); // calculate rtl logic
		vcd->dump(vtime);

		vtime++;
		cnt_clk++;

	#ifdef PROGRESS_BAR
		pos = (int)((float)bar_width * prog);

		std::cout << "\t[";
		for(int i = 0; i < bar_width; ++i)
		{
			if (i < pos) std::cout << "=";
			else if (i == pos) std::cout << ">";
			else std::cout << " ";
		}
		std::cout << "]" << (int)(prog * 100.0f) << " %\r";
		std::cout.flush();

		prog = (float)vtime/finish_time;
	#endif

	}

	top_module->final();

	if(vcd) vcd->close();

	delete top_module;
	delete vcd;

	std::cout << "\n\n\tDone\n";

	return 0;
}
