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

  private void drawInputBox()
  {
    fill(255);
    stroke(128);
    rect(x, y, w, h);
  }

  private void drawInputText()
  {
    fill(0);
    textAlign(LEFT, CENTER);
    text(inputText, x, y, w, h);
  }

  private void drawCursor()
  {
    fill(0);
    noStroke();
    rect(x + textWidth(inputText.substring(0, cursorPosition)), y + h * 0.2, 1, h * 0.6);
  }
  
  public void draw()
  {
    drawInputBox();
    drawInputText();
    drawCursor();
  }
  
  public void handleInput(char pressedKey, int pressedKeyCode)
  {
    if (pressedKey != CODED)
    {
      if (pressedKey == BACKSPACE && cursorPosition > 0)
      {
        inputText = inputText.substring(0, cursorPosition - 1) + inputText.substring(cursorPosition);
        --cursorPosition;
      }
      else if (pressedKey == DELETE && cursorPosition < inputText.length())
      {
        inputText = inputText.substring(0, cursorPosition) + inputText.substring(cursorPosition + 1);
      }
      else if (pressedKey >= 32 && pressedKey < 127)
      {
        inputText = inputText.substring(0, cursorPosition) + pressedKey + inputText.substring(cursorPosition);
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
