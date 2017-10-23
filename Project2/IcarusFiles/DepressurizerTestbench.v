`include "Depressurizer.v"

module DepressurizerTestbench();
	wire depressurizing, start, clock, reset;

	Depressurizer depressurizer(depressurizing, start, clock, reset);
	Tester tester(depressurizing, start, clock, reset);

	// file for gtkwave
  	initial begin
  		$dumpfile("Depressurizer.vcd");
  		$dumpvars(1, depressurizer);
	end

endmodule

/*
** Things to test **
1) reset sets the output to low
2) a second start signal before the pressurization has completed
does not restart the pressurization process
*/
module Tester(depressurizing, start, clock, reset);
	input depressurizing;
	output reg start, clock, reset;

	initial  // Response
  	begin
	$display("\t\t clock  reset  start\t depressurizing \t    Time ");
    	$monitor("\t\t %b\t %b\t %b\t %b", clock, reset, start, depressurizing, $time);
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
  		#stimDelay  clock = 'b1; start = 'b1;  // make sure that this does not restart the depressurization process
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; start = 'b0;
  		#stimDelay  clock = 'b0;

	  	#(2 * stimDelay);
		$finish;
  	end

endmodule
