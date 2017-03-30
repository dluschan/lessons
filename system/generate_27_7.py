from random import randint

x = 10**randint(0, 5)

n = randint(1, x*randint(1, 5))
m = randint(1, 20)

print(n, m)

for i in range(m):
    print(randint(1, x*randint(1, 5)), randint(1, x*randint(1, 5)))
