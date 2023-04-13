class FlightsByAirportDataView extends BarChartDataView
{
  private FlightCount[] airports = {};
  private static final int MAX_AIRPORTS = 161;
  private int sumOfRest = 0;

  public FlightsByAirportDataView(Flights flights, int x, int y, int w, int h)
  {
    super(flights, x, y, w, h);
  }

  protected void filterUpdated()
  {
    airports = flights.getSortedAirports(filter);
    
    sumOfRest = 0;
    for (int i = MAX_AIRPORTS, len = airports.length; i < len; ++i)
    {
        sumOfRest += airports[i].count;
    }
    
    super.filterUpdated();
  }
  
  protected int getBarCount()
  {
    return min(airports.length, MAX_AIRPORTS + 1);
  }

  protected int getBarValue(int i)
  {
    return i < MAX_AIRPORTS ? airports[i].count : sumOfRest;
  }

  protected String getBarLabel(int i)
  {
    return "";
  }

  protected String getBarDescription(int i)
  {
    if (i < MAX_AIRPORTS)
    {
        int ratio = (int)max(1, 10000L * airports[i].count / flights.size());
        return airports[i].category + " (" + ratio / 100 + "." + ratio % 100 + "%)";
    }
    else
    {
        int ratio = (int)max(1, 10000L * sumOfRest / flights.size());
        return "Other (" + ratio / 100 + "." + ratio % 100 + "%)";
    }
  }
}
