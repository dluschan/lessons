program vectorTest;
uses
	vectorlib;
var
	m: Vector;
	a, b: Iterator;

begin
	m := Vector.create();

	m.push_back(112);
	m.push_back(-8);
	m.push_back(87);

	a := m.start();
	m.insert(a, 5);
	b := m.finish();
	m.insert(b, 50);

	b := m.finish();
	while not a.equal(b) do
	begin
		write(a.data(), ' ');
		a := a.next();
	end;
	writeln();
end.
