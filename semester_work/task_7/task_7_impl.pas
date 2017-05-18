unit task_7_impl;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls;

const
  M = 3;
  N = 4;

type
  tstr = array[1..M] of integer;
  tmatr = array[1..N] of tstr;
  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure init(var a: tmatr);
    procedure output(a: tmatr);
    procedure change(var a, b: tstr);
    function summ(mt: tstr): integer;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.init(var a: tmatr);
var
  i, j: integer;
begin
  for i := 0 to stringgrid1.RowCount - 1 do
    for j := 0 to stringgrid1.ColCount - 1 do
    begin
      stringgrid1.cells[j, i] := IntToStr(i * stringgrid1.ColCount + j);
      a[i+1, j+1] := i * stringgrid1.ColCount + j;
    end;
end;

procedure TForm1.output(a: tmatr);
var
  i, j: integer;
begin
  for i := 0 to stringgrid1.RowCount - 1 do
    for j := 0 to stringgrid1.ColCount - 1 do
      stringgrid1.cells[j, i] := IntToStr(a[i+1, j+1]);
end;

function TForm1.summ(mt: tstr): integer;
var
  i, s: integer;
begin
  s := 0;
  for i := 1 to M do
    s := s + mt[i];
  summ := s;
end;

procedure TForm1.change(var a, b: tstr);
var
  i, t: integer;
begin
  for i := 1 to M do
  begin
    t := a[i];
    a[i] := b[i];
    b[i] := t;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  a: tmatr;
  i, maxi, maxs: integer;
begin
  init(a);
  maxs := summ(a[1]);
  Maxi := 1;
  for i := 1 to N do
    if summ(a[i]) > maxs then
    begin
      maxs := summ(a[i]);
      maxi := i;
    end;
  change(a[1], a[maxi]);
  output(a);
end;

end.
