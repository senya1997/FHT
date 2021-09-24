function F_FHT = F_FHT(test_file, type) 

% test_file - sequences of data need to FHT
% type = 1 - impulse, 0 - pure signal

%% variables:
    dir_def = '../fht_defines.v';
    dir_signal	= test_file; % size Nx or Nh

% save reg ver of files for init FPGA RAM in tb:    
    dir_init_fht    = 'init_fht_ram.txt';
    dir_init_conv   = '../../fht_conv/matlab/init_conv_ram.txt';    
    dir_init_imp_p  = '../../fht_conv/matlab/init_imp_p_ram.txt'; 
    dir_init_imp_n	= '../../fht_conv/matlab/init_imp_n_ram.txt';

% dir output math:
    dir_math_addr_rd	= 'math_addr_rd.txt';
    dir_math_addr_wr	= 'math_addr_wr.txt';
    dir_math_fht_ram	= 'math_fht_ram.txt';

N_bank = 4; % defines by architecture of transform in FPGA (don't change for this config)

% read files:
    N       = F_READ_DEFINE(dir_def, 'N');
    row     = F_READ_DEFINE(dir_def, 'BANK_SIZE');
    d_bit	= F_READ_DEFINE(dir_def, 'D_BIT');
    imp_bit	= F_READ_DEFINE(dir_def, 'IMP_BIT');
    w_amp	= F_READ_DEFINE(dir_def, 'MAX_W');

if(type)
    N_signal = F_READ_DEFINE(dir_def, 'Nh');
else
    N_signal = F_READ_DEFINE(dir_def, 'Nx');
end

file_signal = fopen(dir_signal, 'r');

%% get input RAM for start FHT:
k = 0;
ram = zeros;
test_signal = zeros;
     
for i = 1:N_bank
    for j = 1:row
        k = k + 1;
        
        line = fscanf(file_signal, '%d\n');
        if(k > N_signal)
            test_signal(k) = 0;
        else
            test_signal(k) = str2double(line);
        end
        
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

fclose(file_signal);

clear file_signal;
clear line; clear k; clear test_signal;

%% fht:
sin_x = load('sin.txt');
cos_x = load('cos.txt');

file_ram = fopen(dir_init_fht, 'w');
for i = 1 : row
    fprintf(file_ram, '%6.6f\t%6.6f\t%6.6f\t%6.6f\n', ram(i, :));
end
    
file_addr_rd = fopen(dir_math_addr_rd, 'w'); % for compare with rtl
file_addr_wr = fopen(dir_math_addr_wr, 'w');

for i = 1:row % 0 stage (only butterfly)
    temp = F_FHT_BUT([ram(i, 1), ram(i, 2), 0],...
                     [ram(i, 3), ram(i, 4), 0],...
                     [sin_x(1), sin_x(1)],...
                     [cos_x(1), cos_x(1)], w_amp);
    ram(i, :) = [temp(1), temp(3), temp(2), temp(4)];

    fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1); % every second tact
    fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);

    fprintf(file_addr_wr, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
end

last_stage = log(N)/log(2) - 1; % numbers start from zero

% init coef for 1st stage:
    bit_depth = log(row)/log(2) - 2; % bit depth of ROM data: [A_BIT - 3 : 0]	
    div = N/(2*N_bank);
    sector = 1;

name = '';

for stage = 1:last_stage % without 0 stage
	name = 'before_';
    
    num_stage = '';
    n = abs(stage); %// work with positive
    
    while (n > 0)
        c = mod(n, 10); % get current character
        num_stage = [uint8(c + '0'), num_stage]; %// add the character
        n = (n -  c)/10; %// "chop" it off and continue
    end
    
    name = [name, num_stage];
    name = [name, 'st_ram.txt'];
    
    file_ram = fopen(name, 'w');
    for i = 1 : row
        fprintf(file_ram, '%6.6f\t%6.6f\t%6.6f\t%6.6f\n', ram(i, :));
    end
    fclose(file_ram);
    
    ram_buf = zeros;

    sector_size = 1;
	sector_cnt = 2;

	cos_cnt = 0;
	
	for j = 1:sector
        num_coef = bin2dec(fliplr(dec2bin(cos_cnt, bit_depth))) + 1;
        
		for i = (1 + (j-1)*2*div):(2*div + (j-1)*2*div)
			if(j == 1)
				temp = F_FHT_BUT([ram(i, 1), ram(i, 2), ram(i, 2)],...
                                 [ram(i, 3), ram(i, 4), ram(i, 4)],...
                                 [sin_x(num_coef), cos_x(num_coef)],...
                                 [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			elseif(j == 2)
				temp = F_FHT_BUT([ram(i, 2), ram(i, 1), ram(i, 3)],...
                                 [ram(i, 4), ram(i, 3), ram(i, 1)],...
                                 [sin_x(num_coef), cos_x(num_coef)],...
                                 [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                                  
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			elseif(mod(j, 2) == 1) 
				temp = F_FHT_BUT([ram(i, 1), ram(i, 2), ram(i + sector_cnt*2*div, 3)],...
                                 [ram(i, 3), ram(i, 4), ram(i + sector_cnt*2*div, 1)],...
                                 [sin_x(num_coef), cos_x(num_coef)],...
                                 [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                                   
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i + sector_cnt*2*div-1, i-1, i + sector_cnt*2*div-1, i-1);                 
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			else
				temp = F_FHT_BUT([ram(i, 2), ram(i, 1), ram(i + sector_cnt*2*div, 4)],...
                                 [ram(i, 4), ram(i, 3), ram(i + sector_cnt*2*div, 2)],...
                                 [sin_x(num_coef), cos_x(num_coef)],...
                                 [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                                   
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i + sector_cnt*2*div-1, i-1, i + sector_cnt*2*div-1);
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
            end
            
			if(stage == last_stage)
				ram_buf(i, 1) = temp(1);
				ram_buf(i, 2) = temp(2);
				ram_buf(i, 3) = temp(3);
				ram_buf(i, 4) = temp(4);
                
                fprintf(file_addr_wr, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			elseif(i > (div + (j-1)*2*div))
				ram_buf(i - div, 2) = temp(1);
				ram_buf(i - div, 4) = temp(2);
				ram_buf(i, 1) = temp(3);
				ram_buf(i, 3) = temp(4);
                
                fprintf(file_addr_wr, '%4d\t%4d\t%4d\t%4d\n', i-1, i - div - 1, i-1, i - div - 1 );
			else
				ram_buf(i, 1) = temp(1);
				ram_buf(i, 3) = temp(2);
				ram_buf(i + div, 2) = temp(3);
				ram_buf(i + div, 4) = temp(4);
                
                fprintf(file_addr_wr, '%4d\t%4d\t%4d\t%4d\n', i-1,  i + div - 1, i-1, i + div - 1);
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

fclose(file_addr_rd); 
fclose(file_addr_wr); 

clear file_addr_rd; clear file_addr_wr;

%% save final RAM data in files:
    file_ram = fopen(dir_math_fht_ram, 'w');
    for i = 1 : row
        fprintf(file_ram, '%6.6f\t%6.6f\t%6.6f\t%6.6f\n', ram(i, :));
    end
    fclose(file_ram); 
    clear file_ram;
    
% save fixed point version of IMP RAM POS/NEG FHT for conv:
    if(type)
        ram_p = zeros;
        ram_n = zeros;

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

        F_SAVE_REG_RAM(ram_p, imp_bit - 1, dir_init_imp_p); % minus bit expansion for imp
        F_SAVE_REG_RAM(ram_n, imp_bit - 1, dir_init_imp_n);
    else
        F_SAVE_REG_RAM(ram, d_bit, dir_init_conv);
    end

clear temp; clear file_ram; clear file_fft_cp;

F_FHT = ram;