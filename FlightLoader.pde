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
    int lineCount = 0;
    try (FileInputStream reader = new FileInputStream(filepath))
    {
      byte[] tmp = new byte[18];
      reader.read(tmp);
      len = (tmp[0] - '0') << 28 | (tmp[1] - '0') << 24 | (tmp[2] - '0') << 20 | (tmp[3] - '0') << 16
          | (tmp[4] - '0') << 12 | (tmp[5] - '0') <<  8 | (tmp[6] - '0') <<  4 | (tmp[7] - '0');
      lineCount = (tmp[ 9] - '0') << 28 | (tmp[10] - '0') << 24 | (tmp[11] - '0') << 20 | (tmp[12] - '0') << 16
                | (tmp[13] - '0') << 12 | (tmp[14] - '0') <<  8 | (tmp[15] - '0') <<  4 | (tmp[16] - '0');
      buffer = new byte[len];
      reader.read(buffer);
    }
    catch(Exception exc) {}
    
    var flights = new Flight[lineCount];
    
    String flightDate, carrierCode;
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

      flights[line] = new Flight(
        flightDate, carrierCode, flightNumber, originAirportCode, originCityName, originStateCode, originWorldAreaCode,
        destinationAirportCode, destinationCityName, destinationStateCode, destinationWorldAreaCode,
        scheduledDeparture, actualDeparture, scheduledArrival, actualArrival, isCancelled, isDiverted, distance
      );
    }
    return new Flights(flights);
  }
}
