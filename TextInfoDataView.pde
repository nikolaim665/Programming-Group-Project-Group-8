class TextInfoDataView extends DataView
{
  private int currentFlight = 0;

  public TextInfoDataView(Flights flights, int x, int y, int w, int h)
  {
    super(flights, x, y, w, h);
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

  public void draw()
  {
    super.draw();

    fill(0);
    textAlign(LEFT, TOP);
    Flight flight = flights.get(currentFlight);

    int textX = x + 15;
    text("Flight Date: " + flight.flightDate, textX, y);
    text("Carrier Code: " + flight.carrierCode, textX, y + 25);
    text("Flight Number: " + flight.flightNumber, textX, y + 50);
    text("Origin Airport Code: " + flight.originAirportCode, textX, y + 75);
    text("Origin City Name: " + flight.originCityName, textX, y + 100);
    text("Origin State Code: " + flight.originStateCode, textX, y + 125);
    text("Origin World Area Code: " + flight.originWorldAreaCode, textX, y + 150);
    text("Destination Airport Code: " + flight.destinationAirportCode, textX, y + 175);
    text("Destination City Name: " + flight.destinationCityName, textX, y + 200);
    text("Destination State Code: " + flight.destinationStateCode, textX, y + 225);
    text("Destination World Area Code: " + flight.destinationWorldAreaCode, textX, y + 250);
    text("Scheduled Departure: " + formatTime(flight.scheduledDeparture), textX, y + 275);
    text("Actual Departure: " + formatTime(flight.actualDeparture), textX, y + 300);
    text("Scheduled Arrival: " + formatTime(flight.scheduledArrival), textX, y + 325);
    text("Actual Arrival: " + formatTime(flight.actualArrival), textX, y + 350);
    text("Distance: " + flight.distance, textX, y + 375);
    if (flight.isCancelled)
    {
      text("Flight has been cancelled", textX, y + 400);
    }
    else if (flight.isDiverted)
    {
      text("Flight has been diverted", textX, y + 400);
    }
  }

  public void handleClick(int x, int y)
  {
    if (contains(x, y))
    {
      currentFlight = (currentFlight + 1) % flights.size();
    }
  }

  public void handleKey(int keyPressed, int keyCodePressed)
  {
    if (keyPressed == CODED && keyCodePressed == LEFT)
    {
      currentFlight = (currentFlight - 1 + flights.size()) % flights.size();
    }
    else if (keyPressed == CODED && keyCodePressed == RIGHT)
    {
      currentFlight = (currentFlight + 1) % flights.size();
    }
  }
}
