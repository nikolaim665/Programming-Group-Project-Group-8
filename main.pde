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
  
  Flights flights = new FlightLoader(dataPath("flights_lines.txt")).load();
  
  airportsPositions();
  airportsCodes();

  map = new Map("usa.svg", 0, 0, MAP_WIDTH, MAP_HEIGHT, flights);
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
  
  dataViews.setFilter(new Filter(textInput.getText().toUpperCase(), "", "", flights.getMinDate(), flights.getMaxDate()));
}

void draw()
{
  background(255, 255, 180);
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

  int unitRadius = MAP_HEIGHT / 20;
  for (int i = 0; i < 40; i++)
  {
    if (mouseX > airportsPosition[i][0] * MAP_WIDTH  - airportsPosition[i][2] * unitRadius
     && mouseX < airportsPosition[i][0] * MAP_WIDTH  + airportsPosition[i][2] * unitRadius
     && mouseY > airportsPosition[i][1] * MAP_HEIGHT - airportsPosition[i][2] * unitRadius
     && mouseY < airportsPosition[i][1] * MAP_HEIGHT + airportsPosition[i][2] * unitRadius)
    {
      fill(#280137);
      text(airportsCode[i], airportsPosition[i][0] * MAP_WIDTH, airportsPosition[i][1] * MAP_HEIGHT + 25);
      for (int j = 0; j < 40; j++)
      {
        stroke(#FFD773);
        line(airportsPosition[i][0] * MAP_WIDTH, airportsPosition[i][1] * MAP_HEIGHT, airportsPosition[j][0] * MAP_WIDTH, airportsPosition[j][1] * MAP_HEIGHT);
      }
    }
    else
    {
      fill(#9966CB);
    }
    circle(airportsPosition[i][0] * MAP_WIDTH, airportsPosition[i][1] * MAP_HEIGHT, airportsPosition[i][2] * unitRadius * 2);
  }
}

void mousePressed()
{
  if (menu.mouseClicked(mouseX, mouseY))
  {
    dataViews.setView(menu.getSelected());
  }
  else
  {
    dataViews.mouseClicked(mouseX, mouseY);
  }
}

void mouseReleased()
{
  dataViews.setFilter(dataViews.getFilter().withDateRange(datePicker.beginDate(), datePicker.endDate()));
}

void keyReleased()
{
  dataViews.setFilter(dataViews.getFilter().withCityPrefix(textInput.getText().toUpperCase()));
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
  airportsPosition[20][2] = 0.15; 
  airportsPosition[21][0] = 0.3232; 
  airportsPosition[21][1] = 0.9533;
  airportsPosition[21][2] = 0.15;
  airportsPosition[22][0] = 0.2824; 
  airportsPosition[22][1] = 0.8973;
  airportsPosition[22][2] = 0.15;
  airportsPosition[23][0] = 0.2512; 
  airportsPosition[23][1] = 0.8747;
  airportsPosition[23][2] = 0.15;
  airportsPosition[24][0] = 0.316; 
  airportsPosition[24][1] = 0.9147;
  airportsPosition[24][2] = 0.15;
  airportsPosition[25][0] = 0.3416; 
  airportsPosition[25][1] = 0.9533;
  airportsPosition[25][2] = 0.15;
  airportsPosition[26][0] = 0.0824; 
  airportsPosition[26][1] = 0.0973;
  airportsPosition[26][2] = 0.15;
  airportsPosition[27][0] = 0.0744; 
  airportsPosition[27][1] = 0.5907;
  airportsPosition[27][2] = 0.15;
  airportsPosition[28][0] = 0.7936; 
  airportsPosition[28][1] = 0.6387;
  airportsPosition[28][2] = 0.15;
  airportsPosition[29][0] = 0.8008; 
  airportsPosition[29][1] = 0.9013;
  airportsPosition[29][2] = 0.15;
  airportsPosition[30][0] = 0.5472; 
  airportsPosition[30][1] = 0.78;
  airportsPosition[30][2] = 0.15;
  airportsPosition[31][0] = 0.7512; 
  airportsPosition[31][1] = 0.8573;
  airportsPosition[31][2] = 0.15;
  airportsPosition[32][0] = 0.7744; 
  airportsPosition[32][1] = 0.9227;
  airportsPosition[32][2] = 0.15;
  airportsPosition[33][0] = 0.5048; 
  airportsPosition[33][1] = 0.4773;
  airportsPosition[33][2] = 0.15;
  airportsPosition[34][0] = 0.5992; 
  airportsPosition[34][1] = 0.8133;
  airportsPosition[34][2] = 0.15;
  airportsPosition[35][0] = 0.8056; 
  airportsPosition[35][1] = 0.9893;
  airportsPosition[35][2] = 0.15;
  airportsPosition[36][0] = 0.8312; 
  airportsPosition[36][1] = 0.396;
  airportsPosition[36][2] = 0.15;
  airportsPosition[37][0] = 0.812; 
  airportsPosition[37][1] = 0.42;
  airportsPosition[37][2] = 0.15;
  airportsPosition[38][0] = 0.648; 
  airportsPosition[38][1] = 0.452;
  airportsPosition[38][2] = 0.15;
  airportsPosition[39][0] = 0.0368; 
  airportsPosition[39][1] = 0.4427;
  airportsPosition[39][2] = 0.15;
  airportsPosition[40][0] = 0.061; 
  airportsPosition[40][1] = 0.567;
  airportsPosition[40][2] = 0.15;
  airportsPosition[41][0] = 0.8525; 
  airportsPosition[41][1] = 0.359;
  airportsPosition[41][2] = 0.15;
  airportsPosition[42][0] = 0.34167; 
  airportsPosition[42][1] = 0.44;
  airportsPosition[42][2] = 0.15;
  airportsPosition[43][0] = 0.6175; 
  airportsPosition[43][1] = 0.375;
  airportsPosition[43][2] = 0.15;
  airportsPosition[44][0] = 0.771; 
  airportsPosition[44][1] = 0.835;
  airportsPosition[44][2] = 0.15;
  airportsPosition[45][0] = 0.7008; 
  airportsPosition[45][1] = 0.6627;
  airportsPosition[45][2] = 0.15;
  airportsPosition[46][0] = 0.4696; 
  airportsPosition[46][1] = 0.7133;
  airportsPosition[46][2] = 0.15;
  airportsPosition[47][0] = 0.4456; 
  airportsPosition[47][1] = 0.8307;
  airportsPosition[47][2] = 0.15;
  airportsPosition[48][0] = 0.7632; 
  airportsPosition[48][1] = 0.5973;
  airportsPosition[48][2] = 0.15;
  airportsPosition[49][0] = 0.856; 
  airportsPosition[49][1] = 0.3467;
  airportsPosition[49][2] = 0.15;
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
  airportsCode[21] = "KOA";
  airportsCode[22] = "HNL";
  airportsCode[23] = "LIH";
  airportsCode[24] = "OGG";
  airportsCode[25] = "ITO";
  airportsCode[26] = "PDX";
  airportsCode[27] = "LGB";
  airportsCode[28] = "MYR";
  airportsCode[29] = "FLL";
  airportsCode[30] = "AEX";
  airportsCode[31] = "TPA";
  airportsCode[32] = "RSW";
  airportsCode[33] = "MCI";
  airportsCode[34] = "MSY";
  airportsCode[35] = "SJU";
  airportsCode[36] = "PHL";
  airportsCode[37] = "BWI";
  airportsCode[38] = "IND";
  airportsCode[39] = "OAK";
  airportsCode[40] = "MSP";
  airportsCode[41] = "BUR";
  airportsCode[42] = "RIC";
  airportsCode[43] = "SMF";
  airportsCode[44] = "CAK";
  airportsCode[45] = "SNA";
  airportsCode[46] = "";
  airportsCode[47] = "ACY";
  airportsCode[48] = "MIA";
  airportsCode[49] = "RDU";
  airportsCode[50] = "BQN";
  airportsCode[51] = "MKE";
  airportsCode[52] = "STX";
  airportsCode[53] = "AUS";
  airportsCode[54] = "CLE";
  airportsCode[55] = "PIT";
  airportsCode[56] = "SDF";
  airportsCode[57] = "LBE";
  airportsCode[58] = "CMH";
  airportsCode[59] = "IAD";
  airportsCode[60] = "MFR";
  airportsCode[61] = "MTJ";
  airportsCode[62] = "SFO";
  airportsCode[63] = "FSD";
  airportsCode[64] = "EGE";
  airportsCode[65] = "GEG";
  airportsCode[66] = "OMA";
  airportsCode[67] = "SBA";
  airportsCode[68] = "SAN";
  airportsCode[69] = "XNA";
}
