`include "Counter.v"

// Pressurizes the interlock chamber.
// Pressurization takes 8 minutes to complete.
module Pressurizer(pressurizing, start, clock, reset);
	input start, clock, reset;
	output reg pressurizing;

	wire[11:0] count;
	reg restart;
	Counter counter(count, clock, reset || restart);

	always @(posedge clock or posedge reset) begin
		if (reset) begin
			restart <= 'b0;
			pressurizing <= 'b0;
		end
		else if (start && ~pressurizing) begin  // make sure we are not already pressurizing
			restart <= 'b1;
			pressurizing <= 'b1;
		end
		else if (count != 'b101101000000) begin  // count needs to be at 8 minutes
			restart <= 'b0;
			pressurizing <= 'b1;
		end
		else begin
			restart <= 'b0;
			pressurizing <= 'b0;
		end
	end

endmodule
