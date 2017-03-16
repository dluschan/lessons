candy = [0 for i in range(100)]
for i in range(int(input())):
    d, k = map(int, input().split())
    if k % d > 0:
        candy[k % d] += 1
candy.reverse()
print(100 - 1 - candy.index(max(candy)))
