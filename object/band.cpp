#include <iostream>
#include <vector>
#include <random>

class Animal
{
public:
	virtual void singing()
	{
		std::cout << "la-la-la" << std::endl;
	}
};

class Dog: public Animal
{
public:
	void singing()
	{
		std::cout << "Gav-gav" << std::endl;
	}
};

class Terrier: public Dog
{
public:
	void singing()
	{
		std::cout << "tyaf-gav-tyaf" << std::endl;
	}
};

class Pitbull: public Dog
{
public:
	void singing()
	{
		std::cout << "Rr:r:rr-r" << std::endl;
	}
};

class Cat: public Animal
{
public:
	void singing()
	{
		std::cout << "Myayau-ya-yu" << std::endl;
	}
};

int main()
{
	const int n = 5;
	std::vector<Animal*> band;
	for (int i = 0; i < n; ++i)
	{
		switch (rand() % 4)
		{
		case 0:
			band.push_back(new Cat);
			break;
		case 1:
			band.push_back(new Dog);
			break;
		case 2:
			band.push_back(new Terrier);
			break;
		case 3:
			band.push_back(new Pitbull);
			break;
		}
	}

	for (auto singer: band)
		singer->singing();

	return 0;
}
