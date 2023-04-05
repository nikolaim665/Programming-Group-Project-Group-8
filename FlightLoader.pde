import java.io.FileInputStream;

class FlightLoader
{
  private String filepath;
  private byte[] buffer = null;
  private int i = 0, len = 0;
  
  public FlightLoader(String filepath)
  {
    this.filepath = filepath;
  }

  private int nextInt()
  {
    int result = 0;
    while (i < len && buffer[i] != '\t')
    {
      result = (result << 6) | (buffer[i] - '0');
      ++i;
    }
    ++i;
    return result;
  }

  private int nextTime()
  {
    int result = buffer[i] - '0' << 6 | buffer[i + 1] - '0';
    i += 2;
    return result;
  }

  private boolean nextBoolean()
  {
    boolean result = buffer[i] == '1';
    ++i;
    return result;
  }
    
  private String nextString()
  {
    int begin = i;
    while (i < len && buffer[i] != '\t')
    {
      ++i;
    }
    ++i;
    return new String(buffer, 0, begin, i - begin - 1);
  }
    
  public Flights load()
  {
    int lineCount = 0;
    try (FileInputStream reader = new FileInputStream(filepath))
    {
      byte[] tmp = new byte[12];
      reader.read(tmp);
      len = (tmp[0] - '0') << 30 | (tmp[1] - '0') << 24 | (tmp[2] - '0') << 18
          | (tmp[3] - '0') << 12 | (tmp[4] - '0') <<  6 | (tmp[5] - '0');
      lineCount = (tmp[6] - '0') << 30 | (tmp[ 7] - '0') << 24 | (tmp[8] - '0') << 18
                | (tmp[9] - '0') << 12 | (tmp[10] - '0') <<  6 | (tmp[11] - '0');
      buffer = new byte[len];
      reader.read(buffer);
    }
    catch (Exception exc) {}
    
    var flights = new Flight[lineCount];
    
    int flightDate;
    String carrierCode;
    int flightNumber;
    String originAirportCode, originCityName, originStateCode;
    int originWorldAreaCode;
    String destinationAirportCode, destinationCityName, destinationStateCode;
    int destinationWorldAreaCode;
    int scheduledDeparture, actualDeparture, scheduledArrival, actualArrival;
    boolean isCancelled, isDiverted;
    int distance;

    for (int line = 0; i < len; ++line)
    {
      flightDate = nextInt();
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
      scheduledDeparture = nextTime();
      actualDeparture = nextTime();
      scheduledArrival = nextTime();
      actualArrival = nextTime();
      isCancelled = nextBoolean();
      isDiverted = nextBoolean();
      distance = nextInt();

      flights[line] = new Flight(
        flightDate, carrierCode, flightNumber, originAirportCode, originCityName, originStateCode, originWorldAreaCode,
        destinationAirportCode, destinationCityName, destinationStateCode, destinationWorldAreaCode,
        scheduledDeparture, actualDeparture, scheduledArrival, actualArrival, isCancelled, isDiverted, distance
      );
    }
    return new Flights(flights);
  }
}
