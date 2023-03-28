//barcharts for incoming flights, outgoing flights and cumulative flights of states

//parameters for flights barchart
//1. max number of flights
//2. number of markers on y-axis
//3. listOfStatesWithFlights.get(i).numberOf________Flights = type of flight

//-------------


void determineTypeOfBarchart(String flightType)
{
  if (flightType.equals("Incoming"))
    drawFlightsBarchart(50000, 6, "Incoming");
  else if (flightType.equals("Outgoing"))
    drawFlightsBarchart(60000, 7, "Outgoing");
  else if (flightType.equals("Cumulative"))
    drawFlightsBarchart(110000, 12, "Cumulative");
  
}

//I will figure out how to increase the y-axis labels when I have more time


int[] colours = {#F00000, #00F000, #0000F0}; //each bar will be distinguishable from the other

void drawFlightsBarchart(int maxNumberOfFlights, int numberOfMarkers, String flightType) {
  Flights.StateStats[] listOfStatesWithFlights = flights.getFlightsByStates();
  
  //max incoming == 50,000
  //max outgoing == 59,129
  //max cumulative == 103798
  
  //max height of chart == 450 (-30 for labelling x-axis)
  //max width of chart == 450
  //xpos = 690 (+50 for labelling y-axis) 
  //ypos = 50
  
  
  int barChartHeight = 420;
  int barChartWidth = 450;
  
  int xPosition = 750;  //xpos of barchart
  int yPosition = 50;
  
  //drawing axes
  fill(0); stroke(0);
  rect(xPosition, yPosition, 2, barChartHeight);
  rect(xPosition, yPosition+barChartHeight, barChartWidth, 2);
  
  //draw number markers
  
  //max outgoing from one state== 59,129
  
  //draw markers for x axis
  for (int i=0; i<numberOfMarkers;i++ ) {
    int textXPos = xPosition - 60;
    int markerXPos = xPosition - 10;
    
    int text = maxNumberOfFlights - (i*10000);
    int spaceBetweenMarkers = barChartHeight/(numberOfMarkers-1);
    int markerYPos = yPosition + (i*spaceBetweenMarkers);
    
    fill(0); stroke(0);
    rect(markerXPos, markerYPos, 10, 1);  //for x axis, width =10, length = 1
    
    text(text, textXPos, markerYPos);
  }
  
  int numberOfStates = 48;
  int barWidth = barChartWidth/numberOfStates;  //there are 48 US states, not including Alaska and Hawaii
  
  
  for ( int i=0; i<numberOfStates;i++ ) {        //for y axis, width = 1, length = 10
    
    int markerXPos = xPosition + (i*barWidth);
    float markerYPos = yPosition+barChartHeight;
    
    String text = listOfStatesWithFlights[i].stateCode;
    int textYPos = yPosition+barChartHeight + 2 + 15; //the + 2 + 15 is for the height of the x-axis + marker height
    
    fill(0); stroke(0);
    rect(markerXPos, markerYPos, 1, 10);  //for x axis, width =10, length = 1


    font = createFont("Arial",4,true); // needs working on, can't see labels
    textFont(font, 6);
    
     
    text(text, markerXPos, textYPos);
    textFont(font, 16);
    
    //need to make rectangle related to barchart height
    int flights =1;
    
      if (flightType.equals("Incoming")) {
        flights = listOfStatesWithFlights[i].incomingFlights;                       //determines whether we want outgoing, incoming or cumu flights
      }
      else if (flightType.equals("Outgoing")) {
        flights = listOfStatesWithFlights[i].outgoingFlights;
      } 
      else if (flightType.equals("Cumulative")) {
        flights = listOfStatesWithFlights[i].totalFlights;
      }
    
    
    
    float heightOfBar = barChartHeight * (flights); 
    heightOfBar /= maxNumberOfFlights; // if a state has 30,000 flights coming in, the bar will fill halfway
    
    
    
    int roundedHeightOfBar = round(heightOfBar);
    fill(colours[i % colours.length]); noStroke();
    
    rect(markerXPos, (markerYPos), barWidth, -roundedHeightOfBar);
    displayCurrentState(markerXPos, markerYPos, barWidth, roundedHeightOfBar, listOfStatesWithFlights[i].stateCode);
    
  }
  

}


void displayCurrentState(int x, float y, int w, int h, String stateCode)
{                       //displays the name of the current state that the user is hovering over 
                                                                                                  //in the barchart, as it's currently very hard to see
  if (x < mouseX && mouseX< x+w && y-h <mouseY && mouseY< y) {      
      font = createFont("Arial",4,true);
      textFont(font, 30);
      fill(0);
      text(stateCode, 1200, 275 );
  }



}
