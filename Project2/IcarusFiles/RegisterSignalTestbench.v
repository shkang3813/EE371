`include "RegisterSignal.v"

module RegisterSignalTestbench();
	wire out, in, clock, reset;

	RegisterSignal register(out, in, clock, reset);
	Tester tester(out, in, clock, reset);

	// file for gtkwave
  	initial begin
  		$dumpfile("RegisterSignal.vcd");
  		$dumpvars(1, register);
	end 

endmodule

/*
** Things to test **
1) reset sets the output to low
2) high input sets output to high only for one clock cycle
*/
module Tester(out, in, clock, reset);
	input out;
	output reg in, clock, reset;

	initial  // Response
  	begin
	$display("\t\t clock  reset  in\t out \t    Time ");
    	$monitor("\t\t %b\t %b\t %b\t %b", clock, reset, in, out, $time);
  	end

  	parameter stimDelay = 20;

  	initial
  	begin
  					reset = 'b1; in = 'b0;
  					clock = 'b0;
  		#stimDelay  reset = 'b0;
  		#stimDelay  clock = 'b1; in = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; in = 'b0;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; in = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; in = 'b0;
  		#stimDelay  clock = 'b0;

	  	#(2 * stimDelay);
		$finish;
  	end

endmodule
