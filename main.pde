Flights flights;
PImage usaMap;
PFont font;
int flightCountClick = 0;
Menu menu;
DataView dataView;
TextInput textInput;

void settings()
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}
void setup()
{
  flights = new FlightLoader("flights_sample.csv").load();
  
  font = createFont("Arial",16,true); // Arial, 16 point, anti-aliasing on
  textFont(font, 16);


  //usa map image width = 600, height = 400
  //make sure to add usa_map_with_airports.jpeg file
  //the weird width and x-position of the map are to make the image fit perfectly
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  usaMap = loadImage("usa_map_with_airports.jpeg");
  usaMap.resize(MAP_WIDTH, MAP_HEIGHT);
  
  // The menu for switching between displayed content in DataView
  menu = new Menu(MAP_EDGE, 0, SCREEN_WIDTH - MAP_EDGE, MENU_HEIGHT, 30, 10);
  menu.addButton("Flight info");
  menu.addButton("Delayed flights");
  menu.addButton("Flight avg. speed");
  
  menu.addButton("In. flights to states");
  menu.addButton("Out. flights from states");
  menu.addButton("Cum. flights in states");

  dataView = new DataView(flights, MAP_WIDTH + MAP_OFFSET, MENU_HEIGHT, SCREEN_WIDTH - MAP_EDGE, SCREEN_HEIGHT - MENU_HEIGHT);
  
  //don't remove, need to be in the same scope as flights
  assignFlightsToStates(flights.flights, stateCodes);

  menu.addButton("Statistics");

  dataView = new DataView(flights, MAP_WIDTH + MAP_OFFSET, MENU_HEIGHT, SCREEN_WIDTH - MAP_EDGE, SCREEN_HEIGHT - MENU_HEIGHT);
  textInput = new TextInput(SCREEN_WIDTH - 250, 0, 240, MENU_HEIGHT);

}

void draw()
{
  background(0);
  image(usaMap, MAP_OFFSET, 0);
  
  dataView.draw(flightCountClick, textInput.getText());
  menu.draw();
  
  if (dataView.getView() != 0)
  {
    textInput.draw();
  }
  
  int clickedButton = menu.clickedButton();
  if (clickedButton >= 0)
  {
    dataView.setView(clickedButton);
  }
  
  //determineTypeOfBarchart("Incoming");
}
void mouseReleased()
{
  if (dataView.getView() == 0 && dataView.isMouseOver())
  {
    flightCountClick = (flightCountClick + 1) % flights.size();
  }
}
void keyPressed()
{
  if (dataView.getView() != 0)
  {
    textInput.handleInput(key, keyCode);
  }
  else if (key == CODED)
  {
    if (keyCode == LEFT)
    {
      flightCountClick = (flightCountClick - 1 + flights.size()) % flights.size();
    }
    else if (keyCode == RIGHT)
    {
      flightCountClick = (flightCountClick + 1) % flights.size();
    }
  }
  

  
}
