import java.util.HashMap;

// Class representing the entire dataset of flights and contains methods for querying the dataset.
class Flights
{
  private Flight[] flights;

  public Flights(Flight[] flights)
  {
    this.flights = flights;
  }
  
  public int getMinDate()
  {
    return flights[0].flightDate;
  }
  
  public int getMaxDate()
  {
    return flights[flights.length - 1].flightDate;
  }

  public int size()
  {
    return flights.length;
  }

  public Flight get(int i)
  {
    return flights[i];
  }
  
  class Statistics
  {
    public final float avgDistance;
    public final float avgDelay;
    public final int delayed;
    public final int total;
    public final int diverted;
    public final int cancelled;
   
    public Statistics(float avgDistance, float avgDelay, int delayed, int total, int diverted, int cancelled)
    {
      this.avgDistance = avgDistance;
      this.avgDelay = avgDelay;
      this.delayed = delayed;
      this.total = total;
      this.diverted = diverted;
      this.cancelled = cancelled;
    }
  }
  
  public Statistics getStatistics(Filter filter)
  {
    float totalDistance = 0, totalDelay = 0;
    int total = 0, delayed = 0, diverted = 0, cancelled = 0;
    for (Flight flight : flights)
    {
      if (filter.matches(flight))
      {
        ++total;
        totalDistance += flight.distance;
        
        if (flight.actualArrival > flight.scheduledArrival && flight.actualArrival <= 1440)
        {
          ++delayed;
          totalDelay += flight.actualArrival - flight.scheduledArrival;
        }
        if (flight.isDiverted)
        {
          ++diverted;
        }
        if (flight.isCancelled)
        {
          ++cancelled;
        }
      }
    }
    // We don't want to divide by zero, as program crashes have a negative impact on user experience
    if (total == 0)
    {
      return new Statistics(0, 0, 0, 0, 0, 0);
    }
    return new Statistics(totalDistance / total, totalDelay / total, delayed, total, diverted, cancelled);
  }

  // Return states and their numbers of incoming flights which match the filter, as an array
  public FlightCount[] getFlightsByStates(Filter filter)
  {
    int stateCount = 0;
    int[] flightsByStates = new int[STATE_CODES.length];
    
    for (Flight flight: flights)
    {
      if (filter.matches(flight))
      {
        if (flightsByStates[flight.destinationStateCode] == 0)
        {
          ++stateCount;
        }
        ++flightsByStates[flight.destinationStateCode];
      }
    }

    FlightCount[] result = new FlightCount[stateCount];
    for (int i = 0, dest = 0; i < STATE_CODES.length; ++i)
    {
      if (flightsByStates[i] > 0)
      {
        result[dest] = new FlightCount(STATE_CODES[i], flightsByStates[i]);
        ++dest;
      }
    }
    return result;
  }

  public FlightCount[] getFlightsByStates()
  {
    return getFlightsByStates(new Filter());
  }

  // Get first flight matching the given criteria when going from i-th flight in a specified direction
  public int firstMatching(Filter filter, int i, int direction)
  {
    int begin = i, len = flights.length;
    boolean ok = true;
    i = (i + len) % len;
    while (!(ok = filter.matches(flights[i])))
    {
      i = (i + direction + len) % len;
      if (i == begin)
      {
        break;
      }
    }
    return ok ? i : -1;
  }

  // Return airports and their numbers of incoming flights which match the filter, as a HashMap
  public HashMap<String, Integer> getAirports(Filter filter)
  {
    var flightsByAirport = new HashMap<String, Integer>();
    for (Flight flight: flights)
    {
      if (filter.matches(flight))
      {
        flightsByAirport.put(flight.destinationAirportCode, flightsByAirport.getOrDefault(flight.destinationAirportCode, 0) + 1);
      }
    }
    return flightsByAirport;
  }

  // Return airports and numbers of incoming flights which match the filter, as a sorted array
  public FlightCount[] getSortedAirports(Filter filter)
  {
    var flightsByAirport = getAirports(filter);
    var airports = new FlightCount[flightsByAirport.size()];
    int i = 0;
    for (var entry: flightsByAirport.entrySet())
    {
      airports[i] = new FlightCount(entry.getKey(), entry.getValue());
      ++i;
    }
    FlightCount.sort(airports);
    return airports;
  }
}
