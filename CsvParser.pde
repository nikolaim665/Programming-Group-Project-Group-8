// This class reads data from data in the CSV format, stored as a byte array. It assumes the data
// to use the ASCII encoding (which is sufficient for the data from the US Bureau of Transportation).
class CsvParser
{  
  private byte[] bytes;
  private int position = 0;
  
  // Reads data from a file at the given filepath
  public CsvParser(byte[] bytes)
  {
    this.bytes = bytes;
  }
  
  // This method tells whether the end of the data has been reached
  // Return value: true, if the end has been reached, false otherwise
  public boolean reachedEnd()
  {
    return position >= bytes.length;
  }
  
  // This method loads a next cell from the CSV data.
  // Return value: The text contained in the cell.
  public String next()
  {
    StringBuilder result = new StringBuilder();
    boolean isQuoted = position < bytes.length && bytes[position] == '"';
    
    if (isQuoted)
    {
      ++position;
    }
    
    while (position < bytes.length)
    {
      // Ignore control characters other than newline (e.g. Carriage Return characted on Windows)
      if (bytes[position] < 32 && bytes[position] != '\n')
      {
        ++position;
      }
      // Non-quoted cell is terminated by a newline or a comma
      else if (!isQuoted && (bytes[position] == '\n' || bytes[position] == ','))
      {
        ++position;
        break;
      }
      // Quoted cell is terminated by a quote character followed by a newline or a comma
      else if (isQuoted && bytes[position] == '"' && (bytes[position + 1] == '\n' || bytes[position + 1] == ','))
      {
        position += 2;
        break;
      }
      // Two quote characters inside quoted cell denote quote character
      else if (isQuoted && bytes[position] == '"' && bytes[position + 1] == '"')
      {
          position += 2;
          result.append('"');
      }
      // Other characters are just content of the cell
      else
      {
        result.append((char)bytes[position]);
        ++position;
      }
    }
    
    return result.toString();
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
  // Number which rounds to 1 is converted to true, anything else is converted to false.
  // Return value: The resulting number, or false in case of error.
  public boolean nextBoolean()
  {
    try
    {
      return Math.round(Double.parseDouble(next())) == 1;
    }
    catch (NumberFormatException exc)
    {
      return false;
    }
  }
  
  // This method loads a next cell from the CSV data, interprets it as a date in the American format,
  // i.e. MM/DD/YYYY (possibly followed by other information, which is ignored) and converts it to
  // the format YYYY-MM-DD.
  // Return value: The date in the YYYY-MM-DD format, or an empty string in case of an error.
  public String nextDate()
  {
    try
    {
      String date = next();
      int monthEnd = date.indexOf('/');
      int dayEnd = date.indexOf('/', monthEnd + 1);
      String month = (monthEnd < 2 ? "0" : "") + date.substring(0, monthEnd);
      String day = (dayEnd - monthEnd < 3 ? "0" : "") + date.substring(monthEnd + 1, dayEnd);
      String year = date.substring(dayEnd + 1, dayEnd + 5);
      return year + "-" + month + "-" + day;
    }
    catch (IndexOutOfBoundsException exc)
    {
      return "";
    }
  }
  
  // This method loads a next cell from the CSV data, interprets it as a time in the HHMM format,
  // converts it to an integer representing the number of minutes since midnight.
  // Return value: The time as a number of minutes since midnight, or -1 in case of an error.
  public int nextTime()
  {
    try
    {
      String time = next();
      int hours = Integer.parseInt(time.substring(0, 2));
      int minutes = Integer.parseInt(time.substring(2, 4));
      return hours * 60 + minutes;
    }
    catch (IndexOutOfBoundsException exc)
    {
      return -1;
    }
    catch (NumberFormatException exc)
    {
      return -1;
    }
  }
  
  // This method sets the current position in the data to the begining of the next line
  public void skipLine()
  {
    boolean insideQuotes = false;
    
    while (position < bytes.length)
    {
      if (bytes[position] == '"')
      {
        insideQuotes = !insideQuotes;
      }
      else if (bytes[position] == '\n' && !insideQuotes)
      {
        ++position;
        break;
      }
      ++position;
    }
  }
}
