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

		class iterator
		{
		private:
			unsigned int *pointer;

			iterator();

		public:

			iterator& operator=(iterator);

			bool operator==(iterator);

			bool operator!=(iterator);

			~iterator();
		};

		vector(int n=1);

		int operator[](int n);

		vector_iterator begin();

		vector_iterator end();

		void push_back(int x);

		int pop_back();

		bool insert(vector_iterator p, int x);

		bool erase(vector_iterator p);
	};
};

#endif // VECTOR_H
