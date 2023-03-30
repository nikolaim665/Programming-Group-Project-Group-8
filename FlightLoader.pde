import java.io.FileInputStream;

class FlightLoader
{
  private String filepath;
  private byte[] buffer = new byte[1024*1024*64];
  private int i = 0, len = 0;
  
  public FlightLoader(String filepath)
  {
    this.filepath = filepath;
  }

  private int nextInt()
  {
    int result = 0;
    while (i < len && buffer[i] != '\n')
    {
      result = result * 10 + buffer[i] - '0';
      ++i;
    }
    ++i;
    return result;
  }

  private byte nextByte()
  {
    byte result = buffer[i];
    while (i < len && buffer[i] != '\n')
    {
      ++i;
    }
    ++i;
    return result;
  }
    
  private String nextString()
  {
    int begin = i;
    while (i < len && buffer[i] != '\n')
    {
      ++i;
    }
    ++i;
    return new String(buffer, 0, begin, i - begin - 1);
  }
    
  public Flights load()
  {
    try (FileInputStream reader = new FileInputStream(filepath))
    {
      len = reader.read(buffer);
    }
    catch(Exception exc) {}
    
    var flights = new ArrayList<Flight>();
    
    String flightDate, carrierCode;
    int flightNumber;
    String originAirportCode, originCityName, originStateCode;
    int originWorldAreaCode;
    String destinationAirportCode, destinationCityName, destinationStateCode;
    int destinationWorldAreaCode;
    int scheduledDeparture, actualDeparture, scheduledArrival, actualArrival;
    boolean isCancelled, isDiverted;
    int distance;

    while (i < len)
    {
      flightDate = nextString();
      carrierCode = nextString();
      flightNumber = nextInt();
      originAirportCode = nextString();
      originCityName = nextString();
      originStateCode = nextString();
      originWorldAreaCode = nextInt();
      destinationAirportCode = nextString();
      destinationCityName = nextString();
      destinationStateCode = nextString();
      destinationWorldAreaCode = nextInt();
      scheduledDeparture = nextInt();
      actualDeparture = nextInt();
      scheduledArrival = nextInt();
      actualArrival = nextInt();
      isCancelled = nextByte() == '1';
      isDiverted = nextByte() == '1';
      distance = nextInt();

      flights.add(new Flight(
        flightDate, carrierCode, flightNumber, originAirportCode, originCityName, originStateCode, originWorldAreaCode,
        destinationAirportCode, destinationCityName, destinationStateCode, destinationWorldAreaCode,
        scheduledDeparture, actualDeparture, scheduledArrival, actualArrival, isCancelled, isDiverted, distance
      ));
    }
    return new Flights(flights);
  }
}
