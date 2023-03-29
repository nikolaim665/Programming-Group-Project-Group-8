class StatisticsDataView extends DataView
{
  public StatisticsDataView(Flights flights, int x, int y, int w, int h)
  {
    super(flights, x, y, w, h);
  }

  public void draw()
  {
    super.draw();
    
    var airportData = flights.flightsByCarrier(inputText);

    fill(0);
    textAlign(LEFT, TOP);
    text("Flights by: " + (inputText.length() > 0 ? inputText + "..." : "all carriers"), x + 15, y + 15);
    text("Average flight delay: " + round(airportData.avgDelay) + " mins", x + 15, y + 40);
    text("Average flight distance: " + round(airportData.avgDistance) + " miles", x + 15, y + 65);
    text("Delayed flights: " + airportData.delayedCount, x + 15, y + 90);
    text("Total flights: " + airportData.totalCount, x + 15, y + 115);
  }
}
