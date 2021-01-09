function [out_but] = fht_double_but(x, y, sinx, cosx, w_amp) // length 'x' = 8: double DHT-4
//function [out_but] = fht_double_but(x, y, n_x, N)
pi = 3.14159;
/*
// test mixers:

out_but(1) = x(1);
out_but(2) = x(2);

out_but(3) = y(1);
out_but(4) = y(2);

mprintf('WARNING: TEST_MIXER is enabled\n');
*/

//mul_x = cos(n_x*(2*pi/N))*x(2) + sin(n_x*(2*pi/N))*x(3);
//mul_y = -sin(n_x*(2*pi/N))*y(2) + cos(n_x*(2*pi/N))*y(3);

mul_x = (cosx(1)*x(2) + sinx(1)*x(3))/w_amp;
mul_y = (cosx(2)*y(2) + sinx(2)*y(3))/w_amp;

//mul_y =(-sinx(1)*y(2) + cosx(1)*y(3))/w_amp;

out_but(1) = ((x(1) + mul_x)/2);
out_but(2) = ((x(1) - mul_x)/2);

out_but(3) = ((y(1) + mul_y)/2);
out_but(4) = ((y(1) - mul_y)/2);

// breakpoint:
/*
    mprintf('\nx0 = %4d, x1 = %4d, x2 = %4d\n', x(1), x(2), x(3));
    mprintf('y0 = %4d, y1 = %4d, y2 = %4d\n\n', y(1), y(2), y(3));
    
    mprintf('sin_x = %4d, cos_x = %4d\n', sinx(1), cosx(1));
    mprintf('sin_y = %4d, cos_y = %4d\n\n', sinx(2), cosx(2));
    
    mprintf('but_out_x0 = %4d, but_out_x1 = %4d\n',out_but(1), out_but(2));
    mprintf('but_out_y0 = %4d, but_out_y1 = %4d\n',out_but(3), out_but(4));
    
    pause
*/

endfunction 
