function [but_out] = fht_double_but(x, y, sinx, cosx, w_amp) // length 'x' = 8: double DHT-4

// test mixers:
/*
fht_double_but(1) = x(1);
fht_double_but(2) = x(2);

fht_double_but(3) = y(1);
fht_double_but(4) = y(2);

mprintf('WARNING: TEST_MIXER is enabled');
*/

mul_x = (cosx(1)*x(2) + sinx(1)*x(3))/w_amp;
mul_y = (cosx(2)*y(2) + sinx(2)*y(3))/w_amp;

//mul_y =(-sinx(1)*y(2) + cosx(1)*y(3))/w_amp;

but_out(1) = round((x(1) + mul_x)/2);
but_out(2) = round((x(1) - mul_x)/2);

but_out(3) = round((y(1) + mul_y)/2);
but_out(4) = round((y(1) - mul_y)/2);

// breakpoint:
/*
    mprintf('\nx0 = %4d, x1 = %4d, x2 = %4d\n', x(1), x(2), x(3));
    mprintf('y0 = %4d, y1 = %4d, y2 = %4d\n\n', y(1), y(2), y(3));
    
    mprintf('sin_x = %4d, cos_x = %4d\n', sinx(1), cosx(1));
    mprintf('sin_y = %4d, cos_y = %4d\n\n', sinx(2), cosx(2));
    
    mprintf('but_out_x0 = %4d, but_out_x1 = %4d\n',but_out(1), but_out(2));
    mprintf('but_out_y0 = %4d, but_out_y1 = %4d\n',but_out(3), but_out(4));
    
    pause
*/

endfunction 
