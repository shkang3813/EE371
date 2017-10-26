`include "con8to12.v"

module con8to12Testbench();
	wire [7:0] numberin;
	wire [11:0] HEXwrite;

	con8to12 convert (numberin[7:0], HEXwrite[11:0]);
	Tester tester (numberin[7:0], HEXwrite[11:0]);

	// file for gtkwave
  	initial begin
  		$dumpfile("con8to12.vcd");
  		$dumpvars(1, convert);
	end

endmodule

/*
** Things to test **
1) reset sets the output to low
2) a second start signal before the pressurization has completed
does not restart the pressurization process
*/
module Tester(numberin, HEXwrite);
	input [11:0] HEXwrite;
	output reg [7:0] numberin;

	initial  // Response
  	begin
	$display("\t\t numberin\t HEXwrite \t    Time ");
    	$monitor("\t\t %b\t %b", numberin, HEXwrite, $time);
  	end

  	parameter stimDelay = 20;
	
	
  	initial
  	begin
		
		#stimDelay; numberin = 'b00000000;
		#stimDelay; numberin = 'b00000001;
		#stimDelay; numberin = 'b00000010;
		#stimDelay; numberin = 'b00000100;
		#stimDelay; numberin = 'b00001000;
		#stimDelay; numberin = 'b00010000;
		#stimDelay; numberin = 'b00100000;
		#stimDelay; numberin = 'b01000000;
		#stimDelay; numberin = 'b10000000;
		

	  	#(2 * stimDelay);
		$finish;
  	end

endmodule

