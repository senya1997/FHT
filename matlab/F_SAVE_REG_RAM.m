function F_SAVE_REG_RAM = F_SAVE_REG_RAM(ram, bit, file_name)

N_bank = 4;

% save fixed point version of RAM for conv:
row = length(ram);
abs_max_ram = 0;

for i = 1 : row
    cur_max_ram = max(abs(ram(i,:)));

    if(cur_max_ram > abs_max_ram)
        abs_max_ram = cur_max_ram;
    end
end

file_reg = fopen(file_name, 'w');
if(file_reg == -1)
	error('Error: file name is wrong "%s"', file_name); 
end

norm_coef_p = (2^(bit - 1) - 1)/abs_max_ram;
norm_coef_n = (2^(bit - 1))/abs_max_ram;

% fixed point for FPGA like registers:
reg_ram(1:row, 1:N_bank) = zeros;

for i = 1:N_bank
    for j = 1:row
        if(ram(j, i) < 0)
            reg_ram(j, i) = round(ram(j, i)*norm_coef_n);
        else
            reg_ram(j, i) = round(ram(j, i)*norm_coef_p);
        end
    end
end

for i = 1 : row
    fprintf(file_reg, '%6d\t%6d\t%6d\t%6d\n', reg_ram(i, :));
end

fclose(file_reg);
    
F_SAVE_REG_RAM = reg_ram;