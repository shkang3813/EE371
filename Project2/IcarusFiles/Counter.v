module Counter(out[11:0], clock, reset);
	input clock, reset;
	output reg[11:0] out;

	always @(posedge clock or posedge reset) begin
		if (reset) begin
			out <= 'b000000000000;
		end
		else begin
			out <= out + 1;
		end
	end

endmodule
