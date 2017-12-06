module RegisterTransmit(out, transmit, clock, reset);
	input transmit, clock, reset;
	output reg out;

	reg state;
	always @(posedge clock or posedge reset) begin
		if (reset) begin
			out <= 0;
			state <= 0;
		end else if (transmit && state == 0) begin
			out <= 1;
			state <= 1;
		end else if (~transmit && state == 1) begin
			out <= 0;
			state <= 0;
		end else begin
			out <= 0;
			state <= state;
		end
	end
endmodule
