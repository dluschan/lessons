{$mode objfpc} // directive to be used for defining classes
{$m+}		   // directive to be used for using constructor

unit listlib;
interface
	type
		pint = ^integer;

		Iterator = class
		private
			raw_data: pint;
			nextIt, prevIt: Iterator;

		public
			constructor create(it: pint);

			function next(): Iterator;
			function prev(): Iterator;

			function raw(): pint;
			function data(): integer;

			function equal(it: Iterator): boolean;

		private
			procedure setNext(it: Iterator);
			procedure setPrev(it: Iterator);
		end;

		List = class
		private
			head, tail: Iterator;

		public
			constructor create();
			
			function start(): Iterator;
			function finish(): Iterator;

			function at(num: integer): integer;
			function empty(): boolean;

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
		next := nextIt;
	end;

	function Iterator.prev(): Iterator;
	begin
		prev := prevIt;
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

	procedure Iterator.setNext(it: Iterator);
	begin
		nextIt := it;
	end;

	procedure Iterator.setPrev(it: Iterator);
	begin
		prevIt := it;
	end;

	constructor List.create();
	begin
		tail := Iterator.create(nil);
		head := tail;
	end;

	procedure List.push_back(element: integer);
	begin
		insert(finish(), element);
	end;

	procedure List.insert(p: Iterator; element: integer);
	var
		pelement: pint;
		prevIt, currentIt: Iterator;
	begin
		if head = tail then
		begin
			new(pelement);
			pelement^ := element;
			head := Iterator.create(pelement);
			head.setNext(tail);
			tail.setPrev(head);
			exit();
		end;
		if p = head then
		begin
			new(pelement);
			pelement^ := element;
			head := Iterator.create(pelement);
			head.setNext(p);
			p.setPrev(head);
		end
		else
		begin
			prevIt := p.prev();
			new(pelement);
			pelement^ := element;
			currentIt := Iterator.create(pelement);
			prevIt.setNext(currentIt);
			currentIt.setNext(p);
			currentIt.setPrev(prevIt);
			p.setPrev(currentIt);
		end;
	end;

	function List.start(): Iterator;
	begin
		start := head;
	end;

	function List.finish(): Iterator;
	begin
		finish := tail;
	end;

	function List.at(num: integer): integer;
	var
		it: Iterator;
	begin
		it := start();
		while num > 0 do
		begin
			num := num - 1;
			it := it.next();
		end;
		at := it.data();
	end;
	
	function List.empty(): boolean;
	begin
		empty := (head = tail);
	end;
end.
