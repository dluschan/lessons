#include "vector.h"
#include <iostream>

namespace containers
{
	vector::iterator::iterator()
	{
		pointer = new int;
	}

	int* vector::iterator::operator&()
	{
		return pointer;
	}

	vector::iterator& vector::iterator::operator=(vector::iterator it)
	{
		pointer = it.pointer;
		return *this;
	}

	vector::iterator* vector::iterator::operator=(int i)
	{
		*pointer = i;
		return this;
	}

	vector::iterator& vector::iterator::operator=(int *i)
	{
		*pointer = *i;
		return *this;
	}

	vector::iterator& vector::iterator::operator+(int i)
	{
		pointer += i;
		return *this;
	}

	vector::iterator& vector::iterator::operator-(int i)
	{
		pointer -= i;
		return *this;
	}

	vector::iterator& vector::iterator::operator++()
	{
		++pointer;
		return *this;
	}

	vector::iterator& vector::iterator::operator++(int)
	{
		pointer++;
		return *this;
	}

	vector::iterator& vector::iterator::operator--()
	{
		--pointer;
		return *this;
	}

	vector::iterator& vector::iterator::operator--(int)
	{
		pointer--;
		return *this;
	}

	bool vector::iterator::operator!=(vector::iterator it)
	{
		return pointer != it.pointer;
	}

	bool vector::iterator::operator==(vector::iterator it)
	{
		return pointer == it.pointer;
	}

	bool vector::iterator::operator>(vector::iterator it)
	{
		return pointer > it.pointer;
	}

	bool vector::iterator::operator<(vector::iterator it)
	{
		return pointer < it.pointer;
	}

	bool vector::iterator::operator>=(vector::iterator it)
	{
		return pointer >= it.pointer;
	}

	bool vector::iterator::operator<=(vector::iterator it)
	{
		return pointer <= it.pointer;
	}

	vector::iterator::~iterator() {}

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

	vector::iterator vector::begin()
	{
		iterator it;
		it.pointer = m_begin;
		return it;
	}
	
    vector::iterator vector::end()
	{
		iterator it;
		it.pointer = m_end;
		return it;
	}

	void vector::push_back(int x)
	{
		*m_end++ = x;

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

	bool vector::insert(vector::iterator p, int x)
	{
        if ((p < begin()) or (p > end())) return false;

        *m_end = *(m_end-1);
        m_end++;

		for (vector::iterator it = end() - 1; it > p; it--)
			it = *(&it - 1);

        p = x;

		//if(p == end()) m_end++;

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
        
        return true;
	}

	bool vector::erase(vector::iterator p)
	{
        if ((p < begin()) or (p >= end())) return false;

		for (vector::iterator it = p; it < end(); ++it)
			it = *(&it + 1);
		--m_end;

        return true;
	}
};