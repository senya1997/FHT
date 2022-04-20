clear;
close all;
clc;

N = 3700;

fid = fopen('C:\work\src_app\ZScanTest_Spb\Log\Log_1.bin', 'rb');

[a, count] = fread(fid, [8*N 1], 'uint8');

fclose(fid);

rec(1:N) = zeros;
ref(1:N) = zeros;

for i = 1:N
    rec(i) = a(3 + 8*(i - 1))*255 + a(4 + 8*(i - 1));
    ref(i) = a(7 + 8*(i - 1))*255 + a(8 + 8*(i - 1));
end

rec = rec';
ref = ref';

figure;
%subplot(2,1,1);
    plot(1:N, rec);
hold on;
    plot(1:N, ref);
%legend(['Recieved'; 'Reference']);
grid on;

figure;
%subplot(2,1,2);
    plot(abs(rec - ref));
grid on;