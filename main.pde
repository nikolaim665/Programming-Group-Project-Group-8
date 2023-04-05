Map map;
Menu menu;
DataViews dataViews;
TextInput textInput;
DatePicker datePicker;
float[][] airportsPosition = new float[81][3];
String[] airportsCode = new String[81];

void settings()
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}
void setup()
{
  // Arial, 16 point, anti-aliasing on
  textFont(createFont("Arial", 16, true));
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  
  int m = millis();
  Flights flights = new FlightLoader(dataPath("flights_lines.txt")).load();

  airportsPositions();
  airportsCodes();

  map = new Map("usa.svg", 0, 0, MAP_WIDTH, MAP_HEIGHT);
  textInput = new TextInput(SCREEN_WIDTH - 120, 0, 115, MENU_HEIGHT);
  
  datePicker = new DatePicker(flights.getMinDate(), flights.getMaxDate(), MAP_WIDTH + MENU_WIDTH + 20, 0, 320, MENU_HEIGHT);
  
  // The menu for switching between displayed content in DataViews
  menu = new Menu(MAP_WIDTH, 0, MENU_WIDTH, MENU_HEIGHT, "Flight info", "Airline issues", "Flights by state", "Flights by airport");
  
  // The DataViews showing various information, statistics, etc.
  dataViews = new DataViews();
  dataViews.add(new TextInfoDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  dataViews.add(new IssuesDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  dataViews.add(new FlightsByStateDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  dataViews.add(new FlightsByAirportDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  
  dataViews.setFilter(new Filter(textInput.getText().toUpperCase(), flights.getMinDate(), flights.getMaxDate()));
  
  println(millis() - m, "ms");
}

void draw()
{
  background(255, 255, 180);
  dataViews.setView(menu.getSelected());
  map.draw();
  textInput.draw();
  datePicker.draw();
  dataViews.draw();
  menu.draw();
  text("x= " + mouseX + "/ 1250", 1000, 600);
  text("y= " + mouseY + "/ 750", 1000, 650);
  
  if (mousePressed)
  {
    datePicker.mousePressed(mouseX, mouseY);
  }
  for (int i = 0; i < 21; i++)
  {
  if (mouseX > airportsPosition[i][0] * MAP_WIDTH - (airportsPosition[i][2] * (MAP_HEIGHT / 10)) / 2 && mouseX < airportsPosition[i][0] * MAP_WIDTH + 
  (airportsPosition[i][2] * (MAP_HEIGHT / 10)) / 2 && mouseY > airportsPosition[i][1] * MAP_HEIGHT - (airportsPosition[i][2] * (MAP_HEIGHT / 10)) / 2 && mouseY < airportsPosition[i][1] * 
  MAP_HEIGHT + (airportsPosition[i][2] * (MAP_HEIGHT / 10)) / 2)
  {
    fill(#280137);
    text(airportsCode[i], (airportsPosition[i][0] * MAP_WIDTH), (airportsPosition[i][1] * MAP_HEIGHT) + 25);
    for (int j = 0; j < 21; j++)
    {
      stroke(#FFD773);
      line( airportsPosition[i][0] * MAP_WIDTH, airportsPosition[i][1] * MAP_HEIGHT, airportsPosition[j][0] * MAP_WIDTH, airportsPosition[j][1] * MAP_HEIGHT);
    }
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
  if (!menu.mouseClicked(mouseX, mouseY))
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
  airportsPosition[5][0] = 0.7008; 
  airportsPosition[5][1] = 0.6627;
  airportsPosition[5][2] = 0.15;
  airportsPosition[6][0] = 0.4696; 
  airportsPosition[6][1] = 0.7133;
  airportsPosition[6][2] = 0.15;
  airportsPosition[7][0] = 0.4456; 
  airportsPosition[7][1] = 0.8307;
  airportsPosition[7][2] = 0.15;
  airportsPosition[8][0] = 0.7632; 
  airportsPosition[8][1] = 0.5973;
  airportsPosition[8][2] = 0.15;
  airportsPosition[9][0] = 0.856; 
  airportsPosition[9][1] = 0.3467;
  airportsPosition[9][2] = 0.15;
  airportsPosition[10][0] = 0.1872; 
  airportsPosition[10][1] = 0.6733;
  airportsPosition[10][2] = 0.15;
  airportsPosition[11][0] = 0.1408; 
  airportsPosition[11][1] = 0.5373;
  airportsPosition[11][2] = 0.15;
  airportsPosition[12][0] = 0.0944; 
  airportsPosition[12][1] = 0.0707;
  airportsPosition[12][2] = 0.15;
  airportsPosition[13][0] = 0.8088; 
  airportsPosition[13][1] = 0.44;
  airportsPosition[13][2] = 0.15;
  airportsPosition[14][0] = 0.5024; 
  airportsPosition[14][1] = 0.8173;
  airportsPosition[14][2] = 0.15;
  airportsPosition[15][0] = 0.844; 
  airportsPosition[15][1] = 0.352;
  airportsPosition[15][2] = 0.15;
  airportsPosition[16][0] = 0.6904; 
  airportsPosition[16][1] = 0.352;
  airportsPosition[16][2] = 0.15;
  airportsPosition[17][0] = 0.8016; 
  airportsPosition[17][1] = 0.92;
  airportsPosition[17][2] = 0.15;
  airportsPosition[18][0] = 0.888; 
  airportsPosition[18][1] = 0.283;
  airportsPosition[18][2] = 0.15;
  airportsPosition[19][0] = 0.028; 
  airportsPosition[19][1] = 0.443;
  airportsPosition[19][2] = 0.15;
  airportsPosition[20][0] = 0.5312; 
  airportsPosition[20][1] = 0.2853;
  airportsPosition[20][2] = 0.15; // airports done all the way to here for now
  airportsPosition[21][0] = 0.8525; 
  airportsPosition[21][1] = 0.359;
  airportsPosition[21][2] = 0.15;
  airportsPosition[22][0] = 0.34167; 
  airportsPosition[22][1] = 0.44;
  airportsPosition[22][2] = 0.15;
  airportsPosition[23][0] = 0.6175; 
  airportsPosition[23][1] = 0.375;
  airportsPosition[23][2] = 0.15;
  airportsPosition[24][0] = 0.771; 
  airportsPosition[24][1] = 0.835;
  airportsPosition[24][2] = 0.15;
  airportsPosition[25][0] = 0.7008; 
  airportsPosition[25][1] = 0.6627;
  airportsPosition[25][2] = 0.15;
  airportsPosition[26][0] = 0.4696; 
  airportsPosition[26][1] = 0.7133;
  airportsPosition[26][2] = 0.15;
  airportsPosition[27][0] = 0.4456; 
  airportsPosition[27][1] = 0.8307;
  airportsPosition[27][2] = 0.15;
  airportsPosition[28][0] = 0.7632; 
  airportsPosition[28][1] = 0.5973;
  airportsPosition[28][2] = 0.15;
  airportsPosition[29][0] = 0.7632; 
  airportsPosition[29][1] = 0.5973;
  airportsPosition[29][2] = 0.15;
}
void airportsCodes()
{
  airportsCode[0] = "LAX";
  airportsCode[1] = "JFK";
  airportsCode[2] = "DEN";
  airportsCode[3] = "ORD";
  airportsCode[4] = "MCO";
  airportsCode[5] = "ATL";
  airportsCode[6] = "DFW";
  airportsCode[7] = "AUS";
  airportsCode[8] = "CLT";
  airportsCode[9] = "LGA";
  airportsCode[10] = "PHX";
  airportsCode[11] = "LAS";
  airportsCode[12] = "SEA";
  airportsCode[13] = "DCA";
  airportsCode[14] = "IAH";
  airportsCode[15] = "EWR";
  airportsCode[16] = "DTW";
  airportsCode[17] = "MIA";
  airportsCode[18] = "BOS";
  airportsCode[19] = "SFO";
  airportsCode[20] = "MSP";
  airportsCode[30] = "LAX";
  airportsCode[31] = "JFK";
  airportsCode[32] = "DIA";
  airportsCode[33] = "ORD";
  airportsCode[34] = "MCO";
  airportsCode[35] = "LAX";
  airportsCode[36] = "JFK";
  airportsCode[37] = "DIA";
  airportsCode[38] = "ORD";
  airportsCode[39] = "MCO";
  airportsCode[40] = "LAX";
  airportsCode[41] = "JFK";
  airportsCode[42] = "DIA";
  airportsCode[43] = "ORD";
  airportsCode[44] = "MCO";
  airportsCode[45] = "LAX";
  airportsCode[46] = "JFK";
  airportsCode[47] = "DIA";
  airportsCode[48] = "ORD";
  airportsCode[49] = "MCO";
  airportsCode[50] = "LAX";
  airportsCode[51] = "JFK";
  airportsCode[52] = "DIA";
  airportsCode[53] = "ORD";
  airportsCode[54] = "MCO";
  airportsCode[55] = "LAX";
  airportsCode[56] = "JFK";
  airportsCode[57] = "DIA";
  airportsCode[58] = "ORD";
  airportsCode[59] = "MCO";
  airportsCode[60] = "LAX";
  airportsCode[61] = "JFK";
  airportsCode[62] = "DIA";
  airportsCode[63] = "ORD";
  airportsCode[64] = "MCO";
  airportsCode[65] = "LAX";
  airportsCode[66] = "JFK";
  airportsCode[67] = "DIA";
  airportsCode[68] = "ORD";
  airportsCode[69] = "MCO";
  airportsCode[70] = "LAX";
  airportsCode[71] = "JFK";
  airportsCode[72] = "DIA";
  airportsCode[73] = "ORD";
  airportsCode[74] = "MCO";
  airportsCode[75] = "LAX";
  airportsCode[76] = "JFK";
  airportsCode[77] = "DIA";
  airportsCode[78] = "ORD";
  airportsCode[79] = "MCO";
  airportsCode[80] = "sss";
}
