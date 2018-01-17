r = int(input())
w = [int(x) for x in input().split()]
c = [int(x) for x in input().split()]

m = [0]
for i in range(1, r + 1):
    m.append(max([x[0] + m[i - x[1]] for x in zip(c, w) if x[1] <= i], default = 0))
print(m)
