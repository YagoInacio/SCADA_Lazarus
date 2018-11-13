unit super2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);
  private

  public
    comando: integer;

  end;

var
  Form2: TForm2;


implementation

uses super1;
{$R *.lfm}

{ TForm2 }

procedure TForm2.Button2Click(Sender: TObject);
begin
  form2.close();
end;

procedure TForm2.FormCreate(Sender: TObject);
begin

end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin

end;

procedure TForm2.Button1Click(Sender: TObject);
var b: byte;
  cmd: char;
begin
  if form1.digIn[tagclick] then
       begin
         cmd := form1.stateCommandOn[tagclick];
         b := ord(cmd);
         form1. LazSerial1.WriteBuffer(b,1);
         form2.close();
         end
  else
  begin
       cmd := form1.stateCommandOff[tagclick];
       b := ord(cmd);
       form1. LazSerial1.WriteBuffer(b,1);
       form2.close();
  end;
end;

          0:begin
                      cmd := 'o';
                      b:=ord('o');
                      form1.LazSerial1.WriteBuffer(b,1);
                      form2.close();
            end;

     end;

     case nameclick of

        'btPWMmais': begin
                     cmd := '+';
                     b := ord('+');
                     form1.LazSerial1.WriteBuffer(b,1);
                     form2.close();
                     end;

        'btPWMmenos': begin
                      cmd := '-';
                      b := ord('-');
                      form1.LazSerial1.WriteBuffer(b,1);
                      form2.close();
                      end;

        'btPWMrOn':   begin
                      cmd := '2';
                      b := ord('2');
                      form1.LazSerial1.WriteBuffer(b,1);
                      form2.close();
                      end;

        'btPWMrOff':  begin
                      cmd := '1';
                      b := ord('1');
                      form1.LazSerial1.WriteBuffer(b,1);
                      form2.close();
                      end;

          end;
     end;

procedure TForm2.StaticText1Click(Sender: TObject);
begin

end;

end.

