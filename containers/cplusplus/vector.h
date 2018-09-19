#ifndef VECTOR_H
#define VECTOR_H

namespace containers
{
	template <typename T> class vector
	{
	public:
		typedef T* vector_iterator;

		vector(unsigned int n = 10)
		{
			m_begin = new T[n];
			m_end = m_begin;
			m_capacity = m_begin + n;
		}

		unsigned int size() const
		{
			return m_end - m_begin;
		}

		unsigned int capacity() const
		{
			return m_capacity - m_begin;
		}

		T& operator[](unsigned int n)
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

		void push_back(const T& x)
		{
			if (m_capacity == m_end)
			{
				const unsigned int size = m_end - m_begin;

				const unsigned int new_size = 3 * size / 2 + 1;

				T* new_begin = new T[new_size];
				while (m_begin < m_end)
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

		T pop_back()
		{
			return *--m_end;
		}

		void insert(vector_iterator p, T x)
		{
			if (m_capacity == m_end)
			{
				const int size = m_begin == m_end;
				const int new_size = 3 * size / 2 + 1;
				T* new_begin = new T[size];
				while (m_begin < m_end)
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
}; // namespace containers

#endif // VECTOR_H
