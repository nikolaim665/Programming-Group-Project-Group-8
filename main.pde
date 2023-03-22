ArrayList<Flight> flights;
PImage usaMap;


void settings()
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}
void setup()
{
  FlightLoader loader = new FlightLoader("flights_sample.csv");
  flights = loader.load();

  //the weird width and x-position of the map are to make the image fit perfectly
  //usa map image width = 600, height = 400

  //make sure to add usa_map_with_airports.jpeg file

  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  usaMap = loadImage("usa_map_with_airports.jpeg");
  usaMap.resize(MAP_WIDTH, MAP_HEIGHT); // C. O'Sull resized the map and changed screen dimensions to give space for the extra information 10.05 16/03/23
  image(usaMap, -10, 0);

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
  fill(255, 255, 0);
  rect(MAP_WIDTH-10, 0, 300, SCREEN_HEIGHT);
  fill(255);
  rect(MAP_WIDTH+290, 0, SCREEN_WIDTH-MAP_WIDTH-10, SCREEN_HEIGHT); // C. O'Sull updated the screen to show the 3 parts. 
}
