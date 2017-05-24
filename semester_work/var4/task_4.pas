function change(s: string): string;
var
	output: string;
begin
	output := '';
	for i := 1 to length(s) div 2 do
		output := output + s[2*i] + s[2*i - 1];

	change := output;
end;

procedure words(s: string; var s1: string; var k: integer);
var
	c: string;
begin
	k := 0;
	s1 := '';
	s := s + ' ';
	while length(s) <> 0 do
	begin
		c := copy(s, 1, pos(' ', s) - 1);
		if (length(c) > 0) and (length(c) mod 2 = 0) then
		begin
			inc(k);
			c := change(c);
		end;
		s1 := s1 + c + ' ';
		delete(s, 1, pos(' ', s));
	end;
	delete(s1, length(s1), 1);
end;
