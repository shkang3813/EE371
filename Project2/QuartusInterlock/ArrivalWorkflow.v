// Runs a FSM for the space shuttle arrival procedure
module ArrivalWorkflow(busy, startPressurizing, startDepressurizing,
        start, isFive, odClosed, idClosed, pressure[7:0], clock, reset);

    input start, isFive, odClosed, idClosed, clock, reset;
    input [7:0] pressure;
    output reg busy, startPressurizing, startDepressurizing;
	 
	 //wire actualStart;
	 //RegisterSignal register(actualStart, start, clock, reset);

    // measures of low and high pressure
    assign isLowPressure = (pressure < 8'b00001010);  // pressure less than .1
    assign isHighPressure = (pressure > 8'b01011010 && pressure < 8'b01101110);  // pressure greater than .9

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
            busy <= 'b1;  // accept the request, start the workflow
            if (isLowPressure)
					ps <= D;
				else
					ps <= B;
        end
        else if (ps == B && odClosed && idClosed) begin
            startDepressurizing <= 'b1;  // doors closed, start depressurizing
            ps <= C;
        end
        else if (ps == C && isLowPressure) begin
            startDepressurizing <= 'b0;
            ps <= D;  // can now open outer door
        end
        else if (ps == D && !odClosed && isFive) begin
            ps <= E;  // door is open, wait for ship to enter
        end
        else if (ps == E && odClosed) begin
            startPressurizing <= 'b1;  // door closed, begin pressurizing
            ps <= F;
        end
        else if (ps == F && isHighPressure) begin
            startPressurizing <= 'b0;
            ps <= G;  // chamber has been pressurized, wait for inner door to open
        end
        else if (ps == G && !idClosed) begin
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
