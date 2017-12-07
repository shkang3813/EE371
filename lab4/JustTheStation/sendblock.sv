


module sendblock(clk, reset, transmiting, load, databyte, outbit, count);
	input logic clk, reset, transmiting, load;
	input logic [7:0] databyte;
	output logic outbit;
	output logic [3:0] count;
	logic midpoint, srclk;
	
	BSC bt1 (.clk, .reset, .transmiting, .midpoint);
	BIC bt2 (.reset, .transmiting, .midpoint, .count);
	SRclock clk1 (.midpoint, .srclk);
	pari2seri ps1 (.load, .srclk, .databyte, .outbit);
	
endmodule
