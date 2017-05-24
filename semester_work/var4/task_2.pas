const
	n = 100;
type
	TTrain = array[1..n, 1..2] of TDateTime;
function count(train: TTrain): integer;
var
	i, k: integer;
begin
	for i := 1 to n do
		if dayOfWeek(train[i, 1] + train[i, 2]) in [1, 7] then
			inc(k);
	count := k;
end.