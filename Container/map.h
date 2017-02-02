#ifndef MAP_H
#define MAP_H

namespace containers
{
	class Node
	{
		friend class map_iterator;
		friend class map;

	private:
		Node(Node* parent, int key, int data = 0)
			: m_key(key)
			, m_data(data)
			, m_parent(parent)
			, m_left(nullptr)
			, m_right(nullptr)
		{}

		int& operator[](int key)
		{
			if (m_key < key && m_right)
				return (*m_right)[key];
			if (m_key < key && !m_right)
			{
				m_right = new Node(this, key);
				return m_right->m_data;
			}
			if (m_key > key && m_left)
				return (*m_left)[key];
			if (m_key > key && !m_left)
			{
				m_left = new Node(this, key);
				return m_left->m_data;
			}
			return m_data;
		}

		Node* walk_left()
		{
			if (m_left)
				return m_left->walk_left();
			else
				return this;
		}

		Node* walk_until_left()
		{
			if (m_parent->m_right == this)
				return m_parent->walk_until_left();
			else
				return this;
		}

		Node* walk_right()
		{
			if (m_right)
				return m_right->walk_right();
			else
				return this;
		}

		Node* walk_until_right()
		{
			if (m_parent->m_left == this)
				return m_parent->walk_until_right();
			else
				return this;
		}

		int   m_key;
		int   m_data;
		Node* m_parent;
		Node* m_left;
		Node* m_right;
	};

	class map_iterator
	{
	public:
		map_iterator(Node* node)
			: m_node(node)
		{}

		map_iterator(const map_iterator& other)
			: m_node(other.m_node)
		{}

		map_iterator& operator++()
		{
			if (m_node->m_right)
			{
				m_node = m_node->m_right->walk_left();
			}
			else
			{
				m_node = m_node->walk_until_left()->m_parent->walk_left();
			}
			return *this;
		}

		map_iterator operator++(int)
		{
			map_iterator tmpIt(*this);
			++(*this);
			return tmpIt;
		}

		map_iterator& operator--()
		{
			if (m_node->m_left)
			{
				m_node = m_node->m_left->walk_right();
			}
			else
			{
				m_node = m_node->walk_until_right()->m_parent->walk_right();
			}
			return *this;
		}

		map_iterator operator--(int)
		{
			map_iterator tmpIt(*this);
			--(*this);
			return tmpIt;
		}

		int& operator*()
		{
			return m_node->m_data;
		}

		int operator==(const map_iterator& other)
		{
			return m_node == other.m_node;
		}

		int operator!=(const map_iterator& other)
		{
			return !(*this == other);
		}
	private:
		Node* m_node;
	};

	class map
	{
	public:
		map()
			: m_begin(new Node(nullptr, 0))
			, m_end(m_begin)
		{}

		int& operator[](int key)
		{
			if (!m_root)
				m_root = new Node(nullptr, key);
			int& data = m_root->operator [](key);
			m_begin = map_iterator(m_root->walk_left());
			return data;
		}

		map_iterator begin()
		{
			return m_begin;
		}

		map_iterator end()
		{
			return m_end;
		}

	private:
		Node* m_root;
		map_iterator m_begin;
		map_iterator m_end;
	};
}

#endif // MAP_H
