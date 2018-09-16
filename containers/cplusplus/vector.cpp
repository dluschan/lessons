#include "vector.h"

namespace containers
{
    vector::vector(int n)
	{
		m_begin = new int[n];
		m_end = m_begin;
		m_capacity = m_begin + n;
	}

	int vector::operator[](int n)
	{
		return m_begin[n];
	}

	vector_iterator vector::begin()
	{
		return m_begin;
	}
	
    vector_iterator vector::end()
	{
		return m_end;
	}

	void vector::push_back(int x)
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

	int vector::pop_back()
	{
        if(2 * (m_capacity - m_begin) / 3 >= (m_end - m_begin))
        {
            const int size = m_end - m_begin;

            int new_size = (m_capacity - m_end - 1) / 3 + size;

            int *new_begin = new int[new_size];
            while(m_begin < m_end)
                *new_begin++ = *m_begin++;
            new_begin -= size;

            m_begin -= size;
            delete[] m_begin;
            
            m_begin = new_begin;
            m_end = m_begin + size;
            m_capacity = m_begin + new_size;
        }

		return *--m_end;
	}

	void vector::insert(vector_iterator p, int x)
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

	void vector::erase(vector_iterator p)
	{
		for (vector_iterator it = p; it < m_end; ++it)
			*it = *(it + 1);
		--m_end;
	}
};