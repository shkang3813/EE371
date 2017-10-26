// A counter with five states with a change in
// state each clock cycle
module FiveCounter(enable, clock, reset);
	input clock, reset;
	output enable;

	reg[2:0] count;

	always @(posedge clock or posedge reset) begin
		if (reset)
			count <= 3'b000;
		else if (count == 3'b100)
			count <= 3'b100;
		else
			count <= count + 1'b1;
	end

	assign enable = (count == 3'b100);
endmodule
