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
    originAirport = originAirport.toLowerCase().trim();
    float totalDistance = 0, totalDelay = 0;
    int total = 0, delayed = 0;
    for (Flight flight: flights)
    {
      if (flight.originCityName.toLowerCase().startsWith(originAirport))
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

  public class StateStats
  {
    public final String stateCode;
    public final int incomingFlights;
    public final int outgoingFlights;
    public final int totalFlights;

    public StateStats(String stateCode, int incomingFlights, int outgoingFlights, int totalFlights)
    {
      this.stateCode = stateCode;
      this.incomingFlights = incomingFlights;
      this.outgoingFlights = outgoingFlights;
      this.totalFlights = totalFlights;
    }
  }
  public StateStats[] getFlightsByStates()
  {
    final String[] stateCodes = new String[] {
      "AK","AZ","AR","CA","CO","CT","DE","FL","GA","ID","IL","IN","IA","KS","KY","LA",
      "ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ", "NM","NY","NC","ND",
      "OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"
    }; 
    var incoming = new HashMap<String, Integer>(stateCodes.length);
    var outgoing = new HashMap<String, Integer>(stateCodes.length);
    var total = new HashMap<String, Integer>(stateCodes.length);
    
    for (Flight flight: flights)
    {
      incoming.put(flight.originStateCode, incoming.getOrDefault(flight.originStateCode, 0) + 1);
      outgoing.put(flight.destinationStateCode, outgoing.getOrDefault(flight.destinationStateCode, 0) + 1);

      total.put(flight.destinationStateCode, total.getOrDefault(flight.destinationStateCode, 0) + 1);
      if (!flight.originStateCode.equals(flight.destinationStateCode))
      {
        total.put(flight.originStateCode, total.getOrDefault(flight.originStateCode, 0) + 1);
      }
    }

    StateStats[] result = new StateStats[stateCodes.length];
    for (int i = 0; i < stateCodes.length; ++i)
    {
      String code = stateCodes[i];
      result[i] = new StateStats(code, incoming.get(code), outgoing.get(code), total.get(code));
    }
    return result;
  }
}
