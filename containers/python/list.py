class Node:
    def __init__(self, x = None):
        self.m_data = x
        self.m_next = None
        self.m_prev = None

class List:
    def __init__(self):
        self.m_head = Node()
        self.m_tail = self.m_head

    def push_back(self, x):
        self.insert(self.m_tail, x)

    def pop_back(self):
        assert(not self.empty())
        cache = self.m_tail.m_prev.m_data
        self.erase(self.m_tail.m_prev)
        return cache

    def insert(self, node, data):
        local_node = Node(data)
        if self.empty():
            self.m_head = local_node
            self.m_head.m_next = self.m_tail
            self.m_tail.m_prev = self.m_head
        elif node == self.m_head:
            local_node.m_next = self.m_head
            self.m_head.m_prev = local_node
            self.m_head = local_node
        else:
            local_node.m_next = node
            local_node.m_prev = node.m_prev
            node.m_prev.m_next = local_node
            node.m_prev = local_node

    def erase(self, node):
        if node == self.m_tail:
            pass
        elif node == self.m_head:
            self.m_head = self.m_head.m_next
            del node
        else:
            node.m_next.m_prev = node.m_prev
            node.m_prev.m_next = node.m_next
            del node

    def empty(self):
        return self.m_tail == self.m_head

    def at(self, index):
        t = self.m_head
        for i in range(index):
            t = t.m_next
        return t.m_data
