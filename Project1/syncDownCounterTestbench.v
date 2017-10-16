`include "syncDownCounter.v"

module testbench();
	wire clock, reset;
	wire[3:0] out;

	SynchronousDownCounter counter(out[3:0], clock, reset);

	Tester test(out[3:0], clock, reset);

	// file for gtkwave
  	initial 
  	begin
  		$dumpfile("syncDownCounter.vcd");
  		$dumpvars(1, counter);
	end 
endmodule

module Tester(out[3:0], clock, reset);
	input [3:0] out;
	output clock, reset;
	reg clock, reset;

	initial  // Response
  	begin
	$display("\t\t clock  reset \t output \t    Time ");
    	$monitor("\t\t %b\t %b  \t %b", clock, reset, out, 
								  $time );
  	end

	parameter stimDelay = 20;
	integer i;

	initial  // Stimulus
	  begin
	               reset = 'b0; clock = 'b0;
	    #stimDelay reset = 'b1;
	    for (i = 0; i < 16; i++) begin
		    #stimDelay clock = 'b1;
		    #stimDelay clock = 'b0;
	    end		
	    #(2*stimDelay);            	// needed to see END of simulation
	    $finish;                   		// finish simulation
	  end
endmodule