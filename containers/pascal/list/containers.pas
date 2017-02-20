{$mode objfpc} // directive to be used for defining classes
{$m+}		   // directive to be used for using constructor

unit containers;
interface
	type
		link = class
		public
			constructor create(data: longInt);
			destructor destroy();
		
			procedure set_next(pLink: link);
			procedure set_prev(pLink: link);

		private
			m_data: longInt;
			m_next: link;
			m_prev: link;
		end;

		iterator = class
		public
			constructor create(l: link);
			destructor destroy();

			procedure next();
			procedure prev();
			
			procedure set_data(data: longInt);
			function get_data(): longInt;
			
			function equal(other: iterator): boolean;
			function get_link(): link;

		private
			m_link: link;
		end;

		container = class
		public
			constructor create();
			destructor destroy();
			
			function get_begin(): iterator;
			function get_end(): iterator;

			procedure push_back(data: longInt);
			function pop_back(): longInt;

			procedure insert(p: iterator; data: longInt);
			procedure erase(p: iterator);

			function at(index: longInt): longInt;
			function empty(): boolean;
			function size(): longInt;

		private
			m_begin: iterator;
			m_end: iterator;
		end;

implementation
	constructor link.create(data: longInt);
	begin
		m_data := data;
		m_next := nil;
		m_prev := nil;
	end;

	destructor link.destroy();
	begin
		m_next := nil;
		m_prev := nil;
	end;
	
	procedure link.set_next(pLink: link);
	begin
		m_next := pLink;
	end;

	procedure link.set_prev(pLink: link);
	begin
		m_prev := pLink;
	end;

	constructor iterator.create(l: link);
	begin
		m_link := l;
	end;

	destructor iterator.destroy();
	begin
		m_link := nil;
	end;
	
	procedure iterator.next();
	begin
		m_link := m_link.m_next;
	end;

	procedure iterator.prev();
	begin
		m_link := m_link.m_prev;
	end;

	procedure iterator.set_data(data: longInt);
	begin
		m_link.m_data := data;
	end;

	function iterator.get_data(): longInt;
	begin
		get_data := m_link.m_data;
	end;

	function iterator.equal(other: iterator): boolean;
	begin
		equal := m_link = other.m_link;
	end;

	function iterator.get_link(): link;
	begin
		get_link := m_link;
	end;

	constructor container.create();
	var
		local_link: link;
	begin
		local_link := link.create(0);
		m_begin := iterator.create(local_link);
		m_end := iterator.create(local_link);
	end;

	destructor container.destroy();
	begin
		while not empty() do
			pop_back();
		m_end.get_link().destroy();
		m_begin.destroy();
		m_end.destroy();
	end;

	function container.get_begin(): iterator;
	begin
		get_begin := iterator.create(m_begin.m_link);
	end;

	function container.get_end(): iterator;
	begin
		get_end := iterator.create(m_end.m_link);
	end;

	procedure container.push_back(data: longInt);
	var
		it: iterator;
	begin
		it := get_end();
		insert(it, data);
		it.destroy();
	end;

	function container.pop_back(): longInt;
	var
		it: iterator;
	begin
		it := get_end();
		it.prev();
		pop_back := it.get_data();
		erase(it);
		it.destroy();
	end;

	procedure container.insert(p: iterator; data: longInt);
	var
		local_link: link;
	begin
		local_link := link.create(data);
		if p.equal(m_end) and empty() then
		begin
			local_link.set_next(m_end.get_link());
			m_end.get_link().set_prev(local_link);
			m_begin.prev();
			p.prev();
			exit();
		end;

		if p.equal(m_begin) then
		begin
			local_link.set_next(m_begin.get_link());
			m_begin.get_link().set_prev(local_link);
			m_begin.prev();
			p.prev();
		end
		else
		begin
			local_link.set_next(p.get_link());
			local_link.set_prev(p.get_link().m_prev);
			p.get_link().m_prev.set_next(local_link);
			p.get_link().set_prev(local_link);
			p.prev();
		end;
	end;

	procedure container.erase(p: iterator);
	begin
		if p.equal(m_end) then
			exit();

		if p.equal(m_begin) then
		begin
			m_begin.next();
			p.next();
			p.get_link().m_prev.destroy();
		end
		else
		begin
			p.next();
			p.get_link().set_prev(p.get_link().m_prev.m_prev);
			p.get_link().m_prev.m_next.destroy();
			p.get_link().m_prev.set_next(p.get_link());
		end;
	end;

	function container.at(index: longInt): longInt;
	var
		it: iterator;
	begin
		it := get_begin();
		while index > 0 do
		begin
			it.next();
			index := index - 1;
		end;
		at := it.get_data();
		it.destroy();
	end;

	function container.empty(): boolean;
	begin
		empty := m_begin.equal(m_end);
	end;

	function container.size(): longInt;
	var
		it_begin, it_end: iterator;
		index: longInt;
	begin
		it_begin := get_begin();
		it_end := get_end();
		index := 0;

		while not it_begin.equal(it_end) do
		begin
			it_begin.next();
			index := index + 1;
		end;

		it_begin.destroy();
		it_end.destroy();

		size := index;
	end;
end.
