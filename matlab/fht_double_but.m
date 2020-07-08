function fht_double_but = fht_double_but(x, y, sin_x, cos_x, w_amp) % length 'x' = 8: double DHT-4

% test mixers:
%{
fht_double_but(1) = x(1);
fht_double_but(2) = x(2);

fht_double_but(3) = y(1);
fht_double_but(4) = y(2);
%}

mul_x = (cos_x*x(2) + sin_x*x(3))/w_amp;
mul_y =(-sin_x*y(2) + cos_x*y(3))/w_amp;

fht_double_but(1) = round((x(1) + mul_x)/2);
fht_double_but(2) = round((x(1) - mul_x)/2);

fht_double_but(3) = round((y(1) + mul_y)/2);
fht_double_but(4) = round((y(1) - mul_y)/2);
