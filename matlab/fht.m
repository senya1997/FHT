clear;
clc;

% choose test signal:
    test = 'sin';
    %test = 'const';
    %test = 'num';

% variables:
file_def = fopen('../fht_defines.v', 'r');
flag_N = 0;
flag_w_amp = 0;

while(~feof(file_def))
    line = fgetl (file_def);
    
    if(length(line) > 12)
        if(line(1:9) == '`define N ')
            N = str2double(line(11:14));
            flag_N = 1;
        end

        if(line(1:13) == '`define W_BIT ')
            w_amp = str2double(line(15:16));
            flag_w_amp = 1;
        end       
    end
end

if(~flag_N || ~flag_w_amp)
    error('Error while reading defines: N and W_MAX\n');
end

clear line; clear file_def;
clear flag_N; clear flag_w_amp;

w_amp = 2^(w_amp - 2);
Fd = 44100;
bias = 0;
    
amp(1:3) = [round(rand()*15000), round(rand()*15000), round(rand()*15000)];
frequency(1:3) = [100 + round(rand()*1000), 100 + round(rand()*3000), 100 + round(rand()*5000)];
phase(1:3) = [round(rand()*180), round(rand()*180), round(rand()*180)];

%% get input data
N_bank = 4;
row = N/N_bank; % necessarily integer

time = 0 : 1/Fd : (N - 1)/Fd;
signal = bias + amp(1)*sind((frequency(1)*360).* time + phase(1)) +...
                amp(2)*sind((frequency(2)*360).* time + phase(2)) +...
                amp(3)*sind((frequency(3)*360).* time + phase(3));
 
if(strcmp(test, 'sin'))
    fprintf('signal test\n');
    fprintf('amp_1 = %d, amp_2 = %d, amp_3 = %d\nfreq_1 = %d, freq_2 = %d, freq_3 = %d\nphase_1 = %d, phase_2 = %d, phase_3 = %d\n',...
             amp, frequency, phase);
elseif(strcmp(test, 'const'))
    fprintf('const test\n');
elseif(strcmp(test, 'num'))
    fprintf('index number test\n');
else
    error('"test" is wrong\n');
end

k = 0;
ram(1:row, 1:N_bank) = zeros;
test_signal(1:N) = zeros;

for i = 1:N_bank
    for j = 1:row
        k = k + 1;
        
        if(strcmp(test, 'sin'))
            test_signal(k) = round(signal(k));
        elseif(strcmp(test, 'const'))
            test_signal(k) = 100;
        elseif(strcmp(test, 'num'))
            test_signal(k) = k - 1;
        end
        
        if(N_bank == 4)
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
        else
            error('number of bank must be equal 4 because of stage writing points bank number must be 1,3,2,4');
        end
    end
end

clear k;
clear signal;

figure;
    title('Test signal:');
    plot(time, test_signal);
grid on;
    
clear time;

%% fft (for check):
temp_fft = fft(test_signal, N)/N;

ram_fft(1:row, 1:N_bank) = zeros;
for i = 1:row
    ram_fft(i, 1:4) = real(temp_fft((1 + (i-1)*4) : (4*i))) - imag(temp_fft((1 + (i-1)*4) : (4*i)));
end
  
%% fht:
sin_x = load('sin.txt');
cos_x = load('cos.txt');

file_ram = fopen('init_ram.txt', 'w');
for i = 1 : row
    fprintf(file_ram, '%4d\t%4d\t%4d\t%4d\n', ram(i, :));
end
    
file_addr_rd = fopen('addr_rd.txt', 'w'); % for compare with rtl
file_addr_wr = fopen('addr_wr.txt', 'w');

for i = 1:row % 0 stage (only butterfly)
    temp = fht_double_but([ram(i, 1), ram(i, 2), 0], [ram(i, 3), ram(i, 4), 0], [sin_x(1), sin_x(1)],...
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
	name = 'before_xst_ram.txt';
    name(8) = mat2str(stage);
    
    file_ram = fopen(name, 'w');
    for i = 1 : row
        fprintf(file_ram, '%4d\t%4d\t%4d\t%4d\n', ram(i, :));
    end

    ram_buf(1:row, 1:N_bank) = zeros;

    sector_size = 1;
	sector_cnt = 2;

	cos_cnt = 0;
	
	for j = 1:sector
        num_coef = bin2dec(fliplr(dec2bin(cos_cnt, bit_depth))) + 1;
        
		for i = (1 + (j-1)*2*div):(2*div + (j-1)*2*div)
			if(j == 1)
				temp = fht_double_but([ram(i, 1), ram(i, 2), ram(i, 2)], [ram(i, 3), ram(i, 4), ram(i, 4)],...
                            [sin_x(num_coef), cos_x(num_coef)], [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			elseif(j == 2)
				temp = fht_double_but([ram(i, 2), ram(i, 1), ram(i, 3)], [ram(i, 4), ram(i, 3), ram(i, 1)],...
                            [sin_x(num_coef), cos_x(num_coef)], [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			elseif(mod(j, 2) == 1)
				temp = fht_double_but([ram(i, 1), ram(i, 2), ram(i + sector_cnt*2*div, 3)],...
                                      [ram(i, 3), ram(i, 4), ram(i + sector_cnt*2*div, 1)],...
                                      [sin_x(num_coef), cos_x(num_coef)],...
                                      [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                                   
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i + sector_cnt*2*div-1, i-1, i + sector_cnt*2*div-1, i-1);                 
                fprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			else
				temp = fht_double_but([ram(i, 2), ram(i, 1), ram(i + sector_cnt*2*div, 4)],...
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

file_ram = fopen('ram.txt', 'w');
for i = 1 : row
    fprintf(file_ram, '%4d\t%4d\t%4d\t%4d\n', ram(i, :));
end

clear temp;

fclose(file_addr_rd); 
fclose(file_addr_wr); 

%% get norm order in RAM
% from matrix to row:
    cnt = 1;
    clear ram_buf;
    ram_buf(1:N) = zeros;

    for i = 1:row
        ram_buf((1 + (i-1)*4) : (4*i)) = ram(i, 1:4);
        cnt = cnt + 1;
    end

% change index order (bit reverse):
    cnt = 1;
    ram_fht(1:row, 1:N_bank) = zeros;
    
    fft_line = round(real(temp_fft) - imag(temp_fft));
    fht_line(1:N) = zeros;
    
    for i = 1:row
        ram_fht(i, 1:4) = [ram_buf(bin2dec(fliplr(dec2bin(cnt-1, last_stage+1))) + 1),... % cnt+0-1
                           ram_buf(bin2dec(fliplr(dec2bin(cnt, last_stage+1))) + 1),...   % cnt+1-1
                           ram_buf(bin2dec(fliplr(dec2bin(cnt+1, last_stage+1))) + 1),... % cnt+2-1
                           ram_buf(bin2dec(fliplr(dec2bin(cnt+2, last_stage+1))) + 1)];   % cnt+3-1
        
       fht_line((1 + (i-1)*4) : (4*i)) = ram_fht(i, :);
       cnt = cnt + 4;
    end

    clear cnt;

    ram_err = abs(ram_fft - ram_fht);
    err_line = abs(fft_line - fht_line);
    
figure;
title('Compare FHT and FFT with error (abs value of substract):');
    plot(fft_line);
hold on;
    plot(fht_line, 'g');
hold on;
    plot(err_line, 'r');        
legend('FFT', 'FHT', 'Error');
grid on;

figure;
title('Error:');
    plot(err_line);
grid on;

fclose('all');