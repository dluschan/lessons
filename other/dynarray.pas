
program dyn_vectors;
type
	vector = array of integer;
var
	m1: vector;
	m2: vector;
	i: integer;
	n: integer;
begin
	n := 10;
	SetLength(m1, n);
	SetLength(m2, n);
	SetLength(m1, 3*n);

	i := 0;
	while i < 5*n do
	begin
		m1[i] := i;
		i := i + 1;
	end;

	i := 0;
	while i < 5*n do
	begin
		write(m1[i], ' ');
		i := i + 1;
	end;
	writeln();

	i := 0;
	while i < n do
	begin
		write(m2[i], ' ');
		i := i + 1;
	end;
	writeln();
end.
