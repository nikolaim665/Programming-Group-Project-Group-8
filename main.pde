Map map;
Menu menu;
DataViews dataViews;
TextInput textInput;
DatePicker datePicker;
float[][] airportsPosition = new float[75][3];
String[] airportsCode = new String[75];

void settings()
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}
void setup()
{
  // Arial, 16 point, anti-aliasing on
  textFont(createFont("Arial", 16, true));
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  airportsPositions();
  airportsCodes();
  
  Flights flights = new FlightLoader(dataPath("flights_lines.txt")).load();

  map = new Map("usa.svg", 0, 0, MAP_WIDTH, MAP_HEIGHT);
  textInput = new TextInput(SCREEN_WIDTH - 120, 0, 115, MENU_HEIGHT);
  
  datePicker = new DatePicker(flights.minDate, flights.maxDate, SCREEN_WIDTH - 480, 0, 320, MENU_HEIGHT);
  
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
  
  dataViews.setFilter(new Filter(textInput.getText().toUpperCase(), datePicker.beginDate(), datePicker.endDate()));
  createListOfAirports(flights.flights);
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
  for (int i = 0; i < 5; i++)
  {
  if (mouseX > airportsPosition[i][0] * MAP_WIDTH - (airportsPosition[i][2] * (MAP_HEIGHT / 10)) / 2 && mouseX < airportsPosition[i][0] * MAP_WIDTH + 
  (airportsPosition[i][2] * (MAP_HEIGHT / 10)) / 2 && mouseY > airportsPosition[i][1] * MAP_HEIGHT - (airportsPosition[i][2] * (MAP_HEIGHT / 10)) / 2 && mouseY < airportsPosition[i][1] * 
  MAP_HEIGHT + (airportsPosition[i][2] * (MAP_HEIGHT / 10)) / 2)
  {
    fill(#280137);
    text(airportsCode[i], (airportsPosition[i][0] * MAP_WIDTH), (airportsPosition[i][1] * MAP_HEIGHT) + 25);
  }
  else
  {
    fill(#9966CB);
  }
  circle(airportsPosition[i][0] * MAP_WIDTH, airportsPosition[i][1] * MAP_HEIGHT, airportsPosition[i][2] * (MAP_HEIGHT / 10));
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
void airportsPositions()
{
  airportsPosition[0][0] = 0.061; 
  airportsPosition[0][1] = 0.567;
  airportsPosition[0][2] = 0.15;
  airportsPosition[1][0] = 0.8525; 
  airportsPosition[1][1] = 0.359;
  airportsPosition[1][2] = 0.15;
  airportsPosition[2][0] = 0.34167; 
  airportsPosition[2][1] = 0.44;
  airportsPosition[2][2] = 0.15;
  airportsPosition[3][0] = 0.6175; 
  airportsPosition[3][1] = 0.375;
  airportsPosition[3][2] = 0.15;
  airportsPosition[4][0] = 0.771; 
  airportsPosition[4][1] = 0.835;
  airportsPosition[4][2] = 0.15;
}
void airportsCodes()
{
  airportsCode[0] = "LAX";
  airportsCode[1] = "JFK";
  airportsCode[2] = "DIA";
  airportsCode[3] = "ORD";
  airportsCode[4] = "MCO";
}
