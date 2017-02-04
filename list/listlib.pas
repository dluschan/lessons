{$mode objfpc} // directive to be used for defining classes
{$m+}		   // directive to be used for using constructor

unit listlib;
interface
	type
		list_link_pointer = ^list_link;

		list_link = object
		public
			constructor create(data: longInt);
			
			procedure setNext(link: list_link_pointer);
			procedure setPrev(link: list_link_pointer);

		private
			m_data: longInt;
			m_next: list_link_pointer;
			m_prev: list_link_pointer;
		end;

		list_iterator = class
		public
			constructor create(l: list_link_pointer);
			
			procedure next();
			procedure prev();
				
			procedure set_data(data: longInt);
			function get_data(): longInt;
			
			function equal(other: list_iterator): boolean;
			function getLink(): list_link_pointer;

		private
			m_link: list_link_pointer;
		end;

		list = class
		public
			constructor create();
			destructor destroy();
			
			function get_begin(): list_iterator;
			function get_end(): list_iterator;

			procedure push_back(data: longInt);
			function pop_back(): longInt;

			procedure insert(p: list_iterator; data: longInt);
			procedure erase(p: list_iterator);

			function at(index: longInt): longInt;
			function empty(): boolean;

		private
			m_begin: list_iterator;
			m_end: list_iterator;
		end;

implementation
	constructor list_link.create(data: longInt);
	begin
		m_data := data;
		m_next := nil;
		m_prev := nil;
	end;

	procedure list_link.setNext(link: list_link_pointer);
	begin
		m_next := link;
	end;

	procedure list_link.setPrev(link: list_link_pointer);
	begin
		m_prev := link;
	end;

	constructor list_iterator.create(l: list_link_pointer);
	begin
		m_link := l
	end;

	procedure list_iterator.next();
	begin
		m_link := m_link^.m_next;
	end;

	procedure list_iterator.prev();
	begin
		m_link := m_link^.m_prev;
	end;

	procedure list_iterator.set_data(data: longInt);
	begin
		m_link^.m_data := data;
	end;

	function list_iterator.get_data(): longInt;
	begin
		get_data := m_link^.m_data;
	end;

	function list_iterator.equal(other: list_iterator): boolean;
	begin
		equal := m_link = other.m_link;
	end;

	function list_iterator.getLink(): list_link_pointer;
	begin
		getLink := m_link;
	end;

	constructor list.create();
	var
		link: list_link_pointer;
	begin
		new(link, create(0));
		m_begin := list_iterator.create(link);
		m_end   := list_iterator.create(link);
	end;

	destructor list.destroy();
	begin
		while not empty() do
			erase(get_begin());
		dispose(m_end.getLink());
	end;

	function list.get_begin(): list_iterator;
	var
		it: list_iterator;
	begin
		it := list_iterator.create(m_begin.m_link);
		get_begin := it;
	end;

	function list.get_end(): list_iterator;
	var
		it: list_iterator;
	begin
		it := list_iterator.create(m_end.m_link);
		get_end := it;
	end;

	procedure list.push_back(data: longInt);
	begin
		insert(get_end(), data);
	end;

	function list.pop_back(): longInt;
	var
		it: list_iterator;
		tmp: longInt;
	begin
		it := get_end();
		it.prev();
		tmp := it.get_data();
		erase(it);
		pop_back := tmp;
	end;

	procedure list.insert(p: list_iterator; data: longInt);
	var
		link, nextLink, prevLink: list_link_pointer;
	begin
		new(link, create(data));
		if empty() then
		begin
			m_begin := list_iterator.create(link);
			m_begin.getLink()^.setNext(m_end.getLink());
			m_end.getLink()^.setPrev(m_begin.getLink());
			exit();
		end;

		if p.equal(m_begin) then
		begin
			nextLink := p.getLink();
			link^.setNext(nextLink);
			nextLink^.setPrev(link);
			m_begin := list_iterator.create(link);
		end
		else
		begin
			nextLink := p.getLink();
			p.prev();
			prevLink := p.getLink();
			link^.setNext(nextLink);
			nextLink^.setPrev(link);
			link^.setPrev(prevLink);
			prevLink^.setNext(link); 
		end;
	end;

	procedure list.erase(p: list_iterator);
	var
		nextLink, prevLink, curLink: list_link_pointer;
	begin
		if p.equal(m_end) then
			exit();

		if p.equal(m_begin) then
		begin
			nextLink := p.getLink();
			m_begin.next();
			p.next();
			dispose(nextLink);
		end
		else
		begin
			nextLink := p.getLink()^.m_next;
			prevLink := p.getLink()^.m_prev;
			curLink := p.getLink();
			p.next();
			dispose(curLink);
			nextLink^.setPrev(prevLink);
			prevLink^.setNext(nextLink);
		end;
	end;

	function list.at(index: longInt): longInt;
	var
		it: list_iterator;
	begin
		it := get_begin();
		while index > 0 do
		begin
			it.next();
			index := index - 1;
		end;
		at := it.get_data();
	end;

	function list.empty(): boolean;
	begin
		empty := m_begin.equal(m_end);
	end;
end.
