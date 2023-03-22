// The class to represent the single flight in the flight data. Its fields are public and final (i.e. immutable) since
// we do not need the data to change after being loaded. This allows us to access the fields directly without implementing
// getter methods for all the fields.
class Flight
{
  // Flight date in the YYYY-MM-DD format
  public final String flightDate;
  // Code to identify the carrier e.g. AA.
  public final String carrierCode;
  // Flight number (combine with the carrier code to obtain the usual format).
  public final int flightNumber;
  
  // Code of the airport, where the flight started
  public final String originAirportCode;
  // Name of the city
  public final String originCityName;
  // Code of the US state
  public final String originStateCode;
  // Code of the World Area (see: https://en.wikipedia.org/wiki/World_Area_Codes)
  public final int originWorldAreaCode;
  
  // The same information for the airport, where the flight finished 
  public final String destinationAirportCode;
  public final String destinationCityName;
  public final String destinationStateCode;
  public final int destinationWorldAreaCode;
  
  // Time of the scheduled/actual departure/arrival, represented as the number of seconds since midnight.
  // -1 (minus one) is used as an indicator, if the value is missing. 
  public final int scheduledDeparture;
  public final int actualDeparture;
  public final int scheduledArrival;
  public final int actualArrival;
  
  // X-Position and Y-Position of planes on map
  public int xPosition;
  public int yPosition;
 
  // Cancelled flight indicator
  public final boolean isCancelled;
  // Diverted flight indicator
  public final boolean isDiverted;
  // Distance between the origin and destination airports in miles
  public final double distance;
  
  // Just a constructor which takes all the values as arguments and initializes all the fields.
  public Flight(String flightDate, String carrierCode, int flightNumber,
    String originAirportCode, String originCityName, String originStateCode, int originWorldAreaCode,
    String destinationAirportCode, String destinationCityName, String destinationStateCode, int destinationWorldAreaCode,
    int scheduledDeparture, int actualDeparture, int scheduledArrival, int actualArrival,
    boolean isCancelled, boolean isDiverted, double distance, int xPosition, int yPosition) //,int xPosition, int yPosition)
  {
    this.flightDate = flightDate;
    this.carrierCode = carrierCode;
    this.flightNumber = flightNumber;
    
    this.xPosition = xPosition;
    this.yPosition = yPosition;
    
    this.originAirportCode = originAirportCode;
    this.originCityName = originCityName;
    this.originStateCode = originStateCode;
    this.originWorldAreaCode = originWorldAreaCode;
    
    this.destinationAirportCode = destinationAirportCode;
    this.destinationCityName = destinationCityName;
    this.destinationStateCode = destinationStateCode;
    this.destinationWorldAreaCode = destinationWorldAreaCode;
    
    this.scheduledDeparture = scheduledDeparture;
    this.actualDeparture = actualDeparture;
    this.scheduledArrival = scheduledArrival;
    this.actualArrival = actualArrival;
    
    this.isCancelled = isCancelled;
    this.isDiverted = isDiverted;
    this.distance = distance;
  }
}
