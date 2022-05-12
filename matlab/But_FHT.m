function But_FHT = But_FHT(x, y, n_x) % double DHT-3
%function But_FHT = But_FHT(x, y, sin_x, cos_x, w_amp) % double DHT-3

    %mul_x = (cos_x(1)*x(2) + sin_x(1)*x(3))/w_amp;
    %mul_y = (cos_x(2)*y(2) + sin_x(2)*y(3))/w_amp;

    mul_x = cos(n_x*(2*pi/N))*x(2) + sin(n_x*(2*pi/N))*x(3);
    mul_y = -sin(n_x*(2*pi/N))*y(2) + cos(n_x*(2*pi/N))*y(3);
    
But_FHT(1) = (x(1) + mul_x)/2;
But_FHT(2) = (x(1) - mul_x)/2;

But_FHT(3) = (y(1) + mul_y)/2;
But_FHT(4) = (y(1) - mul_y)/2;