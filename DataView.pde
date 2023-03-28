abstract class DataView
{
    protected final Flights flights;
    protected final int x, y, w, h;

    public DataView(Flights flights, int x, int y, int w, int h)
    {
        this.flights = flights;
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }
  
    public boolean isMouseOver()
    {
        return x <= mouseX && mouseX <= x + w && y <= mouseY && mouseY <= y + h;
    }

    public boolean showTextInput()
    {
        return false;
    }

    public void draw(String textInput)
    {
        fill(255, 255, 180);
        noStroke();
        rect(x, y, w, h);
    }
    public void handleKey(int keyPressed, int keyCodePressed) {}
    public void handleClick(int x, int y) {}
}
