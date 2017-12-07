// Start      -> 's' -> 01110011
// Download 1 -> 'd' -> 01100100
// Download 2 -> 'f' -> 01100110
// rtd 1      -> 'g' -> 01100111
// rtd 2      -> 'h' -> 01101000
// -			  -> '-' -> 00101101
// 0          -> '0' -> 00110000
module camInterface(clock, reset, bicS, bicR, dataIn, dataOut, transmit, load, camData1, camData2);
	input logic clock, reset;
	input logic [3:0] bicS, bicR;
	input logic [7:0] dataIn;
	output logic [7:0] dataOut;
	output logic transmit, load;

	// wires in and out of the camera manager
	logic start, download1, download2, rtd1, rtd2;
	output logic [6:0] camData1, camData2;
	logic [5:0] camState1, camState2;
	logic [3:0] tenOut1, tenOut2;
	
	// buffers
	logic [7:0] dataInBuf;
	logic [7:0] tenOutBuf1, tenOutBuf2;
	logic rtd1Once, rtd2Once;
	logic [7:0] tenOutActual1, tenOutActual2;
	logic startTransmit, actualStartTransmit;
	
	cameramanager manager(start, download1, download2, clock, reset,
			camState1, camState2, rtd1, rtd2, camData1, camData2,
			tenOut1, tenOut2);
			
	registerOnce rOne(rtd1, rtd1Once, clock, reset);
	registerOnce rTwo(rtd2, rtd2Once, clock, reset);
	registerOnce rThree(startTransmit, actualStartTransmit, clock, reset);
	
	assignInputs(dataInBuf, start, download1, download2, clock, reset);
	
	assignNumbers tenOne(tenOut1, tenOutActual1, clock, reset);
	assignNumbers tenTwo(tenOut2, tenOutActual2, clock, reset);
			
	always @(posedge clock) begin
		if (reset) begin
			dataInBuf <= 8'b00000000;
		end else if (bicR == 4'b1001) begin
			dataInBuf <= dataIn;
		end
	end
	
	always @(posedge clock) begin
		if (reset) begin
			dataOut <= 8'b00101101;
			tenOutBuf1 <= 8'b00000000;
			tenOutBuf2 <= 8'b00000000;
			load <= 1;
			startTransmit <= 1;
		end else if (rtd1Once) begin
			dataOut <= 8'b01100111;
			load <= 0;
			startTransmit <= 0;
		end else if (rtd2Once) begin
			dataOut <= 8'b01101000;
			load <= 0;
			startTransmit <= 0;
		end else if (camState1 == 6'b010000) begin
			if (tenOutActual1 != tenOutBuf1) begin
				dataOut <= tenOutActual1;
				tenOutBuf1 <= tenOutActual1;
				load <= 0;
				startTransmit <= 0;
			end
		end else if (camState2 == 6'b010000) begin
			if (tenOutActual2 != tenOutBuf2) begin
				dataOut <= tenOutActual2;
				tenOutBuf2 <= tenOutActual2;
				load <= 0;
				startTransmit <= 0;
			end
		end else begin
			load <= 1;
			startTransmit <= 1;
		end
	end
	
	logic stateCounter;
	always @(posedge clock) begin
		if (reset) begin
			transmit <= 0;
			stateCounter <= 0;
		end else if (actualStartTransmit) begin
			transmit <= 0;
			stateCounter <= 1;
		end else if (stateCounter) begin
			transmit <= 1;
			stateCounter <= 0;
		end else if (transmit && bicS == 1) begin
			transmit <= 0;
			stateCounter <= 0;
		end else begin
			transmit <= transmit;
			stateCounter <= stateCounter;
		end
	end
endmodule

module registerOnce(in, out, clock, reset);
	input logic in, clock, reset;
	output logic out;
	
	logic state;
	
	always @(posedge clock) begin
		if (reset) begin
			out <= 0;
			state <= 0;
		end else if (in == 1 && state == 0) begin
			out <= 1;
			state <= 1;
		end else if (in == 0 && state == 1) begin
			out <= 0;
			state <= 0;
		end else begin
			out <= 0;
			state <= state;
		end
	end
	
endmodule

module assignInputs(dataIn, start, download1, download2, clock, reset);
	input logic [7:0] dataIn;
	input logic clock, reset;
	output logic start, download1, download2;
	
	always @(posedge clock) begin
		if (reset) begin
			start <= 0;
			download1 <= 0;
			download2 <= 0;
		end else if (dataIn == 8'b01110011) begin
			start <= 1;
		end else if (dataIn == 8'b01100100) begin
			download1 <= 1;
			download2 <= 0;
		end else if (dataIn == 8'b01100110) begin
			download1 <= 0;
			download2 <= 1;
		end
	end
endmodule

module assignNumbers(tenIn, dataOut, clock, reset);
	input logic [3:0] tenIn;
	input logic clock, reset;
	output logic [7:0] dataOut;
	
	always @(posedge clock) begin
		if (reset) begin
			dataOut <= 8'b00000000;
		end else begin
			dataOut <= tenIn + 8'b00110000;
		end
	end
endmodule

