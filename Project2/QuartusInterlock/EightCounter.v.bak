// A counter with eight states with a change in
// state each clock cycle
module EightCounter(enable, clock, reset);
	input clock, reset;
	output enable;

	reg[2:0] count;

	always @(posedge clock or posedge reset) begin
		if (reset)
			count <= 'b000;
		else
			count <= count + 'b1;
	end

	assign enable = (count == 'b111);
endmodule
