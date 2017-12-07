




module seri2pari(srclk, inbit, outbyte, reset);
	input srclk, inbit, reset;
	output logic [7:0] outbyte;
	
	logic [8:0] datahold;
	
	logic [3:0] count;
	
	always_ff @(posedge srclk or posedge reset) begin
		if(reset) begin
			datahold <= 0;
		end else begin
			datahold[8] <= datahold[7];
			datahold[7] <= datahold[6];
			datahold[6] <= datahold[5];
			datahold[5] <= datahold[4];
			datahold[4] <= datahold[3];
			datahold[3] <= datahold[2];
			datahold[2] <= datahold[1];
			datahold[1] <= datahold[0];
			datahold[0] <= inbit;
		end
	end
	
	always_ff @(posedge srclk or posedge reset) begin
		if(reset) begin
			count <= 0;
			outbyte <= 0;
		end else if(count == 9) begin
			outbyte <= datahold[7:0];
			count <= 0;
		end else begin
			count <= count + 1'b1;
		end
	end
	
	
	
endmodule






module seri2pari_testbench();
	logic srclk, inbit, reset;
	logic [7:0] outbyte;
	
	seri2pari dut (.srclk, .inbit, .outbyte, .reset);
	
	
	integer i;
	
	initial begin
		reset <= 1; 
		inbit <= 0;
		srclk <= 0;
		#1000;
		reset <= 0;
		#1000;
		
		
		for(i=0; i<10; i++)begin
			srclk <= 1;
			#40;
			srclk <= 0;
			#800;
		end
		
		inbit <= 1;
		for(i=0; i<10; i++)begin
			srclk <= 1;
			#40;
			srclk <= 0;
			#800;
		end
		inbit <= 0;
		
		for(i=0; i<10; i++)begin
			srclk <= 1;
			#40;
			srclk <= 0;
			#800;
		end
		
		inbit <= 1;
		srclk <= 1;
		#40;
		srclk <= 0;
		#800;
		
		inbit <= 0;
		srclk <= 1;
		#40;
		srclk <= 0;
		#800;
		
		inbit <= 1;
		srclk <= 1;
		#40;
		srclk <= 0;
		#800;
		
		inbit <= 1;
		srclk <= 1;
		#40;
		srclk <= 0;
		#800;
		
		inbit <= 0;
		srclk <= 1;
		#40;
		srclk <= 0;
		#800;
		
		inbit <= 0;
		srclk <= 1;
		#40;
		srclk <= 0;
		#800;
		
		inbit <= 1;
		srclk <= 1;
		#40;
		srclk <= 0;
		#800;
		
		inbit <= 1;
		srclk <= 1;
		#40;
		srclk <= 0;
		#800;
		
		inbit <= 1;
		srclk <= 1;
		#40;
		srclk <= 0;
		#800;
		
		inbit <= 1;
		srclk <= 1;
		#40;
		srclk <= 0;
		#800;

		$stop;
	end
	
endmodule





