module Pressure(pressure[7:0], startPressurization, startDepressurization, clock, reset);
	input startPressurization, startDepressurization, clock, reset;
	output [7:0] pressure;
	reg [7:0] pressure;
	
	wire sevenEnable, eightEnable;
	SevenCounter seven(sevenEnable, clock, reset || ~startDepressurization);
	EightCounter eight(eightEnable, clock, reset || ~startPressurization);

	always @(posedge clock or posedge reset) begin
		if (reset)
			pressure <= 8'b11001000;
		else if (sevenEnable) begin
			if (pressure > 8'b00000101)
				pressure <= pressure - 8'b00000001;
		end
		else if (eightEnable) begin
			if (pressure < 8'b11001000)
				pressure <= pressure + 8'b00000001;
		end
		else
			pressure <= pressure;
	end
endmodule
