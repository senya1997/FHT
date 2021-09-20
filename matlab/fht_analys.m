clear;
clc;

close all;

%% input (from main matlab file):
    global dir_def;

    global dir_math_fft_cp;
    global dir_math_err_ind;
    
    global dir_math_fht_ram;
    global dir_fpga_fht_ram;

    N       = F_READ_DEFINE(dir_def, 'N');
    row     = F_READ_DEFINE(dir_def, 'BANK_SIZE');
    
%% convert and calc matrix:
    fht_math = load(dir_math_fht_ram);
    fht_fpga = load(dir_fpga_fht_ram);

    fft_math = load(dir_math_fft_cp);
    fft_math = fft_math';

    fht_math_line = F_FHT_RAM_TO_LINE(fht_math);
    fht_fpga_line = F_FHT_RAM_TO_LINE(fht_fpga);

    err_line = F_ABS_ERR_LINE(fht_math_line, fht_fpga_line);
    %err_line = F_ABS_ERR_LINE(fft_math, fht_fpga_line);

    err_ind = load(dir_math_err_ind);
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
    title('Compare:');
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