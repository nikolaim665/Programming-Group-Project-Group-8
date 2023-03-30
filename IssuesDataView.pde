class IssuesDataView extends DataView
{
  private Flights.FlightStats flightData;

  public IssuesDataView(Flights flights, int x, int y, int w, int h)
  {
    super(flights, x, y, w, h);
    this.filterUpdated();
  }

  private void drawPiePiece(int offsetX, int offsetY, int size, int begin, int count, int total, color fillColor)
  {
    fill(fillColor);
    arc(x + offsetX + size / 2, y + offsetY + size / 2, size, size, 2 * PI * begin / total - PI / 2, 2 * PI * (begin + count) / total - PI / 2);
  }

  private void drawText(int offsetX, int offsetY)
  {
    fill(0);
    textAlign(LEFT, TOP);
    text(filter.carrierCodePrefix.length() > 0 ? "Airline: " + filter.carrierCodePrefix + "..." : "All airlines", x + offsetX, y + offsetY);
    text("Average flight delay: " + round(flightData.avgDelay) + " mins", x + offsetX, y + offsetY + 25);
    text("Average flight distance: " + round(flightData.avgDistance) + " miles", x + offsetX, y + offsetY + 50);
    text("Delayed flights: " + flightData.delayed, x + offsetX, y + offsetY + 75);
    text("Total flights: " + flightData.total, x + offsetX, y + offsetY + 100);
  }

  protected void filterUpdated()
  {
    flightData = flights.getFlightStats(filter);
  }
  
  public void draw()
  {
    super.draw();

    // Text
    drawText(15, 15);

    // Delayed flights pie chart
    textAlign(LEFT, TOP);
    drawPiePiece(15, 150, 200, 0, flightData.delayed, flightData.total, #F80000);
    text("Delayed flights (" + flightData.delayed + ")", x + 25, y + 360);
    drawPiePiece(15, 150, 200, flightData.delayed, flightData.total - flightData.delayed, flightData.total, #00EE00);
    text("Flights on time ("+ (flightData.total - flightData.delayed) + ")", x + 25, y + 380);
    
    
    // Diverted flights pie chart
    int divertedOrCancelled = flightData.diverted + flightData.cancelled;
    int normalFlights = flightData.total - divertedOrCancelled;
    drawPiePiece(300, 150, 200, 0, flightData.diverted, flightData.total, #F80000);
    text("Diverted flights (" + flightData.diverted + ")", x + 320, y + 360);
    drawPiePiece(300, 150, 200, flightData.diverted, flightData.cancelled, flightData.total, #0000FF);
    text("Cancelled flights (" + flightData.cancelled + ")", x + 320, y + 380);
    drawPiePiece(300, 150, 200, divertedOrCancelled, normalFlights, flightData.total, #00EE00);
    text("Regular flights (" + normalFlights + ")", x + 320, y + 400);
  }
}
