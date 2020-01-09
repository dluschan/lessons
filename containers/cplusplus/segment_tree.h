#include <vector>
#include <valarray>

template<typename T, typename BinaryOperator>
class SegmentTree
{
public:
	SegmentTree(const std::vector<T>& data, BinaryOperator fun, T zero = T());
	T operator[](const std::slice&);

private:
	T get(size_t from, size_t to, size_t root, size_t left, size_t right);

	size_t left_child(size_t k) const
	{
		return 2*k;
	}

	size_t right_child(size_t k) const
	{
		return 2*k + 1;
	}

	size_t parent(size_t k) const
	{
		return (k - 1) / 2;
	}

	std::vector<T> m_data;
	BinaryOperator m_fun;
	size_t m_size;
};

template<typename T, typename BinaryOperator>
SegmentTree<T, BinaryOperator>::SegmentTree(const std::vector<T>& data, BinaryOperator fun, T zero)
	: m_fun(fun)
{
	m_size = 1;
	while (m_size < data.size())
		m_size *= 2;
	m_data = std::vector<T>(2 * m_size, zero);
	for (size_t i = m_size; i < m_size + data.size(); ++i)
		m_data[i] = data[i - m_size];
	for (size_t i = m_size - 1; i != 0; --i)
		m_data[i] = m_fun(m_data[left_child(i)], m_data[right_child(i)]);
}

template<typename T, typename BinaryOperator>
T SegmentTree<T, BinaryOperator>::operator[](const std::slice& a)
{
	return get(a.start(), a.start() + a.size(), 1, 0, m_size);
}

template<typename T, typename BinaryOperator>
T SegmentTree<T, BinaryOperator>::get(size_t from, size_t to, size_t root, size_t left, size_t right)
{
	if (from == left && to == right)
	{
		return m_data[root];
	}
	else
	{
		size_t mid = (left + right) / 2;
		if (to <= mid)
		{
			return get(from, to, left_child(root), left, mid);
		}
		else if (from >= mid)
		{
			return get(from, to, right_child(root), mid, right);
		}
		else
		{
			return m_fun(get(from, mid, left_child(root), left, mid), get(mid, to, right_child(root), mid, right));
		}
	}
}
