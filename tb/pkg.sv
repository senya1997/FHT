// types:
	package common_types_pkg;
		typedef integer unsigned	uint32_t;
		typedef shortint unsigned	uint16_t;
		
		typedef integer 			int32_t;
		typedef shortint 			int16_t;
		
		typedef real				float64_t;
		typedef shortreal			float32_t;
		
		typedef byte unsigned		uchar_t;
		typedef byte				char_t;
	endpackage

// classes:
	package fht_classes_pkg;
		typedef enum {SAME, DIFF, ERR} e_comp;
		
		`include "TransformRAM.sv"
	endpackage