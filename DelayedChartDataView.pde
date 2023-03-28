class DelayedChartDataView extends DataView
{
  public DelayedChartDataView(Flights flights, int x, int y, int w, int h)
  {
    super(flights, x, y, w, h);
  }

  public boolean showTextInput()
  {
    return true;
  }
  
  private void drawPiePiece(int offsetX, int offsetY, int size, int begin, int count, int total, color fillColor)
  {
    fill(fillColor);
    arc(x + offsetX + size / 2, y + offsetY + size / 2, size, size, 2 * PI * begin / total - PI / 2, 2 * PI * (begin + count) / total - PI / 2);
  }
  
  public void draw(String inputText)
  {
    super.draw(inputText);

    var airportData = flights.flightsFromAirport(inputText);
    
    // Delayed flights
    drawPiePiece(20, 100, 200, 0, airportData.delayedCount, airportData.totalCount, #F80000);
    text("Delayed flights (" + airportData.delayedCount + ")", x + 15, y + 20);
    drawPiePiece(20, 100, 200, airportData.delayedCount, airportData.totalCount - airportData.delayedCount, airportData.totalCount, #00EE00);
    text("Flights on time ("+ (airportData.totalCount - airportData.delayedCount) + ")", x + 15, y + 40);
    
    
    // Diverted flights
    int divertedOrCancelled = airportData.totalDiverted + airportData.totalCancelled;
    int normalFlights = airportData.totalCount - divertedOrCancelled;
    drawPiePiece(250, 100, 200, 0, airportData.totalDiverted, airportData.totalCount, #F80000);
    text("Diverted flights (" + airportData.totalDiverted + ")", x + 250, y + 20);
    drawPiePiece(250, 100, 200, airportData.totalDiverted, airportData.totalCancelled, airportData.totalCount, #0000FF);
    text("Cancelled flights (" + airportData.totalCancelled + ")", x + 250, y + 40);
    drawPiePiece(250, 100, 200, divertedOrCancelled, normalFlights, airportData.totalCount, #00EE00);
    text("Regular flights (" + normalFlights + ")", x + 250, y + 60);
  }
}
