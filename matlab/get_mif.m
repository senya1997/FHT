clear;
clc;

width = 12;
depth = 64;

% read files:
    coef(1:depth, 1:2) = [load('sin.txt'), load('cos.txt')];
    file_mif(1:2) = [fopen('sin.mif', 'wt'), fopen('cos.mif', 'wt')];

% descriptor:
for i = 1:2
	fprintf(file_mif(i), 'WIDTH=%d;\n', width);
	fprintf(file_mif(i), 'DEPTH=%d;\n', depth);
	fprintf(file_mif(i), '\n');
	fprintf(file_mif(i), 'ADDRESS_RADIX=UNS;\n');
    fprintf(file_mif(i), 'DATA_RADIX=HEX;\n');
	fprintf(file_mif(i), '\n');
	fprintf(file_mif(i), 'CONTENT BEGIN\n');
end

fprintf('\n\tadd data in ".mif"...');

% add data:
for k = 1:2
    for i = 1:depth
        str = num2str(dec2hex((coef(i, k) < 0)*2^width + coef(i, k), width/4));
        fprintf(file_mif(k), '%d\t:\t%s;\n', i - 1, str);
    end
    
    fprintf(file_mif(k),'END;');
    fclose(file_mif(k));
end

fprintf('\n\t\tComplete\n');