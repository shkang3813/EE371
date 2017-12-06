


module reciveblock(inbit, clk, reset, count, outbyte);
	input logic inbit, clk, reset;
	output logic [3:0] count;
	output logic [7:0] outbyte;
	
	
	logic go, midpoint, srclk;
	
	startblock st (.inbit, .go, .clk, .reset);
	BSC b1 (.clk, .reset, .transmiting(go), .midpoint);
	BIC b2 (.reset, .transmiting(go), .midpoint, .count);
	SRclock sclk (.midpoint, .srclk);
	seri2pari s2p (.srclk, .inbit, .outbyte, .reset);
	
endmodule
