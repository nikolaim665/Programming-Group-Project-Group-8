abstract class DataView
{
  protected final Flights flights;
  protected final int x, y, w, h;
  protected String filterText = "";

  public DataView(Flights flights, int x, int y, int w, int h)
  {
    this.flights = flights;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  public boolean contains(int posX, int posY)
  {
    return x <= posX && posX <= x + w && y <= posY && posY <= y + h;
  }

  public void draw()
  {
    fill(255, 255, 180);
    noStroke();
    rect(x, y, w, h);
  }

  public void setFilterText(String filterText) 
  {
    if (!this.filterText.equals(filterText))
    {
      this.filterText = filterText;
      this.handleFilterTextUpdate();
    }
  }

  protected void handleFilterTextUpdate() {}
  public void handleKey(int keyPressed, int keyCodePressed) {}
  public void handleClick(int x, int y) {}
}
