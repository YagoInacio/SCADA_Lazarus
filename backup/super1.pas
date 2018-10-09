unit super1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus, StdCtrls, LazSerial, synaser;

type

  { TForm1 }

  TForm1 = class(TForm)
    btRD0: TButton;
    btPWMrOff: TButton;
    btTela2: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    btPWMmais: TButton;
    btPWMmenos: TButton;
    btRD1on: TButton;
    btRD1off: TButton;
    btPWMrOn: TButton;
    Image1: TImage;
    MenuItem6: TMenuItem;
    PopupMenu1: TPopupMenu;
    RJ7: TImage;
    RD1: TImage;
    RD2: TImage;
    RD3: TImage;
    RD4: TImage;
    RD5: TImage;
    RD6: TImage;
    RD7: TImage;
    RJ0: TImage;
    RD0: TImage;
    RJ1: TImage;
    RJ2: TImage;
    RJ3: TImage;
    RJ4: TImage;
    RJ5: TImage;
    RJ6: TImage;
    LazSerial1: TLazSerial;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    StaticText1: TStaticText;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure btPWMrOffClick(Sender: TObject);
    procedure btRD0Click(Sender: TObject);
    procedure btTela2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure btPWMmaisClick(Sender: TObject);
    procedure btPWMmenosClick(Sender: TObject);
    procedure btRD1onClick(Sender: TObject);
    procedure btRD1offClick(Sender: TObject);
    procedure btPWMrOnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure LazSerial1RxData(Sender: TObject);
    procedure LazSerial1Status(Sender: TObject; Reason: THookSerialReason;
      const Value: string);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure enableButtons();
    procedure Timer2Timer(Sender: TObject);
    procedure updateScreen();
  private

  public
     cmd:char;
     count:integer;
     //arrays to separate comunication and screen
     digIn: array[0..99] of boolean;
     digOut: array[0..99] of boolean;
     anaIn: array[0..99] of word;
     anaOut: array[0..99] of word;
  end;

var
  Form1: TForm1;

implementation

uses super2;

{$R *.lfm}

{ TForm1 }

procedure TForm1.updateScreen();   //responsible for updating the screen with no relation to the comunication protocol (called by the timer)
begin
  if digIn[15] then RJ7.Picture.loadFromFile('disjoff.bmp') else RJ7.Picture.loadFromFile('disjdes.bmp');
  if digIn[14] then RJ6.Picture.loadFromFile('disjoff.bmp') else RJ6.Picture.loadFromFile('disjdes.bmp');
  if digIn[13] then RJ5.Picture.loadFromFile('disjoff.bmp') else RJ5.Picture.loadFromFile('disjdes.bmp');
  if digIn[12] then RJ4.Picture.loadFromFile('disjoff.bmp') else RJ4.Picture.loadFromFile('disjdes.bmp');
  if digIn[11] then RJ3.Picture.loadFromFile('disjoff.bmp') else RJ3.Picture.loadFromFile('disjdes.bmp');
  if digIn[10] then RJ2.Picture.loadFromFile('disjoff.bmp') else RJ2.Picture.loadFromFile('disjdes.bmp');
  if digIn[9] then RJ1.Picture.loadFromFile('disjoff.bmp') else RJ1.Picture.loadFromFile('disjdes.bmp');
  if digIn[8] then RJ0.Picture.loadFromFile('disjoff.bmp') else RJ0.Picture.loadFromFile('disjdes.bmp');
  if digIn[7] then RD7.Picture.loadFromFile('disjoff.bmp') else RD7.Picture.loadFromFile('disjdes.bmp');
  if digIn[6] then RD6.Picture.loadFromFile('disjoff.bmp') else RD6.Picture.loadFromFile('disjdes.bmp');
  if digIn[5] then RD5.Picture.loadFromFile('disjoff.bmp') else RD5.Picture.loadFromFile('disjdes.bmp');
  if digIn[4] then RD4.Picture.loadFromFile('disjoff.bmp') else RD4.Picture.loadFromFile('disjdes.bmp');
  if digIn[3] then RD3.Picture.loadFromFile('disjoff.bmp') else RD3.Picture.loadFromFile('disjdes.bmp');
  if digIn[2] then RD2.Picture.loadFromFile('disjoff.bmp') else RD2.Picture.loadFromFile('disjdes.bmp');
  if digIn[1] then RD1.Picture.loadFromFile('disjoff.bmp') else RD1.Picture.loadFromFile('disjdes.bmp');
  if digIn[0] then RD0.Picture.loadFromFile('disjoff.bmp') else RD0.Picture.loadFromFile('disjdes.bmp');

  StaticText1.Caption := inttostr(anaIn[0]);
end;


procedure TForm1.Timer2Timer(Sender: TObject);
begin
  updateScreen();
end;

