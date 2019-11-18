#include <vector>
#include <valarray>

class SegmentTree
{
public:
	SegmentTree(const std::vector<int>&);
	int operator[](const std::slice&);
	
private:
	int get(int k, int a, int b, int l, int r);
	std::vector<int> data;
};

SegmentTree::SegmentTree(const std::vector<int>& a)
{
	const int inf = std::numeric_limits<int>::max();
	int n = int(exp2(ceil(log2(a.size()))));
	data = std::vector<int>(2*n, inf);
	for (int i = n; i < n + a.size(); ++i)
		data[i] = a[i - n];
	for (int i = n - 1; i != 0; --i)
		data[i] = std::min(data[2*i], data[2*i + 1]);
	for (auto x : data)
		std::cout << x << ' ';
	std::cout << std::endl;
}

int SegmentTree::operator[](const std::slice& a)
{
	return get(1, 0, data.size() / 2, a.start(), a.start() + a.size());
}

int SegmentTree::get(int k, int a, int b, int l, int r)
{
	if (a == l && b == r)
	{
		return data[k];
	}
	else
	{
		int mid = (a + b) / 2;
		if (r <= mid)
		{
			return get(2*k, a, mid, l, r);
		}
		else if (l >= mid)
		{
			return get(2*k+1, mid, b, l, r);
		}
		else
		{
			return std::min(get(2*k, a, mid, l, mid), get(2*k+1, mid, b, mid, r));
		}
	}
}

