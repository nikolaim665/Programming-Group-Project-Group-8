class FlightsByAirportDataView extends BarChartDataView
{
  private Airport[] airports = {};

  public FlightsByAirportDataView(Flights flights, int x, int y, int w, int h)
  {
    super(flights, x, y, w, h);
  }

  protected void filterUpdated()
  {
    airports = flights.getSortedAirports(filter);
    super.filterUpdated();
  }
  
  protected int getBarCount()
  {
    return airports.length;
  }

  protected int getBarValue(int i)
  {
    return airports[i].flights;
  }

  protected String getBarLabel(int i)
  {
    return airports[i].code;
  }

  protected String getBarDescription(int i)
  {
    float percentage = (10000 * airports[i].flights / flights.size()) * 0.01;
    return airports[i].code + "\n" + percentage + "% of all flights";
  }
}
