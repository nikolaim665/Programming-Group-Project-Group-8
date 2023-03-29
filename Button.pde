class Button
{
  private int x, y, w, h;
  private String label;
  
  public Button(int x, int y, int w, int h, String label)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }
  
  public void draw()
  { 
    if (contains(mouseX, mouseY))
    {
      stroke(0);
      fill(210);
    }
    else
    {
      stroke(130);
      fill(230);
    }
    
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    text(label, x, y, w, h);
  }
  
  public boolean contains(int posX, int posY)
  {
    return y <= posY && posY <= y + h && x <= posX && posX <= x + w;
  }
}
