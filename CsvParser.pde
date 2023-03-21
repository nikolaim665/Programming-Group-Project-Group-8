// This class reads data from file in the CSV format. It assumes that there are no double quotes or line
// breaks inside quoted cells which is sufficient for our dataset.
class CsvParser
{
  private String[] lines;
  private int y, x = 0;

  // Reads data from a file at the given "filepath"
  // Skip the first "skippedLines" lines
  public CsvParser(String filepath, int skippedLines)
  {
    this.lines = loadStrings(filepath);
    this.y = skippedLines;
  }

  // This method returns the number of lines in the CSV file
  // Return value: an integer indicating the number of lines
  public int lineCount()
  {
    return lines.length;
  }
  
  // This method tells whether the end of the data has been reached
  // Return value: true, if the end has been reached, false otherwise
  public boolean reachedEnd()
  {
    return y >= lines.length;
  }
  
  // This method loads a next cell from the CSV data.
  // Return value: The text contained in the cell.
  public String next()
  {
    String line = lines[y];
    int begin = 0, end = 0;
    
    if (x < line.length()) 
    {
      if (line.charAt(x) == '"')
      {
        begin = x + 1;
        end = line.indexOf('"', begin);
        x = end + 2;
      }
      else
      {
        begin = x;
        end = line.indexOf(',', begin);
        end = end < 0 ? line.length() : end;
        x = end + 1;
      }
    }

    String result = line.substring(begin, end);
    
    while (y < lines.length && x >= lines[y].length())
    {
      x = 0;
      ++y;
    }
    return result;
  }
  
  // This method loads a next cell from the CSV data and converts it to int.
  // Return value: The resulting integer, or -1 in case of an error.
  public int nextInt()
  {
    try
    {
      return Integer.parseInt(next());
    }
    catch (NumberFormatException exc)
    {
      return -1;
    }
  }
  
  // This method loads a next cell from the CSV data and converts it to double.
  // Return value: The resulting number, or a NaN (Not-a-Number) value in case
  // of an error.
  public double nextDouble()
  {
    try
    {
      return Double.parseDouble(next());
    }
    catch (NumberFormatException exc)
    {
      return Double.NaN;
    }
  }
  
  // This method loads a next cell from the CSV data and converts it to boolean.
  // Value which starts with 1 is converted to true, anything else is converted to false.
  // Return value: The resulting number, or false in case of error.
  public boolean nextBoolean()
  {
    return next().startsWith("1");
  }
  
  // This method loads a next cell from the CSV data, interprets it as a date in the American format,
  // i.e. (M)M/(D)D/YYYY (possibly followed by other information, which is ignored) and converts it to
  // the format YYYY-MM-DD.
  // Return value: The date in the YYYY-MM-DD format, or an empty string in case of an error.
  public String nextDate()
  {
    String[] date = next().split("/");
    if (date.length != 3)
    {
      return "";
    }
    
    String month = (date[0].length() < 2 ? "0" : "") + date[0];
    String day = (date[1].length() < 2 ? "0" : "") + date[1];
    String year = date[2].substring(0, 4);
    return year + "-" + month + "-" + day;
  }
  
  // This method loads a next cell from the CSV data, interprets it as a time in the HHMM format,
  // converts it to an integer representing the number of minutes since midnight.
  // Return value: The time as a number of minutes since midnight, or -1 in case of an error.
  public int nextTime()
  {
    String time = next();
    if (time.length() != 4)
    {
      return -1;
    }
    return (time.charAt(0) - '0') * 600 + (time.charAt(1) - '0') * 60 + (time.charAt(2) - '0') * 10 + (time.charAt(3) - '0');
  }
}
