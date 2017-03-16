n = int(input())
if n % 2 == 0:
    prev = n//2*(n-2)//2
    first = (prev + 1) * 2
else:
    prev = ((n - 1) // 2)**2
    first = prev * 2 + 1
s = n*(2*first + 2*n - 2) // 2
print(s)
