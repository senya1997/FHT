clear;
clc;

close all;

fht_math = load('ram.txt');
fht_fpga = load('../../modelsim/fht/fht_ram.txt');

N_bank = 4;
row = length(fht_math);
N = N_bank*row;
last_stage = log(N)/log(2) - 1; % numbers start from zero

% from matrix to line:
    cnt = 1;
    
    fht_math_buf(1:N) = 0;
    fht_fpga_buf(1:N) = 0;
    
    for i = 1:row
        fht_math_buf((1 + (i-1)*4) : (4*i)) = fht_math(i, 1:4);
        fht_fpga_buf((1 + (i-1)*4) : (4*i)) = fht_fpga(i, 1:4);
        
        cnt = cnt + 1;
    end

% change index order (bit reverse):
    cnt = 1;
    
    fht_math(1:row, 1:N_bank) = 0;
    fht_fpga(1:row, 1:N_bank) = 0;
    
    fht_math_line(1:N) = 0;
    fht_fpga_line(1:N) = 0;
    
    for i = 1:row
        fht_math(i, 1:4) = [fht_math_buf(bin2dec(fliplr(dec2bin(cnt-1,	last_stage+1))) + 1),... % cnt+0-1
                            fht_math_buf(bin2dec(fliplr(dec2bin(cnt,	last_stage+1))) + 1),... % cnt+1-1
                            fht_math_buf(bin2dec(fliplr(dec2bin(cnt+1,	last_stage+1))) + 1),... % cnt+2-1
                            fht_math_buf(bin2dec(fliplr(dec2bin(cnt+2,	last_stage+1))) + 1)];   % cnt+3-1
                        
        fht_fpga(i, 1:4) = [fht_fpga_buf(bin2dec(fliplr(dec2bin(cnt-1,	last_stage+1))) + 1),... % cnt+0-1
                            fht_fpga_buf(bin2dec(fliplr(dec2bin(cnt,	last_stage+1))) + 1),... % cnt+1-1
                            fht_fpga_buf(bin2dec(fliplr(dec2bin(cnt+1,	last_stage+1))) + 1),... % cnt+2-1
                            fht_fpga_buf(bin2dec(fliplr(dec2bin(cnt+2,	last_stage+1))) + 1)];   % cnt+3-1
                        
        fht_math_line((1 + (i-1)*4) : (4*i)) = fht_math(i, :);
        fht_fpga_line((1 + (i-1)*4) : (4*i)) = fht_fpga(i, :);
        
        cnt = cnt + 4;
    end

    clear cnt;

err_line = abs(fht_math_line - fht_fpga_line)*100/max(abs(fht_fpga_line));

fclose('all');
    
% graphics
figure;
subplot(2,1,1);
    plot((0 : N - 1), fht_math_line, '+-', 'MarkerSize', 2);
hold on;
    plot((0 : N - 1), fht_fpga_line, 'o-', 'MarkerSize', 2);
xlim([0 N]);
title('Compare FHT and FFT:');
xlabel('Num point');
ylabel('Amp');
legend(['Math FHT'; 'FPGA FHT']);
grid on;

subplot(2,1,2);
    plot((0 : N - 1), err_line);
xlim([0 N]);
title('Error:');
xlabel('Num point');
ylabel('Precent');
grid on;

figure; % zoom x8 times
subplot(2,1,1);
    plot((0 : N - 1), fht_math_line, '+-', 'MarkerSize', 2);
hold on;
    plot((0 : N - 1), fht_fpga_line, 'o-', 'MarkerSize', 2);
xlim([0 N/8 - 1]);
title('Compare FHT and FFT:');
xlabel('Num point');
ylabel('Amp');
legend(['Math FHT'; 'FPGA FHT']);
grid on;

subplot(2,1,2);
    plot((0 : N - 1), err_line);
xlim([0 N/8 - 1]);
title('Error:');
xlabel('Num point');
ylabel('Precent');
grid on;