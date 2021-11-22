function F_FHT_RAM_TO_LINE = F_FHT_RAM_TO_LINE(fht_ram)
    N_bank = 4;
    
% from matrix to line:
    row = length(fht_ram);
    N = N_bank*row;
    
    cnt = 1;
    fht_ram_buf(1:N) = zeros;
    
    for i = 1:row
        fht_ram_buf((1 + (i-1)*N_bank) : (N_bank*i)) = fht_ram(i, 1:N_bank);
        cnt = cnt + 1;
    end

% change index order (bit reverse):
    last_stage = log(N)/log(2); % numbers start from zero

    cnt = 1;
    fht_ram(1:row, 1:N_bank) = zeros;
    fht_ram_line(1:N) = zeros;
    
    for i = 1:row
        fht_ram(i, 1:N_bank) = [fht_ram_buf(bin2dec(fliplr(dec2bin(cnt-1,	last_stage))) + 1),... % cnt+0-1
                                fht_ram_buf(bin2dec(fliplr(dec2bin(cnt,     last_stage))) + 1),... % cnt+1-1
                                fht_ram_buf(bin2dec(fliplr(dec2bin(cnt+1,	last_stage))) + 1),... % cnt+2-1
                                fht_ram_buf(bin2dec(fliplr(dec2bin(cnt+2,	last_stage))) + 1)];   % cnt+3-1

        fht_ram_line((1 + (i-1)*N_bank) : (N_bank*i)) = fht_ram(i, :);
        cnt = cnt + N_bank;
    end
    
F_FHT_RAM_TO_LINE = fht_ram_line;