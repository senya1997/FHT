clear;
clc;

close all;

%% variables:
    dir_fft_math	= 'fft_cp.txt';
    dir_fht_math	= 'ram.txt';
    dir_err_ind     = 'err_ind.txt';
    
    dir_fht_fpga	= '../../modelsim/fht/fht_ram.txt';

    N_bank = 4;

%% convert and calc matrix:
    fht_math = load(dir_fht_math);
    fht_fpga = load(dir_fht_fpga);

    %fft_math = load(dir_fft_math);
    %fft_math = fft_math';

    row = length(fht_fpga);
    N = N_bank*row;

    fht_math_line = F_FHT_RAM_TO_LINE(fht_math);
    fht_fpga_line = F_FHT_RAM_TO_LINE(fht_fpga);

    err_line = F_ABS_ERR_LINE(fht_math_line, fht_fpga_line);
    %err_line = F_ABS_ERR_LINE(fft_math, fht_fpga_line);

    err_ind = load(dir_err_ind);
    err_ind = sort(err_ind);

    fclose('all');
    
%% graphics:
% errors:
    figure;
    subplot(2,1,1);
        histogram(err_ind, 16);
    xlim([0 N]);
    title('Error indexes:');
    ylabel('Number of errors');
    xlabel('Index');
    grid on;

    subplot(2,1,2);
        plot(err_ind, 'o', 'MarkerSize', 3);
    xlabel('Number');
    ylabel('Index');
    grid on;

% FHT compare:
    figure;
    subplot(2,1,1);
        plot((0 : N - 1), fht_math_line, '+-', 'MarkerSize', 2);
    hold on;
        plot((0 : N - 1), fht_fpga_line, 'o-', 'MarkerSize', 2);
    xlim([0 N]);
    title('Compare FHT and FFT:');
    xlabel('Num of point');
    ylabel('Amp');
    legend(['Math FHT'; 'FPGA FHT']);
    grid on;

    subplot(2,1,2);
        plot((0 : N - 1), err_line);
    xlim([0 N]);
    title('Error:');
    xlabel('Num of point');
    ylabel('Precent');
    grid on;

% zoom x8 times:
    figure; 
    subplot(2,1,1);
        plot((0 : N - 1), fht_math_line, '+-', 'MarkerSize', 2);
    hold on;
        plot((0 : N - 1), fht_fpga_line, 'o-', 'MarkerSize', 2);
    xlim([0 N/8 - 1]);
    title('Compare FHT and FFT:');
    xlabel('Num of point');
    ylabel('Amp');
    legend(['Math FHT'; 'FPGA FHT']);
    grid on;

    subplot(2,1,2);
        plot((0 : N - 1), err_line);
    xlim([0 N/8 - 1]);
    title('Error:');
    xlabel('Num of point');
    ylabel('Precent');
    grid on;