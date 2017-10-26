`include "SevenCounter.v"
`include "EightCounter.v"

module Pressure(pressure[7:0], startPressurization, startDepressurization, clock, reset);
	input startPressurization, startDepressurization, clock, reset;
	output reg[7:0] pressure;

	wire sevenEnable, eightEnable;
	SevenCounter seven(sevenEnable, clock, reset || ~startDepressurization);
	EightCounter eight(eightEnable, clock, reset || ~startPressurization);

	always @(posedge clock or posedge reset) begin
		if (reset)
			pressure <= 'b11000010;
		else if (sevenEnable) begin
			if (pressure > 'b0)
				pressure <= pressure - 'b1;
		end
		else if (eightEnable) begin
			if (pressure < 'b11000010)
				pressure <= pressure + 'b1;
		end
		else
			pressure <= pressure;
	end
endmodule
