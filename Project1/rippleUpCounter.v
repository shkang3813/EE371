`include "dFlipFlop.v"

module RippleUpCounter(out[3:0], clock, reset);
	input clock, reset;
	output [3:0] out;

	wire qBarOne;
	wire qBarTwo;
	wire qBarThree;
	wire qBarFour;

	DFlipFlop one(out[0], qBarOne, qBarOne, clock, reset);
	DFlipFlop two(out[1], qBarTwo, qBarTwo, qBarOne, reset);
	DFlipFlop three(out[2], qBarThree, qBarThree, qBarTwo, reset);
	DFlipFlop four(out[3], qBarFour, qBarFour, qBarThree, reset);
endmodule
