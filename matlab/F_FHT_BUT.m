function F_FHT_BUT = F_FHT_BUT(x, y, sin_x, cos_x, w_amp) % length 'x' = 8: double DHT-4

% test mixers:
%{
F_FHT_BUT(1) = x(1);
F_FHT_BUT(2) = x(2);

F_FHT_BUT(3) = y(1);
F_FHT_BUT(4) = y(2);

fprintf('WARNING: TEST_MIXER is enabled\n');
%}

mul_x = (cos_x(1)*x(2) + sin_x(1)*x(3))/w_amp;
mul_y = (cos_x(2)*y(2) + sin_x(2)*y(3))/w_amp;

%mul_x = cos(n_x*(2*pi/N))*x(2) + sin(n_x*(2*pi/N))*x(3);
%mul_y = -sin(n_x*(2*pi/N))*y(2) + cos(n_x*(2*pi/N))*y(3);

F_FHT_BUT = [(x(1) + mul_x)/2,...
             (x(1) - mul_x)/2,...
             (y(1) + mul_y)/2,...
             (y(1) - mul_y)/2];
