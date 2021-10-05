`include "TransformRAM.svh"

// private:
	local function automatic float32_t TransformRAM::Reg2Real(bit_t data);
		int32_t data_int; // integer part of data
		float32_t data_fract;
	
		data_fract = 0;
		
		for(uint16_t k = 0; k < (D_BIT - INT_BIT); k++) 
			data_fract = data_fract + float32_t(data[D_BIT - INT_BIT - (k+1)])/(2**(k+1));
	
		data_int = data[D_BIT - 1 : D_BIT - INT_BIT];
		
		Reg2Real = data_int + data_fract;
	endfunction

// public:
	function automatic void TransformRAM::UpdRAM(bit_t ext_ram[0 : BANK_SIZE - 1][0 : N_BANK - 1]);
		for(uint16_t cnt_data = 0; cnt_data < BANK_SIZE; cnt_data++)
			begin	
				for(uint16_t cnt_bank = 0; cnt_bank < N_BANK; cnt_bank++)
					tran_ram[cnt_data][cnt_bank] = ext_ram[cnt_data][cnt_bank];	
			end
	endfunction
		
	function automatic void TransformRAM::SaveRAMdata(string name);
		int f_ram, f_ram_reg;
		string str_temp;
	
		$display("\tsave RAM in files: '%s', time: %t\n", name, $time);
		
		str_temp = {"reg_", name};
		
		f_ram = $fopen(name, "w");
		f_ram_reg = $fopen(str_temp, "w");
		
		if(f_ram == -1)
			begin
				$fclose(f_ram);
				$fclose(f_ram_reg);
				
				$display("***\tError: file name is wrong: '%s', time: %t\n", name, $time);
				$stop;
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
