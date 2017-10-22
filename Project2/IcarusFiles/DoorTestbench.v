`include "Door.v"

module DoorTestbench();
	wire isClosed, toggle, pressureChanging, clock, reset;

	Door door(isClosed, toggle, pressureChanging, isHighPressure, clock, reset);
	Tester test(isClosed, toggle, pressureChanging, isHighPressure, clock, reset);

	// file for gtkwave
  	initial begin
  		$dumpfile("Door.vcd");
  		$dumpvars(1, door);
	end 

endmodule

/*
** Things to test **
1) reset closes the door
2) toggling changes the state of the door from
   open to closed and vice versa
3) pressure changes set the door to closed and
   keep it closed regardless of toggle
4) when the chamber is at high pressure, the
   door will not respond to the toggle
*/
module Tester(isClosed, toggle, pressureChanging, isHighPressure, clock, reset);
	input isClosed;
	output reg toggle, pressureChanging, isHighPressure, clock, reset;

	initial  // Response
  	begin
	$display("\t\t clock  reset  toggle  pressure isHigh\t isClosed \t    Time ");
    	$monitor("\t\t %b\t %b\t  %b\t   %b\t   %b\t  %b", clock, reset, toggle, 
						pressureChanging, isHighPressure, isClosed, $time);
  	end

  	parameter stimDelay = 20;

  	initial
  	begin
  					reset = 'b1; toggle = 'b0; pressureChanging = 'b0; isHighPressure = 'b0;
  					clock = 'b0;
  		#stimDelay  reset = 'b0;
  		#stimDelay  clock = 'b1; toggle = 'b1;  // test toggle
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; toggle = 'b0;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; pressureChanging = 'b1;  // test pressure changes
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; toggle = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; toggle = 'b0;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; pressureChanging = 'b0;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; toggle = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; toggle = 'b0;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; pressureChanging = 'b1;  // change pressure to high
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; pressureChanging = 'b0; isHighPressure = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; toggle = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; toggle = 'b0;

	  	#(2 * stimDelay);
		$finish;
  	end

endmodule
