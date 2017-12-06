


module startblock(inbit, go, clk, reset);
	input logic inbit, clk, reset;
	
	output logic go;
	
	logic [8:0] count;
	
	always_ff @(posedge clk or posedge reset) begin
		if(reset) begin
			go <= 0;
			count <= 0;
		end else if(inbit | (count != 0)) begin
			go <= 1'b1;
			if(count == 158) begin
				count <= 0;
			end else begin
				count <= count + 1'b1;
			end
		end else begin
			go <= 0;
		end
	end
	
	/*
	always_ff @(posedge clk or posedge reset or posedge go) begin
		if(reset) begin
			count <= 0;
		end else if(go & (count != 158)) begin
			count <= count + 1'b1;
		end else if ((count == 158)) begin
			count <= 0;
		end else begin
			count <= 0;
		end
	end
	*/
	
	
endmodule
