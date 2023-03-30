Map map;
Menu menu;
DataViews dataViews;
TextInput textInput;
DatePicker datePicker;

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

  map = new Map("usa.svg", 0, 0, MAP_WIDTH, MAP_HEIGHT);
  textInput = new TextInput(SCREEN_WIDTH - 120, 0, 115, MENU_HEIGHT);
  
  datePicker = new DatePicker(flights, SCREEN_WIDTH - 380, 0, 220, MENU_HEIGHT);
  
  // The menu for switching between displayed content in DataViews
  menu = new Menu(MAP_WIDTH, 0, DATAVIEW_WIDTH, MENU_HEIGHT, 30, 10);
  menu.addButton("Flight info");
  menu.addButton("Airline issues");
  menu.addButton("Flights by state");
  
  // The DataViews showing various information, statistics, etc.
  dataViews = new DataViews();
  dataViews.add(new TextInfoDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  dataViews.add(new IssuesDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  dataViews.add(new FlightsByStateDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
}

void draw()
{
  map.draw();
  menu.draw();
  textInput.draw();
  datePicker.draw();
  dataViews.draw();
  
  if (mousePressed)
  {
    datePicker.mousePressed(mouseX, mouseY);
  }
}

void mousePressed()
{
  int clickedButton = menu.buttonAt(mouseX, mouseY);
  if (clickedButton >= 0)
  {
    dataViews.setView(clickedButton);
  }
  else
  {
    dataViews.mouseClicked(mouseX, mouseY);
  }
}

void mouseReleased()
{
  dataViews.setFilter(new Filter(textInput.getText().toUpperCase(), datePicker.beginDate(), datePicker.endDate()));
}

void keyReleased()
{
  dataViews.setFilter(new Filter(textInput.getText().toUpperCase(), datePicker.beginDate(), datePicker.endDate()));
}

void keyPressed()
{
  textInput.keyPressed(key, keyCode);
  dataViews.keyPressed(key, keyCode);
}
