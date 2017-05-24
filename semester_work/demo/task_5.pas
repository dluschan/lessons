program train;
uses SysUtils;
var
	s: string;
	d: TDateTime;
	t: TDateTime;
begin
	readln(s);
	d := strtodate(s);
	readln(s);
	t := strtotime(s);
	writeln(formatdatetime('ddd', d + t));
end.
