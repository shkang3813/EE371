
//read picks which item (0 to 9) you want to read
//write picks which item you want to overwrite
//dataWr is the data you are writing into the location picked by write
//writeEn enables the overwrite
//readdata gives the data stored at the location picked by read

module tenbytebuffer (read, write, dataWr, clk, writeEn, reset, readdata);
	input logic [3:0] read, write;
	input logic [7:0] dataWr;
	input logic clk, writeEn, reset;
	output logic [7:0] readdata;
	
	logic [9:0] enWr;
	decoder de (.in(write), .out(enWr));
	
	logic [9:0][7:0] datakept;
	
	genvar i;
	generate
		for (i=0; i<10; i++) begin : eachdata
			build bil (.enable(enWr), .writeEn, .reset, .clk, .dataWr, .dataHeld(datakept[i][7:0]));
		end
	endgenerate
	
	readpross re (.read, .dataCurrent(datakept), .readout(readdata));
	
endmodule


module decoder(in, out);
	
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


module build (enable, writeEn, reset, clk, dataWr, dataHeld);
	input logic enable, writeEn, reset, clk;
	input logic [7:0] dataWr;
	output logic [7:0] dataHeld;
	
	logic go;
	assign go = enable & writeEn;
	
	genvar i;
	generate
		for(i=0; i<8; i++) begin : eachdff
			impD_FF regCurrent(.enab(go), .newinput(dataWr[i]), .reset, .clk, .valueout(dataHeld[i]));
		end
	endgenerate
	
endmodule


module impD_FF (enab, newinput, reset, clk, valueout);

	input enab, newinput, reset, clk;
	output valueout;
	
	logic notenab, a, b, c, oldinput;
	
	not n1 (notenab, enab);
	
	//changes value to the new value when enabled. otherwise keeps the old
	and a1 (a, newinput, enab);
	and a2 (b, oldinput, notenab);
	or o1 (c, a, b);
	D_FF regi (.q(oldinput), .d(c), .reset, .clk);
	assign valueout = oldinput;
	
endmodule


module D_FF (q, d, reset, clk);
	output reg q;
	input d, reset, clk;
	
	always_ff @(posedge clk)
	if (reset)
		q <= 0; // On reset, set to 0
	else
		q <=d; // Otherwise out = d
endmodule 


module readpross (read, dataCurrent, readout);
	input [3:0] read;
	input [9:0][7:0] dataCurrent;
	output [7:0] readout;
	
	logic [9:0] active;
	decoder decRead(.in(read), .out(active));

	genvar i;
	generate 
		for(i=0; i<8; i++) begin : eachbit
		
			muxthis condence (.bt({dataCurrent[9][i], dataCurrent[8][i], 
				dataCurrent[7][i], dataCurrent[6][i], dataCurrent[5][i],
				dataCurrent[4][i], dataCurrent[3][i], dataCurrent[2][i],
				dataCurrent[1][i], dataCurrent[0][i]}),
				.active, .readoutbit(readout[i]));
			
		end
	endgenerate
	
endmodule


module muxthis (bt, active, readoutbit);
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




