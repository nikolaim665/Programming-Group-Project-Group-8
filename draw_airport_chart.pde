// draw airports pareto barchart
//to do so, airports need to be in highest-to-lowest order
ArrayList<Airport> orderedAirports= new ArrayList<Airport>();

void sortAirports(String flightType) {
  //ArrayList<String> dontRepeat = new ArrayList<String>();  //when sorting airports, it will not enter the same airport twice
  
  //mf = mostFlights, ie, mostIncoming/OutgoingFLights

    for (int i=0; i<airports.size(); i++) {
     Airport mf = airports.get(0);
     
      for (int j=0; j<airports.size(); j++) {
        int flights=0;
        
          if (flightType.equals("Incoming"))
            flights = airports.get(j).numberOfIncomingFlights;
          else if (flightType.equals("Outgoing"))
            flights = airports.get(j).numberOfOutgoingFlights;
          else if (flightType.equals("Cumulative"))
            flights = airports.get(j).cumulativeNumberOfFlights;
          
      if (mf.numberOfIncomingFlights < flights)
        mf = airports.get(j);
      
      }
  
      orderedAirports.add(mf);
      airports.remove(mf);
    }
    
    //re arrange colours
    int c=0; //c=colour of bar
    for (int j=0; j<orderedAirports.size(); j++, c++) {
        if (c==3)
          c=0;
         orderedAirports.get(j).barChartColour=airportColours[c];
    }
  
}







void determineTypeOfAirportBarchart(String flightType) {
  if (flightType.equals("Incoming"))
    drawAirportChart(55000, 7, "Incoming");
  else if (flightType.equals("Outgoing"))
    drawAirportChart(55000, 7, "Outgoing");
  else if (flightType.equals("Cumulative"))
    drawAirportChart(110000, 12, "Cumulative");
  
}




void drawAirportChart(int maxFlights, int numberOfMarkers, String flightType) {
  
  //max incoming == 50,000
  //max outgoing == 59,129
  //max cumulative == 103798
  
  //max height of chart == 450 (-30 for labelling x-axis)
  //max width of chart == 738 (num of airports == 738)
  //xpos = 690 (+50 for labelling y-axis) 
  //ypos = 50
  
  
  int barChartHeight = 420;
  int barChartWidth = 738;
  
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
    
    int text = maxFlights - (i*10000);
    int spaceBetweenMarkers = barChartHeight/(numberOfMarkers-1);
    int markerYPos = yPosition + (i*spaceBetweenMarkers);
    
    fill(0); stroke(0);
    rect(markerXPos, markerYPos, 10, 1);  //for y axis, width =10, length = 1
    
    if (text<0)
      text(0, textXPos, markerYPos);
    else
      text(text, textXPos, markerYPos);
  }
  
  
  int numberOfAirports = orderedAirports.size();
  int barWidth = 4;   //barChartWidth/numberOfAirports;
  
  for ( int i=0; i<numberOfAirports;i++ ) {        //for x axis, width = 1, length = 10
    
    int markerXPos = xPosition + (i*barWidth);
    float markerYPos = yPosition+barChartHeight;
    
    //String text = listOfStatesWithFlights.get(i).code;
    //int textYPos = yPosition+barChartHeight + 2 + 15; //the + 2 + 15 is for the height of the x-axis + marker height
    
    
    
     
    //text(text, markerXPos, textYPos);
    //textFont(font, 16);
    
    //need to make rectangle related to barchart height
    int flights =1;
    
      if (flightType.equals("Incoming")) {
        flights = orderedAirports.get(i).numberOfIncomingFlights;                       //determines whether we want outgoing, incoming or cumu flights
      }
      else if (flightType.equals("Outgoing")) {
        flights = orderedAirports.get(i).numberOfOutgoingFlights;
      } 
      else if (flightType.equals("Cumulative")) {
        flights = orderedAirports.get(i).cumulativeNumberOfFlights;
      }
    
    
    
    float heightOfBar = barChartHeight * (flights); 
    heightOfBar /= maxFlights; // if a airport has 30,000 flights coming in, the bar will fill halfway
    
    
    
    int roundedHeightOfBar = round(heightOfBar);
    fill(orderedAirports.get(i).barChartColour); stroke(0);
    
    rect(markerXPos, (markerYPos), barWidth, -roundedHeightOfBar);
    //displayCurrentState(markerXPos, markerYPos, barWidth, roundedHeightOfBar, listOfStatesWithFlights.get(i).code);
    //rect(markerXPos, (markerYPos-1), barWidth, -200);
  }
  
  
  
  
  
}
