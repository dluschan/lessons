program mod3;
var
	f: TextFile;
	n: integer;

procedure calc(var f: TextFile; var n: integer);
var
	s, k: integer;
begin
	n := 0;
	reset(f);
	while not eof(f) do
	begin
		s := 0;
		while not eoln(f) do
		begin
			read(f, k);
			s := s + k;
		end;
		readln(f);
		if s mod 3 = 0 then
			n := n + 1;
	end;
	close(f);
end;

begin
	assign(f, 'input.txt');
	calc(f, n);
	writeln(n);
end.