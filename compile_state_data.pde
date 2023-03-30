
// will create a barchart showing the number of flights going to and/or from each state

//all states minus hawaii and alaska, 48 altogether
String[] stateCodes = {"AK","AZ","AR","CA","CO","CT","DE","FL","GA","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ",
                       "NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"}; 

//first find state with most flights

int[] colours = {#F00000, #00F000, #0000F0}; //each bar will be distinguishable from the other

class State {
  int numberOfIncomingFlights;
  int numberOfOutgoingFlights;
  int cumulativeNumberOfFlights;// = numberOfIncomingFlights+numberOfOutgoingFlights;
  
  String code;         //state code
  int barChartColour;     
  
  public State(String abbrev, int incoming, int outgoing, int colour) {
    this.numberOfIncomingFlights = incoming;
    this.numberOfOutgoingFlights = outgoing;
    this.code = abbrev;
    this.barChartColour = colour;  //to distinguish one bar from another
    
  }


}


ArrayList<State> listOfStatesWithFlights = new ArrayList<State>();

void createStates () {
  int c = 0;
  for (int i =0; i<stateCodes.length; i++, c++) {
    if (c>2)
      c=0;
    
    State newState = new State(stateCodes[i], 0, 0, colours[c]); 
    listOfStatesWithFlights.add( newState );
  }
  
}

void assignFlightsToStates(ArrayList<Flight> flights, String[] stateCodes) {
  createStates();
  
  
  for (int i =0; i<flights.size(); i++) {
    
    
    String originState = flights.get(i).originStateCode;
    String destinationState = flights.get(i).destinationStateCode;
    
    //if both instance variables of flight have been assigned, terminate loop
    int finished = 0;
    
    //listOfStatesWithFlights.get(j) = current state
    
    for (int j=0; j<stateCodes.length && finished<2; j++) {
      
      //if (originState!=destinationState)
      
      if (listOfStatesWithFlights.get(j).code.equals(originState) ) { //.equals(destinationState)
        listOfStatesWithFlights.get(j).numberOfOutgoingFlights++;
        finished++;
      }
      else if (listOfStatesWithFlights.get(j).code.equals(destinationState) ){
        listOfStatesWithFlights.get(j).numberOfIncomingFlights++;
        finished++;
      }

    }
    
    
  }
  
  
  for (int k=0; k<listOfStatesWithFlights.size(); k++) {
    
    //adds incoming + outgoing number of flights to cumulativeNumberOfFlights
    listOfStatesWithFlights.get(k).cumulativeNumberOfFlights = listOfStatesWithFlights.get(k).numberOfIncomingFlights + listOfStatesWithFlights.get(k).numberOfOutgoingFlights;

  }
  
  //start at zero
  State mostIncoming = listOfStatesWithFlights.get(0);
  State mostOutgoing = listOfStatesWithFlights.get(0);
  State mostCumulative = listOfStatesWithFlights.get(0);  //may/may not do this one

  for (int i =1; i<listOfStatesWithFlights.size(); i++) {  //start at 1 because already have 0
    
    if (listOfStatesWithFlights.get(i).numberOfIncomingFlights > mostIncoming.numberOfIncomingFlights) {
      mostIncoming = listOfStatesWithFlights.get(i);
    }
    
    if (listOfStatesWithFlights.get(i).numberOfOutgoingFlights > mostOutgoing.numberOfOutgoingFlights) {
      mostOutgoing = listOfStatesWithFlights.get(i);
    }
    
    if (listOfStatesWithFlights.get(i).cumulativeNumberOfFlights > mostCumulative.cumulativeNumberOfFlights) {
      mostCumulative = listOfStatesWithFlights.get(i);
    }
      
    
  }
  
  
  //System.out.println(mostIncoming.numberOfIncomingFlights);        //max incoming == 50,000
  //System.out.println(mostOutgoing.numberOfOutgoingFlights);        //max outgoing == 59,129
  //System.out.println(mostCumulative.cumulativeNumberOfFlights);    //max cumulative == 103798
  
}
