PShape usaMap;
Menu menu;
DataViews dataViews;
TextInput textInput;

void settings()
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}
void setup()
{
  Flights flights = new FlightLoader("flights_sample.csv").load();
  
  // Arial, 16 point, anti-aliasing on
  textFont(createFont("Arial", 16, true)); 

  //usa map image width = 600, height = 400
  //make sure to add usa_map_with_airports.jpeg file
  //the weird width and x-position of the map are to make the image fit perfectly
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  usaMap = loadShape("usa.svg");
  
  // The menu for switching between displayed content in DataViews
  menu = new Menu(MAP_WIDTH, 0, DATAVIEW_WIDTH, MENU_HEIGHT, 30, 10);
  menu.addButton("Flight info");
  menu.addButton("Delayed flights");
  menu.addButton("Statistics");
  menu.addButton("Flights by state");

  // The DataViews showing various information, statistics, etc.
  dataViews = new DataViews();
  dataViews.add(new TextInfoDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  dataViews.add(new PieChartDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  dataViews.add(new StatisticsDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  dataViews.add(new FlightsByStateDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT, flights.getFlightsByStates()));
  
  textInput = new TextInput(SCREEN_WIDTH - 250, 0, 240, MENU_HEIGHT);
}

void draw()
{
  background(0);
  shape(usaMap, 0, 0, MAP_WIDTH, MAP_HEIGHT);
  
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
  else
  {
    dataViews.handleKey(key, keyCode);
  }
}
