class Map
{
  private PShape shape;
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
    data = flights.getFlightsByStates();

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    int maxFlightCount = getMaxFlightCount();
    for (var state: data)
    {
      PShape stateShape = shape.getChild(state.stateCode);
      
      int gAndB = 455 - 455 * state.flights / maxFlightCount;
      if (gAndB > 255)
      {
        stateShape.setFill(color(255, 255, gAndB - 255));
      }
      else
      {
        stateShape.setFill(color(255, gAndB, 0));
      }
    }
  
  }

  public void draw()
  {
    shape(shape, x, y, w, h);
  }
  
}
