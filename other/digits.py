n = int(input())
digits = [0 for i in range(10)]
for i in range(n):
    x = int(input())
    while x > 0:
        c = x % 10
        digits[c] += 1
        x //= 10
m = max(digits)
for i in range(9,-1,-1):
    if digits[i] == m:
        print(i, end='')
print()
