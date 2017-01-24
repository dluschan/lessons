{$mode objfpc} // directive to be used for defining classes
{$m+}		   // directive to be used for using constructor

unit listlib;
interface
	type
		pint = ^longInt;

		Iterator = class
		private
			raw_data: pint;
			nextIt, prevIt: Iterator;

		public
			constructor create(element: longInt);
			destructor  destroy();

			function next(): Iterator;
			function prev(): Iterator;

			function raw(): pint;
			function data(): longInt;

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

			function at(num: longInt): longInt;
			function empty(): boolean;

			procedure push_back(element: longInt);
			function  pop_back(): longInt;
			procedure insert(p: Iterator; element: longInt);
			procedure erase(p: Iterator);
		end;

implementation
	constructor Iterator.create(element: longInt);
	begin
		new(raw_data);
		raw_data^ := element;
	end;

	destructor Iterator.destroy();
	begin
		dispose(raw_data);
	end;

	function Iterator.next(): Iterator;
	begin
		next := nextIt;
	end;

	function Iterator.prev(): Iterator;
	begin
		prev := prevIt;
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

	procedure List.push_back(element: longInt);
	begin
		insert(finish(), element);
	end;

	function List.pop_back(): longInt;
	var
		res: longInt;
	begin
		res := finish().prev().data();
		erase(finish().prev());
		pop_back := res;
	end;

	procedure List.insert(p: Iterator; element: longInt);
	var
		prevIt, currentIt: Iterator;
	begin
		currentIt := Iterator.create(element);
		if head = tail then
		begin
			head := currentIt;
			head.setNext(tail);
			tail.setPrev(head);
			exit();
		end;
		if p = head then
		begin
			head := currentIt;
			head.setNext(p);
			p.setPrev(head);
		end
		else
		begin
			prevIt := p.prev();
			currentIt := currentIt;
			prevIt.setNext(currentIt);
			currentIt.setNext(p);
			currentIt.setPrev(prevIt);
			p.setPrev(currentIt);
		end;
	end;

	procedure List.erase(p: Iterator);
	var
		prevIt, nextIt: Iterator;
	begin
		if p = tail then
			exit();
		if p = head then
		begin
			prevIt := head;
			head := head.next();
			prevIt.destroy();
		end
		else
		begin
			prevIt := p.prev();
			nextIt := p.next();
			p.destroy();
			prevIt.setNext(nextIt);
			nextIt.setPrev(prevIt);
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

	function List.at(num: longInt): longInt;
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
