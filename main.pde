ArrayList<Flight> flights;

void setup()
{
  FlightLoader loader = new FlightLoader("flights_sample.csv");
  flights = loader.load();
  
  // Print the loaded information to verify that out FlightLoader works correctly
  println("Flight count:", flights.size());
  
  for (int i = 0; i < flights.size(); ++i)
  {
    Flight flight = flights.get(i);
    
    println("===== Flight", i, "=====");
    println("flightDate:", flight.flightDate);
    println("carrierCode:", flight.carrierCode);
    println("flightNumber:", flight.flightNumber);
    println("originAirportCode:", flight.originAirportCode);
    println("originCityName:", flight.originCityName);
    println("originStateCode:", flight.originStateCode);
    println("originWorldAreaCode:", flight.originWorldAreaCode);
    println("destinationAirportCode:", flight.destinationAirportCode);
    println("destinationCityName:", flight.destinationCityName);
    println("destinationStateCode:", flight.destinationStateCode);
    println("destinationWorldAreaCode:", flight.destinationWorldAreaCode);
    println("scheduledDeparture:", flight.scheduledDeparture);
    println("actualDeparture:", flight.actualDeparture);
    println("scheduledArrival:", flight.scheduledArrival);
    println("actualArrival:", flight.actualArrival);
    println("isCancelled:", flight.isCancelled);
    println("isDiverted:", flight.isDiverted);
    println("distance:", flight.distance);
  }
}

void draw()
{

}
