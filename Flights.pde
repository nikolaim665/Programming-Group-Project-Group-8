import java.util.HashMap;

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
  
  class FlightStats
  {
    public final float avgDistance;
    public final float avgDelay;
    public final int delayed;
    public final int total;
    public final int diverted;
    public final int cancelled;
   
    public FlightStats(float avgDistance, float avgDelay, int delayed, int total, int diverted, int cancelled)
    {
      this.avgDistance = avgDistance;
      this.avgDelay = avgDelay;
      this.delayed = delayed;
      this.total = total;
      this.diverted = diverted;
      this.cancelled = cancelled;
    }
  }
  
  public FlightStats getFlightStats(Filter filter)
  {
    float totalDistance = 0, totalDelay = 0;
    int total = 0, delayed = 0, diverted = 0, cancelled = 0;
    for (Flight flight : flights)
    {
      if (filter.matches(flight))
      {
        ++total;
        totalDistance += flight.distance;
        
        if (flight.actualArrival > flight.scheduledArrival && flight.scheduledArrival >= 0)
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
    if (total == 0)
    {
      return new FlightStats(0, 0, 0, 0, 0, 0);
    }
    return new FlightStats(totalDistance / total, totalDelay / total, delayed, total, cancelled, diverted);
  }

  public class StateFlightData
  {
    public final String stateCode;
    public final int flights;

    public StateFlightData(String stateCode, int flights)
    {
      this.stateCode = stateCode;
      this.flights = flights;
    }
  }

  public StateFlightData[] getFlightsByStates(Filter filter)
  {
    var flightsByStates = new HashMap<String, Integer>(STATE_CODES.length);
    
    for (Flight flight: flights)
    {
      if (filter.matches(flight))
      {
        flightsByStates.put(flight.destinationStateCode, flightsByStates.getOrDefault(flight.destinationStateCode, 0) + 1);
        if (!flight.originStateCode.equals(flight.destinationStateCode))
        {
          flightsByStates.put(flight.originStateCode, flightsByStates.getOrDefault(flight.originStateCode, 0) + 1);
        }
      }
    }

    StateFlightData[] result = new StateFlightData[STATE_CODES.length];
    for (int i = 0; i < STATE_CODES.length; ++i)
    {
      result[i] = new StateFlightData(STATE_CODES[i], flightsByStates.getOrDefault(STATE_CODES[i], 0));
    }
    return result;
  }

  public StateFlightData[] getFlightsByStates()
  {
    return getFlightsByStates(new Filter());
  }

  public int firstMatching(Filter filter, int i, int direction)
  {
    int begin = i;
    boolean ok = true;
    while (!(ok = filter.matches(flights.get(i))))
    {
      i = (i + direction + flights.size()) % flights.size();
      if (i == begin)
      {
        break;
      }
    }
    return ok ? i : -1;
  }

  public String dateRange()
  {
    String minDate = "9999-99-99", maxDate = "0000-00-00";
    for (Flight flight: flights)
    {
      if (minDate.compareTo(flight.flightDate) > 0)
      {
        minDate = flight.flightDate;
      }
      if (maxDate.compareTo(flight.flightDate) < 0)
      {
        maxDate = flight.flightDate;
      }
    }
    return minDate + "-" + maxDate;
  }
}
