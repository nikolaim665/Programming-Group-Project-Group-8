class FlightsByStateDataView extends DataView
{
  private final Flights.StateFlightData[] stateFlightData;
  private final int upperLimit, markerStep;
  private final color[] colors = {#F80000, #00EE00, #0000FF};

  public FlightsByStateDataView(Flights flights, int x, int y, int w, int h, Flights.StateFlightData[] stateFlightData)
  {
    super(flights, x, y, w, h);
    this.stateFlightData = stateFlightData;

    int maxFlightCount = getMaxFlightCount();
    this.markerStep = floor(pow(10, floor(log(maxFlightCount / 5) / log(10))));
    this.upperLimit = (maxFlightCount + markerStep - 1) / markerStep * markerStep;
  }
  
  private int getMaxFlightCount()
  {
    int maximum = 0;
    for (int i = 0; i < stateFlightData.length; ++i)
    {
      maximum = max(maximum, stateFlightData[i].flights);
    }
    return maximum;
  }
  
  private void drawBars(int chartX, int chartY, int chartW, int chartH)
  {
    for (int i = 0; i < stateFlightData.length; ++i)
    {
      int barX = chartX + i * chartW / stateFlightData.length;
      int barW = (i + 1) * chartW / stateFlightData.length - i * chartW / stateFlightData.length;
      int barH = chartH * stateFlightData[i].flights / upperLimit;
      
      fill(colors[i % colors.length]);
      rect(barX, chartY + chartH - barH, barW, barH);
      
      fill(0);
      textSize(8);
      textAlign(CENTER, TOP);
      text(stateFlightData[i].stateCode, barX + barW / 2, chartY + chartH);
      
      if (barX < mouseX && mouseX < barX + barW)
      {
        textSize(25);
        text(stateFlightData[i].stateCode, barX + barW / 2, chartY + 2);
      }
    }
  }

  private void drawMarkers(int chartX, int chartY, int chartH)
  {
    fill(0);
    textAlign(RIGHT, CENTER);
    textSize(16);

    int markerX = chartX - 8;
    float markerY = chartY;
    float markerStepY = float(chartH) * markerStep / upperLimit;

    for (int markerValue = upperLimit; markerValue >= 0; markerValue -= markerStep)
    {
      rect(markerX, markerY, 6, 2);
      text(str(markerValue), markerX - 2, markerY - 3);
      markerY += markerStepY;
    }
  }

  private void drawAxes(int chartX, int chartY, int chartW, int chartH)
  {
    fill(0);
    rect(chartX - 2, chartY, 2, chartH);
    rect(chartX - 2, chartY + chartH, chartW + 2, 2);
  }
  
  public void draw(String inputText)
  {
    super.draw(inputText);

    int marginLeft = 80, marginRight = 20;
    int marginTop = 20, marginBottom = 30;
    
    drawBars(x + marginLeft, y + marginTop, w - marginRight - marginLeft, h - marginTop - marginBottom);
    drawAxes(x + marginLeft, y + marginTop, w - marginRight - marginLeft, h - marginTop - marginBottom);
    drawMarkers(x + marginLeft, y + marginTop, h - marginTop - marginBottom);
  }
}
