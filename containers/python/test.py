from list import List

a = List()
a.push_back(3)
a.push_back(5)
a.push_back(0)
a.insert(a.m_head, 100)
a.erase(a.m_head.m_next)
while not a.empty():
    print(a.pop_back())
