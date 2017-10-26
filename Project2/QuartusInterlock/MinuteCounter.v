// Sends a high enable every tenth of a minute where
// a minute is represented by 1950 clock
// cycles
module MinuteCounter(enable, clock, reset);
	input clock, reset;
	output enable;
	
	reg[7:0] count;
	
	always @(posedge clock or posedge reset) begin
		if (reset)
			count <= 8'b0000000;
		else if (count == 8'b11000010)
			count <= 8'b0000000;
		else
			count <= count + 1'b1;
	end

	assign enable = (count == 8'b11000010);
endmodule
