clear;
mclose('all');
clc;

// choose test signal:
    test = 'sin';
    //test = 'const';
    //test = 'num';

// variables:
file_def = mopen('../fht_defines.v', 'r');
flag_N = 0;
flag_w_amp = 0;

line = mgetl(file_def);
len_line = size(line);

for i = 1:len_line(1)
    if(strstr(line(i), '`define N ') ~= '') then
        N = part(line(i), 11:14);
        [N, endstr] = strtod(N);
        flag_N = 1;
    end

    if(strstr(line(i), '`define W_BIT ') ~= '') then
        w_amp = part(line(i), 15:16);
        [w_amp, endstr] = strtod(w_amp);
        flag_w_amp = 1;
    end
end

if(~flag_N || ~flag_w_amp) then
    error('Error while reading defines: N and W_MAX');
end

clear line; clear file_def; clear len_line;
clear flag_N; clear flag_w_amp;

w_amp = 2^(w_amp - 2);
Fd = 44100;
bias = 0;

/************************************ get input data ************************************/

amp(1:3) = [round(rand()*15000), round(rand()*15000), round(rand()*15000)];
frequency(1:3) = [100 + round(rand()*1000), 100 + round(rand()*3000), 100 + round(rand()*5000)];
phase(1:3) = [round(rand()*180), round(rand()*180), round(rand()*180)];

exec('fht_double_but.sci');

N_bank = 4;
row = N/N_bank; // necessarily integer

time = 0 : 1/Fd : (N - 1)/Fd;
signal = bias + amp(1)*sind((frequency(1)*360).* time + phase(1)) + amp(2)*sind((frequency(2)*360).* time + phase(2)) + amp(3)*sind((frequency(3)*360).* time + phase(3));

if(strcmp(test, 'sin') == 0) then
    mprintf('\nsignal test\n\n');
    mprintf('amp_1 = %d, amp_2 = %d, amp_3 = %d\nfreq_1 = %d, freq_2 = %d, freq_3 = %d\nphase_1 = %d, phase_2 = %d, phase_3 = %d\n', amp, frequency, phase);
elseif(strcmp(test, 'const') == 0) then
    mprintf('\nconst test\n\n');
elseif(strcmp(test, 'num') == 0) then
    mprintf('\nindex number test\n\n');
else
    error('\ntest var is wrong\n\n');
end

k = 0;
ram(1:row, 1:N_bank) = 0;
test_signal(1:N) = 0;

//pause;

for i = 1:N_bank
    for j = 1:row
        k = k + 1;
        
        if(strcmp(test, 'sin') == 0) then
            test_signal(k) = round(signal(k));
        elseif(strcmp(test, 'const') == 0) then
            test_signal(k) = 100;
        elseif(strcmp(test, 'num') == 0) then
            test_signal(k) = k - 1;
        end
        
        if(N_bank == 4) then
            select(i)
                case 1 then
                    ram(j, 1) = test_signal(k);
                case 2 then
                    ram(j, 3) = test_signal(k);
                case 3 then
                    ram(j, 2) = test_signal(k);
                case 4 then
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
xgrid(2);

clear time;

/************************************ fft (for check): ************************************/

temp_fft = fft(test_signal)/N;

ram_fft(1:row, 1:N_bank) = 0;
for i = 1:row
    ram_fft(i, 1:4) = real(temp_fft((1 + (i-1)*4) : (4*i))) - imag(temp_fft((1 + (i-1)*4) : (4*i)));
end

/****************************************** fht: ******************************************/

sin_x = mgetl('sin.txt');
    [sin_x, endstr] = strtod(sin_x);
cos_x = mgetl('cos.txt');
    [cos_x, endstr] = strtod(cos_x);

file_ram = mopen('init_ram.txt', 'w');
for i = 1 : row
    mfprintf(file_ram, '%4d\t%4d\t%4d\t%4d\n', ram(i, :));
end
    
file_addr_rd = mopen('addr_rd.txt', 'w'); // for compare with rtl
file_addr_wr = mopen('addr_wr.txt', 'w');

