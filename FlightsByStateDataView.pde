class FlightsByStateDataView extends DataView
{
    protected Flights.StateStats[] stateStats;
    protected final int upperLimit, markerDistance;

    public FlightsByStateDataView(Flights flights, int x, int y, int w, int h, Flights.StateStats[] stateStats)
    {
        super(flights, x, y, w, h);
        this.stateStats = stateStats;

        int maximum = 0;
        for (int i = 0; i < stateStats.length; ++i)
        {
            maximum = max(maximum, stateStats[i].flights);
        }
        markerDistance = floor(pow(10, floor(log(maximum / 5) / log(10))));
        upperLimit = ceil(maximum / float(markerDistance)) * markerDistance;
    }
    
    public void draw(String inputText)
    {
        super.draw(inputText);
        color[] colors = {#FF0000, #00FF00, #0000FF};
        noStroke();

        int marginLeft = 80, marginRight = 100, marginTop = 20, marginBottom = 20;
        int innerW = w - marginRight - marginLeft, innerH = h - marginTop - marginBottom;
        int innerX = x + marginLeft, innerY = y + marginTop;

        float barWidth = float(innerW) / stateStats.length;
        for (int i = 0; i < stateStats.length; ++i)
        {
            fill(colors[i % colors.length]);
            int barHeight = innerH * stateStats[i].flights / upperLimit;
            rect(innerX + barWidth * i, innerY + innerH - barHeight, int(barWidth), barHeight);
        }

        fill(0);
        rect(innerX - 2, innerY, 2, innerH);
        rect(innerX - 2, innerY + innerH, innerW + 2, 2);
        textAlign(RIGHT, CENTER);
        
        for (int markerPos = 0; markerPos <= upperLimit; markerPos += markerDistance)
        {
          int markerY = innerY + innerH - innerH * markerPos / upperLimit;
          rect(innerX - 8, markerY, 6, 2);
          text(str(markerPos), innerX - 10, markerY - 3);
        }
    }
}
