function fht_double_but = fht_double_but(x, y, n_x, n_y, N) % length 'x' = 8: double DHT-4

% test mixers:
%{
fht_double_but(1) = x(1);
fht_double_but(2) = x(2);

fht_double_but(3) = y(1);
fht_double_but(4) = y(2);
%}

cos_x = cos(n_x*(2*pi/N));
sin_x = sin(n_x*(2*pi/N));

cos_y = cos(n_y*(2*pi/N));
sin_y = sin(n_y*(2*pi/N));

fht_double_but(1) = (x(1) + cos_x*x(2) + sin_x*x(3))/2;
fht_double_but(2) = (x(1) - cos_x*x(2) - sin_x*x(3))/2;

fht_double_but(3) = (y(1) + cos_y*y(2) + sin_y*y(3))/2;
fht_double_but(4) = (y(1) - cos_y*y(2) - sin_y*y(3))/2;
