`include "TransformRAM.svh"
/*
 	function TransformRAM::new(string name);
 		
 	endfunction
*/ 	
 	function TransformRAM::new();
 		disp_data = 0;
 		
 		for(uint16_t cnt_data = 0; cnt_data < BANK_SIZE; cnt_data++)
 			for(uint16_t cnt_bank = 0; cnt_bank < N_BANK; cnt_bank++)
 				tran_ram[cnt_data][cnt_bank] = 0;
 	endfunction

// private:
 	
 	
// protected:
 	protected function automatic float32_t TransformRAM::AbsData(float32_t data);
		if(data < 0) AbsData = -data;
		else AbsData = data;
	endfunction

	protected function automatic uint32_t TransformRAM::BitReverse(uint16_t width, uint32_t data);
		bit [width - 1 : 0] reg_data;
		bit [width - 1 : 0] reg_data_buf;
		
		if(data <= 2**width) reg_data = data; // unsigned cast
		else 
			begin
				$display("\n***\tCrytical warning: cast not possible, cause input data have large width: data = %d, width = %d", data, width);
				stop;
				return;
			end
		
		for(uint16_t i = 0; i < width; i++) 
			reg_data_buf[width - 1 - i] = reg_data[i];
		
		BitReverse = reg_data_buf; // unsigned cast
	endfunction
	
	protected function automatic float32_t TransformRAM::Reg2Real(dbit_t data);
		int32_t data_int; // integer part of data
		float32_t data_fract;
	
		data_fract = 0;
		
		for(uint16_t k = 0; k < (D_BIT - INT_BIT); k++) 
			data_fract = data_fract + float32_t(data[D_BIT - INT_BIT - (k+1)])/(2**(k+1)); // one bit in float cast
	
		data_int = $signed(data[D_BIT - 1 : D_BIT - INT_BIT]); // signed cast
		Reg2Real = float32_t(data_int) + data_fract; // cast
	endfunction

// public:
	function void TransformRAM::SetPeriod(uint32_t tact);
		this.tact = tact;
	endfunction
		
	function automatic void TransformRAM::UpdBankRAM(uint16_t bunk_num, dlogic_t ext_ram [0 : BANK_SIZE - 1]);
		for(uint16_t cnt_data = 0; cnt_data < BANK_SIZE; cnt_data++)
			begin
				if(&ext_ram[cnt_data] !== 1'bx)
					tran_ram[cnt_data][bunk_num] = ext_ram[cnt_data];
				else
					begin
						$display("\n***\tCrytical warning: RAM data in 'X' state: addr = %d, data = %d", cnt_data, ext_ram[cnt_data]);
						$stop;
						return;
					end
			end
	endfunction
		
	function automatic void TransformRAM::SaveRAMdata(string name);
		int32_t f_ram, f_ram_reg;
		string str_temp;
	
		$display("\tSave RAM in files: '%s', time: %t\n", name, $time);
		
		str_temp = {"reg_", name};
		
		f_ram = $fopen(name, "w");
		f_ram_reg = $fopen(str_temp, "w");
		
		if(f_ram == 0)
			begin
				$fclose(f_ram);
				$fclose(f_ram_reg);
				
				$display("\n***\tError: file name is wrong: '%s'\n", name);
				$stop;
				return;
			end
		
		for(uint16_t cnt_data = 0; cnt_data < BANK_SIZE; cnt_data++)
			begin
				for(uint16_t cnt_bank = 0; cnt_bank < N_BANK; cnt_bank++) 
					begin
						$fwrite(f_ram, "%6.6f", Reg2Real(tran_ram[cnt_data][cnt_bank]), "\t");
						$fwrite(f_ram_reg, "%d", tran_ram[cnt_data][cnt_bank], "\t");
					end
						
				$fwrite(f_ram, "\n");
				$fwrite(f_ram_reg, "\n");
			end
			
		$fclose(f_ram);
		$fclose(f_ram_reg);
	endfunction

	task automatic TransformRAM::InitRAM(
		input string name,
		input bit fixed_point, // 1 - add '0' in fract part of data before write, 0 - add data in RAM as is
		output dbit_t oDATA,
		output bit [A_BIT - 1 : 0] oADDR_WR,
		output bit oWE
	); // line by line from file
		
		int32_t f_data, scan_data;
		int32_t temp_data;
		
		bit signed [INT_BIT - 1 : 0] data_buf;
		
		$display("\n\tWrite data point in RAM from file: '%s', time: %t\n", name, $time);
		
		f_data = $fopen(name, "r");
		
		if(f_data == 0)
			begin
				$fclose(f_data);
				$display("\n***\tError: file name is wrong: '%s'\n", name);
				$stop;
				return;
			end
	
		for(uint16_t j = 0; j < BANK_SIZE; j++) // rows
			begin
				for(uint16_t i = 0; i < N_BANK; i++) // columns
					begin
						if(i < N_BANK - 1)	scan_data = $fscanf(f_data, "%f\t", temp_data);
						else				scan_data = $fscanf(f_data, "%f\n", temp_data);
						
						tran_ram[j][i] = temp_data; // update internal RAM imitation
						
						if(fixed_point)
							begin
								data_buf = temp_data; // signed cast
								oDATA = {data_buf, {(D_BIT - INT_BIT){1'b0}}};
							end
						else oDATA = temp_data; // signed cast
						
						oADDR_WR = j; // unsigned cast
						
						oWE[i] = 1'b1; // write external RAM
						#(tact);
						oWE[i] = 1'b0;
					end
			end
		
		$fclose(f_data);
	endtask
	