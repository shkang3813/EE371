`include "johnsonCounter.v"

module testbench();
	wire clock, reset;
	wire[3:0] out;

	JohnsonCounter counter(out[3:0], clock, reset);

	Tester test(out[3:0], clock, reset);

	// file for gtkwave
  	initial 
  	begin
  		$dumpfile("johnsonCounter.vcd");
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

	initial  // Stimulus
	  begin
	               clock = 'b0;
	    #stimDelay clock = 'b1; reset = 'b0;
	    #stimDelay clock = 'b0; reset = 'b1;
	    #stimDelay clock = 'b1;
	    #stimDelay clock = 'b0;
	    #stimDelay clock = 'b1;
	    #stimDelay clock = 'b0;
	    #stimDelay clock = 'b1;
	    #stimDelay clock = 'b0;
	    #stimDelay clock = 'b1;
	    #stimDelay clock = 'b0;
	    #stimDelay clock = 'b1;
	    #stimDelay clock = 'b0;
	    #stimDelay clock = 'b1;
	    #stimDelay clock = 'b0;
	    #stimDelay clock = 'b1;
	    #stimDelay clock = 'b0;
	    #stimDelay clock = 'b1;
	    #stimDelay clock = 'b0;
	    #stimDelay clock = 'b1;
	    #stimDelay clock = 'b0;
	    #stimDelay clock = 'b1;
	    #stimDelay clock = 'b0;
	    #stimDelay clock = 'b1;
	    #stimDelay clock = 'b0;
	    #stimDelay clock = 'b1;
	    #stimDelay clock = 'b0;
	    #stimDelay clock = 'b1;
	    #stimDelay clock = 'b0;
	    #stimDelay clock = 'b1;
	    #stimDelay clock = 'b0;
		
	    #(2*stimDelay);            	// needed to see END of simulation
	    $finish;                   		// finish simulation
	  end
endmodule