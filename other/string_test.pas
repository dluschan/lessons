program string_test;
var
	s: string;
	i: integer;
begin
	s := 'Привет, Мир!';
	for i := 1 to length(s) do
	begin
		write(s[i]);
	end;
	writeln();
end.
