unit super1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus, StdCtrls, Buttons, CheckLst, ComCtrls, LazSerial, synaser, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    btRD0: TButton;
    btPWMrOff: TButton;
    btTela2: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    btPWMmais: TButton;
    btPWMmenos: TButton;
    btRD1on: TButton;
    btRD1off: TButton;
    btPWMrOn: TButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    MenuItem6: TMenuItem;
    PopupMenu1: TPopupMenu;
    LazSerial1: TLazSerial;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    StaticText3: TStaticText;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    procedure BitBtn1Click(Sender: TObject);
    procedure btPWMrOffClick(Sender: TObject);
    procedure btRD0Click(Sender: TObject);
    procedure btTela2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure btPWMmaisClick(Sender: TObject);
    procedure btPWMmenosClick(Sender: TObject);
    procedure btRD1onClick(Sender: TObject);
    procedure btRD1offClick(Sender: TObject);
    procedure btPWMrOnClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure LazSerial1RxData(Sender: TObject);
    procedure LazSerial1Status(Sender: TObject; Reason: THookSerialReason;
      const Value: string);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure ProgressBar1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure StaticText1Click(Sender: TObject);
    procedure StaticText3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure enableButtons();
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure updateScreen();
    procedure readlisbox2command();
  private

  public
     cmd:char;
     count:integer;
     //arrays to separate comunication and screen
     digIn: array[0..99] of boolean;
     digOut: array[0..99] of boolean;
     anaIn: array[0..99] of word;
     anaOut: array[0..99] of word;
     state0: array[0..99] of string;
     stateOn: array[0..99] of string;
     stateOff: array[0..99] of string;
     supLim: array[0..99] of integer;
     infLim: array[0..99] of integer;
     scale: array[0..99] of real;
  end;

var
  Form1: TForm1;

implementation

uses super2;

{$R *.lfm}

{ TForm1 }

procedure TForm1.updateScreen();   //responsible for updating the screen with no relation to the comunication protocol (called by the timer)
var i:integer;
begin
  //if digIn[15] then RJ7.Picture.loadFromFile('disjoff.bmp') else RJ7.Picture.loadFromFile('disjdes.bmp');
  //if digIn[14] then RJ6.Picture.loadFromFile('disjoff.bmp') else RJ6.Picture.loadFromFile('disjdes.bmp');
  //if digIn[13] then RJ5.Picture.loadFromFile('disjoff.bmp') else RJ5.Picture.loadFromFile('disjdes.bmp');
  //if digIn[12] then RJ4.Picture.loadFromFile('disjoff.bmp') else RJ4.Picture.loadFromFile('disjdes.bmp');
  //if digIn[11] then RJ3.Picture.loadFromFile('disjoff.bmp') else RJ3.Picture.loadFromFile('disjdes.bmp');
  //if digIn[10] then RJ2.Picture.loadFromFile('disjoff.bmp') else RJ2.Picture.loadFromFile('disjdes.bmp');
  //if digIn[9] then RJ1.Picture.loadFromFile('disjoff.bmp') else RJ1.Picture.loadFromFile('disjdes.bmp');
  //if digIn[8] then RJ0.Picture.loadFromFile('disjoff.bmp') else RJ0.Picture.loadFromFile('disjdes.bmp');
  //if digIn[7] then RD7.Picture.loadFromFile('disjoff.bmp') else RD7.Picture.loadFromFile('disjdes.bmp');
  //if digIn[6] then RD6.Picture.loadFromFile('disjoff.bmp') else RD6.Picture.loadFromFile('disjdes.bmp');
  //if digIn[5] then RD5.Picture.loadFromFile('disjoff.bmp') else RD5.Picture.loadFromFile('disjdes.bmp');
  //if digIn[4] then RD4.Picture.loadFromFile('disjoff.bmp') else RD4.Picture.loadFromFile('disjdes.bmp');
  //if digIn[3] then RD3.Picture.loadFromFile('disjoff.bmp') else RD3.Picture.loadFromFile('disjdes.bmp');
  //if digIn[2] then RD2.Picture.loadFromFile('disjoff.bmp') else RD2.Picture.loadFromFile('disjdes.bmp');
  //if digIn[1] then RD1.Picture.loadFromFile('disjoff.bmp') else RD1.Picture.loadFromFile('disjdes.bmp');
  //if digIn[0] then RD0.Picture.loadFromFile('disjoff.bmp') else RD0.Picture.loadFromFile('disjdes.bmp');

  for i:=0 to ComponentCount-1 do
  begin
     if (components[i] is TImage) and (components[i].name <> 'Background') then
     begin
     with (components[i] as TImage) do
        begin
        bitbtn1.Caption:=name;
        if digIn[tag] then Picture.loadFromFile(stateOn[tag]) else Picture.loadFromFile(stateOff[tag]);


        end;
     end;

     if components[i] is TprogressBar then
     begin
     with (components[i] as TprogressBar) do
        begin

        position := round(scale[tag]*anaIn[tag]);

        end;
     end;

     if (components[i] is TStaticText) and (components[i].name <> 'StaticText3') then
     begin
     with (components[i] as TStaticText) do
        begin
        if (anaIN[tag]*scale[tag] > supLim[tag]) then
        begin
          font.Color:=clRed;
          text := 'Limite superior atingido!';
        end

        else
        begin
          if (anaIN[tag]*scale[tag] < infLim[tag]) then
          begin
             font.Color:=clRed;
             text := 'Limite inferior atingido!';
          end

          else
          begin
               font.Color:=clBlack;
               text := inttostr(round(scale[tag]*anaIn[tag]));
          end;

        end;
        end;
     end;
  end;
  i := 0;

  StaticText3.Caption:=formatdatetime('dd/mm/yy hh:mm:ss,z',now);