for i = 1:row // 0 stage (only butterfly)
    temp = fht_double_but([ram(i, 1), ram(i, 2), 0], [ram(i, 3), ram(i, 4), 0], [sin_x(1), sin_x(1)], [cos_x(1), cos_x(1)], w_amp);
    ram(i, :) = [temp(1), temp(3), temp(2), temp(4)];

    mfprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1); // every second tact
    mfprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);

    mfprintf(file_addr_wr, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
end

last_stage = log(N)/log(2) - 1; // numbers start from zero

// init coef for 1st stage:
    bit_depth = log(row)/log(2) - 2; // bit depth of ROM data: [A_BIT - 3 : 0]	
    div = N/(2*N_bank);
    sector = 1;
    
for stage = 1:last_stage // without 0 stage
	name = 'before_';
    name = strcat([name, string(stage)]);
    name = strcat([name, 'st_ram.txt']);
    
    file_ram = mopen(name, 'w');
    for i = 1 : row
        mfprintf(file_ram, '%4d\t%4d\t%4d\t%4d\n', ram(i, :));
    end

    ram_buf(1:row, 1:N_bank) = 0;

    sector_size = 1;
	sector_cnt = 2;

	cos_cnt = 0;
	
	for j = 1:sector
        num_coef = bin2dec(mtlb_fliplr(dec2bin(cos_cnt, bit_depth))) + 1;
        
		for i = (1 + (j-1)*2*div):(2*div + (j-1)*2*div)
			if(j == 1) then
				temp = fht_double_but([ram(i, 1), ram(i, 2), ram(i, 2)], [ram(i, 3), ram(i, 4), ram(i, 4)], [sin_x(num_coef), cos_x(num_coef)], [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                
                temp_input = [ram(i, 1), ram(i, 2), ram(i, 2), ram(i, 3), ram(i, 4), ram(i, 4)];
                
                mfprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
                mfprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			elseif(j == 2) then
				temp = fht_double_but([ram(i, 2), ram(i, 1), ram(i, 3)], [ram(i, 4), ram(i, 3), ram(i, 1)], [sin_x(num_coef), cos_x(num_coef)], [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                
                temp_input = [ram(i, 2), ram(i, 1), ram(i, 3), ram(i, 4), ram(i, 3), ram(i, 1)];
                                  
                mfprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
                mfprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			elseif(pmodulo(j, 2) == 1) then
				temp = fht_double_but([ram(i, 1), ram(i, 2), ram(i + sector_cnt*2*div, 3)], [ram(i, 3), ram(i, 4), ram(i + sector_cnt*2*div, 1)], [sin_x(num_coef), cos_x(num_coef)], [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                
                temp_input = [ram(i, 1), ram(i, 2), ram(i + sector_cnt*2*div, 3), ram(i, 3), ram(i, 4), ram(i + sector_cnt*2*div, 1)];
                                   
                mfprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i + sector_cnt*2*div-1, i-1, i + sector_cnt*2*div-1, i-1);                 
                mfprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			else
				temp = fht_double_but([ram(i, 2), ram(i, 1), ram(i + sector_cnt*2*div, 4)], [ram(i, 4), ram(i, 3), ram(i + sector_cnt*2*div, 2)], [sin_x(num_coef), cos_x(num_coef)], [cos_x(num_coef), -sin_x(num_coef)], w_amp);
                
                temp_input = [ram(i, 2), ram(i, 1), ram(i + sector_cnt*2*div, 4), ram(i, 4), ram(i, 3), ram(i + sector_cnt*2*div, 2)];
                                   
                mfprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i + sector_cnt*2*div-1, i-1, i + sector_cnt*2*div-1);
                mfprintf(file_addr_rd, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
            end
            /*
            if(stage == last_stage) then
                mprintf('x0 = %d, x1 = %d, x2 = %d; y0 = %d, y1 = %d, y2 = %d; num_coef = %d\n', temp_input, num_coef-1);
            end
            */
			if(stage == last_stage) then
				ram_buf(i, 1) = temp(1);
				ram_buf(i, 2) = temp(2);
				ram_buf(i, 3) = temp(3);
				ram_buf(i, 4) = temp(4);
                
                mfprintf(file_addr_wr, '%4d\t%4d\t%4d\t%4d\n', i-1, i-1, i-1, i-1);
			elseif(i > (div + (j-1)*2*div)) then
				ram_buf(i - div, 2) = temp(1);
				ram_buf(i - div, 4) = temp(2);
				ram_buf(i, 1) = temp(3);
				ram_buf(i, 3) = temp(4);
                
                mfprintf(file_addr_wr, '%4d\t%4d\t%4d\t%4d\n', i-1, i - div - 1, i-1, i - div - 1 );
			else
				ram_buf(i, 1) = temp(1);
				ram_buf(i, 3) = temp(2);
				ram_buf(i + div, 2) = temp(3);
				ram_buf(i + div, 4) = temp(4);
                
                mfprintf(file_addr_wr, '%4d\t%4d\t%4d\t%4d\n', i-1,  i + div - 1, i-1, i + div - 1);
            end
		end
        
		if((sector_cnt == -(sector_size - 1)) && (j >= 2)) then
			sector_size = 2*sector_size;
			sector_cnt = sector_size - 1;
		else
			sector_cnt = sector_cnt - 2;
        end
        
        if(cos_cnt == (row/4 - 1)) then // overflow
            cos_cnt = 0;
        else
            cos_cnt = cos_cnt + 1;
        end
	end

	div = div/2;
	sector = 2*sector;
    
	ram = ram_buf;
end

file_ram = mopen('ram.txt', 'w');
for i = 1 : row
    mfprintf(file_ram, '%4d\t%4d\t%4d\t%4d\n', ram(i, :));
end

clear temp;

mclose(file_addr_rd); 
mclose(file_addr_wr); 

/******************************** get norm order in RAM **********************************/

// from matrix to line:
    cnt = 1;
    clear ram_buf;
    ram_buf(1:N) = 0;

    for i = 1:row
        ram_buf((1 + (i-1)*4) : (4*i)) = ram(i, 1:4);
        cnt = cnt + 1;
    end

// change index order (bit reverse):
    cnt = 1;
    ram_fht(1:row, 1:N_bank) = 0;
    
    fft_line = real(temp_fft) - imag(temp_fft);
    fht_line(1:N) = 0;
    
    for i = 1:row
        ram_fht(i, 1:4) = [ram_buf(bin2dec(mtlb_fliplr(dec2bin(cnt-1, last_stage+1))) + 1),... // cnt+0-1
                           ram_buf(bin2dec(mtlb_fliplr(dec2bin(cnt, last_stage+1))) + 1),...   // cnt+1-1
                           ram_buf(bin2dec(mtlb_fliplr(dec2bin(cnt+1, last_stage+1))) + 1),... // cnt+2-1
                           ram_buf(bin2dec(mtlb_fliplr(dec2bin(cnt+2, last_stage+1))) + 1)];   // cnt+3-1
                           
        fht_line((1 + (i-1)*4) : (4*i)) = ram_fht(i, :);
        cnt = cnt + 4;
    end

    clear cnt;

    ram_err = abs(ram_fft - ram_fht);
    err_line = abs(fft_line - fht_line);
    
    figure;
    title('Compare FHT and FFT with error (abs value of substract):');
        plot(fft_line);
        plot(fht_line, 'g');
        plot(err_line, 'r');        
    legend(['FFT'; 'FHT'; 'Error']);
    xgrid(2);
    
    figure;
    title('Error:');
        plot(err_line);
    xgrid(2);
    
    i = 1;
    threshold = 10;
    [max_err(i), ind_max_err(i)] = max(err_line);
    
    while(max_err(i) > threshold)
        i = i + 1;
        
        [max_err(i), ind_max_err(i)] = max(err_line);
        err_line(ind_max_err(i)) = 0;
    end
    
    ind_max_err = gsort(ind_max_err, 'g', 'i');
    mprintf("\n");
    
    for i = 1:length(ind_max_err)
        mprintf("%d\n", ind_max_err(i)); 
    end
    
mclose('all');
