import io

lines = [line.split(',') for line in open('flights_sample.csv').read().strip().split('\n')[1:]]

def int_to_string(num: int):
    result = ''
    while num > 0:
        result = chr(ord('0') + num % 64) + result
        num //= 64
    return result.zfill(1)

def fmt_date(date: str):
    month, day, year = date.split(' ')[0].split('/')
    return (year.zfill(4) + '-' + month.zfill(2) + '-' + day.zfill(2)).encode()

def fmt_int(integer: str):
    try:
        return int_to_string(int(integer)).encode()
    except:
        return int_to_string(0x7fff_ffff).encode()

def fmt_time(time: str):
    try:
        return int_to_string(int(time[:2]) * 60 + int(time[2:])).zfill(2).encode()
    except:
        return int_to_string(0x7fff_ffff)[-2:].encode()

def fmt_float(num: str):
    try:
        return int_to_string(int(float(num))).encode()
    except:
        return int_to_string(0x7fff_ffff).encode()

def fmt_bool(boolean: str):
    return b'1' if boolean.startswith('1') else b'0'

def fmt_text(text: str):
    return text.encode()

lines.sort(key=lambda line: fmt_date(line[0]))

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
    output.write(fmt_time(line[13]))
    output.write(fmt_time(line[14]))
    output.write(fmt_time(line[15]))
    output.write(fmt_time(line[16]))
    output.write(fmt_bool(line[17]))
    output.write(fmt_bool(line[18]))
    output.write(fmt_float(line[19])+ b'\t')

with open('flights_lines.txt', mode='wb') as file:
    data = output.getvalue()
    file.write(int_to_string(len(data)).zfill(6).encode())
    file.write(int_to_string(len(lines)).zfill(6).encode())
    file.write(data)
