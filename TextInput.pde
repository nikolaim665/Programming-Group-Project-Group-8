// Class for the text input UI widget
class TextInput
{
  private String inputText = "";
  private int cursorPosition = 0;
  private int x, y, w, h;

  // There are multiple labels because we filter by city in some data views
  // and by carrier code in others
  private String[] labels;
  private int currentLabel = 0;

  public TextInput(int x, int y, int w, int h, String ... labels)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.labels = labels;
  }

  private void drawLabel(int textW)
  {
    fill(0);
    text(labels[currentLabel], x, y + 8, textW, h);
  }

  private void drawInputBox(int textW)
  {
    fill(255);
    stroke(128);
    rect(x + textW, y, w - textW, h - 1);
  }

  private void drawInputText(int textW)
  {
    fill(0);
    text(inputText, x + textW + 2, y + 8, w - textW - 2, h);
  }

  private void drawCursor(int textW)
  {
    // Blinking cursor effect
    if (millis() / 500 % 2 == 0)
    {
      fill(0);
      noStroke();
      rect(x + textWidth(inputText.substring(0, cursorPosition)) + textW + 2, y + h * 0.2, 1, h * 0.6);
    }
  }

  public void selectLabel(int i)
  {
    currentLabel = i;
  }
  
  public void draw()
  {
    int textW = round(textWidth(labels[currentLabel]));
    drawLabel(textW);
    drawInputBox(textW);
    drawInputText(textW);
    drawCursor(textW);
  }
  
  public void keyPressed(char pressedKey, int pressedKeyCode)
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
    // The user might unintentionally include some spaces, so we remove them
    return inputText.trim();
  }
}
