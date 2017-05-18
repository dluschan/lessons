base = 189

def rand01():
    global base
    base *= 69069
    base += 1
    base %= 2**32
    return base / 2**32

def rand(a, b):
    return a + (b - a) * rand01()

for i in range(10):
    print(rand(5, 50))
