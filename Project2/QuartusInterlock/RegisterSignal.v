// Leave the statements as nonblocking in order
// to produce correct functionality
module RegisterSignal(out, in, clock, reset);
	input in, clock, reset;
	output reg out;

	reg[1:0] ps;
	parameter[1:0] A = 2'b00, B = 2'b01, C = 2'b10;

	always @(posedge clock or posedge reset) begin
		if (reset) begin
			ps <= A;
			out <= 0;
		end
		else if (ps == A && in) begin
			ps <= B;
			out <= 1;
		end
		else if (ps == B) begin
			if (in)
				ps <= C;
			else
				ps <= A;
			out <= 0;
		end
		else if (ps == C && !in)
			ps <= A;
		else
			ps <= ps;
	end

endmodule
