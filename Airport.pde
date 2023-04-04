static class Airport
{
  public final String code;
  public final int flights;
  
  public Airport(String code, int flights)
  {
    this.code = code;
    this.flights = flights;
  }
  
  // Be careful! This method modifies the array argument as well and the passed array should not be
  // used afterwards. Use the newly returned sorted array.
  public static Airport[] sort(Airport[] array)
  {
    Airport[] second = new Airport[array.length], tmp = null;
    int[] counts = new int[1024];
    int[] starts = new int[1024];
    
    for (int bit = 0, len = array.length; bit < 30; bit += 10)
    {
      for (int i = 0; i < len; ++i)
      {
        ++counts[(array[i].flights >>> bit) & 1023];
      }
      starts[1023] = 0;
      for (int i = 1023; i > 0; --i)
      {
        starts[i - 1] = starts[i] + counts[i];
        counts[i] = 0;
      }
      counts[1023] = 0;
      for (int i = 0; i < len; ++i)
      {
        int key = (array[i].flights >>> bit) & 1023;
        second[starts[key]] = array[i];
        ++starts[key];
      }
      tmp = second;
      second = array;
      array = tmp;
    }
    return second;
  }
}
