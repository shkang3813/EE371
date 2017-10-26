`include "ArrivalWorkflow.v"

module ArrivalWorkflowTestbench();
	wire busy, startPressurizing, startDepressurizing, wForce,
		start, isFive, inChamber, odClosed, idClosed, clock, reset;
    wire [7:0] pressure;

	ArrivalWorkflow workflow(busy, startPressurizing, startDepressurizing, wForce,
        start, isFive, inChamber, odClosed, idClosed, pressure[7:0], clock, reset);
	Tester tester(busy, startPressurizing, startDepressurizing, wForce,
        start, isFive, inChamber, odClosed, idClosed, pressure[7:0], clock, reset);

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
module Tester(busy, startPressurizing, startDepressurizing, wForce,
        start, isFive, inChamber, odClosed, idClosed, pressure[7:0], clock, reset);
	input busy, startPressurizing, startDepressurizing, wForce;
    output reg start, isFive, inChamber, odClosed, idClosed, clock, reset;
    output reg[7:0] pressure;

	initial  // Response
  	begin
	$display("\t\t clock  reset  start   odClosed idClosed pressure in-chamber is-five busy startPressurizing startDepressurizing Time ");
    	$monitor("\t\t %b\t %b\t %b\t %b\t   %b     %b   %b\t%b   %b\t    %b\t\t       %b", clock, reset, start,
    	odClosed, idClosed, pressure, inChamber, isFive, busy, startPressurizing, startDepressurizing, $time);
  	end

	parameter stimDelay = 20;

  	initial
  	begin
  					reset = 'b1; start = 'b0; odClosed = 'b0; idClosed = 'b0;
  					pressure = 'b00001000; isFive = 'b0; inChamber = 'b0; clock = 'b0;
  		#stimDelay  reset = 'b0;
  		#stimDelay  clock = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; start = 'b1;  // advance to state B
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; start = 'b0;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; odClosed = 'b1; idClosed = 'b1;  // depressurize
  		#stimDelay  clock = 'b0;
        #stimDelay  clock = 'b1;
        #stimDelay  clock = 'b0;
        #stimDelay  clock = 'b1;
        #stimDelay  clock = 'b0;
        #stimDelay  clock = 'b1; pressure = 'b00000100;
        #stimDelay  clock = 'b0; isFive = 'b1;  // ready for door to open
        #stimDelay  clock = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; odClosed = 'b0;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; inChamber = 'b1;
  		#stimDelay  clock = 'b0;
        #stimDelay  clock = 'b1; odClosed = 'b1;
        #stimDelay  clock = 'b0;
        #stimDelay  clock = 'b1;
        #stimDelay  clock = 'b0;
        #stimDelay  clock = 'b1; pressure = 'b01000000;
        #stimDelay  clock = 'b0;
        #stimDelay  clock = 'b1; pressure = 'b01010001;
        #stimDelay  clock = 'b0;
        #stimDelay  clock = 'b1; 
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; idClosed = 'b0;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1;

	  	#(2 * stimDelay);
		$finish;
  	end
endmodule
