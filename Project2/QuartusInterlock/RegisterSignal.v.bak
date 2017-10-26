// Leave the statements as nonblocking in order
// to produce correct functionality
module RegisterSignal(out, in, clock, reset);
	input in, clock, reset;
	output reg out;

	reg ps, ns;
	parameter A = 'b0, B = 'b1;

	always @(posedge clock) begin
		case (ps)
		A:  if (in) begin
				ns  = B;
				out = 'b1;
		    end
		    else begin
		   		ns  = A;
		   		out = 'b0;
		    end
		B:  if (in) begin
				ns  = B;
				out = 'b0;
			end
			else begin
				ns  = A;
				out = 'b0;
			end
		default: ns = 'bx;
		endcase
	end

	always @(posedge clock or posedge reset) begin
		if (reset) begin
			out = 'b0;
			ps = A;
		end
		else	
			ps = ns;
	end

endmodule