end;

procedure TForm1.readlisbox2command();
var b:byte;
begin
     if listbox2.items.count > 0 then
     begin

       Timer1.Enabled := false;
       Timer2.Enabled := false;

     while listbox2.Items.Count > 0 do
     begin
           case listbox2.items[0]  of
          'PWM+' :
          begin
            cmd := '+';
            b := ord('+');
            LazSerial1.WriteBuffer(b,1);
            listbox2.Items.delete(0);
          end;

          'PWM-' :
          begin
            cmd := '-';
            b := ord('-');
            LazSerial1.WriteBuffer(b,1);
            listbox2.Items.delete(0);
          end;

          'RD1 - ON' :
          begin
            cmd := 'l';
            b := ord('l');
            LazSerial1.WriteBuffer(b,1);
            listbox2.Items.delete(0);
          end;

          'RD1 - OFF' :
          begin
            cmd := 'd';
            b := ord('d');
            LazSerial1.WriteBuffer(b,1);
            listbox2.Items.delete(0);
          end;

          'PWMr - ON' :
          begin
            cmd := '2';
            b := ord('2');
            LazSerial1.WriteBuffer(b,1);
            listbox2.Items.delete(0);
          end;

          'PWMr - OFF' :
          begin
            cmd := '1';
            b := ord('1');
            LazSerial1.WriteBuffer(b,1);
            listbox2.Items.delete(0);
          end;

          'RD0 - ON/OFF' :
          begin
            listbox2.Items.delete(0);
            b:=ord('o');
            LazSerial1.WriteBuffer(b,1);
          end;


          end;


      end;

      Timer1.Enabled := true;
      Timer2.Enabled := true;

      end;

end;


procedure TForm1.Timer2Timer(Sender: TObject);
begin
  updateScreen();
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
   readlisbox2command();
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
  ListBox2.Items.Add('RD0 - ON/OFF');

end;

procedure TForm1.btTela2Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.Button1Click(Sender: TObject);
var s:Tshape;
begin
 s:=Tshape.Create(Form1);
 s.Top:=56;
 s.Left:=72;
 s.Parent:=Form1;
 s.Name:='S1';
end;

procedure TForm1.btPWMrOffClick(Sender: TObject);
var b:byte;
begin
  ListBox2.Items.Add('PWMr - OFF');

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var i:integer;
begin
     for i:=0 to ComponentCount-1 do
     begin
         if components[i] is Tbutton then
         begin
           listbox1.Items.Add((components[i] as Tbutton).name);
           listbox1.Items.Add((components[i] as Tbutton).caption);
           listbox1.Items.Add(inttostr((components[i] as Tbutton).top));
           listbox1.Items.Add(inttostr((components[i] as Tbutton).left));
           listbox1.Items.Add(inttostr((components[i] as Tbutton).width));
           end;
     end;
     listbox1.Items.SaveToFile('list.txt');
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
var s: string;
begin
  //ListBox2.Items.Add('PWM+');

  if sender is Timage then s:= (sender as timage).name;
  if sender is tbutton then s:=(sender as tbutton).name;
  form2.label1.caption := 'Deseja enviar o comendo de ' + s + '? ';
  form2.show();


