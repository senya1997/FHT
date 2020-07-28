clear;
clc;

exec('dht.sce');

Nx = 6;
Nh = 3;

N = Nx + Nh - 1;

x(1 : 12) = [1, 3, 2, -3, 0, 2, -1, 0, -2, 3, -2, 1];
h(1 : Nh) = [1, 0, 1];

h_temp(1 : Nh) = h(1 : Nh);
h_temp(Nh + 1 : N) = 0;

dht_h = dht(h_temp, N);

y_old(1 : Nh - 1) = 0;

for i = 1:1:(length(x)/Nx)
    low = Nx*(i - 1) + 1;
    high = i*Nx;
    
    x_temp(1 : Nx) = x(low : high);
    x_temp(Nx + 1 : N) = 0;
    
	dht_x = dht(x_temp, N);
    
    n_dht_x = [dht_x(1); flipdim(dht_x(2:length(dht_x)), 1)];
    n_dht_h = [dht_h(1); flipdim(dht_h(2:length(dht_h)), 1)];
    
    dht_y = 0.5*(dht_x.*dht_h + dht_x.*n_dht_h + n_dht_x.*dht_h - n_dht_x.*n_dht_h);
    //dht_y = dht_x*dht_h(2:2:length(dht_h)) + flipdim(dht_x, 2)*dht_h(1:2:length(dht_h));
    
    idht_y = dht(dht_y, N)/N;
    
    y_new(1 : Nh - 1) = idht_y(1 : Nh - 1) + y_old(1 : Nh - 1);
    y_new(Nh : Nx) = idht_y(Nh : Nx);
    
    y_old = idht_y(Nx + 1 : N);
    
    y_out_dht(low : high) = y_new;
end

fft_h = fft(h_temp);

y_old(1 : Nh - 1) = 0;

for i = 1:1:(length(x)/Nx)
    low = Nx*(i - 1) + 1;
    high = i*Nx;
    
    x_temp(1 : Nx) = x(low : high);
    x_temp(Nx + 1 : N) = 0;
    
	fft_x = fft(x_temp);
    
    fft_y = fft_x.*fft_h;
    
    ifft_y = ifft(fft_y);
    ifft_y = ifft_y';
    
    y_new(1 : Nh - 1) = ifft_y(1 : Nh - 1) + y_old(1 : Nh - 1);
    y_new(Nh : Nx) = ifft_y(Nh : Nx);
    
    y_old = ifft_y(Nx + 1 : N);
    
    y_out_fft(low : high) = y_new;
end

y_out_cp(:, 1) = y_out_fft;
y_out_cp(:, 2) = y_out_dht;
