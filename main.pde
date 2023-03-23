Flights flights;
PImage usaMap;
PFont font;
int flightCountClick = 0;
Menu menu;
DataView dataView;
String inputText = "";

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
  menu.addButton("Statistics");

  dataView = new DataView(flights, MAP_WIDTH + MAP_OFFSET, MENU_HEIGHT, SCREEN_WIDTH - MAP_EDGE, SCREEN_HEIGHT - MENU_HEIGHT);
}

void draw()
{
  background(0);
  image(usaMap, MAP_OFFSET, 0);
  
  dataView.draw(flightCountClick, inputText);
  menu.draw();
  
  if (dataView.getView() != 0)
  {
    fill(0);
    textAlign(LEFT, TOP);
    text(inputText, SCREEN_WIDTH - 400, 5);
  }
  
  int clickedButton = menu.clickedButton();
  if (clickedButton >= 0)
  {
    dataView.setView(clickedButton);
  }
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
  if (key!=CODED && dataView.getView() != 0)
  {
    if (key==BACKSPACE) {
      if (inputText.length()>0) {
        inputText=inputText.substring(0, inputText.length()-1);
      }
    }
    else if (key!=RETURN && key!=ENTER) {
      inputText += key;
    }
  }
  else if (key == CODED && dataView.getView() == 0)
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
