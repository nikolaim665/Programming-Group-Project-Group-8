Flights flights;
PImage usaMap;
PFont f;
int flightCountClick = 0;
Menu menu;

void settings()
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}
void setup()
{
  FlightLoader loader = new FlightLoader("flights_sample.csv");
  flights = loader.load();
  f = createFont("Arial",16,true); // Arial, 16 point, anti-aliasing on


  //the weird width and x-position of the map are to make the image fit perfectly
  //usa map image width = 600, height = 400

  //make sure to add usa_map_with_airports.jpeg file

  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  usaMap = loadImage("usa_map_with_airports.jpeg");
  usaMap.resize(MAP_WIDTH, MAP_HEIGHT); // C. O'Sull resized the map and changed screen dimensions to give space for the extra information 10.05 16/03/23
  image(usaMap, -10, 0);

  println("Flight count:", flights.size());
  
  menu = new Menu(MAP_WIDTH+290, 0, 40, 30, 10);
  menu.addButton("Delayed flights");
  menu.addButton("Cancelled flight");
  menu.addButton("Flight avg. speed");
}

void draw()
{
  Flight flight = flights.get(flightCountClick);
  noStroke();
  fill(255, 255, 0);
  rect(MAP_WIDTH-10, 0, 400, SCREEN_HEIGHT);
  fill(255);
  
  rect(MAP_WIDTH+390, 0, SCREEN_WIDTH-MAP_WIDTH-10, SCREEN_HEIGHT); // C. O'Sull updated the screen to show the 3 parts. 
  textFont(f,16);
  textAlign(LEFT, BASELINE);
  fill(0);
  text("FlightDate: " + flight.flightDate, 700, 25);
  text("carrierCode: " + flight.carrierCode, 700, 50);
  text("flightNumber: " + flight.flightNumber, 700, 75);
  text("originAirportCode: " + flight.originAirportCode, 700, 100);
  text("originCityName: " + flight.originCityName, 700, 125);
  text("originStateCode: " + flight.originStateCode, 700, 150);
  text("originWorldAreaCode: " + flight.originWorldAreaCode, 700, 175);
  text("destinationAirportCode: " + flight.destinationAirportCode, 700, 200);
  text("destinationCityName: " + flight.destinationCityName, 700, 225);
  text("destinationStateCode: " + flight.destinationStateCode, 700, 250);
  text("destinationWorldAreaCode: " + flight.destinationWorldAreaCode, 700, 275);
  text("scheduledDeparture: " + flight.scheduledDeparture, 700, 300);
  text("actualDeparture: " + flight.actualDeparture, 700, 325);
  text("scheduledArrival: " + flight.scheduledArrival, 700, 350);
  text("actualArrival: " + flight.actualArrival, 700, 375);
  text("isCancelled: " + flight.isCancelled, 700, 400);
  text("isDiverted: " + flight.isDiverted, 700, 425);
  text("distance: " + flight.distance, 700, 450);
  
  rect(MAP_WIDTH+290, 0, SCREEN_WIDTH-MAP_WIDTH-10, SCREEN_HEIGHT); // C. O'Sull updated the screen to show the 3 parts. 
  
  menu.draw();
}
void keyReleased()
{
  if (flightCountClick < flights.size() - 1)
    {
      flightCountClick++;
    }
   else
   {
     flightCountClick = 0;
   }
}
void mouseReleased()
{
  if (flightCountClick < flights.size() - 1)
    {
      flightCountClick++;
    }
   else
   {
     flightCountClick = 0;
   }
}
  
