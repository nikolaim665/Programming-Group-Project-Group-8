abstract class FlightsByStateDataView extends DataView
{
    protected Flights.StateStats[] stateStats;
    protected final int maxFlights;

    public FlightsByStateDataView(Flights flights, int x, int y, int w, int h, Flights.StateStats[] stateStats)
    {
        super(flights, x, y, w, h);
        this.stateStats = stateStats;

        int maximum = 0;
        for (int i = 0; i < stateStats.length; ++i)
        {
            maximum = max(maximum, getFlightCount(i));
        }
        maxFlights = maximum;
    }

    abstract protected int getFlightCount(int i);

    public void draw(String inputText)
    {
        super.draw(inputText);
        color[] colors = {#FF0000, #00FF00, #0000FF};
        noStroke();
        int barWidth = w / stateStats.length;

        for (int i = 0; i < stateStats.length; ++i)
        {
            fill(colors[i % colors.length]);
            int barHeight = h * getFlightCount(i) / maxFlights;
            rect(x + barWidth * i, y + h - barHeight, barWidth, barHeight);
        }
    }
}
