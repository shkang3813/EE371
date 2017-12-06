

// reports whcih bit is coming next
module BIC(reset, transmiting, midpoint, count);
	input logic reset, transmiting, midpoint;
	output logic [3:0] count;
	
	
	
	always_ff @(posedge midpoint or posedge reset) begin
		if(reset) begin
			count <= 0;
		end else if (count == 4'b1001) begin
			count <= 0;
		end else if (transmiting | (count != 0)) begin
			count <= count + 1'b1;
		end else begin
			count <= 0;
		end
	end
	
	
	
endmodule
