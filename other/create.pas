{$mode objfpc} // directive to be used for defining classes
{$m+}		   // directive to be used for using constructor

program createtest;
type
	MyClass = object
	public
		constructor create(n: integer);
		destructor  destroy();
		function get(): integer;
		
	private
		x: integer;
	end;

	constructor MyClass.create(n: integer);
	begin
		writeln('создание объекта');
		x := n;
	end;

	destructor MyClass.destroy();
	begin
		writeln('Bye');
	end;

	function MyClass.get(): integer;
	begin
		get := x;
	end;
var
	a: ^MyClass;
begin
	new(a, create(5));
	writeln(a^.get());
	dispose(a, destroy);
end.
