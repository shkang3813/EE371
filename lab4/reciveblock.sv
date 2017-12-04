

module reciveblock (insignal, reset, clk, whichbit, byterecived);
	input logic insignal, reset, clk;
	output logic [3:0] whichbit;
	output logic [7:0] byterecived;
	
	logic starter;
	startreader st (.insignal, .starter, .clk, .reset);
	logic midpoint;
	BSC btcount(.clk, .reset, .transmiting(starter), .midpoint);
	BIC bittracker (.reset, .transmiting(starter), .midpoint, .count(whichbit));
	logic srclk;
	sendSRclock thisclk(.midpoint, .srclk);
	seri2par converseri (.insignal, .srclk, .byterecived, .reset);
	
	
	
endmodule



module startreader (insignal, starter, clk, reset);
	input logic insignal, clk, reset;
	output logic starter;
	
	logic [7:0] count;
	
	always_ff @(posedge clk) begin
		if (reset) begin
			starter <= 0;
			count <= 0;
		end else if(insignal & ~(count == 0)) begin
			starter <= 1;
			if(count == 158) begin
				count <= 0;
			end else begin
				count <= count + 1'b1;
			end
		end else begin
			starter <= 0;
		end
	end
	
endmodule

//deturmans when bits are read
//set transmiting to starter
module BSC(clk, reset, transmiting, midpoint);
	input logic clk, reset, transmiting;
	output logic midpoint;
	
	logic [3:0] count;
	always_ff @(posedge clk) begin
		if(reset) begin
			count <= 0;
		end else if(transmiting) begin
			count <= count + 4'b1;
		end else begin
			count <= 0;
		end
		
		if(count == 4'b0111) begin
			midpoint <= 1;
		end else begin
			midpoint <= 0;
		end
	end
	
endmodule

//keeps track of which bit will be sent next ie. 0000 means the next bit sent will be a start bit 
//count is character sent
module BIC(reset, transmiting, midpoint, count);
	input logic reset, transmiting, midpoint;
	output logic [3:0] count;
	
	always_ff @(posedge midpoint) begin
		if(reset) begin
			count <= 0;
		end else if (transmiting & ~(count == 4'b1001)) begin
			count <= count + 1'b1;
		end else if (count == 4'b1001) begin
			count <= 0;
		end
	end
	
endmodule

//S/R Clock control... not exactly nessisary. here to match the block diagram.
module sendSRclock(midpoint, srclk);
	input logic midpoint;
	output logic srclk;
	assign srclk = midpoint;
endmodule

//recoreds each incomig bit sequentialy. 
//sends out the byte that has just finished being recived. 
module seri2par (insignal, srclk, byterecived, reset);
	input logic insignal, srclk, reset;
	
	output logic [7:0] byterecived;
	logic [8:0] bitsin;
	logic [3:0] count;
	
	always_ff @(posedge srclk) begin
		if (reset) begin
			byterecived <= 0;
			bitsin <= 0;
			count <= 0;
		end else begin
			if (count == 4'b1001) begin
				count <= 0;
				byterecived[7] <= bitsin[7];
				byterecived[6] <= bitsin[6];
				byterecived[5] <= bitsin[5];
				byterecived[4] <= bitsin[4];
				byterecived[3] <= bitsin[3];
				byterecived[2] <= bitsin[2];
				byterecived[1] <= bitsin[1];
				byterecived[0] <= bitsin[0];
				
			end else begin
				count <= count + 1'b1;
				bitsin[8] <= bitsin[7];
				bitsin[7] <= bitsin[6];
				bitsin[6] <= bitsin[5];
				bitsin[5] <= bitsin[4];
				bitsin[4] <= bitsin[3];
				bitsin[3] <= bitsin[2];
				bitsin[2] <= bitsin[1];
				bitsin[1] <= bitsin[0];
				bitsin[0] <= insignal;
			end
			
		end
		
	end
	
endmodule