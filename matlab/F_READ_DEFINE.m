function F_READ_DEFINE = F_READ_DEFINE(file_name, def_name)

file_def = fopen(file_name, 'r');

def_name = ['`define ', def_name, ' '];

len_def = length(def_name);

flag_def_val = 0;

while(~feof(file_def))
    %line = fgetl(file_def);
    line = fscanf(file_def, '%s\n');
    len_line = length(line);
    
    if(len_line > len_def)
        if(strcmp(line(1 : len_def), def_name))
            def_val = str2double(line(len_def + 1 : len_line));
            flag_def_val = 1;
            break;
        end
    end
end

if(~flag_def_val)
    error('Error while reading define: "%s"', def_name);
end

fclose(file_def);
    
F_READ_DEFINE = def_val;
