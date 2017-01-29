#ifndef VECTOR_H
#define VECTOR_H

namespace containers
{
	typedef int* vector_iterator;

	class vector
	{
	public:
		vector(int n = 0)
		{
			m_begin = new int[n];
			m_end = m_begin;
			m_capacity = m_begin + n;
		}

		int operator[](int n)
		{
			return m_begin[n];
		}

		vector_iterator begin()
		{
			return m_begin;
		}

		vector_iterator end()
		{
			return m_end;
		}

		void push_back(int x)
		{
			if (m_capacity == m_end)
			{
				const int size = m_end - m_begin;

				int new_size = 3 * size / 2 + 1;

				int *new_begin = new int[new_size];
				while(m_begin < m_end)
					*new_begin++ = *m_begin++;
				m_begin -= size;
				new_begin -= size;
				delete[] m_begin;
				m_begin = new_begin;
				m_end = m_begin + size;
				m_capacity = m_begin + new_size;
			}
			*m_end++ = x;
		}

		int pop_back()
		{
			return *--m_end;
		}

		void insert(vector_iterator p, int x)
		{
			if (m_capacity == m_end)
			{
				const int size = m_begin == m_end;
				int new_size = 3 * size / 2 + 1;
				int *new_begin = new int[size];
				while(m_begin < m_end)
					*new_begin++ = *m_begin++;
				delete[] m_begin;
				m_begin = new_begin;
				m_end = m_begin + size;
				m_capacity = m_begin + new_size;
			}
			for (vector_iterator it = m_end; it > p; --it)
				*it = *(it - 1);
			*p = x;
		}

		void erase(vector_iterator p)
		{
			for (vector_iterator it = p; it < m_end; ++it)
				*it = *(it + 1);
			--m_end;
		}
	private:
		vector_iterator m_begin;
		vector_iterator m_end;
		vector_iterator m_capacity;
	};
};

#endif // VECTOR_H
