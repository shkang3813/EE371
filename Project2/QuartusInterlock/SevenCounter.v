// A counter with seventy states with a change in
// state each clock cycle
module SevenCounter(enable, clock, reset);
	input clock, reset;
	output enable;

	reg[6:0] count;

	always @(posedge clock or posedge reset) begin
		if (reset)
			count <= 7'b0000000;
		else if (count == 7'b1000101)
			count <= 7'b0000000;
		else
			count <= count + 'b1;
	end

	assign enable = (count == 7'b1000101);
endmodule
