const
	n = 10;
type
	t2dmas = array[1..n, 1..n] of real;

function findMax(mas: t2dmas): real;
var
	i, j, max: integer;
	s: real;
begin
	s := a[1, 1];
	for i := 1 to n do
		for j := 1 to n - i + 1 do
			if a[i, j] > s then
				s := a[i, j];
	findMax := s;
end;