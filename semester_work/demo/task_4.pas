program parse_numbers;
var
	s: string;

function sort_digits(s: string): string;
var
	i, j: integer;
	buf: string;
begin
	for i := 1 to length(s) - 1 do
		for j := i + 1 to length(s) do
			if copy(s, i, 1) > copy(s, j, 1) then
			begin
				buf := copy(s, i, 1);
				delete(s, i, 1);
				insert(copy(s, j - 1, 1), s, i);
				delete(s, j, 1);
				insert(buf, s, j);
			end;
	sort_digits := s;
end;

procedure numbers(var s: string);
var
	res, num_s: string;
	code, x: integer;
begin
	res := '';
	s := s + ' ';
	
	while s <> '' do
	begin
		num_s := copy(s, 1, pos(' ', s) - 1);
		delete(s, 1, pos(' ', s));
		val(num_s, x, code);
		if code = 0 then
			res := res + sort_digits(num_s) + ' '
		else
			res := res + num_s + ' ';
	end;
	s := copy(res, 1, length(res) - 1);
end;

begin
	readln(s);
	numbers(s);
	writeln(s);
end.