class StatisticsDataView extends DataView
{
  private Flights.FlightStats flightData;

  public StatisticsDataView(Flights flights, int x, int y, int w, int h)
  {
    super(flights, x, y, w, h);
    this.handleFilterUpdate();
  }

  protected void handleFilterUpdate()
  {
    flightData = flights.getFlightStats(filter);
  }

  public void draw()
  {
    super.draw();
    
    fill(0);
    textAlign(LEFT, TOP);
    text("Flights by: " + (filter.carrierCodePrefix.length() > 0 ? filter.carrierCodePrefix + "..." : "all carriers"), x + 15, y + 15);
    text("Average flight delay: " + round(flightData.avgDelay) + " mins", x + 15, y + 40);
    text("Average flight distance: " + round(flightData.avgDistance) + " miles", x + 15, y + 65);
    text("Delayed flights: " + flightData.delayedCount, x + 15, y + 90);
    text("Total flights: " + flightData.totalCount, x + 15, y + 115);
  }
}
