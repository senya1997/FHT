function fht = fht(test)

clearvars -except test
clc;
close all;

diary LOG_MATLAB.txt
fprintf('\n\t%s\n', datestr(datetime));
glob_path;

fprintf('\n===================================================\n');
fprintf('=              Fast Hartley transform             =\n');
fprintf('===================================================\n');

%% choose test signal (if test mixer is enabled - test signal is number):
    %test = 'sin';      % sine in 3 harmonics
    %test = 'imp';      % impulse response
    %test = 'signal';   % real signal from 'wav'
    %test = 'const';    % const bias
    
%% variables:
rand_sin        = 'Y'; % generate rand sine harm or determine by defined value (Y/N)
save_err_ind	= 'Y'; % save index of error data in file (Y/N, append to exist file)
normalize_input	= 'Y'; % required normalize input signal in ADC bit width (Y/N)

N_bank = 4; % defines by architecture of transform in FPGA (don't change for this config)

Fd = 44100;
bias = 100;

max_amp = 10922; % if normalize not using - signed 16 bit ADC <=> 32767/3, cause pseudorand signal have 3 harmonic
max_freq = 1000; % in Hz
max_phase = 180; % in grad

bias_freq = 100; % in Hz
threshold = 0.2; % in precent max error between FFT and FHT that save index of error data

global dir_def;
 
global dir_sin_coef;
global dir_cos_coef;
 
% dir of input signal sample and impulses:
    global dir_imp; % size Nh
    global dir_signal; % size Nx

% save reg ver of files for init FPGA RAM in tb:    
    global dir_init_fht;
    global dir_init_conv;    
    global dir_init_imp_p; 
    global dir_init_imp_n;

% dir output math:
    global dir_math_fht_ram;
    global dir_math_fft_line;
    global dir_math_err_ind;
    
    global dir_math_addr_rd;
    global dir_math_addr_wr;
    
% read files:
    N       = F_READ_DEFINE(dir_def, 'N');
    Nx      = F_READ_DEFINE(dir_def, 'Nx');
    Nh      = F_READ_DEFINE(dir_def, 'Nh');
    row     = F_READ_DEFINE(dir_def, 'BANK_SIZE');
    d_bit	= F_READ_DEFINE(dir_def, 'D_BIT');
    imp_bit	= F_READ_DEFINE(dir_def, 'IMP_BIT');
    w_amp	= F_READ_DEFINE(dir_def, 'MAX_W');
    adc_amp	= F_READ_DEFINE(dir_def, 'MAX_ADC_D');

% check test mixer define:
    test_mix = F_DEFINE_EXIST(dir_def, 'TEST_MIXER');

    if(test_mix)
        fprintf('\nWARNING: Test of mixers is enabled\n');
        test = 'num'; % linear increase signal from '0' to 'N - 1'
    end
    
fprintf('\nInput data:\n');
fprintf('\tNum of point transform (N)\t\t\t= %d\n',     N);
fprintf('\tNum of point signal in RAM (Nx)\t\t= %d\n',	Nx);
fprintf('\tNum of point impulses in RAM (Nh)\t= %d\n',	Nh);
fprintf('\tRAM bank size\t= %d\n',          row);
fprintf('\tData width\t\t= %d\n',           d_bit);
fprintf('\tImpulse coef width\t\t= %d\n',   imp_bit);
fprintf('\tAmp of Sin/Cos coef\t\t= %d\n',  w_amp);
fprintf('\tAmp of input signal on ADC\t\t= %d\n',  adc_amp);

%% get input data:
fprintf('\nGet input data...\n');

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
    
        fprintf('\tTest type: pure signal(sine) test\n');
        fprintf('\n\tamp_1 = %d,\tamp_2 = %d,\tamp_3 = %d\n\tfreq_1 = %d,\tfreq_2 = %d,\tfreq_3 = %d\n\tphase_1 = %d,\tphase_2 = %d,\tphase_3 = %d\n',...
                amp, freq, phase);
    case 'imp'
        fprintf('\tTest type: impulse test\n');
        file_imp = fopen(dir_imp, 'r');
        
        if(file_imp == -1)
           error('Error: file does not exist "%s"', dir_imp);
        end
    case 'signal'
        fprintf('\tTest type: signal test\n');
        file_signal = fopen(dir_signal, 'r');
        
        if(file_signal == -1)
           error('Error: file does not exist "%s"', dir_signal); 
        end
    case 'const'
        fprintf('\tTest type: const test\n');
    case 'num'
        fprintf('\tTest type: index number test\n');
    otherwise
        error('Test type var is wrong');
end

%% get input RAM for start FHT:
fprintf('\nForming input RAM for FHT...');

k = 0;
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
                error('Number of bank must be equal 4 (writing points bank number must be 1,3,2,4)');
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

% normalize signal in FPGA bit width (if needed)
    if(normalize_input == 'Y')
        fprintf('\n\tNormalize input signal\n');
        
        max_amp = max(abs(test_signal));
        
        norm_coef_p = (adc_amp - 1)/max_amp;
        norm_coef_n = adc_amp/max_amp;
        
        if(max_amp >= adc_amp)
            for i = 1:N_bank
                for j = 1:row
                    if(ram(j, i) < 0)
                        ram(j, i) = round(ram(j, i)*norm_coef_n);
                    else
                        ram(j, i) = round(ram(j, i)*norm_coef_p);
                    end
                end
            end
            
            for i = 1:N
                if(test_signal(i) < 0)
                    test_signal(i) = round(test_signal(i)*norm_coef_n);
                else
                    test_signal(i) = round(test_signal(i)*norm_coef_p);
                end
            end
        end
    end

clear max_freq; clear max_amp; clear max_phase; clear bias_freq;
clear line; clear k; clear signal;
clear norm_coef_p; clear norm_coef_n; clear max_amp;

%% fft (for check):
fprintf('\nStart reference FFT for check correctness of the FHT...');

temp_fft = fft(test_signal, N)/N;
fft_line = real(temp_fft) - imag(temp_fft);

clear temp_fft;

%% fht:
fprintf('\nStart FPGA model of FHT...\n');

sin_x = load(dir_sin_coef);
cos_x = load(dir_cos_coef);

file_ram = fopen(dir_init_fht, 'w');

if(file_ram ~= -1)
	for i = 1 : row
        fprintf(file_ram, '%6.6f\t%6.6f\t%6.6f\t%6.6f\n', ram(i, :));
	end
else
    error('Error: file name is wrong "%s"', dir_init_fht);
end

file_addr_rd = fopen(dir_math_addr_rd, 'w'); % for compare with rtl
if(file_addr_rd == -1)
	error('Error: file name is wrong "%s"', dir_math_addr_rd); 
end

file_addr_wr = fopen(dir_math_addr_wr, 'w');
if(file_addr_wr == -1)
	error('Error: file name is wrong "%s"', dir_math_addr_wr); 
end

for i = 1:row % 0 stage (only butterfly)
    temp = F_FHT_BUT(test_mix, [ram(i, 1), ram(i, 2), 0],...
                               [ram(i, 3), ram(i, 4), 0],...
                               [sin_x(1), sin_x(1)],...
                               [cos_x(1), cos_x(1)], w_amp);
    ram(i, :) = [temp(1), temp(3), temp(2), temp(4)];

    fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1); % every second tact
    fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);

    fprintf(file_addr_wr, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
end

last_stage = log(N)/log(2) - 1; % numbers start from zero
fprintf('\n\tTotal num of stages transform: %d\n', last_stage);

% init coef for 1st stage:
    bit_depth = log(row)/log(2) - 2; % bit depth of ROM data: [A_BIT - 3 : 0]	
    div = N/(2*N_bank);
    sector = 1;
    
for stage = 1:last_stage % without 0 stage
    fprintf('\t\tCurrent stage transform: %d\n', stage);
    
	name = 'before_';
    name = strcat([name, mat2str(stage)]);
    name = strcat([name, 'st_ram.txt']);
    
    file_ram = fopen(name, 'w');
    if(file_ram == -1)
        error('Error: file name is wrong "%s"', name); 
    end

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
				temp = F_FHT_BUT(test_mix, [ram(i, 1), ram(i, 2), ram(i, 2)],...
                                           [ram(i, 3), ram(i, 4), ram(i, 4)],...
                                           [sin_x(num_coef), cos_x(num_coef)],...
                                           [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                
                %temp_input = [ram(i, 1), ram(i, 2), ram(i, 2), ram(i, 3), ram(i, 4), ram(i, 4)];
                
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			elseif(j == 2)
				temp = F_FHT_BUT(test_mix, [ram(i, 2), ram(i, 1), ram(i, 3)],...
                                           [ram(i, 4), ram(i, 3), ram(i, 1)],...
                                           [sin_x(num_coef), cos_x(num_coef)],...
                                           [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                
                %temp_input = [ram(i, 2), ram(i, 1), ram(i, 3), ram(i, 4), ram(i, 3), ram(i, 1)];
                                  
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			elseif(mod(j, 2) == 1) 
				temp = F_FHT_BUT(test_mix, [ram(i, 1), ram(i, 2), ram(i + sector_cnt*2*div, 3)],...
                                           [ram(i, 3), ram(i, 4), ram(i + sector_cnt*2*div, 1)],...
                                           [sin_x(num_coef), cos_x(num_coef)],...
                                           [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                
                %temp_input = [  ram(i, 1), ram(i, 2), ram(i + sector_cnt*2*div, 3),...
                %                ram(i, 3), ram(i, 4), ram(i + sector_cnt*2*div, 1)];
                                   
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i + sector_cnt*2*div-1, i-1, i + sector_cnt*2*div-1, i-1);                 
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			else
				temp = F_FHT_BUT(test_mix, [ram(i, 2), ram(i, 1), ram(i + sector_cnt*2*div, 4)],...
                                           [ram(i, 4), ram(i, 3), ram(i + sector_cnt*2*div, 2)],...
                                           [sin_x(num_coef), cos_x(num_coef)],...
                                           [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                
                %temp_input = [ram(i, 2), ram(i, 1), ram(i + sector_cnt*2*div, 4),...
                %              ram(i, 4), ram(i, 3), ram(i + sector_cnt*2*div, 2)];
                                   
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
fprintf('\nSave output RAM after transform for tb...');

file_ram = fopen(dir_math_fht_ram, 'w');
if(file_ram ~= -1)
    for i = 1 : row
        fprintf(file_ram, '%6.6f\t%6.6f\t%6.6f\t%6.6f\n', ram(i, :));
    end
    fclose(file_ram); 
else
    error('Error: file name is wrong "%s"', dir_math_fht_ram); 
end

file_fft_cp = fopen(dir_math_fft_line, 'w'); % for compare in analys
if(file_fft_cp ~= -1)
    for i = 1 : N
        fprintf(file_fft_cp, '%6.6f\n', fft_line(i)); 
    end
    fclose(file_fft_cp);
else
    error('Error: file name is wrong "%s"', dir_math_fft_line); 
end

% save fixed point version of IMP RAM POS/NEG FHT for conv:
    if(strcmp(test, 'signal'))
        fprintf('\nSave integer (reg) version output RAM signal for FPGA...');
        
        F_SAVE_REG_RAM(ram, d_bit, dir_init_conv);
    elseif(strcmp(test, 'imp'))
        fprintf('\nSave integer (reg) version output RAM impulses for FPGA...');
        
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

        F_SAVE_REG_RAM(ram_p, imp_bit, dir_init_imp_p); % minus bit expansion for imp
        F_SAVE_REG_RAM(ram_n, imp_bit, dir_init_imp_n);
    end

clear temp; clear file_ram; clear file_fft_cp;

%% get norm order in RAM for compare FFT and FHT:
fprintf('\nCalc error between FFT and FHT for compare...');

fht_line = F_FHT_RAM_TO_LINE(ram);

err_line = F_ABS_ERR_LINE(fft_line, fht_line);  % in precent
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
    file_err = fopen(dir_math_err_ind, 'a');

    if(file_err == -1)
        error('Error: file name is wrong "%s"', dir_math_err_ind); 
    end
    
    ind_max_err = sort(ind_max_err);
    for i = 1:length(ind_max_err)
        fprintf(file_err, '%d\n', ind_max_err(i));
    end
    
    fclose(file_err);
    clear file_err;
end

fclose('all');
    
%% graphics:
fprintf('\nPrint and save graphics...\n');

fig_test = figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
    plot(time, test_signal);
title('Test signal:');
xlabel('Time, sec');
ylabel('Amp');
grid on;
clear time;

fig_fht = figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
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

fig_fht_zoom = figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]); % zoom x8 times
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

saveas(fig_test, 'screen/fht_test_signal', 'png'); 
saveas(fig_fht, 'screen/fht_cmp_fft', 'png'); 
saveas(fig_fht_zoom, 'screen/fht_cmp_fft_zoom', 'png'); 

%close(fig_test);
%close(fig_fht);
%close(fig_fht_zoom);

fprintf('\n===================================================\n');
fprintf('=                    Complete                     =\n');
fprintf('===================================================\n');

fht = 0;