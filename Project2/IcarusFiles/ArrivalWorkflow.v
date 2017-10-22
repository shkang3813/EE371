// Runs a FSM for the space shuttle arrival procedure
module ArrivalWorkflow(busy, startPressurizing, startDepressurizing,
		start, odClosed, idClosed, isHighPressure, clock, reset);

	input start, odClosed, idClosed, isHighPressure, clock, reset;
	output reg busy, startPressurizing, startDepressurizing;

	reg [2:0] ps;
	parameter [2:0]
		A = 'b000,
		B = 'b001,
		C = 'b010,
		D = 'b011,
		E = 'b100,
		F = 'b101,
		G = 'b110;

	always @(posedge clock or posedge reset) begin
		if (reset) begin
			startPressurizing <= 'b0;
			startDepressurizing <= 'b0;
			busy <= 'b0;
			ps   <= A;
		end
		else if (ps == A && start) begin
			startPressurizing <= 'b0;
			startDepressurizing <= 'b0;
			busy <= 'b1;
			ps   <= B;
		end
		else if (ps == B && odClosed && idClosed) begin
			startPressurizing <= 'b0;
			startDepressurizing <= 'b1;
			busy <= 'b1;
			ps <= C;
		end
		else if (ps == C && !isHighPressure) begin
			startPressurizing <= 'b0;
			startDepressurizing <= 'b0;
			busy <= 'b1;
		    ps <= D;
		end
		else if (ps == D && !odClosed) begin
			startPressurizing <= 'b0;
			startDepressurizing <= 'b0;
			busy <= 'b1;
			ps <= E;
		end
		else if (ps == E && odClosed) begin
			startPressurizing <= 'b1;
			startDepressurizing <= 'b0;
			busy <= 'b1;
			ps <= F;
		end
		else if (ps == F && isHighPressure) begin
			startPressurizing <= 'b0;
			startDepressurizing <= 'b0;
			busy <= 'b1;
			ps <= G;
		end
		else if (ps == G && !idClosed) begin
			startPressurizing <= 'b0;
			startDepressurizing <= 'b0;
			busy <= 'b0;
			ps <= A;
		end
		else begin
			startPressurizing <= startPressurizing;
			startDepressurizing <= startDepressurizing;
			ps   <= ps;
			busy <= busy;
		end
	end
endmodule
