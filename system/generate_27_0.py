from random import randint

n = randint(1, 100)
m = randint(1, 100)

print(n)
print(m)

for i in range(n*m):
    print(randint(-1000000, 1000000))
