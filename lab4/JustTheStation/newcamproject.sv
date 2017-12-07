

// Start      -> 's' -> 01110011
// Download 1 -> 'd' -> 01100100
// Download 2 -> 'f' -> 01100110
// rtd 1      -> 'g' -> 01100111
// rtd 2      -> 'h' -> 01101000
// -			  -> '-' -> 00101101
// 0          -> '0' -> 00110000


module newcamproject(clock, reset, bicS, dataIn, dataOut, transmit, load, camData1, camData2, cam1stn, cam2stn);
	input logic clock, reset;
	input logic [3:0] bicS;
	input logic [7:0] dataIn;
	output logic [7:0] dataOut;
	output logic transmit, load;
	output logic [6:0] camData1, camData2;
	output logic [5:0] cam1stn, cam2stn;
	
	
	logic ReToDload1, ReToDload2;
	logic [7:0] buffdataout;
	logic [6:0] datacam1n, datacam2n;
	
	logic start, download1, download2;
	
	cameramanager manage (.startsys(start), .downloadresponce1(download1), .downloadresponce2(download2), .clk(clock), .reset, .cam1stn, .cam2stn,
								.ReToDload1, .ReToDload2, .datacam1n, .datacam2n, .buffdataout);
	
	assign start = (dataIn == 8'b01110011);
	assign download1 = (dataIn == 8'b01100100);
	assign download2 = (dataIn == 8'b01100100);
	
	assign camData1 = datacam1n;
	assign camData2 = datacam2n;
	
	logic [7:0] placeh1, placeh2, placeh3, placeh4;
	assign placeh1 = 8'b01110010;  // rtd 1
	assign placeh2 = 8'b01110010;  // rtd 2
	assign placeh3 = 8'b00110000;
	assign placeh4 = placeh3 + buffdataout;
	
	genvar i;
	generate 
		for (i=0; i<8; i++) begin : eachready
			assign dataOut[i] = ((placeh1[i] & ReToDload1) | (placeh2[i] & ReToDload2) | (placeh4[i] & (cam1stn[4] | cam2stn[4]) & ~(ReToDload1 | ReToDload2)));
		end
	endgenerate
	
	logic [7:0] temppi1, temppi2;
	always_ff @(posedge clock) begin
		temppi1 <= dataOut;
		//temppi2 <= temppi1;
		if(dataOut != temppi1 && dataOut != 0
				&& cam1stn != 6'b100000 && cam2stn != 6'b100000) begin
			load <= 1'b1;
		end else begin
			load <= 0;
		end
	end
	
	always_ff @(posedge clock or posedge reset) begin
		if(reset) begin
			transmit <= 0;
		end else if(load) begin
			transmit <= 1'b1;
		end else if (transmit && bicS < 1) begin
			transmit <= 1'b1;
		end else begin
			transmit <= 0;
		end
	end
	
	/*
	logic [4:0] count;
	logic minu;
	assign minu = (bicS == 4'b1001);
	always_ff @(posedge clock or posedge reset) begin
		if(reset) begin
			count <= 0;
		end else if (load == 1'b1) begin
			count <= count + 1'b1 - minu;
		end else begin
			count <= count - minu;
		end
	end
	
	assign transmit = (count != 0);
	*/
	
endmodule 