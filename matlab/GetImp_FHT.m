function GetImp_FHT = GetImp_FHT(...
                                dir_def,... % defines for FPGA project that defined main config of transform
                                dir_imp...  % dir of input sample impulses ('Nh', 'Nx' defined by FPGA define file)
                                ) %#codegen

fprintf('\n=================================================================================\n');
fprintf('=              Get impulse coefficient for RAM by Fast Hartley transform             =\n');
fprintf('=================================================================================\n');

%% main vars:
% save reg ver of files for init RAM:    
    dir_init_imp_p  = './init_imp_p_ram.txt'; 
    dir_init_imp_n	= './init_imp_n_ram.txt';
    
N_bank = 4; % defines by architecture of transform in FPGA (don't change for this config)

% read files:
    N           = F_READ_DEFINE(dir_def, 'N');
    Nx          = F_READ_DEFINE(dir_def, 'Nx');
    Nh          = F_READ_DEFINE(dir_def, 'Nh');
    row         = F_READ_DEFINE(dir_def, 'BANK_SIZE');
    depth_rom	= F_READ_DEFINE(dir_def, 'DEPTH_ROM');
    d_bit       = F_READ_DEFINE(dir_def, 'D_BIT');
    imp_bit     = F_READ_DEFINE(dir_def, 'IMP_BIT');
    w_amp       = F_READ_DEFINE(dir_def, 'MAX_W');
    adc_amp     = F_READ_DEFINE(dir_def, 'MAX_ADC_D');

fprintf('\nInput data:\n');
fprintf('\tNum of point transform (N)\t\t\t= %d\n',     int16(N));
fprintf('\tNum of point signal in RAM (Nx)\t\t= %d\n',	int16(Nx));
fprintf('\tNum of point impulses in RAM (Nh)\t= %d\n',	int16(Nh));
fprintf('\tRAM bank size\t= %d\n',                      int16(row));
fprintf('\tData width\t\t= %d\n',                       int16(d_bit));
fprintf('\tImpulse coef width\t\t= %d\n',               int32(imp_bit));
fprintf('\tAmp of Sin/Cos coef\t\t= %d\n',              int32(w_amp));
fprintf('\tAmp of input signal on ADC\t\t= %d\n',       int32(adc_amp));

%% get input data:
fprintf('\nGet input data...\n');

file_imp = fopen(dir_imp, 'r');

if(file_imp == -1)
   error('Error: file does not exist "%s"', dir_imp);
end

str_temp = fread(file_imp);
fclose(file_imp);

str_temp = char(str_temp(:).');

idx = isstrprop(str_temp, 'wspace');
idy = diff([true, idx, true]);

idb = find(idy < 0);
ide = find(idy > 0) - 1;

test_signal = zeros(N, 1);

for i = 1:N
    test_signal(i) = real(str2double(str_temp(idb(i):ide(i))));
end

fprintf('\nForming input RAM for FHT...');

k = 0;
ram = zeros(row, N_bank);

for i = 1:N_bank
    for j = 1:row
        k = k + 1;
        
    % bit reverse bank order:
        switch(i)
            case 1
                ram(j, 1) = test_signal(k);
            case 2
                ram(j, 3) = test_signal(k);
            case 3
                ram(j, 2) = test_signal(k);
            case 4
                ram(j, 4) = test_signal(k);
        end
    end
end

%% normalize signal in FPGA bit width:
%{
fprintf('\n\tNormalize input signal\n');

max_amp = max(abs(test_signal));

norm_coef_p = (adc_amp - 1)/max_amp;
norm_coef_n = adc_amp/max_amp;

if(max_amp > adc_amp)
    for i = 1:N_bank
        for j = 1:row
            if(ram(j, i) < 0)
                ram(j, i) = round(ram(j, i) * norm_coef_n);
            else
                ram(j, i) = round(ram(j, i) * norm_coef_p);
            end
        end
    end
end
%}
%% fht:
%{
fprintf('\nGenerate twiddle coefficients for FHT...\n');
sin_x = zeros(depth_rom, 1);
cos_x = zeros(depth_rom, 1);

for i = 0 : (depth_rom - 1)
    sin_x = round(sin(2*pi*i / row));
    cos_x = round(cos(2*pi*i / row));
end
%}
fprintf('\nStart transform...\n');

temp = zeros(4, 1);

for i = 1:row % 0 stage (only butterfly)
    temp = But_FHT( [ram(i, 1), ram(i, 2), 0],...
                    [ram(i, 3), ram(i, 4), 0], 0);
                           
    ram(i, :) = [temp(1), temp(3), temp(2), temp(4)];
end

last_stage = log(N)/log(2) - 1; % numbers start from zero
fprintf('\n\tTotal num of stages transform: %d\n', int16(last_stage));

% init coef for 1st stage:
    div = N/(2*N_bank);
    sector = 1;
    
for stage = 1:last_stage % without 0 stage
    fprintf('\t\tCurrent stage transform: %d\n', int16(stage));
    
    ram_buf = zeros(row, N_bank);

    sector_size = 1;
	sector_cnt = 2;

	cos_cnt = 0;
	
	for j = 1:sector
        num_coef = bin2dec(fliplr(dec2bin(cos_cnt, depth_rom))) + 1;
        
        for i = (1 + (j-1)*2*div):(2*div + (j-1)*2*div)
            if(j == 1)
                temp = But_FHT( [ram(i, 1), ram(i, 2), ram(i, 2)],...
                                [ram(i, 3), ram(i, 4), ram(i, 4)], num_coef);
			elseif(j == 2)
                temp = But_FHT([ram(i, 2), ram(i, 1), ram(i, 3)],...
                               [ram(i, 4), ram(i, 3), ram(i, 1)], num_coef);
			elseif(mod(j, 2) == 1)
                temp = But_FHT([ram(i, 1), ram(i, 2), ram(i + sector_cnt*2*div, 3)],...
                               [ram(i, 3), ram(i, 4), ram(i + sector_cnt*2*div, 1)], num_coef);
            else
                temp = But_FHT([ram(i, 2), ram(i, 1), ram(i + sector_cnt*2*div, 4)],...
                               [ram(i, 4), ram(i, 3), ram(i + sector_cnt*2*div, 2)], num_coef);
            end
            
            if(stage == last_stage)
				ram_buf(i, 1) = temp(1);
				ram_buf(i, 2) = temp(2);
				ram_buf(i, 3) = temp(3);
				ram_buf(i, 4) = temp(4);
			elseif(i > (div + (j-1)*2*div))
				ram_buf(i - div, 2) = temp(1);
				ram_buf(i - div, 4) = temp(2);
				ram_buf(i, 1) = temp(3);
				ram_buf(i, 3) = temp(4);
			else
				ram_buf(i, 1) = temp(1);
				ram_buf(i, 3) = temp(2);
				ram_buf(i + div, 2) = temp(3);
				ram_buf(i + div, 4) = temp(4);
            end
        end
        
        if((sector_cnt == -(sector_size - 1)) && (j >= 2))
			sector_size = 2*sector_size;
			sector_cnt = sector_size - 1;
		else
			sector_cnt = sector_cnt - 2;
        end
        
        if(cos_cnt == (row/4 - 1)) % overflow
            cos_cnt = 0;
        else
            cos_cnt = cos_cnt + 1;
        end
	end

	div = div/2;
	sector = 2*sector;
    
	ram = ram_buf;
end

%% save fixed point version of IMP RAM POS/NEG FHT for conv:
    fprintf('\nSave integer (reg) version output RAM impulses for FPGA...');

    ram_p = zeros(row, N_bank);
    ram_n = zeros(row, N_bank);

    ram_p(1, :) = ram(1, :) + ram(1, [1,2,4,3]);
    ram_p(2, :) = ram(2, :) + ram(2, [4,3,2,1]);

    ram_n(1, :) = ram(1, :) - ram(1, [1,2,4,3]);
    ram_n(2, :) = ram(2, :) - ram(2, [4,3,2,1]);

    cnt = 3;
    for i = 2 : 1 : log2(row)
        for j = (2^i - 1): -1 : (2^(i - 1))
            ram_p(cnt, :) = ram(cnt, :) + ram(j + 1, [4,3,2,1]);
            ram_n(cnt, :) = ram(cnt, :) - ram(j + 1, [4,3,2,1]);

            cnt = cnt + 1;
        end
    end

    F_SAVE_REG_RAM(ram_p, imp_bit, dir_init_imp_p); % minus bit expansion for imp (?)
    F_SAVE_REG_RAM(ram_n, imp_bit, dir_init_imp_n);
    
fprintf('\n===================================================\n');
fprintf('=                    Complete                     =\n');
fprintf('===================================================\n');

GetImp_FHT = 0;