class DataViews
{
  private ArrayList<DataView> dataViews = new ArrayList<DataView>();
  private int currentView = 0;
  
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
  }

  public void handleKey(int keyPressed, int keyCodePressed)
  {
    dataViews.get(currentView).handleKey(keyPressed, keyCodePressed);
  }
  public void handleClick(int x, int y)
  {
    dataViews.get(currentView).handleClick(x, y);
  }

  public void add(DataView dataView)
  {
    dataViews.add(dataView);
  }
}
