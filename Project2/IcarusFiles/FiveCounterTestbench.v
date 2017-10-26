`include "FiveCounter.v"

module FiveCounterTestbench();
	wire clock, reset;
	wire enable;

	FiveCounter fiveCounter(enable, clock, reset);
	Tester tester(enable, clock, reset);

	// file for gtkwave
  	initial begin
  		$dumpfile("FiveCounter.vcd");
  		$dumpvars(1, fiveCounter);
	end
endmodule

module Tester(enable, clock, reset);
	output reg clock, reset;
	input enable;

	initial  // Response
  	begin
	$display("\t\t clock  reset \t enable \t    Time ");
    	$monitor("\t\t %b\t %b  \t %b", clock, reset, enable, 
								  $time );
  	end

  	parameter stimDelay = 20;
	integer i;

	initial  // Stimulus
	  begin
	               clock = 'b0;
	    #stimDelay clock = 'b1; reset = 'b1;
	    #stimDelay clock = 'b0; reset = 'b0;
	    for (i = 0; i < 20; i++) begin
		    #stimDelay clock = 'b1;
		    #stimDelay clock = 'b0;
	    end
	    #stimDelay clock = 'b1; reset = 'b1;
	    #stimDelay clock = 'b0; reset = 'b0;
	    for (i = 0; i < 20; i++) begin
		    #stimDelay clock = 'b1;
		    #stimDelay clock = 'b0;
	    end
	    #(2*stimDelay);            	// needed to see END of simulation
	    $finish;                   		// finish simulation
	  end

endmodule