class ChessProblem:
    def __init__(self, size, start, finish, bad):
        self.size = size
        self.start = start
        self.finish = finish
        self.bad = bad
        self.close = []
        self.open = []
    
    def show(self):
        print('Check position:')
        for j in range(self.size[1]):
            for i in range(self.size[0]):
                if (i, j) in self.bad:
                    print('#', end = ' ')
                elif (i, j) in self.close:
                    print('1', end = ' ')
                elif (i, j) == self.start:
                    print('s', end = ' ')
                elif (i, j) == self.finish:
                    print('f', end = ' ')
                else:
                    print('0', end = ' ')
            print()

    def getstart(self):
        return self.start

    def isfinish(self, cur):
        return self.finish == cur

    def near(self, v):
        return [(v[0]+dx, v[1]+dy) for dx in [-1, 0, 1] for dy in [-1, 0, 1] if dx != 0 or dy != 0]

    def check(self, v):
        return v[0] >= 0 and v[0] < self.size[0] \
            and v[1] >= 0 and v[1] < self.size[1] \
            and v not in self.bad + self.close + self.open

    def generate(self, cur):
        self.close.append(cur)
        p = [v for v in self.near(cur) if self.check(v)]
        self.open += p
        return p

def find(start, isfinish, generate, show):
    s = start
    step = 0
    while s:
        cur = s.pop(0)
        if isfinish(cur):
            return step
        q = generate(cur)
        s += q
        step += 1
        show()

game = ChessProblem((5, 5), (0, 0), (3, 2), [(2, 1), (3, 1), (2, 2)])
print(find([game.getstart()], game.isfinish, game.generate, game.show))
