class Flights
{
  private ArrayList<Flight> flights;
  
  public Flights(ArrayList<Flight> flights)
  {
    this.flights = flights;
  }
  
  public int size()
  {
    return flights.size();
  }
  
  public Flight get(int i)
  {
    return flights.get(i);
  }
  
  class Stats
  {
    public final float avgDistance;
    public final float avgDelay;
    public final int delayedCount;
    public final int totalCount;
    public Stats(float avgDistance, float avgDelay, int delayedCount, int totalCount)
    {
      this.avgDistance = avgDistance;
      this.avgDelay = avgDelay;
      this.delayedCount = delayedCount;
      this.totalCount = totalCount;
    }
  }
  
  public Stats stats(String originAirport)
  {
    float totalDistance = 0, totalDelay = 0;
    int total = 0, delayed = 0;
    for (Flight flight: flights)
    {
      if (flight.originCityName.startsWith(originAirport))
      {
        ++total;
        totalDistance += flight.distance;
        if (flight.actualArrival > flight.scheduledArrival && flight.scheduledArrival >= 0)
        {
          ++delayed;
          totalDelay += flight.actualArrival - flight.scheduledArrival;
        }
      }
    }
    if (total == 0)
    {
      return new Stats(0, 0, 0, 0);
    }
    return new Stats(totalDistance / total, totalDelay / total, delayed, total);
  }
}
