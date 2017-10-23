`include "ArrivalWorkflow.v"

module ArrivalWorkflowTestbench();
	wire busy, startPressurizing, startDepressurizing,
		start, odClosed, idClosed, isHighPressure, clock, reset;

	ArrivalWorkflow workflow(busy, startPressurizing, startDepressurizing,
		start, odClosed, idClosed, isHighPressure, clock, reset);
	Tester tester(busy, startPressurizing, startDepressurizing,
		start, odClosed, idClosed, isHighPressure, clock, reset);

	// file for gtkwave
  	initial begin
  		$dumpfile("ArrivalWorkflow.vcd");
  		$dumpvars(1, workflow);
	end
endmodule

/*
** Things to test **
1) reset sets the workflow back to idle
2) 
*/
module Tester(busy, startPressurizing, startDepressurizing,
		start, odClosed, idClosed, isHighPressure, clock, reset);
	input busy, startPressurizing, startDepressurizing;
	output reg start, odClosed, idClosed, isHighPressure, clock, reset;

	initial  // Response
  	begin
	$display("\t\t clock  reset  start   odClosed idClosed isHighPressure busy startPressurizing startDepressurizing Time ");
    	$monitor("\t\t %b\t %b\t %b\t %b\t   %b\t\t %b\t %b\t    %b\t\t       %b", clock, reset, start,
    	odClosed, idClosed, isHighPressure, busy, startPressurizing, startDepressurizing, $time);
  	end

	parameter stimDelay = 20;

  	initial
  	begin
  					reset = 'b1; start = 'b0; odClosed = 'b0; idClosed = 'b0;
  					isHighPressure = 'b1; clock = 'b0;
  		#stimDelay  reset = 'b0;
  		#stimDelay  clock = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; start = 'b1;  // advance to state B
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; start = 'b0;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; odClosed = 'b1; idClosed = 'b1;  // advance to state C
  		#stimDelay  clock = 'b0;
      #stimDelay  clock = 'b1;
      #stimDelay  clock = 'b0;
      #stimDelay  clock = 'b1;
      #stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; isHighPressure = 'b0;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; odClosed = 'b0;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; odClosed = 'b1;
  		#stimDelay  clock = 'b0;
      #stimDelay  clock = 'b1;
      #stimDelay  clock = 'b0;
      #stimDelay  clock = 'b1;
      #stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; isHighPressure = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; idClosed = 'b0;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1;

	  	#(2 * stimDelay);
		$finish;
  	end
endmodule
