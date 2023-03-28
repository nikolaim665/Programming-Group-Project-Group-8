class StatisticsDataView extends DataView
{
    public StatisticsDataView(Flights flights, int x, int y, int w, int h)
    {
        super(flights, x, y, w, h);
    }

    public boolean showTextInput()
    {
        return true;
    }

    public void draw(String inputText)
    {
        super.draw(inputText);
        fill(0);
        textAlign(LEFT, TOP);
        Flights.Stats st = flights.stats(inputText);

        text("Flights from: " + (inputText.length() > 0 ? inputText + "..." : "anywhere"), x, y);
        text("Average flight delay: " + round(st.avgDelay) + " mins", x, y + 25);
        text("Average flight distance: " + round(st.avgDistance) + " miles", x, y + 50);
        text("Delayed flights: " + st.delayedCount, x, y + 75);
        text("Total flights: " + st.totalCount, x, y + 100);
    }
}
