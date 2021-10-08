`include "TransformRAM.svh"

 	function TransformRAM::new();
 		disp_data = 0;
 		
 		for(uint16_t cnt_data = 0; cnt_data < BANK_SIZE; cnt_data++)
 			for(uint16_t cnt_bank = 0; cnt_bank < N_BANK; cnt_bank++)
 				tran_ram[cnt_data][cnt_bank] = 0;
 	endfunction

// private:
 	
 	
// protected:
 	function float32_t TransformRAM::AbsData(float32_t data);
		if(data < 0) AbsData = -data;
		else AbsData = data;
	endfunction
	
	function float32_t TransformRAM::Reg2Real(dbit_t data);
		int32_t data_int; // integer part of data
		float32_t data_fract;
	
		data_fract = 0;
		
		for(uchar_t k = 0; k < (D_BIT - INT_BIT); k++) 
			data_fract = data_fract + float32_t'(data[D_BIT - INT_BIT - (k+1)])/(2**(k+1)); // one bit in float cast
	
		data_int = $signed(data[D_BIT - 1 : D_BIT - INT_BIT]); // signed cast
		Reg2Real = float32_t'(data_int) + data_fract; // cast
	endfunction

// public:
	function void TransformRAM::SetPeriod(uint32_t tact);
		this.tact = tact;
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
	
	function void TransformRAM::UpdBankRAM(uint16_t bunk_num, dlogic_t ext_ram [0 : BANK_SIZE - 1]);
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
				
				$display("\n***\tError: file name is wrong: '%s'\n", name);
				$stop;
				return;
			end
		
		for(uint16_t cnt_data = 0; cnt_data < BANK_SIZE; cnt_data++)
			begin
				for(uchar_t cnt_bank = 0; cnt_bank < N_BANK; cnt_bank++) 
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

	function void TransformRAM::CompareWithFile(string name_ref, float32_t accuracy);
		int32_t f_ref;
		int32_t scan_data;
	
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
		
		$display("\n\tCompare data point in RAM with file: '%s', time: %t\n", name_ref, $time);
		
		f_ref = $fopen(name_ref, "r");
		if(f_ref == 0)
			begin
				$fclose(f_ref);
				$display("\n***\tError: file name is wrong: '%s'\n", name_ref);
				$stop;
				return;
			end
		
		cnt_cur_er = 0;
		max_cur_er = 0;
		sum_cur_er = 0;
		
		for(uint16_t i = 0; i < BANK_SIZE; i++) // row
			begin
				cnt_row_er = 0;
				
				for(uchar_t j = 0; j < N_BANK; j++) // column
					begin
						if(i < N_BANK - 1)	scan_data = $fscanf(f_ref, "%f\t", temp_ref_data);
						else				scan_data = $fscanf(f_ref, "%f\n", temp_ref_data);
						
						temp_ram_data = Reg2Real(tran_ram[i][j]);
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
						$display(" ***\t     REF:\t%s", i, str_ref_data);
					end
			end
	
		$fclose(f_ref);
		
		$display("\n\tMax error: %6.6f", max_cur_er);
		
		if(cnt_cur_er == 0)	$display("\tAvarage error: 0");
		else				$display("\tAvarage error: %6.6f", sum_cur_er/cnt_cur_er);
		
		$display("\tNumber of errors compare RAM with file: %4d, time: %t\n", cnt_cur_er, $time);
	endfunction
	
	function void TransformRAM::Bitrev2NormalRAM(); // convert bit reverse to normal sequence points in RAM
		$display("\n\tRewrite RAM data from bit rev to norm order for IFHT, time: %t\n", $time);
	
		for(j = 0; j < `BANK_SIZE; j = j + 1) 
			begin
				ram_buf_0[j] = FHT.FHT_RAM_A.ram_bank[0].RAM_BANK.`RAM_ACCESS_TB[j];
				ram_buf_1[j] = FHT.FHT_RAM_A.ram_bank[1].RAM_BANK.`RAM_ACCESS_TB[j];
				ram_buf_2[j] = FHT.FHT_RAM_A.ram_bank[2].RAM_BANK.`RAM_ACCESS_TB[j];
				ram_buf_3[j] = FHT.FHT_RAM_A.ram_bank[3].RAM_BANK.`RAM_ACCESS_TB[j];
			end	

		cnt_rev = 0;
	
		for(j = 0; j < `BANK_SIZE; j = j + 1) 
			begin
				temp_data[0] = ram_buf_0[F_BIT_REV(cnt_rev)];
				temp_data[1] = ram_buf_1[F_BIT_REV(cnt_rev)];
				temp_data[2] = ram_buf_2[F_BIT_REV(cnt_rev)];
				temp_data[3] = ram_buf_3[F_BIT_REV(cnt_rev)];
				
				for(i = 0; i < 4; i = i + 1)
					begin
						data_fixp = temp_data[i];
						addr_wr = j;
							
						we[i] = 1'b1;
						#(`TACT);
						we[i] = 1'b0;
					end
					
				cnt_rev = cnt_rev + 1;
			end
	endfunction
	
	function void TransformRAM::DisplayRAM();
	
	endfunction
		
	task TransformRAM::InitRAM(
								input string name,
								input bit fixed_point, // 1 - add '0' in fract part of data before write, 0 - add data in RAM as is
								input bit from_file, // 1 - init external RAM and RAM in class from file, 0 - init external ram from class RAM
								output dbit_t oDATA,
								output abit_t oADDR_WR,
								output bit [N_BANK - 1 : 0] oWE
							); // line by line from file
		
		int32_t f_data, scan_data;
		int32_t temp_data;
		
		bit signed [INT_BIT - 1 : 0] data_buf;
		
		$display("\n\tWrite data point in RAM from file: '%s', time: %t\n", name, $time);
		
		if(from_file)
			begin
				f_data = $fopen(name, "r");
		
				if(f_data == 0)
				begin
					$fclose(f_data);
					$display("\n***\tError: file name is wrong: '%s'\n", name);
					$stop;
					return;
				end
			end
	
		for(uint16_t j = 0; j < BANK_SIZE; j++) // rows
			begin
				for(uchar_t i = 0; i < N_BANK; i++) // columns
					begin
						if(from_file)
							begin
								if(i < N_BANK - 1)	scan_data = $fscanf(f_data, "%f\t", temp_data);
								else				scan_data = $fscanf(f_data, "%f\n", temp_data);
								
								tran_ram[j][i] = temp_data; // update internal RAM imitation
							end
						else data_buf = tran_ram[j][i]); // signed cast
						
						if(fixed_point)
							begin
								data_buf = $signed(temp_data); // signed cast
								oDATA = {data_buf, {(D_BIT - INT_BIT){1'b0}}};
							end
						else oDATA = temp_data; // signed cast
								
						oADDR_WR = j; // unsigned cast
								
						oWE[i] = 1'b1; // write external RAM
						#(tact);
						oWE[i] = 1'b0;
					end
			end
		
		if(from_file) $fclose(f_data);
	endtask