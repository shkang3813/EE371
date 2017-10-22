module Door(isClosed, toggle, pressureChanging, clock, reset);
	input toggle, pressureChanging, clock, reset;
	output reg isClosed;

	always @(posedge clock or posedge reset) begin
		if (reset) begin
			isClosed <= 'b1;
		end
		else if (pressureChanging) begin
			isClosed <= 'b1;
		end
		else if (toggle) begin
			isClosed <= ~isClosed;
		end
	end

endmodule
