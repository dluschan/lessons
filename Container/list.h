#ifndef LIST_H
#define LIST_H

namespace containers
{
	class list_link
	{
	public:
		list_link(int data)
			: m_data(data)
			, m_next(nullptr)
			, m_prev(nullptr)
		{}

		void setNext(list_link* it)
		{
			m_next = it;
		}

		void setPrev(list_link* it)
		{
			m_prev = it;
		}

		friend class list_iterator;

	private:
		int        m_data;
		list_link* m_next;
		list_link* m_prev;
	};

	class list_iterator
	{
	public:
		list_iterator(list_link* l)
			: m_link(l)
		{}

		list_iterator(const list_iterator& other)
			: m_link(other.getLink())
		{}

		list_iterator& operator++()
		{
			m_link = m_link->m_next;
			return *this;
		}

		list_iterator operator++(int)
		{
			list_iterator tmpIt(*this);
			++(*this);
			return tmpIt;
		}

		list_iterator& operator--()
		{
			m_link = m_link->m_prev;
			return *this;
		}

		list_iterator operator--(int)
		{
			list_iterator tmpIt(*this);
			--(*this);
			return tmpIt;
		}

		int operator*()
		{
			return m_link->m_data;
		}

		int operator==(const list_iterator& other)
		{
			return m_link == other.m_link;
		}

		int operator!=(const list_iterator& other)
		{
			return !(*this == other);
		}

		list_link* getLink() const
		{
			return m_link;
		}

	private:
		list_link* m_link;
	};

	class list
	{
	public:
		list()
			: m_begin(new list_link(0))
			, m_end  (m_begin)
		{}

		~list()
		{
			while (!empty())
					erase(m_begin);
			delete m_end.getLink();
		}

		list_iterator begin()
		{
			return m_begin;
		}

		list_iterator end()
		{
			return m_end;
		}

		void push_back(int x)
		{
			insert(m_end, x);
		}

		int pop_back()
		{
			list_iterator it = m_end;
			int tmp = *--it;
			erase(it);
			return tmp;
		}

		void insert(list_iterator p, int x)
		{
			list_link* l = new list_link(x);
			if (empty())
			{
				m_begin = list_iterator(l);
				m_begin.getLink()->setNext(m_end.getLink());
				m_end.getLink()->setPrev(m_begin.getLink());
				return;
			}

			if (p == m_begin)
			{
				list_link* nextLink = p.getLink();
				l->setNext(nextLink);
				nextLink->setPrev(l);
			}
			else
			{
				list_link* nextLink = p.getLink();
				list_link* prevLink = (--p).getLink();
				l->setNext(nextLink);
				nextLink->setPrev(l);
				l->setPrev(prevLink);
				prevLink->setNext(l);
			}
		}

		void erase(list_iterator p)
		{
			if (p == m_end)
				return;
			if (p == m_begin)
			{
				list_link* linkNext = (++p).getLink();
				delete m_begin.getLink();
				m_begin = list_iterator(linkNext);
			}
			else
			{
				list_link* linkNext = (++p).getLink();
				list_link* linkPrev = (----p).getLink();
				delete (++p).getLink();
				linkNext->setPrev(linkPrev);
				linkPrev->setNext(linkNext);
			}
		}

		bool empty()
		{
			return m_begin == m_end;
		}

	private:
		list_iterator m_begin;
		list_iterator m_end;
	};
}

#endif // LIST_H
