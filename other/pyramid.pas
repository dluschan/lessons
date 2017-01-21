program pyr;
uses
	vectorlib;
var
	n: integer;
	w, h: integer;
	sum: integer;
	width, height: Vector;
	wbegin, hbegin, wend: Iterator;
begin
	width := Vector.create();
	height := Vector.create();

	readln(n);
	while n > 0 do
	begin
		n := n - 1;
		readln(w, h);

		wbegin := width.start();
		wend   := width.finish();
		hbegin := height.start();

		while (not wbegin.equal(wend)) and (w > wbegin.data()) do
		begin
			wbegin := wbegin.next();
			hbegin := hbegin.next();
		end;

		if wbegin.equal(wend) then
		begin
			width.push_back(w);
			height.push_back(h);
			continue;
		end;

		if (w = wbegin.data()) and (hbegin.data() < h) then
		begin
			hbegin.raw()^ := h;
			continue;
		end;
		
		if w < wbegin.data() then
		begin
			width.insert(wbegin, w);
			height.insert(hbegin, h);
			continue;
		end;
	end;
	
	wbegin := height.start();
	wend   := height.finish();
	sum := 0;
	while not wbegin.equal(wend) do
	begin
		sum := sum + wbegin.data();
		wbegin := wbegin.next();
	end;
	writeln(sum);
end.
