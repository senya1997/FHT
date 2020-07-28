function out_dht = dht(x, N)

pi = 3.1415926;
H(1:N) = 0;

for k = 1:N
    for n = 1:N
        H(k) = H(k) + x(n)*2^(1/2)*cos(2*pi*(n-1)*(k-1)/N - pi/4);
    end
end
    
out_dht = H;

endfunction 
