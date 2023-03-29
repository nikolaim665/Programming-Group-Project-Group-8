class Map
{
  private PShape shape;
  private int x, y, w, h;

  public Map(String svgPath, int x, int y, int w, int h)
  {
    shape = loadShape(svgPath);

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  public void draw()
  {
    shape(shape, x, y, w, h);
  }
}
