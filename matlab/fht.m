clear;
clc;

close all;

%% choose test signal:
    %test = 'sin';       % sine in 3 harmonics
    %test = 'imp';      % impulse response
    test = 'signal';   % real signal from 'wav'
    %test = 'const';    % const bias
    %test = 'num';      % linear increase signal from '0' to 'N - 1'

%% variables:
file_def = fopen('../fht_defines.v', 'r');

dir_imp =       '../../gcpu/matlab/conv/h.txt'; % size Nh
dir_signal =    '../../gcpu/matlab/conv/x.txt'; % size Nx

N_bank = 4; % defines by architecture of transform in FPGA (don't change for this config)

Fd = 44100;
bias = 0;

rand_sin = 'Y'; % generate rand sine harm or determine by defined value (Y/N)
max_amp = 10922; % signed 16 bit ADC <=> 32767/3, cause pseudorand signal have 3 harmonic

max_freq_1 = 1000; % in Hz
max_freq_2 = 2000;
max_freq_3 = 5000;

bias_freq = 100; % in Hz
max_phase = 180; % in grad

threshold = 0.2; % in precent max error between FFT and FHT that save index of error data
save_err_ind = 'Y'; % save index of error data in file (Y/N, append to exist file)

%% read files:
flag_N = 0;

flag_Nx = 0;
flag_Nh = 0;

flag_w_amp = 0;

while(~feof(file_def))
    line = fgetl(file_def);
    
    if(length(line) > 12)
        if(strcmp(line(1:10), '`define N '))
            N = str2double(line(11:14));
            flag_N = 1;
        end

        if(strcmp(line(1:11), '`define Nx '))
            Nx = str2double(line(12:15));
            flag_Nx = 1;
        end

        if(strcmp(line(1:11), '`define Nh '))
            Nh = str2double(line(12:15));
            flag_Nh = 1;
        end
        
        if(strcmp(line(1:14), '`define W_BIT '))
            w_amp = str2double(line(15:16));
            flag_w_amp = 1;
        end       
    end
end

if(~flag_N || ~flag_w_amp || ~flag_Nx || ~flag_Nh)
    error('Error while reading defines');
end

fclose(file_def);

clear file_def; clear len_line;
clear flag_N; clear flag_Nx; clear flag_Nh; clear flag_w_amp;

w_amp = 2^(w_amp - 2);

%% get input data
amp(1:3) = [round(rand()*max_amp),...
            round(rand()*max_amp),...
            round(rand()*max_amp)];
        
frequency(1:3) = [  bias_freq + round(rand()*max_freq_1),...
                    bias_freq + round(rand()*max_freq_2),...
                    bias_freq + round(rand()*max_freq_3)];
                
phase(1:3) = [  round(rand()*max_phase),...
                round(rand()*max_phase),...
                round(rand()*max_phase)];

if(rand_sin == 'N')
    amp(1:3)        = [round(max_amp), round(max_amp/2), round(max_amp/4)];
    frequency(1:3)	= [max_freq_1, max_freq_2, max_freq_3];
    phase(1:3)      = [max_phase, max_phase, max_phase];
end
            
clear max_amp; clear max_phase; clear bias_freq;
clear max_freq_1; clear max_freq_2; clear max_freq_3;

time = 0 : 1/Fd : (N - 1)/Fd;
signal = bias + amp(1)*sind((frequency(1)*360).* time + phase(1)) +...
                amp(2)*sind((frequency(2)*360).* time + phase(2)) +...
                amp(3)*sind((frequency(3)*360).* time + phase(3));

switch(test)
    case 'sin'
        fprintf('\nsignal test\n\n');
        fprintf('amp_1 = %d,\tamp_2 = %d,\tamp_3 = %d\nfreq_1 = %d,\tfreq_2 = %d,\tfreq_3 = %d\nphase_1 = %d,\tphase_2 = %d,\tphase_3 = %d\n',...
                amp, frequency, phase);
    case 'imp'
        fprintf('\nimpulse test\n\n');
        file_imp = fopen(dir_imp, 'r');         % 'h.txt' must be autogenerated, cause 'Nh' defines in 'fht_defines.v'
    case 'signal'
        fprintf('\nsignal test\n\n');
        file_signal = fopen(dir_signal, 'r');	% 'x.txt' must be autogenerated, cause 'Nx' defines in 'fht_defines.v'
    case 'const'
        fprintf('\nconst test\n\n');
    case 'num'
        fprintf('\nindex number test\n\n');
    otherwise
        error('test var is wrong');
end

k = 0;
row = N/N_bank; % necessarily integer

ram(1:row, 1:N_bank) = 0;
test_signal(1:N) = 0;

for i = 1:N_bank
    for j = 1:row
        k = k + 1;
        
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
end

if(strcmp(test, 'signal'))
    fclose(file_signal);
end

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

file_ram = fopen('ram.txt', 'w');
file_fft_cp = fopen('fft_cp.txt', 'w'); % for compare in analys

for i = 1 : row
    fprintf(file_ram, '%6.6f\t%6.6f\t%6.6f\t%6.6f\n', ram(i, :));
end

for i = 1 : N
   fprintf(file_fft_cp, '%6.6f\n', fft_line(i)); 
end

fclose(file_addr_rd); 
fclose(file_addr_wr); 

fclose(file_ram); 
fclose(file_fft_cp); 

clear file_addr_rd; clear file_addr_wr;
clear temp; clear file_ram; clear file_fft_cp;

%% get norm order in RAM
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
    
%% graphics
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
xlabel('Num point');
ylabel('Amp');
legend(['FFT'; 'FHT']);
grid on;

subplot(2,1,2);
    plot((0 : N - 1), err_line, 'o-', 'MarkerSize', 2);
xlim([0 N]);
title('Error:');
xlabel('Num point');
ylabel('Precent');
grid on;

figure; % zoom x8 times
subplot(2,1,1);
    plot((0 : N - 1), fft_line, '+-', 'MarkerSize', 2);
hold on;
    plot((0 : N - 1), fht_line, 'o-', 'MarkerSize', 2);
xlim([0 N/8 - 1]);
title('Compare FHT and FFT:');
xlabel('Num point');
ylabel('Amp');
legend(['FFT'; 'FHT']);
grid on;

subplot(2,1,2);
    plot((0 : N - 1), err_line, 'o-', 'MarkerSize', 2);
xlim([0 N/8 - 1]);
title('Error:');
xlabel('Num point');
ylabel('Precent');
grid on;