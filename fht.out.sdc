## Generated SDC file "fht.out.sdc"

## Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, the Altera Quartus II License Agreement,
## the Altera MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Altera and sold by Altera or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 14.1.0 Build 186 12/03/2014 SJ Full Version"

## DATE    "Tue Jun 16 23:54:39 2020"

##
## DEVICE  "EP4CE15F23C8"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {iCLK} -period 8.000 -waveform { 0.000 4.000 } [get_ports {iCLK}]
create_clock -name {iCLK_2} -period 16.000 -waveform { 0.000 8.000 } [get_ports {iCLK_2}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {iCLK_2}] -rise_to [get_clocks {iCLK_2}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {iCLK_2}] -fall_to [get_clocks {iCLK_2}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {iCLK_2}] -rise_to [get_clocks {iCLK}]  0.040  
set_clock_uncertainty -rise_from [get_clocks {iCLK_2}] -fall_to [get_clocks {iCLK}]  0.040  
set_clock_uncertainty -fall_from [get_clocks {iCLK_2}] -rise_to [get_clocks {iCLK_2}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {iCLK_2}] -fall_to [get_clocks {iCLK_2}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {iCLK_2}] -rise_to [get_clocks {iCLK}]  0.040  
set_clock_uncertainty -fall_from [get_clocks {iCLK_2}] -fall_to [get_clocks {iCLK}]  0.040  
set_clock_uncertainty -rise_from [get_clocks {iCLK}] -rise_to [get_clocks {iCLK_2}]  0.040  
set_clock_uncertainty -rise_from [get_clocks {iCLK}] -fall_to [get_clocks {iCLK_2}]  0.040  
set_clock_uncertainty -rise_from [get_clocks {iCLK}] -rise_to [get_clocks {iCLK}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {iCLK}] -fall_to [get_clocks {iCLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {iCLK}] -rise_to [get_clocks {iCLK_2}]  0.040  
set_clock_uncertainty -fall_from [get_clocks {iCLK}] -fall_to [get_clocks {iCLK_2}]  0.040  
set_clock_uncertainty -fall_from [get_clocks {iCLK}] -rise_to [get_clocks {iCLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {iCLK}] -fall_to [get_clocks {iCLK}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************

#set_false_path -from [get_clocks {*iCLK}] -to [get_registers {fht_control:CONTROL|rdy}]
#set_false_path -from [get_clocks {*iCLK}] -to [get_registers {fht_control:CONTROL|rdy}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

