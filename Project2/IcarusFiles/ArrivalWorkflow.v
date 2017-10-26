// Runs a FSM for the space shuttle arrival procedure
module ArrivalWorkflow(busy, startPressurizing, startDepressurizing, wForce,
        start, isFive, inChamber, odClosed, idClosed, pressure[7:0], clock, reset);

    input start, isFive, inChamber, odClosed, idClosed, clock, reset;
    input [7:0] pressure;
    output reg busy, startPressurizing, startDepressurizing, wForce;

    // measures of low and high pressure
    assign isLowPressure = (pressure < 'b00000101);  // pressure less than .1
    assign isHighPressure = (pressure > 'b01010000);  // pressure greater than .9

    reg [2:0] ps;
    parameter [2:0]
        A = 'b000,
        B = 'b001,
        C = 'b010,
        D = 'b011,
        E = 'b100,
        F = 'b101,
        G = 'b110,
        H = 'b111;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            startPressurizing <= 'b0;
            startDepressurizing <= 'b0;
            wForce <= 'b0;
            busy <= 'b0;
            ps   <= A;
        end
        else if (ps == A && start) begin
            busy <= 'b1;  // accept the request, start the workflow
            ps   <= B;
        end
        else if (ps == B && odClosed && idClosed) begin
            startDepressurizing <= 'b1;  // doors closed, start depressurizing
            ps <= C;
        end
        else if (ps == C && isLowPressure && isFive) begin
            startDepressurizing <= 'b0;
            ps <= D;  // can now open outer door
        end
        else if (ps == D && !odClosed) begin
            wForce <= 'b1;  // door is open, wait for ship to enter
            ps <= E;
        end
        else if (ps == E && inChamber) begin
            wForce <= 'b0;  // allow doors to close
            ps <= F;
        end
        else if (ps == F && odClosed) begin
            startPressurizing <= 'b1;  // door closed, begin pressurizing
            ps <= G;
        end
        else if (ps == G && isHighPressure) begin
            startPressurizing <= 'b0;
            ps <= H;  // chamber has been pressurized, wait for inner door to open
        end
        else if (ps == H && !idClosed) begin
            busy <= 'b0;
            ps <= A;
        end
        else begin
            startPressurizing <= startPressurizing;
            startDepressurizing <= startDepressurizing;
            wForce <= wForce;
            ps   <= ps;
            busy <= busy;
        end
    end
endmodule
