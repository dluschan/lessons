program test_time;
uses
	containers, sysutils;
const
	n = 50000000;
	k = 1000;
var
	i: longInt;
	m: container;
	it: iterator;

procedure log(mes: string);
var
	hr, min, sec, ms: word;
begin
	DecodeTime(Time(), hr, min, sec, ms);
	write(mes);
	writeln(' Current time: ', hr, ':', min, ':', sec, '.', ms);
end;

begin
	log('Start.');

	m := container.create();
	for i := 1 to n do
		m.push_back(i);
	log('Created.');

	m.at(n-1);
	log('Returned.');

	it := m.get_begin();
	for i := 1 to 100 do
		m.insert(it, 9);
	it.destroy();
	log('Inserted.');

	m.size();
	log('Returned size.');

	while not m.empty() do
		m.pop_back();
	m.destroy();
	log('Destroyed.');
end.
