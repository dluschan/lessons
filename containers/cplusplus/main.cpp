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

	//n+=v.insert(v.begin() + zero_pos, 9);
	//std::cout<<v.begin()<<" "<<v.begin()+zero_pos<<"\n\n";
	containers::vector::iterator i = v.erase(v.begin()+zero_pos);
	//v.insert(v.begin()+zero_pos, 9);
	std::cout<<&i<<" : "<<&(v.begin() + zero_pos)<<"\n";

	for(containers::vector::iterator it = v.begin(); it < v.end(); it++)
		cout<<*&it<<"\n";

	return 0;
}
