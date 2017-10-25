// A counter with seven states with a change in
// state each clock cycle
module SevenCounter(enable, clock, reset);
	input clock, reset;
	output enable;

	reg[2:0] count;

	always @(posedge clock or posedge reset) begin
		if (reset)
			count <= 'b000;
		else if (count == 'b110)
			count <= 'b000;
		else
			count <= count + 'b1;
	end

	assign enable = (count == 'b110);
endmodule
