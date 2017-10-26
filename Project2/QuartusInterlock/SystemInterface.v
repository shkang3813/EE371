module SystemInterface(idClosed, odClosed, pressure[7:0], fiveCount[5:0], arrival,
		departure, startArrival, startDeparture, idToggle, odToggle, clock, reset);
	// System inputs and outputs
	input startArrival, startDeparture, idToggle, odToggle, clock, reset;
	output idClosed, odClosed, arrival, departure;
	output[7:0] pressure;
	output[5:0] fiveCount;

	// Pressure
	wire aStartPress, aStartDepress, dStartPress, dStartDepress;
	Pressure pressureTracker(pressure, (aStartPress || dStartPress),
			(aStartDepress || dStartDepress), clock, reset);

	// Doors and door inputs
	wire pressureChanging, isLowPressure, isHighPressure;
	assign pressureChanging = aStartPress || aStartDepress || dStartPress || dStartDepress;
	assign isLowPressure = (pressure < 8'b00001010);  // pressure less than .1
	assign isHighPressure = (pressure > 8'b01010000 && pressure < 8'b01101110);  // pressure greater than .9
	Door id(idClosed, idToggle, pressureChanging, isHighPressure, clock, reset);
	Door od(odClosed, odToggle, pressureChanging, isLowPressure, clock, reset);

	// Workflows
	wire arrivalBusy, departureBusy;
	assign arrival = arrivalBusy;
	assign departure = departureBusy;
	wire isFive, fiveCounterActive;
	assign fiveCounterActive = (startArrival || startDeparture
			|| arrivalBusy || departureBusy);  // want the counter to start right at the start of signal
	FiveCounter fiveCounter(isFive, fiveCount, clock, ~fiveCounterActive);
	ArrivalWorkflow arrivalWorkflow(arrivalBusy, aStartPress, aStartDepress,
			(startArrival && !arrivalBusy && !departureBusy), isFive,
			odClosed, idClosed, pressure, clock, reset);
	DepartureWorkflow departureWorkflow(departureBusy, dStartPress, dStartDepress,
			(startDeparture && !arrivalBusy && !departureBusy), isFive,
			odClosed, idClosed, pressure, clock, reset);
endmodule
