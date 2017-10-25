`include "Pressure.v"

module PressureTestbench();
	wire startPressurization, startDepressurization, clock, reset;
	wire[7:0] pressure;

	Pressure dut(pressure[7:0], startPressurization, startDepressurization, clock, reset);
	Tester tester(pressure[7:0], startPressurization, startDepressurization, clock, reset);

	// file for gtkwave
  	initial begin
  		$dumpfile("Pressure.vcd");
  		$dumpvars(1, pressure);
	end
endmodule

module Tester(pressure[7:0], startPressurization, startDepressurization, clock, reset);
	output reg startPressurization, startDepressurization, clock, reset;
	input[7:0] pressure;

	initial  // Response
  	begin
	$display("\t\t clock  reset\tstartPres startDepres \t pressure  Time ");
    	$monitor("\t\t %b\t %b  \t  %b \t    %b \t    %b", clock, reset, startPressurization, 
					startDepressurization, pressure, $time );
  	end

  	parameter stimDelay = 20;
    integer i;

  	initial
  	begin
  					reset = 'b1; startPressurization = 'b0; startDepressurization = 'b0;
                    clock = 'b0;
  		#stimDelay  reset = 'b0;
  		#stimDelay  clock = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1; startDepressurization = 'b1;  // advance to state B
  		for (i = 0; i < 21; i++) begin
            #stimDelay clock = 'b1;
            #stimDelay clock = 'b0;
        end
  		#stimDelay  clock = 'b1; startDepressurization = 'b0;
  		#stimDelay  clock = 'b0;
        #stimDelay  clock = 'b1;
  		#stimDelay  clock = 'b0;
  		#stimDelay  clock = 'b1;
        #stimDelay  clock = 'b0;
        #stimDelay  clock = 'b1; startPressurization = 'b1;  // advance to state B
        for (i = 0; i < 28; i++) begin
            #stimDelay clock = 'b1;
            #stimDelay clock = 'b0;
        end
        #stimDelay  clock = 'b1; startPressurization = 'b0;

	  	#(2 * stimDelay);
		$finish;
  	end
endmodule
