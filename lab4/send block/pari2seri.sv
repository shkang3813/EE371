


module pari2seri(load, srclk, reset, databyte, outbit);
	input logic load, srclk, reset;
	input logic [7:0] databyte;
	output logic outbit;
	
	logic [9:0][7:0] dataheld;
	logic [3:0] count, count2, count3;
	logic [9:0] senddata;
	
	always_ff @(posedge load or posedge reset) begin
		if(reset)begin
			dataheld[0] <= 0;
			dataheld[1] <= 0;
			dataheld[2] <= 0;
			dataheld[3] <= 0;
			dataheld[4] <= 0;
			dataheld[5] <= 0;
			dataheld[6] <= 0;
			dataheld[7] <= 0;
			dataheld[8] <= 0;
			dataheld[9] <= 0;
			count <= 0;
		end else if (count == 0) begin
			dataheld[0] <= databyte;
			count <= count + 1'b1;
		end else if (count == 1) begin
			dataheld[1] <= databyte;
			count <= count + 1'b1;
		end else if (count == 2) begin
			dataheld[2] <= databyte;
			count <= count + 1'b1;
		end else if (count == 3) begin
			dataheld[3] <= databyte;
			count <= count + 1'b1;
		end else if (count == 4) begin
			dataheld[4] <= databyte;
			count <= count + 1'b1;
		end else if (count == 5) begin
			dataheld[5] <= databyte;
			count <= count + 1'b1;
		end else if (count == 6) begin
			dataheld[6] <= databyte;
			count <= count + 1'b1;
		end else if (count == 7) begin
			dataheld[7] <= databyte;
			count <= count + 1'b1;
		end else if (count == 8) begin
			dataheld[8] <= databyte;
			count <= count + 1'b1;
		end else if (count == 9) begin
			dataheld[9] <= databyte;
			count <= 0;
		end else begin
			count <= 0;
		end
	end
	
	
	always_ff @(posedge srclk or posedge reset) begin
		if(reset) begin
			count2 <= 0;
			count3 <= 0;
		end else if(count2 == 9) begin
			count2 <= 0;
			if(count3 == 9) begin
				count3 <= 0;
			end else begin
				count3 <= count3 + 1'b1;
			end
		end else begin
			count2 <= count2 + 1'b1;
		end
	end
	
	always_ff @(posedge srclk or posedge reset) begin
		if(reset) begin
			senddata <= 0;
		end else if (count2 == 0)begin
			if(count3 == 0) begin
				senddata <= {1'b1, dataheld[0], 1'b0};
			end else if (count3 == 1) begin
				senddata <= {1'b1, dataheld[1], 1'b0};
			end else if (count3 == 2) begin
				senddata <= {1'b1, dataheld[2], 1'b0};
			end else if (count3 == 3) begin
				senddata <= {1'b1, dataheld[3], 1'b0};
			end else if (count3 == 4) begin
				senddata <= {1'b1, dataheld[4], 1'b0};
			end else if (count3 == 5) begin
				senddata <= {1'b1, dataheld[5], 1'b0};
			end else if (count3 == 6) begin
				senddata <= {1'b1, dataheld[6], 1'b0};
			end else if (count3 == 7) begin
				senddata <= {1'b1, dataheld[7], 1'b0};
			end else if (count3 == 8) begin
				senddata <= {1'b1, dataheld[8], 1'b0};
			end else if (count3 == 9) begin
				senddata <= {1'b1, dataheld[9], 1'b0};
			end 
		end else begin
			senddata[9] <= senddata[8];
			senddata[8] <= senddata[7];
			senddata[7] <= senddata[6];
			senddata[6] <= senddata[5];
			senddata[5] <= senddata[4];
			senddata[4] <= senddata[3];
			senddata[3] <= senddata[2];
			senddata[2] <= senddata[1];
			senddata[1] <= senddata[0];
		end
	end
	
	assign outbit = senddata[9];
	
endmodule



module pari2seri_testbench();
	logic load, srclk, reset;
	logic [7:0] databyte;
	logic outbit;
	
	pari2seri dut (.load, .srclk, .reset, .databyte, .outbit);
	
	
	integer i;
	
	initial begin
		reset <= 1; 
		load <= 0;
		srclk <= 0;
		databyte <= 0;
		#1000;
		reset <= 0;
		#1000;
		
		
		for(i=0; i<10; i++)begin
			load <= 1;
			databyte[7:0] = i;
			#500;
			load <= 0;
			#500;
			
		end
		
		for(i=0; i<400; i++)begin
			srclk <= 1;
			#40;
			srclk <= 0;
			#800;
		end
		

		$stop;
	end
	
endmodule







