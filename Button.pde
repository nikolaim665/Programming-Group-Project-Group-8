class Button
{
  private int x, y, w, h;
  private String label;
  private boolean wasPressed = false;
  
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
    if (isMouseOver())
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
  
  private boolean isMouseOver()
  {
    return y <= mouseY && mouseY <= y + h && x <= mouseX && mouseX <= x + w;
  }
  
  public boolean isClicked()
  {
    boolean clicked = isMouseOver() && mousePressed && !wasPressed;
    wasPressed = mousePressed;
    return clicked;
  }  
}
