class Map
{
  private PShape shape;
  private int x, y, w, h;
  private FlightCount[] data;
  private int maxFlightCount;
  
  private int getMaxFlightCount()
  {
    int maximum = 0;
    for (int i = 0; i < data.length; ++i)
    {
      maximum = max(maximum, data[i].count);
    }
    return maximum;
  }
  
  public Map(String svgPath, int x, int y, int w, int h, Flights flights)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    shape = loadShape(svgPath);
    data = flights.getFlightsByStates();
    maxFlightCount = getMaxFlightCount();
    
    int g = 0, b = 0;
    for (int i=0; i<data.length; i++)
    {
      PShape state = shape.getChild(data[i].category);
      
      if (state != null)
      {
        int gAndB = 455 - 455 * data[i].count / maxFlightCount;
        if (gAndB > 255 && gAndB < 280)
        {
            g=255;
            b=gAndB-255;
        }
        if (gAndB>280)
        {
            g=255;
            b=gAndB-230;
        }
        else
        {
            g=gAndB;
            b=0;
        }
        state.setFill(color(255,g,b));
      }
    }
  }

  public void draw()
  {
    shape(shape, x, y, w, h);  
    //0%==480, 10%== 430, 20%==385,  30%==340,  40%==270,  50%==225, 60%==180,  70%==135,   80==90, 90%==45,   0%==0
    noStroke();
    
    fill(255);
    rect(MAP_WIDTH-75, MAP_HEIGHT-280, 75, 30);
    fill(255,0,0); rect(MAP_WIDTH-75, MAP_HEIGHT-250, 75, 20); //100%
    fill(255,45,0); rect(MAP_WIDTH-75, MAP_HEIGHT-230, 75, 20); //90&
    fill(255,90,0); rect(MAP_WIDTH-75, MAP_HEIGHT-210, 75, 20); //80%
    fill(255,135,0); rect(MAP_WIDTH-75, MAP_HEIGHT-190, 75, 20); //70%
    fill(255,180,0); rect(MAP_WIDTH-75, MAP_HEIGHT-170, 75, 20); //60%
    fill(255,225,0); rect(MAP_WIDTH-75, MAP_HEIGHT-150, 75, 20); //50%
    fill(255,255,45); rect(MAP_WIDTH-75, MAP_HEIGHT-130, 75, 20); //40%
    fill(255,255,90); rect(MAP_WIDTH-75, MAP_HEIGHT-110, 75, 20); //30%
    fill(255,255,135); rect(MAP_WIDTH-75, MAP_HEIGHT-90, 75, 20); //20%
    fill(255,255,180); rect(MAP_WIDTH-75, MAP_HEIGHT-70, 75, 20); //10%
    fill(255,255,230); rect(MAP_WIDTH-75, MAP_HEIGHT-50, 75, 20); //0%
    
    fill(0);
    text("Flights:", MAP_WIDTH-70, MAP_HEIGHT-275);

    int step = maxFlightCount / 10000 * 1000;
    for (int i = 0; i <= 10; ++i)
    {
      text(step * i, MAP_WIDTH - 70, MAP_HEIGHT - 50 - i * 20);
    }

  }
}// C O'Sull implemented heatmap into main 05/04/23
