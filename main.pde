// Variables for UI widgets
Map map;
Menu menu;
DataViews dataViews;
TextInput textInput;
DatePicker datePicker;
AirportPicker airportPicker;

// Settings the screen size on startup
void settings()
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup()
{
  // Setting window title
  surface.setTitle("Flight Data & Connections");

  // Arial, 16 point, anti-aliasing on
  textFont(createFont("Arial", 16, true));
  // All our text is left-aligned
  textAlign(LEFT, TOP);
  
  // Loading flights
  Flights flights = new FlightLoader(dataPath("flights_lines.txt")).load();
  
  // Creating all the UI widgets
  map = new Map("usa.svg", 0, 0, MAP_WIDTH, MAP_HEIGHT, flights);
  airportPicker = new AirportPicker(MAP_WIDTH, MAP_HEIGHT, round(SCREEN_HEIGHT / 20 * 0.15), flights);

  textInput = new TextInput(SCREEN_WIDTH - 245, 0, 240, MENU_HEIGHT, "City: ", "City: ", "Carrier code: ", "Carrier code: ");
  datePicker = new DatePicker(flights.getMinDate(), flights.getMaxDate(), MAP_WIDTH + MENU_WIDTH + 20, 0, DATEPICKER_WIDTH, MENU_HEIGHT);
  
  // The menu for switching between displayed content in DataViews
  menu = new Menu(MAP_WIDTH, 0, MENU_WIDTH, MENU_HEIGHT, "Flight info", "Airport issues", "Flights by state", "Flights by airport");
  
  // The DataViews showing various information, statistics, etc.
  dataViews = new DataViews();
  dataViews.add(new TextInfoDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  dataViews.add(new IssuesDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  dataViews.add(new FlightsByStateDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  dataViews.add(new FlightsByAirportDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  
  // Initialise filtering
  updateFilter();
}

void draw()
{
  // Yellow background (better for people with dyslexia)
  // as Cormac O'Sullivan found out
  background(255, 255, 180);

  // Drawing the UI widgets
  map.draw();
  textInput.draw();
  datePicker.draw();
  dataViews.draw();
  menu.draw();
  airportPicker.draw();

  // Mouse input for the date picker
  if (mousePressed)
  {
    datePicker.mousePressed(mouseX, mouseY);
  }
}

void mousePressed()
{
  // If drop-down menu was clicked, change the selected data view
  // Else let the current data view handle the click
  if (menu.mouseClicked(mouseX, mouseY))
  {
    dataViews.setView(menu.getSelected());
    textInput.selectLabel(menu.getSelected());
  }
  else
  {
    dataViews.mouseClicked(mouseX, mouseY);
  }
}

// This global variable is for synchronizing the method, if it runs in multiple threads at once
Filter currentFilter = null;
void updateFilter()
{
  // The first two data views are filtered by city, the other two are filtered by carrier code
  if (menu.getSelected() >= 2)
  {
    currentFilter = new Filter(textInput.getText(), "", airportPicker.getDeparture(), airportPicker.getArrival(), datePicker.beginDate(), datePicker.endDate());
  }
  else
  {
    currentFilter = new Filter("", textInput.getText(), airportPicker.getDeparture(), airportPicker.getArrival(), datePicker.beginDate(), datePicker.endDate());
  }

  dataViews.setFilter(currentFilter);
  airportPicker.setFilter(currentFilter);
}

void keyPressed()
{
  textInput.keyPressed(key, keyCode);
  dataViews.keyPressed(key, keyCode);

  // Run updateFilter in a separate thread to make the user interaction smoother
  // and avoid lagging application when the user is typing the city name for filtering
  thread("updateFilter");
}

void mouseReleased()
{
  airportPicker.mouseClick(mouseX, mouseY);

  // In this case we run it synchronously because the displayed lines on the map should
  // be filtered immediately
  updateFilter();
}
