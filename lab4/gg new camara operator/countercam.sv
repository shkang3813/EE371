

module countercam (up, down, clk, reset, count, buffdata);
	input logic up, down, clk, reset;
	output logic [6:0] count;
	output logic [7:0] buffdata;

	
	
	logic [31:0]  divided_clocks;
	//initial
	//	divided_clocks <= 0;
	
	
	always_ff @(posedge clk) begin
		if (reset) begin
			divided_clocks <= 0;
		end else begin
			divided_clocks <= divided_clocks + 1;
		end
		
	end
		
		
	logic clkdiv2;
	//set div clk to 23 for normal use. set to 0 for testing
	//always_ff @(posedge divided_clocks[0]) begin
	always_ff @(posedge reset or posedge divided_clocks[21]) begin
		if (reset) begin
			count <= 7'b0;
			clkdiv2 <= 1'b0;
		end else if (up) begin
			clkdiv2 <= clkdiv2 + 1'b1;
			if (clkdiv2) begin
				if (count < 100) begin
					count <= count + 1'b1;
				end
			end
		end else if (down) begin
			if (count > 0) begin
				count <= count - 1'b1;
			end
		
		end 
		
	end
	
	
	always_comb begin
		if(reset) begin
			buffdata = 0;
		end else if (count >= 90) begin
			buffdata = 8'b1001;
		end else if ((count >= 80) & (count < 90)) begin
			buffdata = 8'b1000;
		end else if ((count >= 70) & (count < 80)) begin
			buffdata = 8'b1000;
		end else if ((count >= 60) & (count < 70)) begin
			buffdata = 8'b1000;
		end else if ((count >= 50) & (count < 60)) begin
			buffdata = 8'b1000;
		end else if ((count >= 40) & (count < 50)) begin
			buffdata = 8'b1000;
		end else if ((count >= 30) & (count < 40)) begin
			buffdata = 8'b1000;
		end else if ((count >= 20) & (count < 30)) begin
			buffdata = 8'b1000;
		end else if ((count >= 10) & (count < 20)) begin
			buffdata = 8'b1000;
		end else if ((count >= 0) & (count < 10)) begin
			buffdata = 8'b1000;
		end else begin
			buffdata = 0;
		end
	end
	
	

endmodule 



module countercam_testbench();
	logic up, down, clk, reset;
	logic [6:0] count;
	logic [7:0] buffdata;
	
	
	countercam dut (.up, .down, .clk, .reset, .count, .buffdata);
	
	//setup the clock
	parameter CLOCK_PERIOD=100;
	initial begin	
		clk<= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	integer i, j, k;
	//set up the inputs to the design. Each line is a clock cycle.
	initial begin
			reset <= 1;
			up <= 0;
			down <= 0;
			@(posedge clk);
			reset <= 0;
			
			for (i=0; i < 110; i++) begin
				@(posedge clk);
			end
			up <= 1;
			for (j=0; j < 510; j++) begin
				@(posedge clk);
			end
			up <= 0;
			down <= 1;
			for (k=0; k < 110; k++) begin
				@(posedge clk);
			end
			@(posedge clk);
			
			
																								

		$stop; // end the simulation.
	end
endmodule
