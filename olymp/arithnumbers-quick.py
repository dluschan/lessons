def between(a, d, border_l, border_r):
    k = len(border_l)
    for i in range(len(border_l)):
        k -= 1
        q = (a + k*d) % 10
        if q != int(border_l[i]) or q != int(border_r[i]):
            break
    return int(border_l[len(border_l) - 1 - k]) <= q and q <= int(border_r[len(border_l) - 1 - k])

def le(a, d, border): # seq(a, d) less or equal than border
    k = len(border)
    for digit in border:
        k -= 1
        q = (a + k*d) % 10
        if int(digit) != q:
            break
    return q <= int(border[len(border) - 1 - k])

def ge(a, d, border): # seq(a, d) greater or equal than border
    k = len(border)
    for digit in border:
        k -= 1
        q = (a + k*d) % 10
        if int(digit) != q:
            break
    return int(border[len(border) - 1 - k]) <= q

l = input()
r = input()

res = max(99*(len(r) - len(l) - 1), 0)

if len(l) == 1 and len(r) == 1:
    print(int(r) - int(l) + 1)
    exit(0)

if len(l) == 1 and len(r) > 1:
    res += 10 - int(l)
    l = '10'

for a in range(10):
    for d in range(10):
        if len(r) == len(l):
            if between(a, d, l, r):
                res += 1
                print('b', a, d)
        if len(r) - len(l) > 0:
            if ge(a, d, l):
                res += 1
                print('g', a, d)
            if ge(a, d, l) and le(a, d, r):
                res += 1
                print('l and g', a, d)
print(res)
