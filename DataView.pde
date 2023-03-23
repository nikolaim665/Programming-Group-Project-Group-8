class DataView
{
  private Flights flights;
  private int x, y, w, h;
  private int currentView = 0;

  public DataView(Flights flights, int x, int y, int w, int h)
  {
    this.flights = flights;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public void setView(int newView)
  {
    currentView = newView;
  }
  
  public boolean isMouseOver()
  {
    return x <= mouseX && mouseX <= x + w && y <= mouseY && mouseY <= y + h;
  }
  
  private String formatTime(int sinceMidnight)
  {
    if (sinceMidnight < 0)
    {
      return "N/A";
    }
    int minutes = sinceMidnight % 60;
    int hours = sinceMidnight / 60;
    return "" + hours + (minutes < 10 ? ":0" : ":") + minutes;
  }

  private void drawTextInfo(int selectedFlight)
  {
    fill(0);
    textAlign(LEFT, TOP);
    Flight flight = flights.get(selectedFlight);

    text("Flight Date: " + flight.flightDate, x, y);
    text("Carrier Code: " + flight.carrierCode, x, y + 25);
    text("Flight Number: " + flight.flightNumber, x, y + 50);
    text("Origin Airport Code: " + flight.originAirportCode, x, y + 75);
    text("Origin City Name: " + flight.originCityName, x, y + 100);
    text("Origin State Code: " + flight.originStateCode, x, y + 125);
    text("Origin World Area Code: " + flight.originWorldAreaCode, x, y + 150);
    text("Destination Airport Code: " + flight.destinationAirportCode, x, y + 175);
    text("Destination City Name: " + flight.destinationCityName, x, y + 200);
    text("Destination State Code: " + flight.destinationStateCode, x, y + 225);
    text("Destination World Area Code: " + flight.destinationWorldAreaCode, x, y + 250);
    text("Scheduled Departure: " + formatTime(flight.scheduledDeparture), x, y + 275);
    text("Actual Departure: " + formatTime(flight.actualDeparture), x, y + 300);
    text("Scheduled Arrival: " + formatTime(flight.scheduledArrival), x, y + 325);
    text("Actual Arrival: " + formatTime(flight.actualArrival), x, y + 350);
    text("Is Cancelled: " + flight.isCancelled, x, y + 375);
    text("Is Diverted: " + flight.isDiverted, x, y + 400);
    text("Distance: " + flight.distance, x, y + 425);
  }

  private void drawDelayedChart()
  {
    int totalCount = flights.size();
    int delayedCount = flights.countDelayed();

    float angle = 2 * PI * delayedCount / totalCount;
    float shift = -PI / 2;
    int size = (w < h ? w : h);
    
    fill(255, 0, 0);
    arc(x + size / 2, y + size / 2, size - 20, size - 20, shift, angle + shift);
    fill(0, 255, 0);
    arc(x + size / 2, y + size / 2, size - 20, size - 20, angle + shift, 2 * PI + shift);
  }

  public void draw(int selectedFlight)
  {
    fill(255, 255, 128);
    noStroke();
    rect(x, y, w, h);

    if (currentView == 0)
    {
      drawTextInfo(selectedFlight);
    }
    else if (currentView == 1)
    {
      drawDelayedChart();
    }
    else if (currentView == 2)
    {
      // Draw some other cool stuff
    }
  }
}
