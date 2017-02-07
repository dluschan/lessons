{$mode objfpc} // directive to be used for defining classes
{$m+}		   // directive to be used for using constructor

unit listlib;
interface
	type
		list_link = class
		public
			constructor create(data: longInt);
			
			procedure setNext(link: list_link);
			procedure setPrev(link: list_link);

		private
			m_data: longInt;
			m_next: list_link;
			m_prev: list_link;
		end;

		list_iterator = class
		public
			constructor create(l: list_link);
			
			procedure next();
			procedure prev();
			
			procedure set_data(data: longInt);
			function get_data(): longInt;
			
			function equal(other: list_iterator): boolean;
			function getLink(): list_link;

		private
			m_link: list_link;
		end;

		list = class
		public
			constructor create();
			destructor destroy(); override;
			
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

	procedure list_link.setNext(link: list_link);
	begin
		m_next := link;
	end;

	procedure list_link.setPrev(link: list_link);
	begin
		m_prev := link;
	end;

	constructor list_iterator.create(l: list_link);
	begin
		m_link := l;
	end;

	procedure list_iterator.next();
	begin
		m_link := m_link.m_next;
	end;

	procedure list_iterator.prev();
	begin
		m_link := m_link.m_prev;
	end;

	procedure list_iterator.set_data(data: longInt);
	begin
		m_link.m_data := data;
	end;

	function list_iterator.get_data(): longInt;
	begin
		get_data := m_link.m_data;
	end;

	function list_iterator.equal(other: list_iterator): boolean;
	begin
		equal := m_link = other.m_link;
	end;

	function list_iterator.getLink(): list_link;
	begin
		getLink := m_link;
	end;

	constructor list.create();
	var
		link: list_link;
	begin
		link := list_link.create(0);
		m_begin := list_iterator.create(link);
		m_end := list_iterator.create(link);
	end;

	destructor list.destroy();
	begin
		while not empty() do
			pop_back();
		m_end.getLink().destroy();
		m_begin.destroy();
		m_end.destroy();
	end;

	function list.get_begin(): list_iterator;
	begin
		get_begin := list_iterator.create(m_begin.m_link);
	end;

	function list.get_end(): list_iterator;
	begin
		get_end := list_iterator.create(m_end.m_link);
	end;

	procedure list.push_back(data: longInt);
	var
		it: list_iterator;
	begin
		it := get_end();
		insert(it, data);
		it.destroy();
	end;

	function list.pop_back(): longInt;
	var
		it: list_iterator;
	begin
		it := get_end();
		it.prev();
		pop_back := it.get_data();
		erase(it);
		it.destroy();
	end;

	procedure list.insert(p: list_iterator; data: longInt);
	var
		link: list_link;
	begin
		link := list_link.create(data);
		if p.equal(m_end) and empty() then
		begin
			link.setNext(m_end.getLink());
			m_end.getLink().setPrev(link);
			m_begin.prev();
			p.prev();
			exit();
		end;

		if p.equal(m_begin) then
		begin
			link.setNext(m_begin.getLink());
			m_begin.getLink().setPrev(link);
			m_begin.prev();
			p.prev();
		end
		else
		begin
			link.setNext(p.getLink());
			link.setPrev(p.getLink().m_prev);
			p.getLink().m_prev.setNext(link);
			p.getLink().setPrev(link);
			p.prev();
		end;
	end;

	procedure list.erase(p: list_iterator);
	begin
		if p.equal(m_end) then
			exit();

		if p.equal(m_begin) then
		begin
			m_begin.next();
			p.next();
			p.getLink().m_prev.destroy();
		end
		else
		begin
			p.next();
			p.getLink().setPrev(p.getLink().m_prev.m_prev);
			p.getLink().m_prev.m_next.destroy();
			p.getLink().m_prev.setNext(p.getLink());
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
		it.destroy();
	end;

	function list.empty(): boolean;
	begin
		empty := m_begin.equal(m_end);
	end;
end.
