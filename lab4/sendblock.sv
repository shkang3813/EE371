


//deturmans when bits are read
module BSC(clk, reset, transmiting, midpoint);
	input logic clk, reset, transmiting;
	output logic midpoint;
	
	logic [3:0] count;
	always_ff @(posedge clk) begin
		if(reset) begin
			count <= 0;
		end else if(transmiting) begin
			count <= count + 4'b1;
		end else
			count <= 0;
		end
		
		if(count == 4'b0111) begin
			midpoint <= 1;
		end else
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
			count <= count + 1;
		end else if (count == 4'b1001) begin
			count <= 0;
		end
	end
	
endmodule

//S/R Clock control... not exactly nessisary. here to match the block diagram.
module SRclock(midpoint, srclk);
	input logic midpoint;
	output logic srclk;
	assign srclk = midpoint;
endmodule


//send a load signal every time you want to add a byte to the send buffer
//busin is the data you plan on sending
//outbit is the bit sent to the other...
//designed to not send anything if the buffer has not been updated
//only sends new values 
//allows for new data to be added while transsmiting without corupting the data currently being sent
//note avoid sending more than 10 data sets in rapid succession. data will be lost.
module par2seri(clk, srclk, load, reset, busin, outbit);
	input logic clk, srclk, load, reset;
	input logic [7:0] busin;
	output logic outbit
	
	logic [3:0] count, count2, count3;
	logic full;
	
	always_ff @(negedge load) begin
		if(reset) begin
			count <= 0;
			full <= 0;
		end else if (~(count == 4'b1001)) begin
			count <= count + 1;
			full <= 0;
		end else if (count == 4'b1001) begin
			count <= 0;
			full <= 1;
		end
	end
	
	always_ff @(posedge srclk) begin
		if(reset) begin
			count2 <= 0;
			count3 <= 0;
		end else if (~(count2 == 4'b1001)) begin
			count2 <= count2 + 1;
		end else if (count2 == 4'b1001) begin
			count2 <= 0;
			if (count3 == 4'b1001) begin
				if ((full == 0) & (count == count3)) begin
					count3 <= count3;
				end else begin
					count3 <= 0;
					full <= 0;
				end
			end else begin
				if ((full == 0) & (count == count3)) begin
					count3 <= count3;
				end else begin
					count3 <= count3 + 4'b1;
				end
			end
		end
	end
	
	logic [9:0] holder;
	logic [7:0] readdata
	always_ff @(posedge srclk) begin
		if (reset) begin
			holder <= 0;
		end else if (count2 == 4'b0000) begin
			if((full == 1) | ~(count == count3)) begin
				holder <= {1'b1, readdata, 1'b0};
			end
		end else begin
			holder[9] <= holder [8];
			holder[8] <= holder [7];
			holder[7] <= holder [6];
			holder[6] <= holder [5];
			holder[5] <= holder [4];
			holder[4] <= holder [3];
			holder[3] <= holder [2];
			holder[2] <= holder [1];
			holder[1] <= holder [0];
			end
	end
		
	tenbytebuffer outbuff (.read(count3), .write(count), .dataWr(busin), .clk, .writeEn(load), .reset, .readdata);
	
	assign outbit = holder[9];
	
endmodule






















