#ifndef VECTOR_H
#define VECTOR_H

namespace containers
{
	typedef int* vector_iterator;

	class vector
	{
	private:
		vector_iterator m_begin;
		vector_iterator m_end;
		vector_iterator m_capacity;

	public:
		vector(int n=0);

		int operator[](int n);

		vector_iterator begin();

		vector_iterator end();

		void push_back(int x);

		int pop_back();

		bool insert(vector_iterator p, int x);

		void erase(vector_iterator p);
	};
};

#endif // VECTOR_H
