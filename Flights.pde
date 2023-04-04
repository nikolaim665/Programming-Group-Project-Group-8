import java.util.HashMap;

class Flights
{
  private Flight[] flights;

  public Flights(Flight[] flights)
  {
    this.flights = flights;
  }
  
  public String getMinDate()
  {
    return flights[0].flightDate;
  }
  
  public String getMaxDate()
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

  public Airport[] getSortedAirports(Filter filter)
  {
    var flightsByAirport = new HashMap<String, Integer>();
    for (Flight flight: flights)
    {
      if (filter.matches(flight))
      {
        flightsByAirport.put(flight.destinationAirportCode, flightsByAirport.getOrDefault(flight.destinationAirportCode, 0) + 1);
        if (!flight.originAirportCode.equals(flight.destinationAirportCode))
        {
          flightsByAirport.put(flight.originAirportCode, flightsByAirport.getOrDefault(flight.originAirportCode, 0) + 1);
        }
      }
    }

    var airports = new Airport[flightsByAirport.size()];
    int i = 0;
    for (var entry: flightsByAirport.entrySet())
    {
      airports[i] = new Airport(entry.getKey(), entry.getValue());
      ++i;
    }
    return Airport.sort(airports);
  }

  public Airport[] getSortedAirports()
  {
    return getSortedAirports(new Filter());
  }
}
