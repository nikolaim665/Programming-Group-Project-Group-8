Map map;
Menu menu;
DataViews dataViews;
TextInput textInput;
DatePicker datePicker;
float[][] airportsPosition = new float[60][3];
String[] airportsCode = new String[60];
boolean departureSelected = false;
boolean arrivalSelected = false;
int departureDisplayed = 0;
int arrivalDisplayed = 0;
boolean clicked = false;
PImage planeIcon;
void settings()
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup()
{
  // Arial, 16 point, anti-aliasing on
  textFont(createFont("Arial", 16, true));
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  planeIcon = loadImage("planeIcon.png");
  planeIcon.resize(60, 60);
  for(int n = 0; n < planeIcon.pixels.length; n++) if(planeIcon.pixels[n] == 0) planeIcon.pixels[n] = 0;
  
  Flights flights = new FlightLoader(dataPath("flights_lines.txt")).load();
  
  airportsPositions();
  airportsCodes();

  map = new Map("usa.svg", 0, 0, MAP_WIDTH, MAP_HEIGHT, flights);
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
  
  updateFilter();
}

void draw()
{
  background(255, 255, 180);
  map.draw();
  textInput.draw();
  datePicker.draw();
  dataViews.draw();
  menu.draw();
  text("x= " + mouseX + "/ 1250", 1100, 600);
  text("y= " + mouseY + "/ 750", 1100, 650);
  
  if (mousePressed)
  {
    datePicker.mousePressed(mouseX, mouseY);
  }
  if (departureSelected == true && arrivalSelected == false)
  {
    for (int j = 0; j < airportsPosition.length; j++)
      {
         if ( departureDisplayed != j)
         {
            stroke(#4C0013);
            line(airportsPosition[departureDisplayed][0] * MAP_WIDTH, airportsPosition[departureDisplayed][1] * MAP_HEIGHT, airportsPosition[j][0] * MAP_WIDTH, airportsPosition[j][1] * MAP_HEIGHT);
         }
      }
   }
    if (departureSelected == true)
  {
      fill(#FFFADA);
      noStroke();
      rect(airportsPosition[departureDisplayed][0] * MAP_WIDTH - 20, airportsPosition[departureDisplayed][1] * MAP_HEIGHT - 30, 40, 20);
      fill(#4B0076);
      text(airportsCode[departureDisplayed], airportsPosition[departureDisplayed][0] * MAP_WIDTH, airportsPosition[departureDisplayed][1] * MAP_HEIGHT - 20);
  }
    if (arrivalSelected == true)
  {
      fill(#FFFADA);
      noStroke();
      rect(airportsPosition[arrivalDisplayed][0] * MAP_WIDTH - 20, airportsPosition[arrivalDisplayed][1] * MAP_HEIGHT - 30, 40, 20);
      fill(#4B0076);
      text(airportsCode[arrivalDisplayed], airportsPosition[arrivalDisplayed][0] * MAP_WIDTH, airportsPosition[arrivalDisplayed][1] * MAP_HEIGHT - 20);
      stroke(0);
      line(airportsPosition[arrivalDisplayed][0] * MAP_WIDTH, airportsPosition[arrivalDisplayed][1] * MAP_HEIGHT, airportsPosition[departureDisplayed][0] * 
      MAP_WIDTH, airportsPosition[departureDisplayed][1] * MAP_HEIGHT);
      image(planeIcon, airportsPosition[arrivalDisplayed][0] * MAP_WIDTH, airportsPosition[arrivalDisplayed][1] * MAP_HEIGHT);
  }
  for (int i = 0; i < airportsPosition.length; i++)
  {
    int unitRadius = SCREEN_HEIGHT / 20;
    if (mouseX > airportsPosition[i][0] * MAP_WIDTH  - airportsPosition[i][2] * unitRadius
     && mouseX < airportsPosition[i][0] * MAP_WIDTH  + airportsPosition[i][2] * unitRadius
     && mouseY > airportsPosition[i][1] * MAP_HEIGHT - airportsPosition[i][2] * unitRadius
     && mouseY < airportsPosition[i][1] * MAP_HEIGHT + airportsPosition[i][2] * unitRadius)
    {
      if (departureSelected == false && arrivalSelected == false && clicked)
      {
        departureDisplayed = i;
        departureSelected = true;
        clicked = false;
      }
      if (departureSelected == true && arrivalSelected == false && clicked)
      {
        if ( i != departureDisplayed)
        {
          arrivalDisplayed = i;
          arrivalSelected = true;
          clicked = false;
        }
        else
        {
          clicked = false;
        }
      }
      fill(#FFFADA);
      noStroke();
      rect(airportsPosition[i][0] * MAP_WIDTH - 20, airportsPosition[i][1] * MAP_HEIGHT - 30, 40, 20);
      fill(#4B0076);
      text(airportsCode[i], airportsPosition[i][0] * MAP_WIDTH, airportsPosition[i][1] * MAP_HEIGHT - 20);
    }
    else
    {
      fill(#9966CB);
    }
    stroke(0);
    circle(airportsPosition[i][0] * MAP_WIDTH, airportsPosition[i][1] * MAP_HEIGHT, airportsPosition[i][2] * unitRadius * 2);
  }
  if (departureSelected == true && arrivalSelected ==  true && clicked)
  {
    departureDisplayed = 0;
    arrivalDisplayed = 0;
    arrivalSelected = false;
    departureSelected = false;
    clicked = false;
  }
}

void mousePressed()
{
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

void updateFilter()
{
  int start = millis();
  if (menu.getSelected() >= 2)
  {
    dataViews.setFilter(new Filter(textInput.getText(), "", "", "", datePicker.beginDate(), datePicker.endDate()));
  }
  else
  {
    dataViews.setFilter(new Filter("", textInput.getText(), "", "", datePicker.beginDate(), datePicker.endDate()));
  }
  
  delay(max(500 - millis() + start, 0));
  thread("updateFilter");
}

void keyPressed()
{
  textInput.keyPressed(key, keyCode);
  dataViews.keyPressed(key, keyCode);
}

void mouseReleased()
{
  for (int i = 0; i < airportsPosition.length; i++)
  {
    int unitRadius = SCREEN_HEIGHT / 20;
    if (mouseX > airportsPosition[i][0] * MAP_WIDTH  - airportsPosition[i][2] * unitRadius
     && mouseX < airportsPosition[i][0] * MAP_WIDTH  + airportsPosition[i][2] * unitRadius
     && mouseY > airportsPosition[i][1] * MAP_HEIGHT - airportsPosition[i][2] * unitRadius
     && mouseY < airportsPosition[i][1] * MAP_HEIGHT + airportsPosition[i][2] * unitRadius)
     {
      clicked = true;
     }
  }
}

public int airportCodeFinder(String code)
{
  for (int i = 0; i < airportsCode.length; i++)
  {
    if (code == airportsCode[i])
    {
      return i;
    }
  }
  return -1;
}

public boolean airportDisplayable(String code)
{
  for (int i = 0; i < airportsCode.length; i++)
  {
    if (code == airportsCode[i])
    {
      return true;
    }
  }
  return false;
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
  airportsPosition[40][0] = 0.2448; 
  airportsPosition[40][1] = 0.2213;
  airportsPosition[40][2] = 0.15;
  airportsPosition[41][0] = 0.1696; 
  airportsPosition[41][1] = 0.2693;
  airportsPosition[41][2] = 0.15;
  airportsPosition[42][0] = 0.3152; 
  airportsPosition[42][1] = 0.3333;
  airportsPosition[42][2] = 0.15;
  airportsPosition[43][0] = 0.4016; 
  airportsPosition[43][1] = 0.152;
  airportsPosition[43][2] = 0.15;
  airportsPosition[44][0] = 0.4728; 
  airportsPosition[44][1] = 0.3227;
  airportsPosition[44][2] = 0.15;
  airportsPosition[45][0] = 0.4792; 
  airportsPosition[45][1] = 0.396;
  airportsPosition[45][2] = 0.15;
  airportsPosition[46][0] = 0.4648; 
  airportsPosition[46][1] = 0.5347;
  airportsPosition[46][2] = 0.15;
  airportsPosition[47][0] = 0.4496; 
  airportsPosition[47][1] = 0.6227;
  airportsPosition[47][2] = 0.15;
  airportsPosition[48][0] = 0.556; 
  airportsPosition[48][1] = 0.6453;
  airportsPosition[48][2] = 0.15;
  airportsPosition[49][0] = 0.5176; 
  airportsPosition[49][1] = 0.5933;
  airportsPosition[49][2] = 0.15;
  airportsPosition[50][0] = 0.204; 
  airportsPosition[50][1] = 0.4013;
  airportsPosition[50][2] = 0.15;
  airportsPosition[51][0] = 0.2904; 
  airportsPosition[51][1] = 0.6013;
  airportsPosition[51][2] = 0.15;
  airportsPosition[52][0] = 0.12; 
  airportsPosition[52][1] = 0.896;
  airportsPosition[52][2] = 0.15;
  airportsPosition[53][0] = 0.596; 
  airportsPosition[53][1] = 0.716;
  airportsPosition[53][2] = 0.15;
  airportsPosition[54][0] = 0.8888; 
  airportsPosition[54][1] = 0.2213;
  airportsPosition[54][2] = 0.15;
  airportsPosition[55][0] = 0.704; 
  airportsPosition[55][1] = 0.432;
  airportsPosition[55][2] = 0.15;
  airportsPosition[56][0] = 0.736; 
  airportsPosition[56][1] = 0.472;
  airportsPosition[56][2] = 0.15;
  airportsPosition[57][0] = 0.6672; 
  airportsPosition[57][1] = 0.5013;
  airportsPosition[57][2] = 0.15;
  airportsPosition[58][0] = 0.6424; 
  airportsPosition[58][1] = 0.576;
  airportsPosition[58][2] = 0.15;
  airportsPosition[59][0] = 0.6496; 
  airportsPosition[59][1] = 0.6653;
  airportsPosition[59][2] = 0.15;
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
  airportsCode[40] = "BZN";
  airportsCode[41] = "BOI";
  airportsCode[42] = "CPR";
  airportsCode[43] = "MOT";
  airportsCode[44] = "FSD";
  airportsCode[45] = "OMA";
  airportsCode[46] = "ICT";
  airportsCode[47] = "OKC";
  airportsCode[48] = "LIT";
  airportsCode[49] = "XNA";
  airportsCode[50] = "SLC";
  airportsCode[51] = "ABQ";
  airportsCode[52] = "ANC";
  airportsCode[53] = "JAN";
  airportsCode[54] = "PWM";
  airportsCode[55] = "CMH";
  airportsCode[56] = "CRW";
  airportsCode[57] = "SDF";
  airportsCode[58] = "BNA";
  airportsCode[59] = "BHM";
}
