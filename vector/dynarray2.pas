program dyn_vectors;
type
	vector = array of integer;
var
	m: vector;
	n: integer;
	a, b: ^integer;
begin
	n := 10;
	SetLength(m, n);

	a := @m[0];
	b := @m[10];
	while a <> b do
	begin
		write(a^, ' ');
		a := a + 1;
	end;

	for i := 0 to n - 1 do
		m[i] := i;

	a := @m[0];
	b := @m[10];
	while a <> b do
	begin
		write(a^, ' ');
		a := a + 1;
	end;
end.
