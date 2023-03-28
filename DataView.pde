class DataView
{
  private Flights flights;
  private int x, y, w, h; //starting X, Starting y, ending x, ending y
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

  public int getView()
  {
    return currentView;
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
    text("Distance: " + flight.distance+" miles", x, y + 375);
    if (flight.isCancelled)
    {
      text("FLight has been cancelled", x, y + 425);
    }
    if (flight.isDiverted)
    {
      text("Flight has been diverted", x, y + 400); //C O'Sull added true/false conditions for text output originally made by richard and nicolas
    }
  }


  private void drawDelayedChart(String inputText)
  {
    Flights.Stats st = flights.stats(inputText);


    float angle = 2 * PI * st.delayedCount / st.totalCount;
    float shift = -PI / 2;
    int size = (w < h ? w : h);
    float x1= x + size / 2;
    float x2=x + 1.5*size;
    float y1=y + size/2 +20;

    fill(255, 0, 0);
    arc(x1, y1, size - 100, size - 100, shift, angle + shift);
    fill(0, 255, 0);
    arc(x1, y1, size - 100, size - 100, angle + shift, 2 * PI + shift);

    text("Green = flights running on time: ("+(st.totalCount-st.delayedCount)+")", x+50, y+10);
    fill(255, 0, 0);
    text("Red = delayed flights: ("+st.delayedCount+")", x+50, y+27);


    float diverted = 2 * PI * st.totalDiverted / st.totalCount;
    float cancelled = 2*PI *st.totalCancelled / st.totalCount;
    float remainder= (2*PI *(st.totalCount-(st.totalDiverted+st.totalCancelled))/st.totalCount);

    fill(255, 0, 0);
    arc(x2, y1, size - 100, size - 100, 0+shift, diverted+shift );//width,height,diameter,diameter,start from angle, angle of sector,       diverted flights
    fill(0, 255, 0);
    arc(x2, y1, size - 100, size - 100, diverted+shift, diverted+cancelled+shift); // cancelled
    fill(0, 0, 255);
    arc(x2, y1, size - 100, size - 100, diverted + cancelled+shift, diverted+cancelled+remainder+shift);
    text("Blue= Non-cancelled/diverted flights: ("+(st.totalCount-(st.totalDiverted+st.totalCancelled))+")", x2-30, y+10);
    fill(255, 0, 0);
    text("Red = diverted flights: ("+st.totalDiverted+")", x2-30, y+27);
    fill(0, 255, 0);
    text("Green = cancelled flights: ("+(st.totalCancelled)+")", x2-30, y+45);
    
    fill(0);
    text("Flights from: " + (inputText.length() > 0 ? inputText + "..." : "anywhere"), ((x2+x1)/2)-60, y+30);
    // C. O'Sull added a second pie chart and adjusted parameters for this screen
  }
  private void drawStats(String inputText)
  {
    fill(0);
    textAlign(LEFT, TOP);
    Flights.Stats st = flights.stats(inputText);

    text("Flights from: " + (inputText.length() > 0 ? inputText + "..." : "anywhere"), x, y);
    text("Average flight delay: " + round(st.avgDelay) + " mins", x, y + 25);
    text("Average flight distance: " + round(st.avgDistance) + " miles", x, y + 50);
    text("Delayed flights: " + st.delayedCount, x, y + 75);
    text("Total flight: " + st.totalCount, x, y + 100);
  }

  public void draw(int selectedFlight, String inputText)
  {
    fill(255, 255, 180);
    noStroke();
    rect(x, y, w, h);
    inputText = inputText.trim();

    if (currentView == 0)
    {
      drawTextInfo(selectedFlight);
    } else if (currentView == 1)
    {
      drawDelayedChart(inputText);
    } else if (currentView == 2)
    {
      drawStats(inputText);
    }
  }
}
