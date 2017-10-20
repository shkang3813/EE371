module SynchronousDownCounter(out[3:0], clock, reset);
	input clock, reset;
	output [3:0] out;

	wire dOne, qOne, qBarOne;
	wire dTwo, qTwo, qBarTwo;
	wire dThree, qThree, qBarThree;
	wire dFour, qFour, qBarFour;

	assign out[3:0] = {qFour, qThree, qTwo, qOne};

	assign dOne = qBarOne;
	assign dTwo = qBarOne ^ qTwo;
	assign dThree = (qBarTwo & qBarOne) ^ qThree;
	assign dFour = (qBarThree & qBarTwo & qBarOne) ^ qFour;

	DFlipFlop one(qOne, qBarOne, dOne, clock, reset);
	DFlipFlop two(qTwo, qBarTwo, dTwo, clock, reset);
	DFlipFlop three(qThree, qBarThree, dThree, clock, reset);
	DFlipFlop four(qFour, qBarFour, dFour, clock, reset);
endmodule
