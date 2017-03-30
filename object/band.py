from random import randint

class Animal:
    def singing(self):
        print("La-la-la")

class Dog(Animal):
    def singing(self):
        print("Gav-gav")

class Cat(Animal):
    def singing(self):
        print("Myayau-ya-yu")

n = 5
band = []

for i in range(n):
    t = randint(0, 1)
    if t == 0:
        band.append(Dog())
    elif t == 1:
        band.append(Cat())

for singer in band:
    singer.singing()
