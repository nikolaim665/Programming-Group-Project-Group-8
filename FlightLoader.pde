
class FlightLoader
{
  private String filepath;
  
  public FlightLoader(String filepath)
  {
    this.filepath = filepath;
  }
  
  public ArrayList<Flight> load()
  {
    CsvParser parser = new CsvParser(filepath, 1);
    ArrayList<Flight> flights = new ArrayList<Flight>(parser.lineCount());

    while (!parser.reachedEnd())
    {
      String flightDate = parser.nextDate();
      String carrierCode = parser.next();
      int flightNumber = parser.nextInt();
      
      String originAirportCode = parser.next();
      String originCityName = parser.next();
      String originStateCode = parser.next();
      int originWorldAreaCode = parser.nextInt();
      
      String destinationAirportCode = parser.next();
      String destinationCityName = parser.next();
      String destinationStateCode = parser.next();
      int destinationWorldAreaCode = parser.nextInt();
      
      int scheduledDeparture = parser.nextTime();
      int actualDeparture = parser.nextTime();
      int scheduledArrival = parser.nextTime();
      int actualArrival = parser.nextTime();
       
      boolean isCancelled = parser.nextBoolean();
      boolean isDiverted  = parser.nextBoolean();
      double distance = parser.nextDouble();
      
      Flight flight = new Flight(flightDate, carrierCode, flightNumber, originAirportCode, originCityName, originStateCode, originWorldAreaCode,
        destinationAirportCode, destinationCityName, destinationStateCode, destinationWorldAreaCode, scheduledDeparture, actualDeparture,
        scheduledArrival, actualArrival, isCancelled, isDiverted, distance, width/2, height/2); //the width and height are temporary, will be linked to origin city
      flights.add(flight);
    }
    
    return flights;
  }
}
