from random import randint

month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days = [0]
s = 0
for i in range(len(month) - 1):
    s += month[i]
    days.append(s)

m = randint(1, 12)
d = randint(1, month[m-1])

cur_day = d + days[m - 1]

print(str(d).rjust(2, '0'), str(m).rjust(2, '0'), sep = '.')

cells = {}
for i in range(randint(3, 1000)):
    m0 = randint(1, 12)
    d0 = randint(1, month[m0-1])
    day = d0 + days[m0 - 1]
    if day <= cur_day:
        cells[randint(3, 1000)] = str(d0).rjust(2, '0') + '.' + str(m0).rjust(2, '0')

print(len(cells))
for key in sorted(cells):
    print(key, cells[key])
