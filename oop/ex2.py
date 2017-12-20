class Figure:
    def __init__(self, perimeter = 0):
        self.setPerimeter(perimeter)

    def __str__(self):
        return "make string: " + str(self.p)

    def __int__(self):
        return self.p

    def setPerimeter(self, perimeter):
        self.p = perimeter

f = Figure(37)
print(f)
