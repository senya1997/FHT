function F_DEFINE_EXIST = F_DEFINE_EXIST(file_name, def_name)

def_name = ['`define ', def_name];
len_def = length(def_name);

file_def = fopen(file_name, 'r');
def_exist = 0;

while(~feof(file_def))
    line = fgetl(file_def);
    len_line = length(line);

    if(len_line >= len_def)
        if(strcmp(line(1 : len_def), def_name))
            def_exist = 1;
            break;
        end
    end
end

fclose(file_def);

F_DEFINE_EXIST = def_exist;