class IncomingFlightsDataView extends FlightsByStateDataView
{
    public IncomingFlightsDataView(Flights flights, int x, int y, int w, int h, Flights.StateStats[] stateStats)
    {
        super(flights, x, y, w, h, stateStats);
    }

    protected int getFlightCount(int i)
    {
        return stateStats[i].incomingFlights;
    }
}
