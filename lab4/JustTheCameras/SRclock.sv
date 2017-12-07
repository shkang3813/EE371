

module SRclock(midpoint, srclk);
	input logic midpoint;
	output logic srclk;
	assign srclk = midpoint;
endmodule
