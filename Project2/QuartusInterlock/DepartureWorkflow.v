// Runs a FSM for the space shuttle departure procedure
module DepartureWorkflow(busy, startPressurizing, startDepressurizing,
        start, isFive, odClosed, idClosed, pressure[7:0], clock, reset);

    input start, isFive, odClosed, idClosed, clock, reset;
    input [7:0] pressure;
    output reg busy, startPressurizing, startDepressurizing;
	 
	 //wire actualStart;
	 //RegisterSignal register(actualStart, start, clock, reset);

    // measures of low and high pressure
    assign isLowPressure = (pressure < 8'b00001010);
    assign isHighPressure = (pressure > 8'b01011010 && pressure < 8'b01101110);

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
        I = 'b1000,
		  J = 'b1001;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            startPressurizing <= 'b0;
            startDepressurizing <= 'b0;
            busy <= 'b0;
            ps   <= A;
        end
        else if (ps == A && start) begin
            busy <= 'b1;  // accept the request, start the workflow
				if (isHighPressure)
					ps <= D;
				else
					ps <= B;
        end
        else if (ps == B && odClosed && idClosed) begin
        	if (pressure > 8'b01101110)
            	startDepressurizing <= 'b1;  // doors closed, fix pressure
            else
            	startPressurizing <= 'b1;
            ps <= C;
        end
        else if (ps == C && isHighPressure) begin
            startDepressurizing <= 'b0;
            startPressurizing <= 'b0;
            ps <= D;  // can now open inner door
        end
        else if (ps == D && !idClosed && isFive) begin
            ps <= E;  // door is open, wait for ship to enter
        end
        else if (ps == E && idClosed) begin
            startDepressurizing <= 'b1;  // door closed, begin depressurizing
            ps <= F;
        end
        else if (ps == F && isLowPressure) begin
            startDepressurizing <= 'b0;
            ps <= G;  // chamber has been pressurized, wait for outer door to open
        end
        else if (ps == G && !odClosed) begin
            ps <= H;  // opened, now close again
        end
        else if (ps == H && odClosed) begin
        	startPressurizing <= 'b1;
        	ps <= I;
        end
        else if (ps == I && isHighPressure) begin
		   startPressurizing <= 'b0;
        	ps <= J;
        end
        else if (ps == J && !idClosed) begin
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
