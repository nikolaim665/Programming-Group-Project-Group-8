import java.io.FileReader;

class FlightLoader
{
  private String filepath;
  
  public FlightLoader(String filepath)
  {
    this.filepath = filepath;
  }
    
  public Flights load()
  {
    try (BufferedReader reader = new BufferedReader(new FileReader(filepath)))
    {
      var flights = new ArrayList<Flight>();
      
      String flightDate, carrierCode;
      int flightNumber;
      String originAirportCode, originCityName, originStateCode;
      int originWorldAreaCode;
      String destinationAirportCode, destinationCityName, destinationStateCode;
      int destinationWorldAreaCode;
      int scheduledDeparture, actualDeparture, scheduledArrival, actualArrival;
      boolean isCancelled, isDiverted;
      float distance;

      String firstLine = reader.readLine();
      while (firstLine != null)
      {
        flightDate = firstLine;
        carrierCode = reader.readLine();
        flightNumber = parseInt(reader.readLine());
        originAirportCode = reader.readLine();
        originCityName = reader.readLine();
        originStateCode = reader.readLine();
        originWorldAreaCode = parseInt(reader.readLine());
        destinationAirportCode = reader.readLine();
        destinationCityName = reader.readLine();
        destinationStateCode = reader.readLine();
        destinationWorldAreaCode = parseInt(reader.readLine());
        scheduledDeparture = parseInt(reader.readLine());
        actualDeparture = parseInt(reader.readLine());
        scheduledArrival = parseInt(reader.readLine());
        actualArrival = parseInt(reader.readLine());
        isCancelled = reader.read() == '1'; reader.readLine();
        isDiverted = reader.read() == '1'; reader.readLine();
        distance = parseFloat(reader.readLine());

        flights.add(new Flight(
          flightDate, carrierCode, flightNumber, originAirportCode, originCityName, originStateCode, originWorldAreaCode,
          destinationAirportCode, destinationCityName, destinationStateCode, destinationWorldAreaCode,
          scheduledDeparture, actualDeparture, scheduledArrival, actualArrival, isCancelled, isDiverted, distance
        ));
        firstLine = reader.readLine();
      }
      return new Flights(flights);
    }
    catch (Exception e)
    {
      return new Flights(new ArrayList<Flight>());
    }
  }
}
