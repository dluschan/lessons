const
	n = 5;
	m = 4;
type
	TStr = array[1..2*m] of integer;
	TMatr = array[1..n] of TStr;
	
function mn(x: TStr): integer;
var
	i, m: integer;
begin
	m := x[1];
	for i := 2 to 2*m do
		if x[i] < m then
			m := x[i];
	mn := m;
end;

procedure reverse(var x: TStr);
var
	i, t: integer;
begin
	for i := 1 to m do
	begin
		t := x[i];
		x[i] := x[2*m - i + 1];
		x[2*m - i + 1] := t;
	end;
end;