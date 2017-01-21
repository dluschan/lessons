program listTest;
uses
	listlib;
var
	m: List;
	a, b: Iterator;

begin
	m := List.create();

	m.push_back(112);
	m.push_back(-8);
	m.push_back(87);

	a := m.start();
	m.insert(a, 37);

	a := m.start();
	b := m.finish();
	while not a.equal(b) do
	begin
		write(a.data(), ' ');
		a := a.next();
	end;
	writeln();
end.
