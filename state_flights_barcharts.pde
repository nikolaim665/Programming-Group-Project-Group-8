//barcharts for incoming flights, outgoing flights and cumulative flights of states

//parameters for flights barchart
//1. max number of flights
//2. number of markers on y-axis
//3. listOfStatesWithFlights.get(i).numberOf________Flights = type of flight

//-------------


void determineTypeOfStatesBarchart(String flightType) {
  if (flightType.equals("Incoming"))
    drawFlightsBarchart(50000, 6, "Incoming");
  else if (flightType.equals("Outgoing"))
    drawFlightsBarchart(60000, 7, "Outgoing");
  else if (flightType.equals("Cumulative"))
    drawFlightsBarchart(110000, 12, "Cumulative");
  
}

//I will figure out how to increase the y-axis labels when I have more time



void drawFlightsBarchart(int maxNumberOfFlights, int numberOfMarkers, String flightType) {
  //max incoming == 50,928
  //max outgoing == 50,960
  //max cumulative == 101,800 (roughly)
  
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
  
  
  //draw markers for x axis
  for (int i=0; i<numberOfMarkers;i++ ) {
    int textXPos = xPosition - 60;
    int markerXPos = xPosition - 10;
    
    int text = maxNumberOfFlights - (i*10000);
    int spaceBetweenMarkers = barChartHeight/(numberOfMarkers-1);
    int markerYPos = yPosition + (i*spaceBetweenMarkers);
    
    fill(0); stroke(0);
    rect(markerXPos, markerYPos, 10, 1);  //for y axis, width =10, length = 1
    
    text(text, textXPos, markerYPos);
  }
  
  int numberOfStates = 48;
  int barWidth = barChartWidth/numberOfStates;
  
  
  for ( int i=0; i<numberOfStates;i++ ) {        //for x axis, width = 1, length = 10
    
    int markerXPos = xPosition + (i*barWidth);
    float markerYPos = yPosition+barChartHeight;
    
    String text = listOfStatesWithFlights.get(i).code;
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
        flights = listOfStatesWithFlights.get(i).numberOfIncomingFlights;                       //determines whether we want outgoing, incoming or cumu flights
      }
      else if (flightType.equals("Outgoing")) {
        flights = listOfStatesWithFlights.get(i).numberOfOutgoingFlights;
      } 
      else if (flightType.equals("Cumulative")) {
        flights = listOfStatesWithFlights.get(i).cumulativeNumberOfFlights;
      }
    
    
    
    float heightOfBar = barChartHeight * (flights); 
    heightOfBar /= maxNumberOfFlights; // if an airport has 30,000 flights coming in, the bar will fill halfway
    
    
    
    int roundedHeightOfBar = round(heightOfBar);
    fill(listOfStatesWithFlights.get(i).barChartColour); noStroke();
    
    rect(markerXPos, (markerYPos), barWidth, -roundedHeightOfBar);
    
    displayCurrentState(markerXPos, markerYPos, barWidth, roundedHeightOfBar, listOfStatesWithFlights.get(i).code);
    //rect(markerXPos, (markerYPos-1), barWidth, -200);
  }
 
  
}


void displayCurrentState(int x, float y, int w, int h, String stateCode) {                       //displays the name of the current state that the user is hovering over 
                                                                                                 //in the barchart, as it's currently very hard to see
  if (x < mouseX && mouseX< x+w) {
    if(y-h <mouseY && mouseY< y) {
      
      font = createFont("Arial",30,true);
      fill(0);
      text(stateCode, 1200, 275 ); //int barChartHeight = 420;
                                   //int barChartWidth = 450;
                         
                                   //750+ 450, 50+(barChartHeight/2)
                                   //int xPosition = 750;  //xpos of barchart
                                   //int yPosition = 50;
      textFont(font, 16);
    }
  }



}
