// A counter with fifty states with a change in
// state every 195 clock cycles.
// Note that this is a single-cycle counter,
// outputting a high enable continuously once
// a full cycle has been completed until a reset
// should occur.
module FiveCounter(enable, count[5:0], clock, reset);
	input clock, reset;
	output enable;
	output reg[5:0] count;
	
	wire minute;
	MinuteCounter counter(minute, clock, reset);

	always @(posedge clock or posedge reset) begin
		if (reset)
			count <= 6'b000000;
		else if (count == 6'b110010)
			count <= 6'b110010;  // stay at the enable state
		else if (minute)
			count <= count + 6'b000001;
		else
			count <= count;
	end

	assign enable = (count == 6'b110010);
endmodule
