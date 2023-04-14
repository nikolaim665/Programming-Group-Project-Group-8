// Class containing all the data views. It does not have any information about specific
// data views and can handle any instance of a subclass of the DataView class.
// Displays the currently selected data view and passes all user interaction events
// to the currently selected data view.
class DataViews
{
  private ArrayList<DataView> dataViews = new ArrayList<DataView>();
  private int currentView = 0;
  private Filter filter = null;
  
  public void setView(int newView)
  {
    currentView = newView;
  }
  
  public int getView()
  {
    return currentView;
  }
  
  public void draw()
  {
    dataViews.get(currentView).draw();
  }

  public void setFilter(Filter filter)
  {
    for (DataView dataView: dataViews)
    {
      dataView.setFilter(filter);
    }
    this.filter = filter;
  }

  public void keyPressed(int keyPressed, int keyCodePressed)
  {
    dataViews.get(currentView).keyPressed(keyPressed, keyCodePressed);
  }
  public void mouseClicked(int x, int y)
  {
    dataViews.get(currentView).mouseClicked(x, y);
  }

  public void add(DataView dataView)
  {
    dataViews.add(dataView);
  }
}
