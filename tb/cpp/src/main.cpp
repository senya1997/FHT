#include <iostream>

#include "../obj_dir/Vfht_top.h"

#include <verilated.h> // Defines common routines
#include <verilated_vcd_c.h>

int main(int argc, char **argv) {

// init Verilators vars:
	Verilated::commandArgs(argc, argv);

// create instance of DUT:
	Vfht_top *top_module = new Vfht_top;

	VerilatedVcdC* vcd = nullptr;
    Verilated::traceEverOn(true);  // Verilator must compute traced signals

	vcd = new VerilatedVcdC;
	top_module->trace(vcd, 99);	// trace 99 levels of hierarchy
	vcd->open("out.vcd");		// open the dump file

	const int bar_width = 70;

	const int finish_t = 1'000'000; // ns
	const int half_per = 10; // ns

// vars:
	double prog = 0.0;
	int pos;

	vluint64_t vtime = 0; // unsigned long int

	int clock = 0;
	int rst = 1;

	std::cout << "\n\tStart FHT tb\n";
	std::cout << "\nProgress:\n";
	while(!Verilated::gotFinish())
	{
		std::cout << "[";
		vtime++;

		if(vtime%half_per == 0) clock ^= 1;

		if((vtime >= 5*half_per) & (vtime < 7*half_per)) rst = 0;
		else rst = 1;

		top_module->iRESET = rst;
		top_module->iCLK = clock;

		top_module->eval();
		vcd->dump(vtime);

		pos = bar_width * prog;

		for(int i = 0; i < bar_width; ++i)
		{
			if (i < pos) std::cout << "=";
			else if (i == pos) std::cout << ">";
			else std::cout << " ";
		}

		std::cout << "] %d %%\r" << int(prog * 100.0);
		std::cout.flush();

		if(vtime > finish_t) break;

		prog = (double)vtime/finish_t;
	}

	top_module->final();

	if(vcd) vcd->close();

	delete top_module;

	std::cout << "\n\n\tDone\n";

	exit(EXIT_SUCCESS);
}
