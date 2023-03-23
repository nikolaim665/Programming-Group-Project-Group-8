class TextInput
{
  private String inputText = "";
  private int x, y, w, h;
  
  public TextInput(int x, int y, int w, int h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public void draw()
  {
    fill(255);
    noStroke();
    rect(x, y, w, h);
    fill(0);
    textAlign(LEFT, CENTER);
    text(inputText, x, y, w, h);
  }
  
  public void handleInput(char pressedKey)
  {
    if (pressedKey != CODED)
    {
      if (pressedKey == BACKSPACE)
      {
        if (inputText.length() > 0)
        {
          inputText = inputText.substring(0, inputText.length() - 1);
        }
      }
      else if (pressedKey != RETURN && pressedKey != ENTER)
      {
        inputText += pressedKey;
      }
    }
  }
  
  public String getText()
  {
    return inputText;
  }
}
