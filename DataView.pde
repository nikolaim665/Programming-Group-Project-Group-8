// Abstract class for the data views
abstract class DataView
{
  protected final Flights flights;
  protected final int x, y, w, h;
  protected Filter filter;

  public DataView(Flights flights, int x, int y, int w, int h)
  {
    this.flights = flights;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.filter = new Filter();
  }

  // The data views are expected to draw themselves on the screen
  public abstract void draw();

  public final void setFilter(Filter newFilter) 
  {
    // We want to update the filter only if the new filter is different
    // because it is a O(n) operation proportional to the number of flights
    if (!filter.equals(newFilter))
    {
      filter = newFilter;
      this.filterUpdated();
    }
  }

  protected void filterUpdated() {}

  // Handling user interaction events
  public void keyPressed(int keyPressed, int keyCodePressed) {}
  public void mouseClicked(int x, int y) {}
}
