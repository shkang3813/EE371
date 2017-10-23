`include "Pressurizer.v"

module PressurizerTestbench();
	wire pressurizing, start, clock, reset;

	Pressurizer pressurizer(pressurizing, start, clock, reset);
	Tester tester(pressurizing, start, clock, reset);

	// file for gtkwave
  	initial begin
  		$dumpfile("Pressurizer.vcd");
  		$dumpvars(1, pressurizer);
	end

endmodule

/*
** Things to test **
1) reset sets the output to low
2) a second start signal before the pressurization has completed
does not restart the pressurization process
*/
module Tester(pressurizing, start, clock, reset);
	input pressurizing;
	output reg start, clock, reset;

	initial  // Response
  	begin
	$display("\t\t clock  reset  start\t pressurizing \t    Time ");
    	$monitor("\t\t %b\t %b\t %b\t %b", clock, reset, start, pressurizing, $time);
  	end

  	parameter stimDelay = 20;

  	initial
  	begin
					reset = 'b1; start = 'b0;
					clock = 'b0;
  		#stimDelay  reset = 'b0;
  		#stimDelay  clock = 'b1; start = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; start = 'b0;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; start = 'b1;  // make sure that this does not restart the pressurization process
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; start = 'b0;
  		#stimDelay  clock = 'b0;

	  	#(2 * stimDelay);
		$finish;
  	end

endmodule
