import io

lines = [line.split(',') for line in open('flights_sample.csv').read().strip().split('\n')[1:]]

def fmt_date(date: str):
    month, day, year = date.split(' ')[0].split('/')
    return (year.zfill(4) + '-' + month.zfill(2) + '-' + day.zfill(2)).encode()

def fmt_int(integer: str):
    try:
        return str(int(integer)).encode()
    except:
        return str(0x7fff_ffff).encode()

def fmt_time(time: str):
    try:
        return str(int(time[:2]) * 60 + int(time[2:])).encode()
    except:
        return str(0x7fff_ffff).encode()

def fmt_float(num: str):
    try:
        return str(int(float(num))).encode()
    except:
        return str(0x7fff_ffff).encode()

def fmt_bool(boolean: str):
    return b'1' if boolean.startswith('1') else b'0'

def raw_int(num: int):
    result = ''
    for i in range(8):
        result = chr(ord('0') + num % 16) + result
        num //= 16
    return result.encode()

def fmt_text(text: str):
    return text.encode()

output = io.BytesIO()
for line in lines:
    output.write(fmt_date(line[0])+ b'\t')
    output.write(fmt_text(line[1])+ b'\t')
    output.write(fmt_int(line[2])+ b'\t')
    output.write(fmt_text(line[3])+ b'\t')
    output.write(fmt_text(line[4][1:] + ',' + line[5][:-1])+ b'\t')
    output.write(fmt_text(line[6])+ b'\t')
    output.write(fmt_int(line[7])+ b'\t')
    output.write(fmt_text(line[8])+ b'\t')
    output.write(fmt_text(line[9][1:] + ',' + line[10][:-1])+ b'\t')
    output.write(fmt_text(line[11])+ b'\t')
    output.write(fmt_int(line[12])+ b'\t')
    output.write(fmt_time(line[13])+ b'\t')
    output.write(fmt_time(line[14])+ b'\t')
    output.write(fmt_time(line[15])+ b'\t')
    output.write(fmt_time(line[16])+ b'\t')
    output.write(fmt_bool(line[17])+ b'\t')
    output.write(fmt_bool(line[18])+ b'\t')
    output.write(fmt_float(line[19])+ b'\t')

with open('flights_lines.txt', mode='wb') as file:
    data = output.getvalue()
    file.write(raw_int(len(data))+ b'\t')
    file.write(raw_int(len(lines))+ b'\t')
    file.write(data)
