#include <algorithm>
#include <iostream>
#include "vector.h"
#include "list.h"
#include "map.h"

using namespace std;
using namespace containers;

template<class T>
void proc(T& v)
{
	for (int i = 0; i < 10; ++i)
		v.push_back(rand() % 100);

	for (auto x: v)
		cout << x << ' ';
	cout << endl;

	sort(v.begin(), v.end());

	for (auto x: v)
		cout << x << ' ';
	cout << endl;
}

void proc(list& l)
{
	for (int i = 0; i < 10; ++i)
		l.push_back(rand() % 100);

	auto it = l.begin();
	auto itEnd = l.end();

	while (it != itEnd)
		cout << *(it++) << ' ';
	cout << endl;

	it = l.begin();

	while (it++ != itEnd)
		l.pop_back();

	it = l.begin();

	while (it != itEnd)
		cout << *(it++) << ' ';
	cout << endl;
}

void procHeavy(list& l, int n, int k)
{
	while (n--)
	{
		for (int i = 0; i < k; ++i)
			l.push_back(rand() % 100);
		for (int i = 0; i < k; ++i)
			l.pop_back();
	}
}

void proc(map& m)
{
	m[1] = 1;
	m[2] = 2;
	m[3] = 3;
	auto it = m.begin();
	auto itEnd = m.end();
	for (; it != itEnd; ++it)
		cout << *it << ' ';
	cout << endl;
}

int main()
{
	vector v;
	list l;
	map m;
	proc(m);
	//procHeavy(l, 5, 1000);
	return 0;
}
