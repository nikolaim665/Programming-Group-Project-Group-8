// Abstract bar chart class to avoid duplicating the code for our two barcharts.
// Its subclasses are expected to implement the methods about the particular bars
// of a bar chart.
abstract class BarChartDataView extends DataView
{
  private int upperLimit = 1, markerStep = 1;
  private final color[] colors = {#F80000, #6ded6f, #000b8c};

  public BarChartDataView(Flights flights, int x, int y, int w, int h)
  {
    super(flights, x, y, w, h);
  }

  protected abstract int getBarCount();
  protected abstract int getBarValue(int i);
  protected abstract String getBarLabel(int i);
  protected abstract String getBarDescription(int i);

  protected void filterUpdated()
  {
    int maximum = getMaximum();
    markerStep = max(1, floor(pow(10, floor(log(maximum / 5) / log(10)))));
    if (maximum > markerStep * 15)
    {
      markerStep *= 5;
    }
    if (maximum > markerStep * 10)
    {
      markerStep *= 2;
    }
    upperLimit = max(maximum + markerStep - 1, 1) / markerStep * markerStep;
  }
  
  private int getMaximum()
  {
    int maximum = 0;
    for (int i = 0, len = getBarCount(); i < len; ++i)
    {
      maximum = max(maximum, getBarValue(i));
    }
    return maximum;
  }
  
  private void drawBars(int chartX, int chartY, int chartW, int chartH)
  {
    for (int i = 0, len = getBarCount(); i < len; ++i)
    {
      int barX = chartX + i * chartW / len;
      int barW = (i + 1) * chartW / len - i * chartW / len;
      int barH = chartH * getBarValue(i) / upperLimit;
      
      fill(colors[i % colors.length]);
      rect(barX, chartY + chartH - barH, barW, barH);
      
      fill(0);
      textSize(6);
      
      String label = getBarLabel(i);
      text(label, barX + barW / 2 - textWidth(label) / 2, chartY + chartH);
      
      if (barX < mouseX && mouseX < barX + barW)
      {
        textSize(25);
        String text = getBarDescription(i);
        float textW = textWidth(text);
        text(text, max(chartX + 5, min(chartX + chartW - textW, barX + barW / 2 - textW / 2)), chartY + 2);
      }
    }
  }

  private void drawMarkers(int chartX, int chartY, int chartH)
  {
    fill(0);
    textSize(16);

    int maxW = ceil(textWidth(str(upperLimit)));
    int markerX = chartX - 8;
    float markerY = chartY;
    float markerStepY = float(chartH) * markerStep / upperLimit;

    for (int markerValue = upperLimit; markerValue >= 0; markerValue -= markerStep)
    {
      rect(markerX, markerY, 6, 2);
      text(str(markerValue), markerX - maxW - 1, markerY - 11);
      markerY += markerStepY;
    }
  }

  private void drawAxes(int chartX, int chartY, int chartW, int chartH)
  {
    fill(0);
    rect(chartX - 2, chartY, 2, chartH);
    rect(chartX - 2, chartY + chartH, chartW + 2, 2);
  }

  public void draw()
  {
    noStroke();

    int marginLeft = 70, marginRight = 10;
    int marginTop = 20, marginBottom = 20;
    
    drawBars(x + marginLeft, y + marginTop, w - marginRight - marginLeft, h - marginTop - marginBottom);
    drawAxes(x + marginLeft, y + marginTop, w - marginRight - marginLeft, h - marginTop - marginBottom);
    drawMarkers(x + marginLeft, y + marginTop, h - marginTop - marginBottom);
  }
}
