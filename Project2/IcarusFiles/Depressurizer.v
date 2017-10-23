`include "Counter.v"

// Depressurizes the interlock chamber.
// Depressurization takes 7 minutes to complete.
module Depressurizer(depressurizing, start, clock, reset);
	input start, clock, reset;
	output reg depressurizing;

	wire[11:0] count;
	reg restart;
	Counter counter(count, clock, reset || restart);

	always @(posedge clock or posedge reset) begin
		if (reset) begin
			restart <= 'b0;
			depressurizing <= 'b0;
		end
		else if (start && ~depressurizing) begin  // make sure we are not already depressurizing
			restart <= 'b1;
			depressurizing <= 'b1;
		end
		else if (count != 'b100111011000) begin  // count needs to be at 7 minutes
			restart <= 'b0;
			depressurizing <= 'b1;
		end
		else begin
			restart <= 'b0;
			depressurizing <= 'b0;
		end
	end

endmodule