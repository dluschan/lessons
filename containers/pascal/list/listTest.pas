program listTest;
uses
	listlib;
var
	m: list;
	a, b: list_iterator;

begin
	m := list.create();
	m.push_back(1);
	m.push_back(2);
	m.push_back(3);
	m.push_back(4);
	m.push_back(5);

	a := m.get_begin();
	a.next();
	a.next();
	m.insert(a, -1);
	m.insert(a, -2);
	m.insert(a, -3);
	a.destroy();
	
	a := m.get_begin();
	b := m.get_end();
	while not a.equal(b) do
	begin
		write(a.get_data(), ' ');
		a.next();
	end;
	writeln();
	
	a.destroy();
	b.destroy();

	a := m.get_begin();
	a.next();
	m.erase(a);
	m.erase(a);

	a := m.get_begin();
	b := m.get_end();
	while not a.equal(b) do
	begin
		write(a.get_data(), ' ');
		a.next();
	end;
	writeln();
end.
