

module cameramanager (startsys, downloadresponce1, downloadresponce2, clk, reset, cam1stn, cam2stn,
								ReToDload1, ReToDload2, datacam1n, datacam2n, buffdataout);
	input logic startsys, downloadresponce1, downloadresponce2, clk, reset;
	output logic [5:0] cam1stn, cam2stn;
	// 0: lowpower state
	// 1: standby state
	// 2: active state
	// 3: idle state
	// 4: downloading state
	// 5: flushing state
	output logic ReToDload1, ReToDload2;
	output logic [6:0] datacam1n, datacam2n;
	output logic [7:0] buffdataout;
	
	logic [7:0] buffdatacam1, buffdatacam2;
	genvar i; 
	generate 
		for (i=0; i<8; i++) begin : eachbuff
			assign buffdataout[i] = ((buffdatacam1[i] & cam1stn[4]) | (buffdatacam2[i] & cam2stn[4]));
		end
	endgenerate
	
	
	logic [3:0] interst1, interst2;
	// 0: sending flush
	// 1: sending ready to download
	// 2: sending go to standby
	// 3: sending start filming
	
	logic [5:0] cam1st, cam2st;
	logic [6:0] datacam1, datacam2;
	
	logic cam1standby, cam1star;
	assign cam1standby = cam2st[0] | interst2[2]; 
	assign cam1star = startsys | interst2[3];
	assign ReToDload1 = interst1[1];
	assign ReToDload2 = interst2[1];
	
	camerastate camera1 (.GoToStandbyIN(cam1standby), .StartFilmingIN(cam1star), .DownloadIN(downloadresponce1), 
					.FlushIN(interst2[0]), .clk, .reset,
					.lowpowerstate(cam1st[0]), .standbystate(cam1st[1]), .activestate(cam1st[2]),
					.idlestate(cam1st[3]), .downloadingstate(cam1st[4]), .flushstate(cam1st[5]),
					.ForceflushOUT(interst1[0]), .ReadyToDownloadOUT(interst1[1]), .GoToStandbyOUT(interst1[2]), 
					.StartFilmingOUT(interst1[3]),
					.data(datacam1), .buffdata(buffdatacam1));
					
	camerastate camera2 (.GoToStandbyIN(interst1[2]), .StartFilmingIN(interst1[3]), .DownloadIN(downloadresponce2),
					.FlushIN(interst1[0]), .clk, .reset,
					.lowpowerstate(cam2st[0]), .standbystate(cam2st[1]), .activestate(cam2st[2]), 
					.idlestate(cam2st[3]), .downloadingstate(cam2st[4]), .flushstate(cam2st[5]),
					.ForceflushOUT(interst2[0]), .ReadyToDownloadOUT(interst2[1]), .GoToStandbyOUT(interst2[2]), 
					.StartFilmingOUT(interst2[3]),
					.data(datacam2), .buffdata(buffdatacam2));
					
	
	assign cam1stn = cam1st;
	assign cam2stn = cam2st;
		
	assign datacam1n = datacam1;
	assign datacam2n = datacam2;
	

endmodule


module cameramanager_testbench();
	logic startsys, downloadresponce1, downloadresponce2, clk, reset;
	logic [5:0] cam1stn, cam2stn;
	logic ReToDload1, ReToDload2;
	logic [6:0] datacam1n, datacam2n;
	logic [7:0] buffdataout;
	
	
	cameramanager dut (.startsys, .downloadresponce1, .downloadresponce2, .clk, .reset, .cam1stn, .cam2stn, .ReToDload1, .ReToDload2, .datacam1n, .datacam2n, .buffdataout);
	
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
			startsys <= 0;
			downloadresponce1 <= 0;
			downloadresponce2 <= 0;
						
			for (i=0; i < 10; i++) begin
				@(posedge clk);
			end
			
			reset <= 0;
			startsys <= 1;
			@(posedge clk);
			@(posedge clk);
			startsys <= 0;
			
			for (j=0; j < 380; j++) begin
				@(posedge clk);
			end
			
			downloadresponce1 <= 1;
			downloadresponce2 <= 1;
			@(posedge clk);
			downloadresponce1 <= 0;
			downloadresponce2 <= 0;
			
			for (k=0; k < 480; k++) begin
				@(posedge clk);
			end
			
			downloadresponce1 <= 1;
			downloadresponce2 <= 1;
			@(posedge clk);
			downloadresponce1 <= 0;
			downloadresponce2 <= 0;
			
			for (k=0; k < 1000; k++) begin
				@(posedge clk);
			end
			
			@(posedge clk);
			
			
																								

		$stop; // end the simulation.
	end
endmodule
