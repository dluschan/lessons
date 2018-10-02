class BinaryHeap:
	def __init__(self, s=None, reverse=False):
		self.comp = (lambda a, b: a > b) if reverse else (lambda a, b: a < b)
		self.data = []
		if s is None:
			pass
		elif isinstance(s, list):
			for x in s:
				self.push(x)
		else:
			raise TypeError('bad type')

	def __str__(self):
		return str(self.data)

	def __heapifyDown(self, p):
		l = 2*p + 1
		r = 2*p + 2
		if l == len(self.data) - 1:
			if self.comp(self.data[p], self.data[l]):
				self.data[l], self.data[p] = self.data[p], self.data[l]
		elif r <= len(self.data) - 1:
			m = r if self.comp(self.data[l], self.data[r]) else l
			if self.comp(self.data[p], self.data[m]):
				self.data[m], self.data[p] = self.data[p], self.data[m]
				self.__heapifyDown(m)

	def __heapifyUp(self, c):
		if c == 0:
			return
		p = (c - 1) // 2
		if self.comp(self.data[p], self.data[c]):
			self.data[c], self.data[p] = self.data[p], self.data[c]
			self.__heapifyUp(p)

	def pop(self):
		self.data[0], self.data[-1] = self.data[-1], self.data[0]
		res = self.data.pop()
		self.__heapifyDown(0)
		return res

	def push(self, x):
		self.data.append(x)
		self.__heapifyUp(len(self.data) - 1)

	def empty(self):
		return len(self.data) == 0
