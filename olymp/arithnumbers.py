def seq(a, d, n):
    res = str(a)
    for i in range(n-1):
        a += d
        a %= 10
        res += str(a)
    return res[::-1]

l = input()
r = input()

limits = set()
for a in range(10):
    for d in range(10):
        limits.add(int(seq(a, d, len(l))))
        limits.add(int(seq(a, d, len(r))))

res = 100*(len(r) - len(l) - 1)
for limit in limits:
    if int(l) <= limit and limit <= int(r):
        res += 1
print(res)
