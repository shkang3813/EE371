`include "Counter.v"

module CounterTestbench();
	wire clock, reset;
	wire[11:0] out;

	Counter counter(out[11:0], clock, reset);
	Tester tester(out[11:0], clock, reset);

	// file for gtkwave
  	initial begin
  		$dumpfile("Counter.vcd");
  		$dumpvars(1, counter);
	end
endmodule

module Tester(out[11:0], clock, reset);
	output reg clock, reset;
	input[11:0] out;

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
