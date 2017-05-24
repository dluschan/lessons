program find_physics;
var
	input_file_name, output_file_name: string;

procedure filter_file(a, b: string);
var
	f1, f2: textfile;
	s: string;
begin
	assign(f1, a);
	assign(f2, b);
	reset(f1);
	rewrite(f2);
	while not eof(f1) do
	begin
		readln(f1, s);
		s := ' ' + s + ' ';
		if pos(' physics ', s) > 0 then
			writeln(f2, copy(s, 2, length(s) - 2));
	end;
	close(f1);
	close(f2);
end;

begin
	readln(input_file_name);
	readln(output_file_name);	
	filter_file(input_file_name, output_file_name);
end.