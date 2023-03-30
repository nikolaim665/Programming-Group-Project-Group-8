class DatePicker
{
  private final int minYear, minMonth, minDay;
  private final int maxYear, maxMonth, maxDay;
  private int beginYear, beginMonth, beginDay;
  private int endYear, endMonth, endDay;
  private final int x, y, w, h;

  public DatePicker(Flights flights, int x, int y, int w, int h)
  {
    String[] range = flights.dateRange().split("-");
    beginYear = minYear = parseInt(range[0]);
    beginMonth = minMonth = parseInt(range[1]);
    beginDay = minDay = parseInt(range[2]);
    endYear = maxYear = parseInt(range[3]);
    endMonth = maxMonth = parseInt(range[4]);
    endDay = maxDay = parseInt(range[5]);
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  private int dateToDays(int y, int m, int d)
  {
    return y * 366 + m * 31 + d - minYear * 366 - minMonth * 31 - minDay;
  }
    
  private int dateToPos(int y, int m, int d)
  {
    return (int)(x + w * (long)dateToDays(y, m, d) / dateToDays(maxYear, maxMonth, maxDay)); 
  }
  
  private String daysToDate(int days)
  {
    return (minYear + days / 366) + "-" + (minMonth + days % 366 / 31) + "-" + (minDay + days % 366 % 31);
  }
  
  private int posToDays(int xPos)
  {
    return (int)((xPos - x) * (long)dateToDays(maxYear, maxMonth, maxDay) / w);
  }

  public void draw()
  {
    noStroke();
    int from = dateToPos(beginYear, beginMonth, beginDay);
    int to = dateToPos(endYear, endMonth, endDay);

    fill(#707070);
    rect(x, y, from - x, 8);
    rect(to, y, x + w - to, 8);

    fill(#0080FF);
    rect(from, y, to - from, 8);

    fill(0);
    textAlign(LEFT, TOP);
    text(beginYear + "-" + beginMonth + "-" + beginDay, x, y + 8);
    textAlign(RIGHT, TOP);
    text(endYear + "-" + endMonth + "-" + endDay, x + w, y + 8);
  }
  
  public void handlePress(int posX, int posY)
  {
    if (posX > x && posX < x + w && posY > y && posY < y + h)
    {
      int days = posToDays(posX);
      int beginDays = dateToDays(beginYear, beginMonth, beginDay);
      int endDays = dateToDays(endYear, endMonth, endDay);
  
      String[] date = daysToDate(days).split("-");
      int year = parseInt(date[0]);
      int month = parseInt(date[1]);
      int day = parseInt(date[2]);
      
      if (abs(days - beginDays) < abs(days - endDays))
      {
        beginYear = year;
        beginMonth = month;
        beginDay = day;
      }
      else
      {
        endYear = year;
        endMonth = month;
        endDay = day;
      }
    }
  }
}
