clear;
clc;

close all;

%% choose test signal:
    %test = 'sin';      % sine in 3 harmonics
    test = 'imp';      % impulse response
    %test = 'signal';   % real signal from 'wav'
    %test = 'const';    % const bias
    %test = 'num';      % linear increase signal from '0' to 'N - 1'

%% variables:
dir_def = '../fht_defines.v';

% 'h.txt' must be autogenerated, cause 'Nh' defines in 'fht_defines.v':
    dir_imp =       '../../fht_conv/matlab/h.txt'; % size Nh
    dir_signal =    '../../fht_conv/matlab/x.txt'; % size Nx

% save reg ver of FHT for conv test:
    dir_reg_imp_p =   '../../fht_conv/matlab/reg_imp_p_ram.txt'; 
    dir_reg_imp_n =   '../../fht_conv/matlab/reg_imp_n_ram.txt';
    dir_reg_fht =   '../../fht_conv/matlab/reg_fht_ram.txt';

N_bank = 4; % defines by architecture of transform in FPGA (don't change for this config)

Fd = 44100;
bias = 0;

rand_sin = 'Y'; % generate rand sine harm or determine by defined value (Y/N)

max_amp = 10922; % signed 16 bit ADC <=> 32767/3, cause pseudorand signal have 3 harmonic
max_freq = 1000; % in Hz
max_phase = 180; % in grad

bias_freq = 100; % in Hz

threshold = 0.2; % in precent max error between FFT and FHT that save index of error data
save_err_ind = 'Y'; % save index of error data in file (Y/N, append to exist file)

% read files:
    N       = F_READ_DEFINE(dir_def, 'N');
    Nx      = F_READ_DEFINE(dir_def, 'Nx');
    Nh      = F_READ_DEFINE(dir_def, 'Nh');
    d_bit	= F_READ_DEFINE(dir_def, 'D_BIT');
    imp_bit	= F_READ_DEFINE(dir_def, 'IMP_BIT');
    w_amp	= F_READ_DEFINE(dir_def, 'W_BIT');

%% get input data:
time = 0 : 1/Fd : (N - 1)/Fd;

switch(test)
    case 'sin'
        if(rand_sin == 'N')
            amp(1:3)    = [round(max_amp),      round(max_amp/2),	round(max_amp/4)];
            freq(1:3)	= [round(max_freq),     round(max_freq/2),	round(max_freq/4)];
            phase(1:3)  = [round(max_phase),	round(max_phase),	round(max_phase)];
        else
            amp(1:3)    = zeros;
            freq(1:3)	= zeros;
            phase(1:3)  = zeros;

            for i = 1:3
                amp(i) = round(rand()*max_amp);
                freq(i) = bias_freq + round(rand()*max_freq);
                phase(i) = round(rand()*max_phase);
            end
        end
        
        signal = bias + amp(1)*sind((freq(1)*360).* time + phase(1)) +...
                        amp(2)*sind((freq(2)*360).* time + phase(2)) +...
                        amp(3)*sind((freq(3)*360).* time + phase(3));
    
        fprintf('\nsignal test\n\n');
        fprintf('amp_1 = %d,\tamp_2 = %d,\tamp_3 = %d\nfreq_1 = %d,\tfreq_2 = %d,\tfreq_3 = %d\nphase_1 = %d,\tphase_2 = %d,\tphase_3 = %d\n',...
                amp, freq, phase);
    case 'imp'
        fprintf('\nimpulse test\n\n');
        file_imp = fopen(dir_imp, 'r');         
    case 'signal'
        fprintf('\nsignal test\n\n');
        file_signal = fopen(dir_signal, 'r');
    case 'const'
        fprintf('\nconst test\n\n');
    case 'num'
        fprintf('\nindex number test\n\n');
    otherwise
        error('test var is wrong');
end

%% get input RAM for start FHT:
k = 0;
row = N/N_bank; % necessarily integer

ram(1:row, 1:N_bank) = zeros;
test_signal(1:N) = zeros;

for i = 1:N_bank
    for j = 1:row
        k = k + 1;
        
	% choose test signal:
        switch(test)
            case 'sin'
                test_signal(k) = round(signal(k));
            case 'imp'
                line = fgetl(file_imp);
            
                if(k > Nh)
                    test_signal(k) = 0;
                else
                    test_signal(k) = str2double(line);
                end
            case 'signal'
                line = fgetl(file_signal);
            
                if(k > Nx)
                    test_signal(k) = 0;
                else
                    test_signal(k) = str2double(line);
                end
            case 'const'
                test_signal(k) = bias;
            case 'num'
                test_signal(k) = k - 1;
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
            otherwise
                error('number of bank must be equal 4 because of stage writing points bank number must be 1,3,2,4');
        end
    end
end

if(strcmp(test, 'imp'))
    fclose(file_imp);
    clear file_imp;
end

if(strcmp(test, 'signal'))
    fclose(file_signal);
    clear file_signal;
end

clear max_freq; clear max_amp; clear max_phase; clear bias_freq;
clear line; clear k; clear signal;

%% fft (for check):
temp_fft = fft(test_signal, N)/N;

ram_fft(1:row, 1:N_bank) = zeros;
for i = 1:row
    ram_fft(i, 1:4) = real(temp_fft((1 + (i-1)*4) : (4*i))) - imag(temp_fft((1 + (i-1)*4) : (4*i)));
end
  
fft_line = real(temp_fft) - imag(temp_fft);

%% fht:
sin_x = load('sin.txt');
cos_x = load('cos.txt');

file_ram = fopen('init_ram.txt', 'w');
for i = 1 : row
    fprintf(file_ram, '%6.6f\t%6.6f\t%6.6f\t%6.6f\n', ram(i, :));
end
    
file_addr_rd = fopen('addr_rd.txt', 'w'); % for compare with rtl
file_addr_wr = fopen('addr_wr.txt', 'w');

w_amp = 2^(w_amp - 2); % minus bit expansion

for i = 1:row % 0 stage (only butterfly)
    temp = fht_double_but(  [ram(i, 1), ram(i, 2), 0],...
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
    
for stage = 1:last_stage % without 0 stage
	name = 'before_';
    name = strcat([name, mat2str(stage)]);
    name = strcat([name, 'st_ram.txt']);
    
    file_ram = fopen(name, 'w');
    for i = 1 : row
        fprintf(file_ram, '%6.6f\t%6.6f\t%6.6f\t%6.6f\n', ram(i, :));
    end
    fclose(file_ram);
    
    ram_buf(1:row, 1:N_bank) = 0;

    sector_size = 1;
	sector_cnt = 2;

	cos_cnt = 0;
	
	for j = 1:sector
        num_coef = bin2dec(fliplr(dec2bin(cos_cnt, bit_depth))) + 1;
        
		for i = (1 + (j-1)*2*div):(2*div + (j-1)*2*div)
			if(j == 1)
				temp = fht_double_but(  [ram(i, 1), ram(i, 2), ram(i, 2)],...
                                        [ram(i, 3), ram(i, 4), ram(i, 4)],...
                                        [sin_x(num_coef), cos_x(num_coef)],...
                                        [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                
                temp_input = [ram(i, 1), ram(i, 2), ram(i, 2), ram(i, 3), ram(i, 4), ram(i, 4)];
                
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			elseif(j == 2)
				temp = fht_double_but(  [ram(i, 2), ram(i, 1), ram(i, 3)],...
                                        [ram(i, 4), ram(i, 3), ram(i, 1)],...
                                        [sin_x(num_coef), cos_x(num_coef)],...
                                        [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                
                temp_input = [ram(i, 2), ram(i, 1), ram(i, 3), ram(i, 4), ram(i, 3), ram(i, 1)];
                                  
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			elseif(mod(j, 2) == 1) 
				temp = fht_double_but(  [ram(i, 1), ram(i, 2), ram(i + sector_cnt*2*div, 3)],...
                                        [ram(i, 3), ram(i, 4), ram(i + sector_cnt*2*div, 1)],...
                                        [sin_x(num_coef), cos_x(num_coef)],...
                                        [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                
                temp_input = [  ram(i, 1), ram(i, 2), ram(i + sector_cnt*2*div, 3),...
                                ram(i, 3), ram(i, 4), ram(i + sector_cnt*2*div, 1)];
                                   
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i + sector_cnt*2*div-1, i-1, i + sector_cnt*2*div-1, i-1);                 
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			else
				temp = fht_double_but(  [ram(i, 2), ram(i, 1), ram(i + sector_cnt*2*div, 4)],...
                                        [ram(i, 4), ram(i, 3), ram(i + sector_cnt*2*div, 2)],...
                                        [sin_x(num_coef), cos_x(num_coef)],...
                                        [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                
                temp_input = [  ram(i, 2), ram(i, 1), ram(i + sector_cnt*2*div, 4),...
                                ram(i, 4), ram(i, 3), ram(i + sector_cnt*2*div, 2)];
                                   
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i + sector_cnt*2*div-1, i-1, i + sector_cnt*2*div-1);
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
            end
            %{
            if(stage == last_stage)
                fprintf('x0 = %d, x1 = %d, x2 = %d; y0 = %d, y1 = %d, y2 = %d; num_coef = %d\n', temp_input, num_coef-1);
            end
            %}
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
file_ram = fopen('ram.txt', 'w');
file_fft_cp = fopen('fft_cp.txt', 'w'); % for compare in analys

for i = 1 : row
    fprintf(file_ram, '%6.6f\t%6.6f\t%6.6f\t%6.6f\n', ram(i, :));
end

for i = 1 : N
   fprintf(file_fft_cp, '%6.6f\n', fft_line(i)); 
end

fclose(file_ram); 
fclose(file_fft_cp); 

% save fixed point version of IMP RAM POS/NEG FHT for conv:
    if(strcmp(test, 'signal'))
        reg_ram = F_SAVE_REG_RAM(ram , d_bit, dir_reg_fht);
    elseif(strcmp(test, 'imp'))
        ram_p(1:row, 1:N_bank) = zeros;
        ram_n(1:row, 1:N_bank) = zeros;

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

        reg_ram_p = F_SAVE_REG_RAM(ram_p , imp_bit - 1, dir_reg_imp_p); % minus bit expansion for imp
        reg_ram_n = F_SAVE_REG_RAM(ram_n , imp_bit - 1, dir_reg_imp_n);
    end

clear temp; clear file_ram; clear file_fft_cp;

%% get norm order in RAM for compare FFT and FHT:
% from matrix to line:
    cnt = 1;
    clear ram_buf;
    ram_buf(1:N) = 0;

    for i = 1:row
        ram_buf((1 + (i-1)*4) : (4*i)) = ram(i, 1:4);
        cnt = cnt + 1;
    end

% change index order (bit reverse):
    cnt = 1;
    ram_fht(1:row, 1:N_bank) = 0;
    
    fht_line(1:N) = 0;
    for i = 1:row
        ram_fht(i, 1:4) = [ram_buf(bin2dec(fliplr(dec2bin(cnt-1, last_stage+1))) + 1),... % cnt+0-1
                           ram_buf(bin2dec(fliplr(dec2bin(cnt,	 last_stage+1))) + 1),... % cnt+1-1
                           ram_buf(bin2dec(fliplr(dec2bin(cnt+1, last_stage+1))) + 1),... % cnt+2-1
                           ram_buf(bin2dec(fliplr(dec2bin(cnt+2, last_stage+1))) + 1)];   % cnt+3-1
                           
        fht_line((1 + (i-1)*4) : (4*i)) = ram_fht(i, :);
        cnt = cnt + 4;
    end

    clear cnt;

err_line = abs(fft_line - fht_line)*100/max(abs(fht_line));  % in precent
err_line_buf = err_line;

i = 1;
[max_err(i), ind_max_err(i)] = max(err_line_buf);
err_line_buf(ind_max_err(i)) = 0;

while(max_err(i) > threshold)
    i = i + 1;

    [max_err(i), ind_max_err(i)] = max(err_line_buf);
    err_line_buf(ind_max_err(i)) = 0;
end

if((i ~= 1) && (save_err_ind == 'Y'))
    file_err = fopen('err_ind.txt', 'a');

    ind_max_err = sort(ind_max_err);
    for i = 1:length(ind_max_err)
        fprintf(file_err, '%d\n', ind_max_err(i));
    end
    
    fclose(file_err);
    clear file_err;
end

fclose('all');
    
%% graphics:
figure;
    plot(time, test_signal);
title('Test signal:');
xlabel('Time, sec');
ylabel('Amp');
grid on;
clear time;

figure;
subplot(2,1,1);
    plot((0 : N - 1), fft_line, '+-', 'MarkerSize', 2);
hold on;
    plot((0 : N - 1), fht_line, 'o-', 'MarkerSize', 2);
xlim([0 N]);
title('Compare FHT and FFT:');
xlabel('Num of point');
ylabel('Amp');
legend(['FFT'; 'FHT']);
grid on;

subplot(2,1,2);
    plot((0 : N - 1), err_line, 'o-', 'MarkerSize', 2);
xlim([0 N]);
title('Error:');
xlabel('Num of point');
ylabel('Precent');
grid on;

figure; % zoom x8 times
subplot(2,1,1);
    plot((0 : N - 1), fft_line, '+-', 'MarkerSize', 2);
hold on;
    plot((0 : N - 1), fht_line, 'o-', 'MarkerSize', 2);
xlim([0 N/8 - 1]);
title('Compare FHT and FFT:');
xlabel('Num of point');
ylabel('Amp');
legend(['FFT'; 'FHT']);
grid on;

subplot(2,1,2);
    plot((0 : N - 1), err_line, 'o-', 'MarkerSize', 2);
xlim([0 N/8 - 1]);
title('Error:');
xlabel('Num of point');
ylabel('Precent');
grid on;