# Programming Project - Group 8
The flight data browser project.

Group members:
- Nicolas Moschenross
- Richard Blazek
- Cormac O'Sullivan
- David Varley

## Project structure
- `data/flights_sample.csv` - file with sample flights
- `CsvParser.pde` - class CsvParser, which parses data stored in the CSV format
- `Flight.pde` - class Flight, which contains data about a single Flight
- `FlightLoader.pde` - class FlightLoader, which uses CsvParser to parse a file and create an ArrayList of Flight objects, containing the information about the flights in the given file
<<<<<<< HEAD

- `main.pde` - the main program (currently just dummy program which loads all flights and prints them)
- `sketch.properties` - a configuration file which tells Processing that the main program is in the file `main.pde`
-  'Screens' - creates the screens on which graphs will be displayed
=======
- 
- `main.pde` - the main program (currently just dummy program which loads all flights and prints them)
- `sketch.properties` - a configuration file which tells Processing that the main program is in the file `main.pde`
- 'Screens' - creates the screens on which graphs will be displayed
>>>>>>> 2d34449ec42599c8fc15c3ee6ba208ff569a1434
-  'Widgets' - creates buttons to go forward and back to different screens
