class TextInput
{
  private String inputText = "";
  private int cursorPosition = 0;
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
    // Box area
    fill(255);
    stroke(128);
    rect(x, y, w, h);
    
    // Input text
    fill(0);
    textAlign(LEFT, CENTER);
    text(inputText, x, y, w, h);
    
    // Cursor
    rect(x + textWidth(inputText.substring(0, cursorPosition)), y + h * 0.2, 1, h * 0.6);
  }
  
  public void handleInput(char pressedKey, int pressedKeyCode)
  {
    if (pressedKey != CODED)
    {
      if (pressedKey == BACKSPACE && cursorPosition > 0)
      {
        inputText = inputText.substring(0, cursorPosition - 1) + (cursorPosition == inputText.length() ? "" : inputText.substring(cursorPosition, inputText.length()));
        --cursorPosition;
      }
      else if (pressedKey == DELETE && cursorPosition < inputText.length())
      {
        inputText = inputText.substring(0, cursorPosition) + (cursorPosition == inputText.length() - 1 ? "" : inputText.substring(cursorPosition + 1, inputText.length()));
      }
      else if (pressedKey >= 32 && pressedKey < 127)
      {
        inputText += pressedKey;
        ++cursorPosition;
      }
    }
    else if (pressedKeyCode == LEFT && cursorPosition > 0)
    {
      --cursorPosition;
    }
    else if (pressedKeyCode == RIGHT && cursorPosition < inputText.length())
    {
      ++cursorPosition;
    }
  }
  
  public String getText()
  {
    return inputText;
  }
}
