`include "TransformRAM.svh"

 	function TransformRAM::new();
 		for(uint16_t cnt_data = 0; cnt_data < BANK_SIZE; cnt_data++)
 			for(uint16_t cnt_bank = 0; cnt_bank < N_BANK; cnt_bank++)
 				tran_ram[cnt_data][cnt_bank] = 0;
 	endfunction

	function void TransformRAM::SetPeriod(time tact);
		this.tact = tact*1000; // ???
	endfunction
	
	function uint32_t TransformRAM::GetAllErr();
		GetAllErr = cnt_all_er;
	endfunction
	
	function float32_t TransformRAM::GetMaxErr();
		GetMaxErr = max_er;
	endfunction
	
	function float32_t TransformRAM::GetAvErr();
		if(cnt_all_er != 0) GetAvErr = sum_er/cnt_all_er;
		else GetAvErr = 0;
	endfunction
	
	function float32_t TransformRAM::GetMaxDataRam();
		dbit_t max_data;
		
		max_data = 0;
		for(uint16_t i = 0; i < BANK_SIZE; i++) // rows
			for(uchar_t j = 0; j < N_BANK; j++) // column
				if(tran_ram[i][j] > max_data) max_data = tran_ram[i][j];
		
		return Reg2Float(max_data);
	endfunction
	
	function float32_t TransformRAM::GetMinDataRam();
		dbit_t min_data;
		
		min_data = 0;
		for(uint16_t i = 0; i < BANK_SIZE; i++) // rows
			for(uchar_t j = 0; j < N_BANK; j++) // column
				if(tran_ram[i][j] < min_data) min_data = tran_ram[i][j];
		
		return Reg2Float(min_data);
	endfunction
	
	function float32_t TransformRAM::GetMeanDataRam();
		float32_t sum_data;
		
		sum_data = 0;
		for(uint16_t i = 0; i < BANK_SIZE; i++) // rows
			for(uchar_t j = 0; j < N_BANK; j++) // column
				sum_data = sum_data + Reg2Float(tran_ram[i][j]);
		
		return sum_data/(BANK_SIZE * N_BANK);
	endfunction
	
	function float32_t TransformRAM::AbsData(float32_t data);
		if(data < 0) AbsData = -data;
		else AbsData = data;
	endfunction
	
	function float32_t TransformRAM::Reg2Float(dbit_t data);
		int32_t data_int; // integer part of data
		float32_t data_fract;
	
		data_fract = 0;
		
		for(uchar_t k = 0; k < (D_BIT - INT_BIT); k++) 
			data_fract = data_fract + float32_t'(data[D_BIT - INT_BIT - (k+1)])/(2**(k+1)); // one bit in float cast
	
		data_int = $signed(data[D_BIT - 1 : D_BIT - INT_BIT]); // signed cast
		Reg2Float = float32_t'(data_int) + data_fract; // cast
	endfunction
	
	function void TransformRAM::UpdBankRAM(uint16_t bunk_num, dlogic_t ext_ram [0 : BANK_SIZE - 1]);
		for(uint16_t cnt_data = 0; cnt_data < BANK_SIZE; cnt_data++)
			begin
				if(&ext_ram[cnt_data] !== 1'bx)
					tran_ram[cnt_data][bunk_num] = ext_ram[cnt_data]; // "unsigned" to signed cast
				else
					begin
						$display("\n ***\tCrytical warning: RAM data in 'X' state: bank = %d, addr = %d, data = %d", bunk_num, cnt_data, ext_ram[cnt_data]);
						$stop;
						return;
					end
			end
	endfunction
	
	function e_comp TransformRAM::CompareBankRAM(uint16_t bunk_num, float32_t accuracy, dlogic_t ext_ram [0 : BANK_SIZE - 1]);
		float32_t temp_ram_data;
		float32_t temp_ext_data; // external for class RAM data
		float32_t temp_er;
		
	// errors in current compare with file:
		uint32_t cnt_cur_er; 
		float32_t max_cur_er;
		float32_t sum_cur_er;
		
		$display("\tCompare data point in RAM with class RAM, time: %t\n", $time);
		
		cnt_cur_er = 0;
		max_cur_er = 0;
		sum_cur_er = 0;
		
		for(uint16_t i = 0; i < BANK_SIZE; i++) // row
			begin
				if(&ext_ram[i] !== 1'bx) temp_ext_data = Reg2Float(ext_ram[i]);
				else
					begin
						$display("\n ***\tCrytical warning: RAM data in 'X' state: bank = %d,  addr = %d, data = %d", bunk_num, i, ext_ram[i]);
						return ERR;
					end
					
				temp_ram_data = Reg2Float(tran_ram[i][bunk_num]);
				temp_er = AbsData(temp_ext_data - temp_ram_data);

				if(temp_er > accuracy)
					begin
						sum_er		= sum_er + temp_er;
						sum_cur_er	= sum_cur_er + temp_er;
						
						cnt_all_er = cnt_all_er + 1;
						cnt_cur_er = cnt_cur_er + 1;
									
						if(temp_er > max_er)		max_er = temp_er;
						if(temp_er > max_cur_er)	max_cur_er = temp_er;
						
						$display(" ***\tLine %3d: EXT RAM =\t\t\t%6.6f, CLASS RAM:\t\t\t%6.6f", i, temp_ext_data, temp_ram_data);
					end
			end
		
		$display("\n\tNumber of errors compare RAM with class RAM: %4d, time: %t", cnt_cur_er, $time);
		$display("\tMax error: %6.6f", max_cur_er);
		
		if(cnt_cur_er == 0)
			begin
				$display("\tAvarage error: 0\n");
				return SAME;
			end
		else
			begin
				$display("\tAvarage error: %6.6f\n", sum_cur_er/cnt_cur_er);
				return DIFF;
			end
	endfunction
	
	function void TransformRAM::SaveRAMdata(string name);
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
				
				$display("\n ***\tError: file name is wrong: '%s'\n", name);
				$stop;
				return;
			end
		
		for(uint16_t cnt_data = 0; cnt_data < BANK_SIZE; cnt_data++)
			begin
				for(uchar_t cnt_bank = 0; cnt_bank < N_BANK; cnt_bank++) 
					begin
						$fwrite(f_ram, "%6.6f", Reg2Float(tran_ram[cnt_data][cnt_bank]), "\t");
						$fwrite(f_ram_reg, "%d", tran_ram[cnt_data][cnt_bank], "\t");
					end
						
				$fwrite(f_ram, "\n");
				$fwrite(f_ram_reg, "\n");
			end
			
		$fclose(f_ram);
		$fclose(f_ram_reg);
	endfunction

	function e_comp TransformRAM::CompareWithFile(string name_ref, float32_t accuracy);
		int32_t f_ref;
	
		float32_t temp_ref_data; // reference data from file
		float32_t temp_ram_data;
		float32_t temp_er;
		
	// errors in current compare with file:
		uchar_t cnt_row_er;
		uint32_t cnt_cur_er; 
		float32_t max_cur_er;
		float32_t sum_cur_er;
		
		string str_ref_data;
		string str_ram_data;
		string str_temp;
		
		$display("\tCompare data point in RAM with file: '%s', time: %t\n", name_ref, $time);
		
		f_ref = $fopen(name_ref, "r");
		if(f_ref == 0)
			begin
				$fclose(f_ref);
				$display("\n ***\tError: file name is wrong: '%s'\n", name_ref);
				return ERR;
			end
		
		cnt_cur_er = 0;
		max_cur_er = 0;
		sum_cur_er = 0;
		
		for(uint16_t i = 0; i < BANK_SIZE; i++) // row
			begin
				cnt_row_er = 0;
				
				str_ram_data = "";
				str_ref_data = "";
				
				for(uchar_t j = 0; j < N_BANK; j++) // column
					begin
						if(i < N_BANK - 1)	void'($fscanf(f_ref, "%f\t", temp_ref_data));
						else				void'($fscanf(f_ref, "%f\n", temp_ref_data));
						
						temp_ram_data = Reg2Float(tran_ram[i][j]);
						temp_er = AbsData(temp_ref_data - temp_ram_data);
						
						str_temp.realtoa(temp_ref_data);
						str_ref_data = {str_ref_data, str_temp, ",\t\t\t\t"};
						
						str_temp.realtoa(temp_ram_data);
						str_ram_data = {str_ram_data, str_temp, ",\t\t\t\t"};

						if(temp_er > accuracy)
							begin
								sum_er		= sum_er + temp_er;
								sum_cur_er	= sum_cur_er + temp_er;
								
								cnt_row_er = cnt_row_er + 1;
								cnt_all_er = cnt_all_er + 1;
								cnt_cur_er = cnt_cur_er + 1;
								
								if(temp_er > max_er)		max_er = temp_er;
								if(temp_er > max_cur_er)	max_cur_er = temp_er;
							end
					end
				
				if(cnt_row_er != 0)
					begin
						$display(" ***\tLine %3d:\t%s", i, str_ram_data);
						$display(" ***\t     REF:\t%s", str_ref_data);
					end
			end
	
		$fclose(f_ref);
		
		$display("\n\tNumber of errors compare RAM with file: %4d, time: %t", cnt_cur_er, $time);
		$display("\tMax error: %6.6f", max_cur_er);
		
		if(cnt_cur_er == 0)
			begin
				$display("\tAvarage error: 0\n");
				return SAME;
			end
		else
			begin
				$display("\tAvarage error: %6.6f\n", sum_cur_er/cnt_cur_er);
				return DIFF;
			end
	endfunction
	
	function void TransformRAM::Bitrev2NormalRAM(); // convert bit reverse to normal sequence points in RAM
		dbit_t tran_ram_buf [0 : BANK_SIZE - 1][0 : N_BANK - 1];
		abit_t cnt_addr_rev;
		abit_t addr_rev;
		
		$display("\tRewrite RAM data from bit reverse to norm order, time: %t\n", $time);
		
		for(uint16_t i = 0; i < BANK_SIZE; i++) // rows
			for(uchar_t j = 0; j < N_BANK; j++) // column
				tran_ram_buf[i][j] = tran_ram[i][j];

		cnt_addr_rev = 0;
		
		for(uint16_t i = 0; i < BANK_SIZE; i++) // rows
			begin
				addr_rev = AddrBitReverse(cnt_addr_rev);
				
				for(uchar_t j = 0; j < N_BANK; j++) // column
					tran_ram[i][j] = tran_ram_buf[addr_rev][j];
				
				cnt_addr_rev = cnt_addr_rev + 1;
			end
	endfunction
	
	task TransformRAM::DisplayRAM(ref dbit_t data_disp);
		nbit_t cnt_bank_rev;
		nbit_t bank_rev;
		
		$display("\tDisplay RAM data in bank bit reverse order, time: %t\n", $time);
		
		cnt_bank_rev = 0;
		
		for(uchar_t i = 0; i < N_BANK; i++) // column
			begin
				bank_rev = BankBitReverse(cnt_bank_rev);
					
				for(uint16_t j = 0; j < BANK_SIZE; j++) // rows
					begin
						data_disp = tran_ram[j][bank_rev];
						#(tact);
					end
					
				cnt_bank_rev = cnt_bank_rev + 1;
			end
	endtask

	task TransformRAM::InitRAM(
							string name,
							bit fixed_point, // 1 - add '0' in fract part of data before write, 0 - add data in RAM as is
							bit from_file, // 1 - init external RAM and RAM in class from file, 0 - init external ram from class RAM
							ref dbit_t out_data,
							ref abit_t out_addr,
							ref webit_t out_we
						); // line by line from file
						
		int32_t f_data;
		int32_t temp_data;
		
		if(from_file)
			begin
				$display("\tWrite data point in RAM from file: '%s', time: %t\n", name, $time);
				f_data = $fopen(name, "r");
		
				if(f_data == 0)
					begin
						$fclose(f_data);
						$display("\n ***\tError: file name is wrong: '%s'\n", name);
						$stop;
						return;
					end
			end
		else 
			$display("\tWrite data point in RAM from class RAM, time: %t\n", $time);
		
		for(uint16_t i = 0; i < BANK_SIZE; i++) // rows
			for(uchar_t j = 0; j < N_BANK; j++) // columns
				begin
					if(from_file)
						begin
							if(j < N_BANK - 1)	void'($fscanf(f_data, "%f\t", temp_data));
							else				void'($fscanf(f_data, "%f\n", temp_data));
							
							tran_ram[i][j] = $signed(temp_data); // update internal RAM imitation, signed cast
						end
					
					if(fixed_point & from_file)	out_data = {tran_ram[i][j], {(D_BIT - INT_BIT){1'b0}}};
					else						out_data = tran_ram[i][j];
							
					out_addr = i; // row choose, unsigned cast
					
					out_we[j] = 1'b1; // column choose, write external RAM
					#(tact);
					out_we[j] = 1'b0;
				end
		
		if(from_file) $fclose(f_data);
	endtask
