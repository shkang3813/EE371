`include "dFlipFlop.v"

module RippleUpCounter(out[0:3], clock, reset);
	input clock, reset;
	output [0:3] out;

	wire qBarOne;
	wire qBarTwo;
	wire qBarThree;
	wire qBarFour;

	DFlipFlop one(out[3], qBarOne, qBarOne, clock, reset);
	DFlipFlop two(out[2], qBarTwo, qBarTwo, out[3], reset);
	DFlipFlop three(out[1], qBarThree, qBarThree, out[2], reset);
	DFlipFlop four(out[0], qBarFour, qBarFour, out[1], reset);
endmodule
