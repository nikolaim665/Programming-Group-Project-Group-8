lines = [line.split(',') for line in open('flights_sample.csv').read().strip().split('\n')[1:]]

def fmt_date(date: str):
    month, day, year = date.split(' ')[0].split('/')
    return year.zfill(4) + '-' + month.zfill(2) + '-' + day.zfill(2)

def fmt_int(integer: str):
    try:
        return str(int(integer))
    except:
        return -1

def fmt_time(time: str):
    try:
        return str(int(time[:2]) * 60 + int(time[2:]))
    except:
        return -1

def fmt_float(num: str):
    try:
        return str(float(num))
    except:
        return -1

def fmt_bool(boolean: str):
    return '1' if boolean.startswith('1') else '0'


with open('flights_lines.txt', mode='w') as output:
    print(len(lines), file=output)
    for line in lines:
        print(fmt_date(line[0]), file=output)
        print(line[1], file=output)
        print(fmt_int(line[2]), file=output)
        print(line[3], file=output)
        print(line[4][1:] + ',' + line[5][:-1], file=output)
        print(line[6], file=output)
        print(fmt_int(line[7]), file=output)
        print(line[8], file=output)
        print(line[9][1:] + ',' + line[10][:-1], file=output)
        print(line[11], file=output)
        print(fmt_int(line[12]), file=output)
        print(fmt_time(line[13]), file=output)
        print(fmt_time(line[14]), file=output)
        print(fmt_time(line[15]), file=output)
        print(fmt_time(line[16]), file=output)
        print(fmt_bool(line[17]), file=output)
        print(fmt_bool(line[18]), file=output)
        print(fmt_float(line[19]), file=output)
