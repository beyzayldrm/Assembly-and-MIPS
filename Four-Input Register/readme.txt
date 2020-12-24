In this project, I have designed the sub-register using 8 rising-edge triggered D flip-flops. I
have first connected the given 8-bit input pin and the splitter, and have connected the input
splitter to 8 rising-edge triggered D flip flops through data input D and connected the output
splitter through output Q. I have connected the D flip flops to the clock through clock input
C to form the register and make sure that flip-flops are written to as a unit.
For the second part, I have designed a four-input register using a copy of the sub-register I
have designed in the first part as the basis. I created a multiplexor to have the circuit input
get selected from the number of inputs provided. The four inputs in the circuit from which
the multiplexor with 8 data bits and 2 select bits has to choose to feed into the register are:
an external data-in input (input 0), an 8-bit constant input initialized to zero (input 1), the
output of an adder that increments the register by adding 1 to the current value in the
register (input 2), and lastly the output of the register (input 1). So, if 00 is entered to the 2
select bits of the multiplexor, register gets loaded from data-in input. If 01 is entered,
register gets loaded with constant 0. If 10 is entered, the value in the register gets
incremented through an adder. If 11 is entered, the value is on hold, the numbers in register
are unchanged. Lastly, I connected my register to 8-bit output through out_1 and to clock
through clock_1 such that the input bits in_1 are copied onto the output bits out_1 when
clock_1 is enabled.