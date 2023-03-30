class Map
{
  private PShape shape;
  private int x, y, w, h;
  private Flights.StateFlightData[] data;
  public Map(String svgPath, int x, int y, int w, int h, Flights flights)
  {
    shape = loadShape(svgPath);
    data= flights.getFlightsByStates("");

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  public void draw()
  {
    shape(shape, x, y, w, h); 
  }








for (int i=0; (i<data.length); i++)
{
    String code =data[i].stateCode;
    int numbFlights= data[i].flights;
    println(numbFlights);
}

}
