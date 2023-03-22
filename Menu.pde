class Menu
{
  private ArrayList<Button> buttons;
  private int x, y, buttonH, padding, spacing;
  private int lastX;
  
  public Menu(ArrayList<Button> buttons, int x, int y, int buttonH, int padding, int spacing)
  {
    this.buttons = buttons;
    this.x = x;
    this.y = y;
    this.padding = padding;
    this.spacing = spacing;
    this.buttonH = buttonH;
    
    this.lastX = this.x;
  }
  
  public void addButton(String label)
  {
    int w = ceil(textWidth(label)) + padding;
    buttons.add(new Button(lastX, y, w, buttonH, label));
    lastX += w + spacing;
  }
  
  public void draw()
  {
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
