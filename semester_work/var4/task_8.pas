function check(s: string): boolean;
var
	w: string;
	a, b: integer;
begin
	a := 0;
	b := 0;
	s := ' ' + s + ' ';
	while pos('  ', s) > 0 do
		delete(s, pos('  ', s), 1);
	delete(s, 1, 1);
	while length(s) > 0 do
	begin
		w := copy(s, 1, pos(' ', s) - 1);
		if length(w) = 5 then
			inc(a)
		else
			inc(b);
		delete(s, 1, pos(' ', s));
	end;
	check := a > b;
end;

procedure filter(a, b: string);
var
	fin, fout: TextFile;
	s: string;
begin
	assign(fin, a);
	assign(fout, b);
	reset(fin);
	rewrite(fout);
	while not eof(fin) do
	begin
		readln(fin, s);
		if check(s) then
			writeln(fout, s);
	end;
	closeFile(fin);
	closeFile(fout);
end;