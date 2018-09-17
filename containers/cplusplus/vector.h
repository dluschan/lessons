#ifndef VECTOR_H
#define VECTOR_H

namespace containers
{
	typedef int* vector_iterator;

	class vector
	{
	public:
		class iterator
		{
		friend class vector;

		private:
			int *pointer;

			iterator();

		public:

			int* operator&();

			iterator& operator=(iterator);

			iterator* operator=(int);

			iterator& operator=(int*);

			iterator& operator+(int);

			iterator& operator-(int);

			iterator& operator++();

			iterator& operator++(int);

			iterator& operator--();

			iterator& operator--(int);

			bool operator==(iterator);

			bool operator!=(iterator);

			bool operator>(iterator);

			bool operator<(iterator);

			bool operator>=(iterator);

			bool operator<=(iterator);

			~iterator();
		};
	
	private:
		vector_iterator m_begin;
		vector_iterator m_end;
		vector_iterator m_capacity;

	public:
		vector(int n=1);

		int operator[](int n);

		iterator begin();

		iterator end();

		void push_back(int x);

		int pop_back();

		bool insert(iterator p, int x);

		bool erase(iterator p);
	};
};

#endif // VECTOR_H
