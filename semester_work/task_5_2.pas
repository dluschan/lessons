program day_of_arrival;
uses SysUtils;
var
	s: string;
	start, t: TDateTime;
	days: array[1..7] of string;
begin
	days[1] := 'вс';
	days[2] := 'пн';
	days[3] := 'вт';
	days[4] := 'ср';
	days[5] := 'чт';
	days[6] := 'пт';
	days[7] := 'сб';
	readln(s);
	start := strtodate(s);
	readln(s);
	t := strtotime(s);
	writeln(days[dayofweek(start + t)]);
end.