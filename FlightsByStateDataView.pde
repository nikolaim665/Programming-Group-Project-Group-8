class FlightsByStateDataView extends BarChartDataView
{
  private Flights.StateFlightData[] stateFlightData = {};

  public FlightsByStateDataView(Flights flights, int x, int y, int w, int h)
  {
    super(flights, x, y, w, h);
  }

  protected void filterUpdated()
  {
    stateFlightData = flights.getFlightsByStates(filter);
    super.filterUpdated();
  }
  
  protected int getBarCount()
  {
    return stateFlightData.length;
  }

  protected int getBarValue(int i)
  {
    return stateFlightData[i].flights;
  }

  protected String getBarLabel(int i)
  {
    return stateFlightData[i].stateCode;
  }

  protected String getBarDescription(int i)
  {
    return stateFlightData[i].stateCode;
  }
}
