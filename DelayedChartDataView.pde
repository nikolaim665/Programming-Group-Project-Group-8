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

  public void draw(String inputText)
  {
    super.draw(inputText);

    var airportData = flights.flightsFromAirport(inputText);
    float angle = 2 * PI * airportData.delayedCount / airportData.totalCount;
    
    float shift = -PI / 2;
    int size = (w < h ? w : h);
    
    fill(255, 0, 0);
    arc(x + size / 2, y + size / 2, size - 100, size - 100, shift, angle + shift);
    text("Red = delayed flights: (" + airportData.delayedCount + ")", x + 50, y + 30);

    fill(0, 255, 0);
    arc(x + size / 2, y + size / 2, size - 100, size - 100, angle + shift, 2 * PI + shift);
    text("Green = flights running on time: ("+ (airportData.totalCount - airportData.delayedCount) + ")", x + 50, y + 10);
  }
}
