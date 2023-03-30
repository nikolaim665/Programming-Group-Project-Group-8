Map map;
Menu menu;
DataViews dataViews;
TextInput textInput;

void settings()
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}
void setup()
{
  // Arial, 16 point, anti-aliasing on
  textFont(createFont("Arial", 16, true));
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  Flights flights = new FlightLoader(dataPath("flights_lines.txt")).load();
  
  
  map = new Map("usa.svg", 0, 0, MAP_WIDTH, MAP_HEIGHT, flights);
  textInput = new TextInput(SCREEN_WIDTH - 250, 0, 240, MENU_HEIGHT);
  
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
  dataViews.add(new FlightsByStateDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
}

void draw()
{
  map.draw();
  menu.draw();
  textInput.draw();
  dataViews.draw();
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
  textInput.handleInput(key, keyCode);
  dataViews.setFilterText(textInput.getText());
  
  dataViews.handleKey(key, keyCode);
}
