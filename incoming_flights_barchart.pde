void drawIncomingFlightsBarchart() {
  //max incoming == 50,000
  //max outgoing == 59,129
  //max cumulative == 103798
  
  //max height of chart == 450 (-30 for labelling x-axis)
  //max width of chart == 450
  //xpos = 690 (+50 for labelling y-axis) 
  //ypos = 50
  
  int barChartHeight = 420;
  int barChartWidth = 450;
  
  int xPosition = 740;  //xpos of barchart
  int yPosition = 50;
  
  //drawing axes
  fill(0); stroke(0);
  rect(xPosition, yPosition, 2, barChartHeight);
  rect(xPosition, yPosition+barChartHeight, barChartWidth, 2);
  
  //draw number markers
  
  //max incoming to one state== 50,000
  
  //draw markers for x axis
  for (int i=0; i<6;i++ ) {
    int textXPos = xPosition - 30;
    int markerXPos = xPosition - 10;
    
    int text = 50000 - (i*10000);
    int spaceBetweenMarkers = barChartHeight/5;
    int markerYPos = yPosition + (i*spaceBetweenMarkers);
    
    fill(0); stroke(0);
    rect(markerXPos, markerYPos, 10, 1);  //for x axis, width =10, length = 1
    
    text(text, textXPos, markerYPos);
  }
  
  int numberOfStates = 48;
  int barWidth = barChartWidth/numberOfStates;  //there are 48 US states, not including Alaska and Hawaii
  //int barLength = barChartHeight/50000;  // if a state has 25000 flights coming in, the bar will fill halfway (with further code)
  
  
  for ( int i=0; i<numberOfStates;i++ ) {        //for y axis, width = 1, length = 10
    
    int markerXPos = xPosition + (i*barWidth);
    float markerYPos = yPosition+barChartHeight;
    
    String text = listOfStatesWithFlights.get(i).code;
    int textYPos = yPosition+barChartHeight + 2 + 15; //the + 2 + 15 is for the length of the x-axis + marker length
    
    fill(0); stroke(0);
    rect(markerXPos, markerYPos, 1, 10);  //for x axis, width =10, length = 1


    font = createFont("Arial",4,true); // needs working on, can't see labels
    textFont(font, 6);
    text(text, markerXPos, textYPos);
    textFont(font, 16);
    
    //need to make rectangle related to barchart height
    float heightOfBar = barChartHeight * (listOfStatesWithFlights.get(i).numberOfIncomingFlights);
    heightOfBar /= 50000;
    
    
    
    int roundedHeightOfBar = round(heightOfBar);
    fill(listOfStatesWithFlights.get(i).barChartColour); noStroke();
    
    rect(markerXPos, (markerYPos-1), barWidth, -roundedHeightOfBar);
    //rect(markerXPos, (markerYPos-1), barWidth, -200);
  }
 
  
}
