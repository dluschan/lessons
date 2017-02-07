{$mode objfpc} // directive to be used for defining classes
{$m+}		   // directive to be used for using constructor

unit containers;
interface
	type
		link = ^longInt;

		iterator = class
		public
			constructor create(l: link);

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
			destructor destroy(); override;

			function get_begin(): iterator;
			function get_end(): iterator;

			procedure push_back(data: longInt);
			function pop_back(): longInt;

			procedure insert(p: iterator; data: longInt);
			procedure erase(p: iterator);

			function at(index: longInt): longInt;
			function empty(): boolean;

		private
			m_length: longInt;
			m_capacity: longInt;
			m_data: array of longInt;
		end;

implementation
	constructor iterator.create(l: link);
	begin
		m_link := l;
	end;

	procedure iterator.next();
	begin
		m_link := m_link + 1;
	end;

	procedure iterator.prev();
	begin
		m_link := m_link - 1;
	end;

	procedure iterator.set_data(data: longInt);
	begin
		m_link^ := data;
	end;

	function iterator.get_data(): longInt;
	begin
		get_data := m_link^;
	end;

	function iterator.equal(other: iterator): boolean;
	begin
		equal := (m_link = other.m_link);
	end;

	function iterator.get_link(): link;
	begin
		get_link := m_link;
	end;

	constructor container.create();
	begin
		m_length := 0;
		m_capacity := 0;
	end;

	destructor container.destroy();
	begin
	end;

	procedure container.push_back(data: longInt);
	begin
		insert(get_end(), data);
	end;

	function container.pop_back(): longInt;
	begin
		pop_back := m_data[m_length-1];
		m_length := m_length - 1;
	end;

	procedure container.insert(p: iterator; data: longInt);
	var
		index, i: longInt;
	begin
		index := p.get_link() - get_begin().get_link();

		if m_length = m_capacity then
		begin
			m_capacity := 3 * m_capacity div 2 + 1;
			setLength(m_data, m_capacity);
		end;
		m_length := m_length + 1;

		for i := m_length downto index + 1 do
			m_data[i] := m_data[i-1];

		m_data[index] := data;
	end;

	procedure container.erase(p: iterator);
	var
		index, i: longInt;
	begin
		index := p.get_link() - get_begin().get_link();

		m_length := m_length - 1;

		for i := index to m_length - 1 do
			m_data[i] := m_data[i+1];
	end;

	function container.get_begin(): iterator;
	begin
		get_begin := iterator.create(@m_data[0]);
	end;

	function container.get_end(): iterator;
	begin
		get_end := iterator.create(@m_data[m_length]);
	end;

	function container.at(index: longInt): longInt;
	begin
		at := m_data[index];
	end;

	function container.empty(): boolean;
	begin
		empty := (m_length = 0);
	end;
end.
