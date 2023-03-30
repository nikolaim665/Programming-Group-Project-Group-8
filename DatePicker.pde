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
    return round(float(xPos - x) * dateToDays(maxYear, maxMonth, maxDay) / w);
  }

  private String formatDate(int y, int m, int d)
  {
    int january = y % 4 == 0 && (y % 100 != 0 || y % 400 == 0) ? 29 : 28;
    int[] monthLengths = {31, january, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    m = max(1, min(m, 12));
    d = max(1, min(d, monthLengths[m - 1]));
    return y + (m < 10 ? "-0" : "-") + m + (d < 10 ? "-0" : "-") + d;
  }

  public String beginDate()
  {
    return formatDate(beginYear, beginMonth, beginDay);
  }

  public String endDate()
  {
    return formatDate(endYear, endMonth, endDay);
  }

  public void draw()
  {
    noStroke();
    int from = dateToPos(beginYear, beginMonth, beginDay);
    int to = dateToPos(endYear, endMonth, endDay);

    fill(#707070);
    rect(x, y, from - x, 9);
    rect(to, y, x + w - to, 9);

    fill(#0080FF);
    rect(from, y, to - from, 9);

    fill(0);
    textAlign(LEFT, TOP);
    text(beginDate(), x, y + 9, w, h - 9);
    textAlign(RIGHT, TOP);
    text(endDate(), x, y + 9, w, h - 9);
  }
  
  public void mousePressed(int posX, int posY)
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
