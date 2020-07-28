clear;
clc;

[x, freq_x] = getDataHex('..\impulses\hex\sample_in_short_16bit.hex');
[h, freq_h] = getDataHex('..\impulses\hex\c1000_16bit.hex');

cut_border = 1; % cut impulse if amplitude smaller then "cut_border" in "%" from max
length_border = 8192;

if(freq_x ~= freq_h)
    warning('\nsample rate of input signal and impulse are different!\n');
end

if(length(h) > length_border)
    fprintf('\ncut filter...\n');
    max_h = max(h);
    ind_sign = 1;

    for i = 1:length(h)
        if(h(i) >= cut_border*max_h/100) 
            ind_sign = i;
        end
    end

    h_cut = h(1:ind_sign);
    fprintf('complete\n\n');
else
    h_cut = h;
end

%% direct calc:
fprintf('\nstart direct apply filter...\n');

y(1:length(x)) = zeros;
for i = 1:length(x) % sample length
    for j = 1:length(h_cut) % impulse length
        if(i-j >= 1)
            y(i) = y(i) + round(h_cut(j))*round(x(i-j));
        end
    end
end

%% calc throgh FFT:
fprintf('\nstart apply filter by FFT...\n');

Nh = 2048;
Nx = 2049;
N = Nh + Nx - 1;

h_temp(1 : Nh) = round(h(1 : Nh));
h_temp(Nh + 1 : N) = zeros;

fft_h = fft(h_temp, N);

y_old(1 : Nh - 1) = zeros;

for i = 1:1:round((length(x)/Nx))
    low = Nx*(i - 1) + 1;
    high = i*Nx;
    
    x_temp(1 : Nx) = x(low : high);
    x_temp(Nx + 1 : N) = zeros;
    
	fft_x = fft(x_temp, N);
    
    fft_y = fft_x.*fft_h;
    ifft_y = ifft(fft_y, N);
    
    y_new(1 : Nh - 1) = ifft_y(1 : Nh - 1) + y_old(1 : Nh - 1);
    y_new(Nh : Nx) = ifft_y(Nh : Nx);
    
    y_old = ifft_y(Nx + 1 : N);
    
    y_out(low : high) = y_new;
end

%% graphics:
fprintf('\nbuilding graph...\n');

figure;
plot(h); hold on;
plot(h_cut); grid on;
title('impulses:'); legend('original', 'applied');

figure;
plot(y/1e10); hold on;
plot(y_out/1e10); grid on;
title('signal:'); legend('direct out', 'FFT out');

figure;
plot(y(1:length(y_out)) - y_out); grid on;
title('fault (substract):');

audiowrite('sample_dir_out.wav', y/1e10, freq_x);
audiowrite('sample_fft_out.wav', y_out/1e10, freq_x);

fprintf('\ncomplete\n');
