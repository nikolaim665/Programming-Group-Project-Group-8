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

  public int countDelayed()
  {
    int delayed = 0;
    for (Flight flight: flights)
    {
      if (flight.actualArrival > flight.scheduledArrival)
      {
        ++delayed;
      }
    }
    return delayed;
  }
}
