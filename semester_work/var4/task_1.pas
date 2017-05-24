procedure click();
var
	i, j: integer;
begin
	for i := 0 to sgdTest.colcount - 1 do
		for j := 0 to sdgTest.rowcount - 1 do
			sgdTest.cells[i, j] := inttostr(i * i + j);
end;
