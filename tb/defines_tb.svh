typedef integer unsigned	uint32_t;
typedef shortint unsigned	uint16_t;

typedef real		float64_t;
typedef shortreal	float32_t;

`timescale 1ns/1ns

// `define EN_BREAKPOINT
`define COMPARE_WITH_MATLAB

// if modelsim issue error 'Unresolved reference to...' try to switch this define:
	//`define RAM_ACCESS_TB altsyncram_component.mem_data
	//`define RAM_ACCESS_TB altsyncram_component.m_default.altsyncram_inst.mem_data
	`define RAM_ACCESS_TB altsyncram_component.m_non_arria10.altsyncram_inst.mem_data

`define CLK_FREQ 100 // MHz

`define TACT		$ceil(1000/`CLK_FREQ) // ns
`define HALF_TACT	$ceil(`TACT/2)
/*
`define TACT 21
`define HALF_TACT `TACT/2 
 */
`define NUM_OF_RPT 50	// number of repeat butterfly test
`define ACCURACY 0.001	// for all tests (butterfly, FHT)