procedure TForm1.enableButtons(); //enable the buttons (called when connection is open)
begin
  btRD0.Enabled := true;
  btRD1on.Enabled := true;
  btRD1off.Enabled := true;
  btPWMmais.Enabled := true;
  btPWMmenos.Enabled := true;
  btPWMrOn.Enabled := true;
  btPWMrOff.Enabled := true;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  LazSerial1.ShowSetupDialog;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.btRD0Click(Sender: TObject);
var b:byte;
begin
  b:=ord('o');
  LazSerial1.WriteBuffer(b,1);
end;

procedure TForm1.btTela2Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.btPWMrOffClick(Sender: TObject);
var b:byte;
begin
  cmd := '1';
  b := ord('1');
  LazSerial1.WriteBuffer(b,1);
end;

procedure TForm1.Button2Click(Sender: TObject);
var b:byte;
begin
  cmd := 's';
  b:=ord('s');
  LazSerial1.WriteBuffer(b,1);
end;

procedure TForm1.Button3Click(Sender: TObject);
var b:byte;
begin
  cmd := 'a';
  b:=ord('a');
  LazSerial1.WriteBuffer(b,1);

end;

procedure TForm1.Button4Click(Sender: TObject);
var b:byte;
begin
  cmd := 'q';
  b:=ord('q');
  LazSerial1.WriteBuffer(b,1);
end;

procedure TForm1.btPWMmaisClick(Sender: TObject);
var b:byte;
begin
  cmd := '+';
  b := ord('+');
  LazSerial1.WriteBuffer(b,1);
end;

procedure TForm1.btPWMmenosClick(Sender: TObject);
var b:byte;
begin
  cmd := '-';
  b := ord('-');
  LazSerial1.WriteBuffer(b,1);

end;

procedure TForm1.btRD1onClick(Sender: TObject);
var b:byte;
begin
  cmd := 'l';
  b := ord('l');
  LazSerial1.WriteBuffer(b,1);
end;

procedure TForm1.btRD1offClick(Sender: TObject);
var b:byte;
begin
  cmd := 'd';
  b := ord('d');
  LazSerial1.WriteBuffer(b,1);
end;

procedure TForm1.btPWMrOnClick(Sender: TObject);
var b:byte;
begin
  cmd := '2';
  b := ord('2');
  LazSerial1.WriteBuffer(b,1);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     cmd := ' ';
     count := 0;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;





procedure TForm1.LazSerial1RxData(Sender: TObject);  //when something is received on the serial port this function will organize according to the data
var s, s1:string;
    v:byte;
    val:integer;
begin
  s:=LazSerial1.ReadData;
  if cmd = 's' then   //Status "J"
  begin
    s1:='';
    v:=ord(s[1]);

    if (v and 128)>1 then digIn[15] := true else digIn[15]:= false;
    if (v and 64)>1 then digIn[14] := true else digIn[14]:= false;
    if (v and 32)>1 then digIn[13] := true else digIn[13]:= false;
    if (v and 16)>1 then digIn[12] := true else digIn[12]:= false;
    if (v and 8)>1 then digIn[11] := true else digIn[11]:= false;
    if (v and 4)>1 then digIn[10] := true else digIn[10]:= false;
    if (v and 2)>1 then digIn[9] := true else digIn[9]:= false;
    if (v and 1)=1 then digIn[8] := true else digIn[8]:= false;

  end;

  if cmd = 'a' then   //Analog input
  begin
    anaIn[0]:=ord(s[1])*256+ord(s[2]);
  end;

    if cmd = 'q' then    //Status "D"
  begin
    s1:='';
    v:=ord(s[1]);

    if (v and 128)>1 then digIn[7] := true else digIn[7]:= false;
    if (v and 64)>1 then digIn[6] := true else digIn[6]:= false;
    if (v and 32)>1 then digIn[5] := true else digIn[5]:= false;
    if (v and 16)>1 then digIn[4] := true else digIn[4]:= false;
    if (v and 8)>1 then digIn[3] := true else digIn[3]:= false;
    if (v and 4)>1 then digIn[2] := true else digIn[2]:= false;
    if (v and 2)>1 then digIn[1] := true else digIn[1]:= false;
    if (v and 1)=1 then digIn[0] := true else digIn[0]:= false;
  end;
end;

procedure TForm1.LazSerial1Status(Sender: TObject; Reason: THookSerialReason;
  const Value: string);
begin
  if reason = HR_Connect then enableButtons();  //the buttons are disabledd by default. Whenever the connection port is opened, the buttons are enabled
  Timer1.Enabled := true;
end;


procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  LazSerial1.Open;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  LazSerial1.Close;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.Timer1Timer(Sender: TObject);  //sends the requests for the device using the timer event
begin
  if count = 0 then Button2.Click;
  if count = 1 then Button3.Click;
  if count = 2 then Button4.Click;
  count := count + 1;
  if count >= 3 then count := 0;
end;

end.

