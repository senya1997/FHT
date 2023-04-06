# IP core of Fast Hartley transform

FHT is transform for real signal (not complex) that can be using in further processing e.g. convolution. Relation with FFT is:

``` FHT(S) = Re(FFT(S)) + Im(FFT(S))```

IP core based on modify Cooley-Tukey method with butterfly that require 3 operand and calculate in 2 steps. Base algorythm use 2 per 4 banks RAM that storage source signal, intermediate and final result of calculation. Project include math model in matlab and compare result RTL with math model.

For now project using altera's IP blocks: FIFO, RAM, ROM, etc.

## The procedure for launching ##

---

#### Configure before compilation and tests:

1. Set RTL settings via ```fht_defines.v``` (mixer test, whether data rounding is required, etc.).

2. Using TCL to determine the number of conversion points ```N(FHT)```: it is determined by the number of words in one RAM bank,
   i.e. by changing the bit addressing of one RAM bank, the number of conversion points changes in accordance with the table:

   ```
   |----------------------|
   |A_BIT | N(FHT)| D_BIT |
   |----------------------|
   |  5   | 128	|	23   |
   |  6   | 256	|	24   |
   | 	7   | 512	|	25   |
   | 	8   | 1024	|	26   |
   | 	9   | 2048	|	27   |
   | 	10  | 4096	|	28   |
   |----------------------|
   ```

   

3. Set the width of the ADC data, the width of the twiddle coefficients, the number of points that are written to the RAM for convolution (Nx). TCL generates twiddle coef. in automatic mode.

4. Before compiling, check the mixer test mode (bypass butterfly), because it disables the RTL part (a message will be displayed in the TCL command line in Quartus) and it needs to be turned off before the final compilation of the working version.

5. Compile only via TCL with the '-c' key, by uploading a function to the Quartus TCL console to use the keys, from project dir:

   ```tcl
   source script/src.tcl
   src script/fht.tcl -c
   ```

   Without a key - compilation is not started, only define and coef. files are updated.

6. Before compiling and running tests, check that the define file was written correctly

***

#### Launching testbench:

1. Run ``fht.m`` in matlab and select the type of test - the files for math model will be generated. Math models comparison with RTL (addr RD/WR, RAM state at all stages, etc.).

2. Mixer test requires enabling the option in ```fht_defines.v``` and using the test ```test = num``` or ```test = const```

3. Run the ```.do``` file in questa, before that enable breakpoint and output messages via ```fht_defines.v``` 

***

#### Using RTL:

1. Fill the RAM with point of signal (points can be written to all banks at once via the bit reverse counter of bank).

2. Issue the start strobe and wait for ready signals.

3. Read the transformed data from RAM (you can also read 4 banks at the same time), taking into account that the point numbers in the banks have a bit-reverse order.

---

### Remarks ###

---

* Overflow in the butterfly: at the end, a common divisor of ```4 * W_MAX``` is obtained, not ```2 * W_MAX```
* Delayed ready signal in control for one clock cycle only on finish the calulate transform (at the output of control comb. logic, timequest?).
* Input data is entered through a bit-reverse bank counter, i.e. the order is not 0, 1, 2, 3 but 0, 2, 1, 3.
* Input/output ports of the top module: for faster processing of the received data - at the input and output points are recieve/transmit from all memory banks simultaneously.
* Twiddle coefficients require keeping only a quarter of the period in memory, the rest is calculated either by symmetry
or the sign changes, so the number of words in ROM is 4 times less than in one bank, i.e. if the address bus for RAM
```[A_BIT - 1 : 0]```, then for ROM it will be ```[A_BIT - 3 : 0]```
* Convert ROM to registers?

***

* Import of package inside the module/program body or outside (globally)?
* Combine twiddle coefficients into one ROM block so that one M9K block is explicitly used
* Transfer the calculation of coefficients from the ROM block to the BUT block
* Check whether the expansion bit for the coefficients gives a higher accuracy or can an unbalanced range be used?
* Influence of width twiddle coef. and N(FHT) on the error...
* QSYS needs to be updated according to TCL

---
