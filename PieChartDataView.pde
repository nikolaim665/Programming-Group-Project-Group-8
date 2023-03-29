class PieChartDataView extends DataView
{
  private Flights.CarrierFlightData flightData;

  public PieChartDataView(Flights flights, int x, int y, int w, int h)
  {
    super(flights, x, y, w, h);
    this.handleFilterTextUpdate();
  }

  private void drawPiePiece(int offsetX, int offsetY, int size, int begin, int count, int total, color fillColor)
  {
    fill(fillColor);
    arc(x + offsetX + size / 2, y + offsetY + size / 2, size, size, 2 * PI * begin / total - PI / 2, 2 * PI * (begin + count) / total - PI / 2);
  }

  protected void handleFilterTextUpdate()
  {
    flightData = flights.flightsOfCarrier(filterText);
  }
  
  public void draw()
  {
    super.draw();

    // Delayed flights
    drawPiePiece(20, 100, 200, 0, flightData.delayedCount, flightData.totalCount, #F80000);
    text("Delayed flights (" + flightData.delayedCount + ")", x + 15, y + 20);
    drawPiePiece(20, 100, 200, flightData.delayedCount, flightData.totalCount - flightData.delayedCount, flightData.totalCount, #00EE00);
    text("Flights on time ("+ (flightData.totalCount - flightData.delayedCount) + ")", x + 15, y + 40);
    
    
    // Diverted flights
    int divertedOrCancelled = flightData.totalDiverted + flightData.totalCancelled;
    int normalFlights = flightData.totalCount - divertedOrCancelled;
    drawPiePiece(250, 100, 200, 0, flightData.totalDiverted, flightData.totalCount, #F80000);
    text("Diverted flights (" + flightData.totalDiverted + ")", x + 250, y + 20);
    drawPiePiece(250, 100, 200, flightData.totalDiverted, flightData.totalCancelled, flightData.totalCount, #0000FF);
    text("Cancelled flights (" + flightData.totalCancelled + ")", x + 250, y + 40);
    drawPiePiece(250, 100, 200, divertedOrCancelled, normalFlights, flightData.totalCount, #00EE00);
    text("Regular flights (" + normalFlights + ")", x + 250, y + 60);
  }
}
