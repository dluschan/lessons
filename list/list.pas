program listtest;
Type
	List = ^Node;
	Node = record
		data: integer;
		next: List;
	end;
var
	l: List;

procedure print_list(l: List);
begin
    while l <> nil do
    begin
        write(l^.data, ' ');
        l := l^.next;
    end;
    writeln();
end;

procedure init_list(var head: List; x: integer);
begin
	new(head);
	head^.data := x;
end;

procedure insert_after_pointer(p: List; x: integer);
//вставка после элемента списка, на который указывает p
//предполагается, что p указывает на существующий элемент
var
	item: List;
begin
	new(item);
	item^.next := p^.next;
	p^.next := item;
	item^.data := x;
end;

procedure insert_to_tail(var head: List; x: integer);
//вставка в конец списка
var
	i: integer;
	p: List;
begin
	if head = nil then
		init_list(head, x)
	else
	begin
		p := head;
		while p^.next <> nil do
			p := p^.next;
		insert_after_pointer(p, x);
	end;
end;

procedure insert_to_head(var head: List; x: integer);
var
	item: List;
begin
	if head = nil then
		init_list(head, x)
	else
	begin
		new(item);
		item^.data := x;
		item^.next := head;
		head := item;
	end;
end;

procedure insert_after_index(head: List; x: integer; pos: integer);
//вставка после элементом с номером pos
//предпологается, что в списке есть хотя бы pos элементов
var
	i: integer;
begin
	for i := 1 to pos - 1 do
		head := head^.next;
	insert_after_pointer(head, x);
end;

procedure remove_head(var head: List);
var
	copy: List;
begin
	if head <> nil then
	begin
		copy := head^.next;
		dispose(head);
		head := copy;
	end;
end;

procedure remove_to_pointer(p: List);
var
	copy: List;
begin
	if p^.next <> nil then
	begin
		copy := p^.next^.next;
		dispose(p^.next);
		p^.next := copy;
	end;
end;

begin
    l := nil;
	insert_to_tail(l, 6);
	insert_to_head(l, 1);
	insert_to_head(l, 8);
	insert_to_tail(l, -4);
	remove_head(l);
	remove_to_pointer(l);
	print_list(l);
end.
