program test_memory_leaks;
uses
	containers, sysutils;

procedure check(lost_memory: longInt);
begin
	if lost_memory = 0 then
		writeln('Ok')
	else
		writeln('Failed: ', lost_memory, ' bytes lost.');
end;

procedure test();
var
	m: container;
	it: iterator;
	memory: longInt;
	i, j: longInt;
begin
	memory := getHeapStatus().TotalAllocated;
	m := container.create();
	m.destroy();
	check(getHeapStatus().TotalAllocated - memory);

	memory := getHeapStatus().TotalAllocated;
	m := container.create();
	it := m.get_begin();
	it.destroy();
	m.destroy();
	check(getHeapStatus().TotalAllocated - memory);

	memory := getHeapStatus().TotalAllocated;
	m := container.create();
	m.push_back(1);
	m.pop_back();
	m.destroy();
	check(getHeapStatus().TotalAllocated - memory);

	memory := getHeapStatus().TotalAllocated;
	m := container.create();
	m.push_back(random(1000000));
	m.push_back(random(1000000));
	m.destroy();
	check(getHeapStatus().TotalAllocated - memory);

	memory := getHeapStatus().TotalAllocated;
	m := container.create();
	it := m.get_end();
	m.insert(it, random(1000000));
	m.erase(it);
	it.destroy();
	m.destroy();
	check(getHeapStatus().TotalAllocated - memory);

	memory := getHeapStatus().TotalAllocated;
	for i := 1 to 100 do
	begin
		m := container.create();
		for j := 1 to random(1000000) do
			m.push_back(j);
		m.destroy();
	end;
	check(getHeapStatus().TotalAllocated - memory);
end;

begin
	test();
end.
