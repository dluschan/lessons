#ifndef MAP_H
#define MAP_H

namespace containers
{
	class Tree
	{
	public:
		Tree(int key, int data = 0)
			: m_key(key)
			, m_data(data)
		{}

		int& operator[](int key)
		{
			if (m_key == key)
				return m_data;
			if (m_key < key && m_right)
				return (*m_right)[key];
			if (m_key < key && !m_right)
			{
				m_right = new Tree(key);
				return m_right->m_data;
			}
			if (m_key > key && m_left)
				return (*m_left)[key];
			if (m_key > key && !m_left)
			{
				m_left = new Tree(key);
				return m_left->m_data;
			}
		}

	private:

		int   m_key;
		int   m_data;
		Tree* m_left;
		Tree* m_right;
	};

	class map
	{
	public:
		int& operator[](int key)
		{
			if (!m_root)
				m_root = new Tree(key);
			return m_root->operator [](key);
		}

	private:
		Tree* m_root;
	};
}

#endif // MAP_H
