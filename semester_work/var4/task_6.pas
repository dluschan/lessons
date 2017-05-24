procedure calc(var f: TextFile; var n: integer);
var
	t: boolean;
	a, b: integer;
begin
	reset(f);
	n := 0;
	while not seekEOF(f) do
	begin
		t := true;
		read(f, a);
		while (not seekEOLn(f)) and (t) do
		begin
			read(f, b);
			if b >= a then
				t := false;
			a := b;
		end;
		if t then
			inc(n);
		readln(f);
	end;
	closeFile(f);
end;

procedure TForm1.btnRunClick(Sender: TObject);
var
	f: TextFile;
	n: integer;
begin
	assignFile(f, 'input.txt');
	calc(f, n);
	lblOut.Caption := intToStr(n);
end;