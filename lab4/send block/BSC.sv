


module BSC(clk, reset, transmiting, midpoint);
	input logic clk, reset, transmiting;
	output logic midpoint;
	
	logic [3:0] count;
	always_ff @(posedge clk or posedge reset) begin
		if(reset) begin
			count <= 0;
		end else if(transmiting  | (count2 != 0)) begin
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
	
	logic [3:0] count2;
	always_ff @(posedge midpoint or posedge reset) begin
		if(reset) begin
			count2 <= 0;
		end else if ((count2 == 9)) begin
			count2 <= 0;
		end else begin
			count2 <= count2 + 1'b1;
		end 
	end
	
endmodule


