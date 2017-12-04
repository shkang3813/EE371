



module sendblock(clk, reset, transmiting, load, busin, outbit, whichbit);
	input logic clk, reset, transmiting, load;
	input logic [7:0] busin;
	output logic outbit;
	output logic [3:0] whichbit;
	
	logic midpoint;
	SendBSC bitcounter (.clk, .reset, .transmiting, .midpoint);
	SendBIC bitidenity (.reset, .transmiting, .midpoint, .count(whichbit));
	logic srclk;
	SRclock thisclock (.midpoint, .srclk);
	par2seri sendingblk (.clk, .srclk, .load, .reset, .busin, .outbit);
	
endmodule






//deturmans when bits are read
module SendBSC(clk, reset, transmiting, midpoint);
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
	end
	
	always_ff @(posedge clk) begin
		if(count == 4'b0111) begin
			midpoint <= 1;
		end else begin
			midpoint <= 0;
		end
	end
	
endmodule

//keeps track of which bit will be sent next ie. 0000 means the next bit sent will be a start bit 
//count is character sent
module SendBIC(reset, transmiting, midpoint, count);
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
	output logic outbit;
	
	logic [3:0] count, count2, count3;
	//logic full;
	
	always_ff @(negedge load) begin
		if(reset) begin
			count <= 0;
		//	full <= 0;
		end else if (~(count == 4'b1001)) begin
			count <= count + 1'b1;
		//	full <= 0;
		end else if (count == 4'b1001) begin
			count <= 0;
		//	full <= 1;
		end
	end
	
	always_ff @(posedge srclk) begin
		if(reset) begin
			count2 <= 0;
			count3 <= 0;
		end else if (~(count2 == 4'b1001)) begin
			count2 <= count2 + 1'b1;
		end else if (count2 == 4'b1001) begin
			count2 <= 0;
			if (count3 == 4'b1001) begin
				//if (/*(full == 0) & */(count == count3)) begin
				//	count3 <= count3;
				//end else begin
					count3 <= 0;
					//full <= 0;
				//end
			end else begin
				//if (/*(full == 0) & */(count == count3)) begin
				//	count3 <= count3;
				//end else begin
					count3 <= count3 + 4'b1;
				//end
			end
		end
	end
	/*
	always_ff @(posedge srclk or negedge load)begin
		if(reset) begin
			full <= 0;
		end else if (~(count == 4'b1001)) begin
			full <= 0;
		end else if (count == 4'b1001) begin
			full <= 1;
		end
		
		if (count3 == 4'b1001) begin
			if (~((full == 0) & (count == count3))) begin
				full <= 0;
			end 
		end 
		
	end
	*/
	
	
	logic [9:0] holder;
	logic [7:0] readdata;
	always_ff @(posedge srclk) begin
		if (reset) begin
			holder <= 0;
		end else if (count2 == 4'b0000) begin
			//if((full == 1) | ~(count == count3)) begin
				holder <= {1'b1, readdata, 1'b0};
			//end
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
		
	tenByteBuffer outbuff (.read(count3), .write(count), .dataWr(busin), .clk, .writeEn(load), .reset, .readdata);
	
	assign outbit = holder[9];
	
endmodule






//read picks which item (0 to 9) you want to read
//write picks which item you want to overwrite
//dataWr is the data you are writing into the location picked by write
//writeEn enables the overwrite
//readdata gives the data stored at the location picked by read

module tenByteBuffer (read, write, dataWr, clk, writeEn, reset, readdata);
	input logic [3:0] read, write;
	input logic [7:0] dataWr;
	input logic clk, writeEn, reset;
	output logic [7:0] readdata;
	
	logic [9:0] enWr;
	sendDecoder de (.in(write), .out(enWr));
	
	logic [9:0][7:0] datakept;
	
	genvar i;
	generate
		for (i=0; i<10; i++) begin : eachdata
			sendBuild bil (.enable(enWr), .writeEn(writeEn), .reset(reset), .clk(clk), .dataWr(dataWr), .dataHeld(datakept[i][7:0]));
		end
	endgenerate
	
	sendReadpross re (.read(read), .dataCurrent(datakept), .readout(readdata));
	
endmodule


module sendDecoder(in, out);
	
	input logic [3:0] in;
	output logic [9:0] out;
	
	assign out[0] = (~in[3] & ~in[2] & ~in[1] & ~in[0]);
	assign out[1] = (~in[3] & ~in[2] & ~in[1] & in[0]);
	assign out[2] = (~in[3] & ~in[2] & in[1] & ~in[0]);
	assign out[3] = (~in[3] & ~in[2] & in[1] & in[0]);
	assign out[4] = (~in[3] & in[2] & ~in[1] & ~in[0]);
	assign out[5] = (~in[3] & in[2] & ~in[1] & in[0]);
	assign out[6] = (~in[3] & in[2] & in[1] & ~in[0]);
	assign out[7] = (~in[3] & in[2] & in[1] & in[0]);
	assign out[8] = (in[3] & ~in[2] & ~in[1] & ~in[0]);
	assign out[9] = (in[3] & ~in[2] & ~in[1] & in[0]);
	
endmodule 


module sendBuild (enable, writeEn, reset, clk, dataWr, dataHeld);
	input logic enable, writeEn, reset, clk;
	input logic [7:0] dataWr;
	output logic [7:0] dataHeld;
	
	logic go;
	assign go = enable & writeEn;
	
	genvar i;
	generate
		for(i=0; i<8; i++) begin : eachdff
			sendImpsendD_FF currentReg(.enab(go), .newinput(dataWr[i]), .reset(reset), .clk(clk), .valueout(dataHeld[i]));
		end
	endgenerate
	
endmodule


module sendImpsendD_FF (enab, newinput, reset, clk, valueout);

	input enab, newinput, reset, clk;
	output valueout;
	
	logic notenab, a, b, c, oldinput;
	
	not n1 (notenab, enab);
	
	//changes value to the new value when enabled. otherwise keeps the old
	and a1 (a, newinput, enab);
	and a2 (b, oldinput, notenab);
	or o1 (c, a, b);
	sendD_FF regi (.q(oldinput), .d(c), .reset(reset), .clk(clk));
	assign valueout = oldinput;
	
endmodule


module sendD_FF (q, d, reset, clk);
	output reg q;
	input d, reset, clk;
	
	always_ff @(posedge clk)
	if (reset)
		q <= 0; // On reset, set to 0
	else
		q <=d; // Otherwise out = d
endmodule 


module sendReadpross (read, dataCurrent, readout);
	input [3:0] read;
	input [9:0][7:0] dataCurrent;
	output [7:0] readout;
	
	logic [9:0] active;
	sendDecoder decRead(.in(read), .out(active));

	genvar i;
	generate 
		for(i=0; i<8; i++) begin : eachbit
		
			sendMuxthis condence (.bt({dataCurrent[9][i], dataCurrent[8][i], 
				dataCurrent[7][i], dataCurrent[6][i], dataCurrent[5][i],
				dataCurrent[4][i], dataCurrent[3][i], dataCurrent[2][i],
				dataCurrent[1][i], dataCurrent[0][i]}),
				.active, .readoutbit(readout[i]));
			
		end
	endgenerate
	
endmodule


module sendMuxthis (bt, active, readoutbit);
	input logic [9:0] bt, active;
	output logic readoutbit;
	
	logic [9:0] temp;
	genvar i;
	generate
		for(i=0; i<10; i++) begin : eachbit
			assign temp[i] = bt[i] & active[i];
		end
	endgenerate
	assign readoutbit = (temp[0] | temp[1] | temp[2] | temp[3] | temp[4] | temp[5] | 
						temp[6] | temp[7] | temp[8] | temp[9]);
	
endmodule




















