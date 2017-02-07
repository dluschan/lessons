{$mode objfpc} // directive to be used for defining classes
{$m+}		   // directive to be used for using constructor

unit vectorlib;
interface
	type
		pint = ^longInt;
		
		Iterator = class
		private
			raw_data: pint;

		public
			constructor create(it: pint);
			
			function next(): Iterator;
			function prev(): Iterator;
			
			function data(): longInt;
			function raw(): pint;

			function equal(it: Iterator): boolean;
		end;

		Vector = class
		private
			length: longInt;
			capacity: longInt;
			data: array of longInt;

		public
			constructor create();

			function start(): Iterator;
			function finish(): Iterator;

			function at(num: longInt): longInt;
			function empty(): boolean;

			procedure push_back(element: longInt);
			procedure insert(p: Iterator; element: longInt);
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

	function Iterator.data(): longInt;
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

	procedure Vector.push_back(element: longInt);
	begin
		insert(finish(), element);
	end;

	procedure Vector.insert(p: Iterator; element: longInt);
	var
		index, i: longInt;
	begin
		index := p.raw() - start().raw();
		
		if length = capacity then
		begin
			capacity := 3 * capacity div 2 + 1;
			setLength(data, capacity);
		end;
		length := length + 1;

		for i := length downto index + 1 do
			data[i] := data[i-1];

		data[index] := element;
	end;

	function Vector.start(): Iterator;
	begin
		start := Iterator.create(@data[0]);
	end;

	function Vector.finish(): Iterator;
	begin
		finish := Iterator.create(@data[length]);
	end;

	function Vector.at(num: longInt): longInt;
	begin
		at := data[num];
	end;

	function Vector.empty(): boolean;
	begin
		empty := (length = 0);
	end;
end.
