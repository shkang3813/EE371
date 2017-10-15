module JohnsonCounter(out[3:0], clock, reset);
	input clock, reset;
	output reg [3:0] out;

	always @(posedge clock) begin
		if (reset == 0) begin
			out <= 'b0000;
		end
		else begin
			out[3] <= ~out[0];
			out[2] <= out[3];
			out[1] <= out[2];
			out[0] <= out[1];
		end
	end
endmodule