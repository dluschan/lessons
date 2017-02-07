program test_push_pop_insert_erase;
uses
	containers;

function to_str(c: container): string;
var
	it_begin, it_end: iterator;
	res, s: string;
begin
	res := '';
	it_begin := c.get_begin();
	it_end := c.get_end();
	while not it_begin.equal(it_end) do
	begin
		str(it_begin.get_data():1, s);
		res := res + s + ' ';
		it_begin.next();
	end;
	it_begin.destroy();
	it_end.destroy();
	delete(res, length(res), 1);
	to_str := res;
end;

procedure print(c: container);
begin
	writeln(to_str(c));
end;

function equal(c: container; pattern: string): boolean;
begin
	check := to_str(c) = pattern;
end;

procedure check(c: container; pattern: string);
begin
	if equal(c, pattern) then
		writeln('Ok')
	else
		writeln('Foo');
end;

procedure test();
var
	m, m2: container;
	it: iterator;
begin
	m := container.create();
	m.push_back(1);
	m.push_back(2);
	m.push_back(3);
	m.push_back(4);
	m.push_back(5);

	check(m, '1 2 3 4 5');

	it := m.get_begin();
	it.next();
	it.next();
	m.insert(it, -1);
	m.insert(it, -2);
	m.insert(it, -3);
	it.destroy();

	check(m, '1 2 -3 -2 -1 3 4 5');

	it := m.get_begin();
	it.next();
	m.erase(it);
	m.erase(it);
	it.destroy();

	check(m, '1 -2 -1 3 4 5');
	
	m2 := container.create();
	while not m.empty() do
		m2.push_back(m.pop_back());

	m.destroy();
	
	check(m2, '5 4 3 -1 -2 1');

	m2.destroy();
end;

begin
	test();
end.
