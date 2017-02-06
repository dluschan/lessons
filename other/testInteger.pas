program testInt;
var
	i: integer;
begin
	i := 1;
	writeln(i);
	while i > 0 do
	begin
		i := i << 1;
		writeln(i);
	end;
end.
