#include <algorithm>
#include <iostream>
#include "vector.h"

using namespace std;

int main()
{
	containers::vector v;

	unsigned int n, zero_pos;
	cin>>n>>zero_pos;
	cout<<"\n";

	for(int i=0; i<n; i++)
	{
		v.push_back(i);
		std::cout<<i<<'\n';
	}

	cout<<"\n";

	n+=v.insert(v.begin()+zero_pos, 0);
	for(int i=0; i<n; i++)
		cout<<v.pop_back()<<"\n";

	return 0;
}
