`include "RegisterSignal.v"

module Door(isClosed, toggle, pressureChanging, isCorrectPressure, wForce, clock, reset);
	input toggle, pressureChanging, isCorrectPressure, wForce, clock, reset;
	output reg isClosed;

	// used so that a toggle signal is not registered more than once
	wire actualToggle;
	RegisterSignal register(actualToggle, toggle, clock, reset);

	always @(posedge clock or posedge reset) begin
		if (reset)
			isClosed <= 'b1;
		else if (wForce)
			isClosed <= isClosed;
		else if (pressureChanging || !isCorrectPressure)
			isClosed <= 'b1;
		else if (actualToggle)
			isClosed <= ~isClosed;
		else
			isClosed <= isClosed;
	end

endmodule
