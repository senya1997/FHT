function F_ABS_ERR_LINE = F_ABS_ERR_LINE(math_line, fpga_line) % abs error of 2 sequences in precent

F_ABS_ERR_LINE = abs(math_line - fpga_line)*100/max(abs(fpga_line));