end;

procedure TForm1.btPWMmenosClick(Sender: TObject);
begin

  ListBox2.Items.Add('PWM-');

end;

procedure TForm1.btRD1onClick(Sender: TObject);
begin
  ListBox2.Items.Add('RD1 - ON');
end;

procedure TForm1.btRD1offClick(Sender: TObject);
begin
ListBox2.Items.Add('RD1 - OFF');

end;

procedure TForm1.btPWMrOnClick(Sender: TObject);
begin
  ListBox2.Items.Add('PWMr - ON');

end;

procedure TForm1.Button5Click(Sender: TObject);
begin

end;

procedure TForm1.FormClick(Sender: TObject);
begin

end;



procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
  IM:Timage;
  BG:Timage;
  PB:TprogressBar;
  ST:TStaticText;
begin
  cmd := ' ';
  count := 0;

  BG := Timage.Create(form1);
  BG.parent := form1;
  BG.Name := 'Background';
  BG.Picture.LoadFromFile('BG.bmp');
  BG.AutoSize:=True;

  i := 0;
  listbox1.Items.LoadFromFile('dig.txt');
  while listbox1.Items.Count > 0 do
  begin
    IM := Timage.Create(form1);
    IM.parent := form1;
    IM.tag := strtoint(listbox1.Items[0]);
    listbox1.Items.Delete(0);

    IM.top := strtoint(listbox1.Items[0]);
    listbox1.Items.delete(0);

    IM.left := strtoint(listbox1.Items[0]);
    listbox1.Items.delete(0);

    state0[IM.tag] := listbox1.Items[0];
    IM.Picture.loadFromFile(state0[IM.tag]);
    listbox1.Items.delete(0);

    stateOn[IM.tag] := listbox1.Items[0];
    listbox1.Items.delete(0);

    stateOff[IM.tag] := listbox1.Items[0];
    listbox1.Items.delete(0);

    IM.Visible:=true;

    IM.name := 'IM'+inttostr(i);
    i:=i+1;

  end;

  i := 0;
  listbox1.Items.LoadFromFile('ana.txt');
  while listbox1.Items.Count > 0 do
  begin
    PB := TprogressBar.Create(form1);
    ST := TStaticText.Create(form1);

    PB.parent := form1;
    PB.tag := strtoint(listbox1.Items[0]);
    ST.parent := form1;
    ST.tag := strtoint(listbox1.Items[0]);
    listbox1.Items.Delete(0);

    PB.top := strtoint(listbox1.Items[0]);
    ST.top := strtoint(listbox1.Items[0])+20;
    listbox1.Items.delete(0);

    PB.left := strtoint(listbox1.Items[0]);
    ST.left := strtoint(listbox1.Items[0]);
    listbox1.Items.delete(0);

    supLim[PB.tag] := strtoint(listbox1.Items[0]);
    PB.Max := supLim[PB.tag];
    listbox1.Items.delete(0);

    infLim[PB.tag] := strtoint(listbox1.Items[0]);
    PB.Min := infLim[PB.tag];
    listbox1.Items.delete(0);

    scale[PB.tag] := strtofloat(listbox1.Items[0]);
    listbox1.Items.delete(0);

    PB.BarShowText := true;
    PB.Visible:=true;
    ST.Visible:=true;
    ST.Height := 35;
    ST.Width := 250;

    PB.name := 'PB'+inttostr(i);
    ST.name := 'ST'+inttostr(i);

    i:=i+1;
  end;
  Timer2.Enabled := true;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;



procedure TForm1.LazSerial1RxData(Sender: TObject);  //when something is received on the serial port this function will organize according to the data
var s:string;
    v:byte;

begin
  s:=LazSerial1.ReadData;
  if cmd = 's' then   //Status "J"
  begin
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

procedure TForm1.ListBox1Click(Sender: TObject);
begin

end;

procedure TForm1.ListBox2Click(Sender: TObject);
begin

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

procedure TForm1.ProgressBar1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  end;

procedure TForm1.StaticText1Click(Sender: TObject);
begin

end;

procedure TForm1.StaticText3Click(Sender: TObject);
begin

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

