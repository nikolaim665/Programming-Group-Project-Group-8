Flights flights;
PImage usaMap;
PFont f;
int flightCountClick = 0;
Menu menu;
DataView dataView;

void settings()
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}
void setup()
{
  FlightLoader loader = new FlightLoader("flights_sample.csv");
  flights = loader.load();
  f = createFont("Arial",16,true); // Arial, 16 point, anti-aliasing on
  textFont(f,16);


  //the weird width and x-position of the map are to make the image fit perfectly
  //usa map image width = 600, height = 400

  //make sure to add usa_map_with_airports.jpeg file

  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  usaMap = loadImage("usa_map_with_airports.jpeg");
  usaMap.resize(MAP_WIDTH, MAP_HEIGHT); // C. O'Sull resized the map and changed screen dimensions to give space for the extra information 10.05 16/03/23
  image(usaMap, -10, 0);

  println("Flight count:", flights.size());
  
  menu = new Menu(MAP_WIDTH-10, 0, SCREEN_WIDTH - MAP_WIDTH + 10, 40, 30, 10);
  menu.addButton("Flight info");
  menu.addButton("Delayed flights");
  menu.addButton("Flight avg. speed");

  dataView = new DataView(flights, MAP_WIDTH-10, 40, SCREEN_WIDTH-MAP_WIDTH+10, SCREEN_HEIGHT);
}

void draw()
{

  dataView.draw(flightCountClick);
  menu.draw();
  
  int clickedButton = menu.clickedButton();
  if (clickedButton >= 0)
  {
    dataView.setView(clickedButton);
  }
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
  if (flightCountClick < flights.size() - 1 && dataView.isMouseOver())
    {
      flightCountClick++;
    }
   else if (flightCountClick == flights.size() - 1)
   {
     flightCountClick = 0;
   }
}
  
