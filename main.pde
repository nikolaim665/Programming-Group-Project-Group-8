Flights flights;
PImage usaMap;
PFont font;
int flightCountClick = 0;
Menu menu;
DataViews dataViews;
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
  
  // The menu for switching between displayed content in DataViews
  menu = new Menu(MAP_EDGE, 0, SCREEN_WIDTH - MAP_EDGE, MENU_HEIGHT, 30, 10);
  menu.addButton("Flight info");
  menu.addButton("Delayed flights");
  menu.addButton("Flight avg. speed");
  
  menu.addButton("In. flights to states");
  menu.addButton("Out. flights from states");
  menu.addButton("Cum. flights in states");
  menu.addButton("Statistics");

  dataViews = new DataViews(MAP_WIDTH + MAP_OFFSET, MENU_HEIGHT, SCREEN_WIDTH - MAP_EDGE, SCREEN_HEIGHT - MENU_HEIGHT);
  dataViews.add(new TextInfoDataView(flights, dataViews.x, dataViews.y, dataViews.w, dataViews.h));
  dataViews.add(new DelayedChartDataView(flights, dataViews.x, dataViews.y, dataViews.w, dataViews.h));
  dataViews.add(new StatisticsDataView(flights, dataViews.x, dataViews.y, dataViews.w, dataViews.h));
  var stateStats = flights.getFlightsByStates();
  dataViews.add(new IncomingFlightsDataView(flights, dataViews.x, dataViews.y, dataViews.w, dataViews.h, stateStats));
  dataViews.add(new OutgoingFlightsDataView(flights, dataViews.x, dataViews.y, dataViews.w, dataViews.h, stateStats));
  dataViews.add(new TotalFlightsDataView(flights, dataViews.x, dataViews.y, dataViews.w, dataViews.h, stateStats));
  
  textInput = new TextInput(SCREEN_WIDTH - 250, 0, 240, MENU_HEIGHT);

}

void draw()
{
  background(0);
  image(usaMap, MAP_OFFSET, 0);
  
  dataViews.draw(textInput.getText());
  menu.draw();
  
  if (dataViews.showTextInput())
  {
    textInput.draw();
  }
}
void mouseReleased()
{
  int clickedButton = menu.buttonAt(mouseX, mouseY);
  if (clickedButton >= 0)
  {
    dataViews.setView(clickedButton);
  }
  else
  {
    dataViews.handleClick(mouseX, mouseY);
  }
}
void keyPressed()
{
  if (dataViews.showTextInput())
  {
    textInput.handleInput(key, keyCode);
  }
  dataViews.handleKey(key, keyCode);
}
