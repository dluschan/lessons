class SegmentTree:
    def __init__(self, s, f, zero):
        self.k = len(s)
        self.f = f
        n = 1
        while n < len(s):
            n *= 2
        self.size = 2*n
        self.data = [None] * n + list(s) + [zero] * (n - len(s))
        self.__build()

    def __build(self):
        for i in range(self.size // 2 - 1, 0, -1):
            self.data[i] = self.f(*self.data[2*i: 2*i + 2])

    def __getitem__(self, item):
            if isinstance(item, slice):
                return self.__request((item.start, item.stop))
            elif isinstance(item, int):
                return self.__request((item, item))
            else:
                raise TypeError('bad type')

    def __request(self, x, y = None):
        if y is None:
            y = 0, self.size // 2 - 1, 1
        l, r = x
        a, b, k = y
        m = (a + b) // 2
        if l == a and r == b:
            return self.data[k]
        elif m >= r:
            return self.__request(x, (a, m, 2*k))
        elif l > m:
            return self.__request(x, (m+1, b, 2*k + 1))
        else:
            return self.f(self.__request((l, m), (a, m, 2*k)), self.__request((m+1, r), (m+1, b, 2*k + 1)))
