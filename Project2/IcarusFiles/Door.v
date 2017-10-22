`include "RegisterSignal.v"

module Door(isClosed, toggle, pressureChanging, isHighPressure,
		clock, reset);
	input toggle, pressureChanging, isHighPressure, clock, reset;
	output reg isClosed;

	// used so that a toggle signal is not registered more than once
	wire actualToggle;
	RegisterSignal register(actualToggle, toggle, clock,  reset);

	always @(posedge clock or posedge reset) begin
		if (reset) begin
			isClosed <= 'b1;
		end
		else if (pressureChanging || isHighPressure) begin
			isClosed <= 'b1;
		end
		else if (actualToggle) begin
			isClosed <= ~isClosed;
		end
	end

endmodule
