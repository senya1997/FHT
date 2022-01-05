global dir_def;

global dir_sin_coef;
global dir_cos_coef;

global dir_imp;
global dir_signal;

global dir_init_fht;
global dir_init_conv;
global dir_init_imp_p;
global dir_init_imp_n;

global dir_math_fht_ram;
global dir_math_fft_line;
global dir_math_err_ind;

global dir_math_addr_rd;
global dir_math_addr_wr;

global dir_fpga_fht_ram;

dir_def = '../fht_defines.v';

dir_sin_coef = 'sin.txt';
dir_cos_coef = 'cos.txt';

% dir of input signal sample and impulses ('h.txt', 'x.txt' must be autogenerated, cause 'Nh', 'Nx' defines by 'fht_defines.v'):
    dir_imp     = '../../gcpu/sample/h.txt'; % size Nh
    dir_signal	= '../../gcpu/sample/x.txt'; % size Nx

% save reg ver of files for init FPGA RAM in tb:    
    dir_init_fht    = 'init_fht_ram.txt';
    dir_init_conv   = '../../fht_conv/matlab/init_conv_ram.txt';    
    dir_init_imp_p  = '../../fht_conv/matlab/init_imp_p_ram.txt'; 
    dir_init_imp_n	= '../../fht_conv/matlab/init_imp_n_ram.txt';

% dir output math for compare in matlab and tb:
    dir_math_fht_ram	= 'math_fht_ram.txt';
    dir_math_fft_line   = 'math_fft_cp.txt';
    dir_math_err_ind    = 'math_err_ind.txt';
    
    dir_math_addr_rd	= 'math_addr_rd.txt';
    dir_math_addr_wr	= 'math_addr_wr.txt';
    
dir_fpga_fht_ram	= '../debug/fpga_fht_ram.txt'; % read to analys