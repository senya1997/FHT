clear;
clc;

close all;

diary LOG_MATLAB.txt
fprintf('\n\t%s\n', datestr(datetime));
glob_path;

fprintf('\n\tCompare math model and RTL\n');

%% input (from main matlab file):
    global dir_def;

    global dir_math_fht_ram;
    global dir_fpga_fht_ram;

    global dir_math_fft_line;
    global dir_math_err_ind;

    N = F_READ_DEFINE(dir_def, 'N');
    
fprintf('\nInput data:\n');
fprintf('\tNum of point transform (N) = %d\n',     N);
fprintf('\tCompared files:\t"%s" and "%s"\n', dir_math_fht_ram, dir_fpga_fht_ram);
fprintf('\tIndexes of error element files:\t"%s"\n', dir_math_err_ind);

%% convert and calc matrix:
fprintf('\nLoad input data and calc accuracy...');

    fht_math = load(dir_math_fht_ram);
    fht_fpga = load(dir_fpga_fht_ram);

    fft_math = load(dir_math_fft_line);
    fft_math = fft_math';

    fht_math_line = F_FHT_RAM_TO_LINE(fht_math);
    fht_fpga_line = F_FHT_RAM_TO_LINE(fht_fpga);

    err_line = F_ABS_ERR_LINE(fht_math_line, fht_fpga_line);
    %err_line = F_ABS_ERR_LINE(fft_math, fht_fpga_line);

    err_ind = load(dir_math_err_ind);
    err_ind = sort(err_ind);

    fclose('all');
    
%% graphics:
fprintf('\nPrint graphics...\n');

% errors:
    fig_err = figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
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
    fig_comp = figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
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
    fig_comp_zoom = figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]); 
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
    
saveas(fig_err, 'screen/fht_err_ind', 'png'); 
saveas(fig_comp, 'screen/fht_math_cmp_fpga', 'png'); 
saveas(fig_comp_zoom, 'screen/fht_math_cmp_fpga_zoom', 'png'); 

%close(fig_err);
%close(fig_comp);
%close(fig_comp_zoom);
