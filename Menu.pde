class Menu
{
  private ArrayList<Button> buttons;
  private int x, y, w, h, padding, spacing;
  private int lastX;
  
  public Menu(int x, int y, int w, int h, int padding, int spacing)
  {
    this.buttons = new ArrayList<Button>();
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.padding = padding;
    this.spacing = spacing;
    
    this.lastX = this.x;
  }
  
  public void addButton(String label)
  {
    int w = ceil(textWidth(label)) + padding;
    buttons.add(new Button(lastX + spacing, y, w, h - 1, label));
    lastX += w + spacing;
  }
  
  public void draw()
  {
    fill(255, 255, 180);
    noStroke();
    rect(x, y, w, h);
    for (int i = 0; i < buttons.size(); ++i)
    {
      buttons.get(i).draw();
    }
  }
  
  public int clickedButton()
  {
    for (int i = 0; i < buttons.size(); ++i)
    {
      if (buttons.get(i).isClicked())
      {
        return i;
      }
    }
    return -1;
  }
}
