unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  Sky = class
    count: integer;
    data: array[1..100] of TRect;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox1Resize(Sender: TObject);
  private
    { private declarations }
    stars: Sky;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  star: TRect;
begin
     star.Left := random(paintbox1.canvas.width);
     star.Right := star.Left + random(50);
     star.Top := random(paintbox1.canvas.height);
     star.Bottom := star.Top + random(50);

     stars.data[stars.count] := star;
     stars.count := stars.count + 1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     stars.count := 0;
end;

procedure TForm1.FormResize(Sender: TObject);
var
  w, h: integer;
begin
     w := Width - 25;
     h := Height - 10;
     Button1.Left := w - 20;
     Button2.Left := w - 20;
     Button3.Left := w - 20;
     Button4.Left := w - 20;
     paintbox1.Width := w;
     paintbox1.Height := h;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var
  i: integer;
begin
     paintbox1.canvas.Brush.color := clBlack;
     paintbox1.Canvas.Rectangle(0, 0, paintbox1.Width, paintbox1.Height);

     paintbox1.canvas.Brush.color := clRed;
     for i := 1 to stars.count do
          paintbox1.Canvas.Ellipse(stars.data[i]);
end;

procedure TForm1.PaintBox1Resize(Sender: TObject);
begin
     paintbox1.canvas.Brush.color := clBlack;
     paintbox1.Canvas.Rectangle(0, 0, paintbox1.Width, paintbox1.Height);
end;

end.
