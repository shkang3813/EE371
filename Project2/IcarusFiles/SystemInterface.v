`include "Door.v"
`include "Pressure.v"
`include "ArrivalWorkflow.v"
`include "DepartureWorkflow.v"

module SystemInterface(idClosed, odClosed, pressure[7:0], arrival, departure,
		startArrival, startDeparture, inChamber, idToggle, odToggle, clock, reset);
	input startArrival, startDeparture, inChamber, idToggle, odToggle, clock, reset;
	output idClosed, odClosed, arrival, departure;
	output[7:0] pressure;

	wire arrivalForce, departureForce;  // workflows can force parts of the system to freeze
	assign wForce = arrivalForce || departureForce;

	// Pressure
	wire startPressurizing, startDepressurizing;
	Pressure pressureTracker(pressure, startPressurizing, startDepressurizing, clock, reset);

	// Doors and door inputs
	wire pressureChanging;
	assign pressureChanging = startPressurizing || startDepressurizing;
	assign isLowPressure = (pressure < 'b00000101);  // pressure less than .1
	assign isHighPressure = (pressure > 'b01010000);  // pressure greater than .9
	Door id(idClosed, idToggle, pressureChanging, isHighPressure, wForce, clock, reset);
	Door od(odClosed, odToggle, pressureChanging, isLowPressure, wForce, clock, reset);

	// Workflows
	wire arrivalBusy, departureBusy;
	assign arrival = arrivalBusy;
	assign departure = departureBusy;
	reg isFive = 'b1;
	ArrivalWorkflow arrivalWorkflow(arrivalBusy, startPressurizing, startDepressurizing,
			arrivalForce, (startArrival && !arrivalBusy && !departureBusy), isFive, inChamber, odClosed, idClosed, pressure, clock, reset);
endmodule
