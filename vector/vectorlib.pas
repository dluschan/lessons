{$mode objfpc} // directive to be used for defining classes
{$m+}		   // directive to be used for using constructor

unit vectorlib;
interface
	type
		pint = ^integer;
		
		Iterator = class
		private
			raw_data: pint;

		public
			constructor create(it: pint);
			function next(): Iterator;
			function prev(): Iterator;
			function data(): integer;
			function equal(it: Iterator): boolean;
			function raw(): pint;
		end;

		Vector = class
		private
			length: integer;
			capacity: integer;
			data: array of integer;

		public
			constructor create();
			function start(): Iterator;
			function finish(): Iterator;
			function at(num: integer): integer;
			procedure push_back(element: integer);
			procedure insert(p: Iterator; element: integer);
		end;
implementation

constructor Iterator.create(it: pint);
begin
	raw_data := it;
end;

function Iterator.next(): Iterator;
begin
	next := Iterator.create(raw_data + 1);
end;

function Iterator.prev(): Iterator;
begin
	prev := Iterator.create(raw_data - 1);
end;

function Iterator.data(): integer;
begin
	data := raw_data^;
end;

function Iterator.raw(): pint;
begin
	raw := raw_data;
end;

function Iterator.equal(it: Iterator): boolean;
begin
	equal := (raw_data = it.raw_data);
end;

constructor Vector.create();
begin
	length := 0;
	capacity := 0;
end;

procedure Vector.push_back(element: integer);
begin
	if length = capacity then
	begin
		capacity := 3 * capacity div 2 + 1;
		setLength(data, capacity);
	end;
	data[length] := element;
	length := length + 1;
end;

procedure Vector.insert(p: Iterator; element: integer);
var
	tail: Iterator;
begin
	if length = capacity then
	begin
		capacity := 3 * capacity div 2 + 1;
		setLength(data, capacity);
	end;
	length := length + 1;

	tail := finish();

	while not tail.equal(p) do
	begin
		tail.raw()^ := tail.prev().data();
		tail := tail.prev();
	end;
	
	p.raw()^ := element;
end;

function Vector.start(): Iterator;
begin
	start := Iterator.create(@data[0]);
end;

function Vector.at(num: integer): integer;
begin
	at := data[num];
end;

function Vector.finish(): Iterator;
begin
	finish := Iterator.create(@data[length]);
end;

end.
