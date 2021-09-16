function F_SAVE_REG_RAM = F_SAVE_REG_RAM(ram, bit, file_name)

% save fixed point version of RAM for conv:
row = length(ram);
abs_max_ram = 0;

for i = 1 : row
    if(max(ram(i,:)) > abs(min(ram(i,:))))
        cur_max_ram = max(ram(i,:));
    else
        cur_max_ram = abs(min(ram(i,:)));
    end

    if(cur_max_ram > abs_max_ram)
        abs_max_ram = cur_max_ram;
    end
end

file_reg = fopen(file_name, 'w');
reg_ram = round(ram*(2^(bit - 1))/abs_max_ram); % fixed point for FPGA like registers

for i = 1 : row
    fprintf(file_reg, '%6d\t%6d\t%6d\t%6d\n', reg_ram(i, :));
end

fclose(file_reg);
    
F_SAVE_REG_RAM = reg_ram;