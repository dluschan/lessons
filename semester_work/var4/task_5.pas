procedure TForm1.btnRunClick(Sender: TObject);
var
	i: integer;
begin
	lbl.Caption := '';
	i := 0;
	while (i < sgdSeans.rowCount) and (lbl.Caption = '') do
	begin
		if (edtTime.text >= sgdSeans.cells[1, i]) and (edtTime.text <= sgdSeans.cells[2, i]) then
			lbl.Caption := sgdSeans.cells[0, i];
		inc(i);
	end;
	if lbl.Caption = '' then
		lbl.Caption := 'Перерыв';
end;
