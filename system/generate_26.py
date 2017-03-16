from random import randint

x = 10**randint(0, 5)

n = randint(1, 5*x)
b = randint(1, 3*x)
a = b + randint(1, 2*x)
d = randint(1, 2*x)
c = d + randint(1, 3*x)

print(n)
print(a)
print(b)
print(c)
print(d)
