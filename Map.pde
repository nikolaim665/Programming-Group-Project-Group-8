class Map
{
  private PShape shape;
  private PShape state;
  private int x, y, w, h;
  private Flights.StateFlightData[] data;
  
    private int getMaxFlightCount()
  {
    int maximum = 0;
    for (int i = 0; i < data.length; ++i)
    {
      maximum = max(maximum, data[i].flights);
    }
    return maximum;
  }
  
  public Map(String svgPath, int x, int y, int w, int h, Flights flights)
  {
    shape = loadShape(svgPath);
    data= flights.getFlightsByStates();

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  
    
    int r=255; int g=0; int b=0;
for (int i=0; i<data.length; i++)
{
    String code =data[i].stateCode;
    int flight =data[i].flights;
    state = shape.getChild(code);
    
    int percent = round((100*flight)/getMaxFlightCount());
    println(code +" flight"+ flight +" / "+ getMaxFlightCount() + " = " +percent);
    int gAndB= round(percent*4.55);
    gAndB= gAndB-455;
    if (gAndB<0)
    {
      gAndB=gAndB*-1;
    }
    if (gAndB >255)
    {
        g=255;
        b=gAndB-255;
    }
    else
    {
       g=gAndB;
       b=0;
    }
    state.setFill(color(r,g,b));
    state.setStroke(color(0,0,0));
}
  
  }

  public void draw()
  {
    shape(shape, x, y, w, h); 

    
  }
  
}
