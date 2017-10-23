// Runs a FSM for the space shuttle arrival procedure
module ArrivalWorkflow(busy, startPressurizing, startDepressurizing,
		start, odClosed, idClosed, isHighPressure, clock, reset);

	input start, odClosed, idClosed, isHighPressure, clock, reset;
	output reg busy, startPressurizing, startDepressurizing;

	reg [3:0] ps;
	parameter [3:0]
		A = 'b0000,
		B = 'b0001,
		C = 'b0010,
		D = 'b0011,
		E = 'b0100,
		F = 'b0101,
		G = 'b0110,
		H = 'b0111,
		I = 'b1000;

	always @(posedge clock or posedge reset) begin
		if (reset) begin
			startPressurizing <= 'b0;
			startDepressurizing <= 'b0;
			busy <= 'b0;
			ps   <= A;
		end
		else if (ps == A && start) begin
			busy <= 'b1;
			ps   <= B;
		end
		else if (ps == B && odClosed && idClosed) begin
			startDepressurizing <= 'b1;
			ps <= C;
		end
		else if (ps == C) begin
			startDepressurizing <= 'b0;  // turn off signal
			ps <= D;
		end
		else if (ps == D && !isHighPressure) begin
		    ps <= E;
		end
		else if (ps == E && !odClosed) begin
			ps <= F;
		end
		else if (ps == F && odClosed) begin
			startPressurizing <= 'b1;
			ps <= G;
		end
		else if (ps == G) begin
			startPressurizing <= 'b0;  // turn off signal
			ps <= H;
		end
		else if (ps == H && isHighPressure) begin
			ps <= I;
		end
		else if (ps == I && !idClosed) begin
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
