n, k = map(int, input().split())
print(0 if n <= k // 2 else min(n, k - 1) - k // 2)
