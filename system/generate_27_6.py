from random import randint

n = randint(3, 30)
m = randint(3, 30)

print(n, m)

for i in range(n):
    for j in range(m):
        print(randint(-1000000, 1000000), end=' ')
    print()

i = randint(1, m)
j = randint(1, m)
while i == j:
    j = randint(1, m)

print(i, j)
