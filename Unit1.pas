unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, sButton, sEdit, sSkinProvider, sSkinManager,
  sListBox, sLabel, ImgList, acAlphaImageList, Buttons, sBitBtn, acAlphaHints,
  sDialogs, Menus, ShellAPI;

type
  TForm1 = class(TForm)
    SG: TStringGrid;
    sButton1: TsButton;
    sButton2: TsButton;
    sButton3: TsButton;
    sEdit1: TsEdit;
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    sLB: TsListBox;
    sButton4: TsButton;
    sButton5: TsButton;
    sButton6: TsButton;
    sButton7: TsButton;
    sLabelFX1: TsLabelFX;
    sBitBtn1: TsBitBtn;
    sAlphaImageList1: TsAlphaImageList;
    sAlphaHints1: TsAlphaHints;
    sOpenDialog1: TsOpenDialog;
    sSaveDialog1: TsSaveDialog;
    PopupMenu1: TPopupMenu;
    L1: TMenuItem;
    S1: TMenuItem;
    N1: TMenuItem;
    U1: TMenuItem;
    D1: TMenuItem;
    N2: TMenuItem;
    D2: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure sButton6Click(Sender: TObject);
    procedure sButton7Click(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);
    procedure sLabelFX1DblClick(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure U1Click(Sender: TObject);
    procedure sLBDblClick(Sender: TObject);
    procedure SGDblClick(Sender: TObject);
    procedure SGDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);

    procedure calc;
    procedure clear;
    procedure drwChar(s: string);
    procedure drwRow(i, row: Integer);
    procedure lang;
    procedure repaintSG;

    function power2(i: Integer): Integer;
    function findTag(s: string): Integer;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  arr: array [0 .. 4, 0 .. 6] of Integer;
  f1, f2: string;

implementation

{$R *.dfm}

procedure TForm1.calc;
var
  j, i, t: Integer;
  s: string;
begin
  s := '';
  for i := 0 to 4 do
  begin
    t := 0;
    for j := 0 to 6 do
    begin
      t := t + (arr[i, j] * power2(j));
    end;
    s := s + inttostr(t) + ',';
  end;
  delete(s, length(s), 1);
  sEdit1.Text := s;
end;

procedure TForm1.clear;
var
  j, i: Integer;
begin
  for i := 0 to 4 do
    for j := 0 to 6 do
      arr[i, j] := 0;
  repaintSG;

end;

procedure TForm1.D1Click(Sender: TObject);
begin
  if (sLB.ItemIndex = sLB.Count - 1) or (sLB.ItemIndex = -1) then
    exit;
  sLB.Items.Exchange(sLB.ItemIndex, sLB.ItemIndex + 1);
end;

procedure TForm1.drwChar(s: string);
var
  t: string;
  r1, r2, r3, r4, r5: Integer;
begin
  clear;
  delete(s, ansiPos('//', s), length(s));
  s := trim(s);

  t := copy(s, 1, ansiPos(',', s) - 1);
  delete(s, 1, ansiPos(',', s));
  r1 := strtoInt(t);

  t := copy(s, 1, ansiPos(',', s) - 1);
  delete(s, 1, ansiPos(',', s));
  r2 := strtoInt(t);

  t := copy(s, 1, ansiPos(',', s) - 1);
  delete(s, 1, ansiPos(',', s));
  r3 := strtoInt(t);

  t := copy(s, 1, ansiPos(',', s) - 1);
  delete(s, 1, ansiPos(',', s));
  r4 := strtoInt(t);

  r5 := strtoInt(s);
  drwRow(r1, 0);
  drwRow(r2, 1);
  drwRow(r3, 2);
  drwRow(r4, 3);
  drwRow(r5, 4);
  repaintSG;
end;

procedure TForm1.drwRow(i, row: Integer);
begin
  if i > 63 then
  begin
    arr[row, 6] := 1;
    i := i - 64;
  end;
  if i > 31 then
  begin
    arr[row, 5] := 1;
    i := i - 32;
  end;
  if i > 15 then
  begin
    arr[row, 4] := 1;
    i := i - 16;
  end;
  if i > 7 then
  begin
    arr[row, 3] := 1;
    i := i - 8;
  end;
  if i > 3 then
  begin
    arr[row, 2] := 1;
    i := i - 4;
  end;
  if i > 1 then
  begin
    arr[row, 1] := 1;
    i := i - 2;
  end;
  if i > 0 then
  begin
    arr[row, 0] := 1;

  end;
end;

function TForm1.findTag(s: string): Integer;
var
  i: Integer;
begin
  s := '//' + s;
  result := -1;
  for i := 0 to sLB.Count - 1 do
    if ansiPos(s, sLB.Items.Strings[i]) <> 0 then
      result := i;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  clear;
  sLB.clear;
  lang;
end;

procedure TForm1.lang;
begin
  if sBitBtn1.ImageIndex = 5 then // Ukraine
  begin
    sLabelFX1.Hint := 'Подвійне клацання, щоб відвідати веб-сайт';
    f1 := 'Додавання до списку';
    f2 := 'Введіть мітку';
    sButton1.Caption := 'Очистити';
    sButton2.Caption := 'Залити';
    sButton3.Caption := 'Інвертувати';
    sButton4.Caption := 'Додати до списку';
    sButton5.Caption := 'Завантажити';
    sButton6.Caption := 'Зберегти';
    sButton7.Caption := 'Видалити';
    sBitBtn1.Caption := 'Language';
    L1.Caption := 'Завантажити';
    D1.Caption := 'Донизу';
    D2.Caption := 'Видалити';
    U1.Caption := 'Догори';
    S1.Caption := 'Зберегти';
  end
  else
  begin
    sLabelFX1.Hint := 'Dubl click to visit website';
    f1 := 'Add to list';
    f2 := 'Input tag';
    sButton1.Caption := 'Clear';
    sButton2.Caption := 'Fill';
    sButton3.Caption := 'Invert';
    sButton4.Caption := 'Add to list';
    sButton5.Caption := 'Load';
    sButton6.Caption := 'Save';
    sButton7.Caption := 'Delete';
    sBitBtn1.Caption := 'Мова';
    L1.Caption := 'Load';
    D1.Caption := 'Down';
    D2.Caption := 'Delete';
    U1.Caption := 'Up';
    S1.Caption := 'Save';
  end;
end;

function TForm1.power2(i: Integer): Integer;
var
  j, t: Integer;
begin
  if i = 0 then
  begin
    result := 1;
    exit;
  end;
  t := 1;
  for j := 1 to i do
    t := t * 2;
  result := t;
end;

procedure TForm1.repaintSG;
var
  j, i: Integer;
begin
  for i := 0 to 4 do
    for j := 0 to 6 do
      SG.Cells[i, j] := inttostr(arr[i, j]);
  calc;
end;

procedure TForm1.sBitBtn1Click(Sender: TObject);
begin
  if sBitBtn1.ImageIndex = 5 then
    sBitBtn1.ImageIndex := 6
  else
    sBitBtn1.ImageIndex := 5;
  lang;
end;

procedure TForm1.sButton1Click(Sender: TObject);
begin
  clear;
end;

procedure TForm1.sButton2Click(Sender: TObject);
var
  j, i: Integer;
begin
  for i := 0 to 4 do
    for j := 0 to 6 do
      arr[i, j] := 1;
  repaintSG;
end;

procedure TForm1.sButton3Click(Sender: TObject);
var
  j, i: Integer;
begin
  for i := 0 to 4 do
    for j := 0 to 6 do
      if arr[i, j] = 0 then
        arr[i, j] := 1
      else
        arr[i, j] := 0;
  repaintSG;
end;

procedure TForm1.sButton4Click(Sender: TObject);
var
  s: string;
begin
  s := InputBox(f1, f2, '');
  if trim(s) = '' then
    exit;
  sLB.Items.delete(findTag(s));
  sLB.Items.Add(trim(sEdit1.Text) + ' //' + s);
  sLB.ItemIndex := sLB.Count - 1;
  clear;
end;

procedure TForm1.sButton5Click(Sender: TObject);
var
  i: Integer;
begin
  if sOpenDialog1.Execute then
    sLB.Items.LoadFromFile(sOpenDialog1.FileName);
  for i := sLB.Count - 1 downto 0 do
    if ansiPos('//', sLB.Items.Strings[i]) = 0 then
      sLB.Items.delete(i);
end;

procedure TForm1.sButton6Click(Sender: TObject);
begin
  if sSaveDialog1.Execute then
    sLB.Items.SaveToFile(sSaveDialog1.FileName);
end;

procedure TForm1.sButton7Click(Sender: TObject);
begin
  if sLB.ItemIndex = -1 then
    exit;
  sLB.Items.delete(sLB.ItemIndex);
end;

procedure TForm1.SGDblClick(Sender: TObject);
begin
  if arr[SG.Col, SG.row] = 0 then
    arr[SG.Col, SG.row] := 1
  else
    arr[SG.Col, SG.row] := 0;
  repaintSG;
end;

procedure TForm1.SGDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
  if SG.Cells[ACol, ARow] = '0' then
  begin
    SG.Canvas.Brush.Color := clWhite;
    SG.Canvas.FillRect(Rect);
    SG.Canvas.Font.Color := clWhite;
  end
  else
  begin
    SG.Canvas.Brush.Color := clBlack;
    SG.Canvas.FillRect(Rect);
    SG.Canvas.Font.Color := clBlack;
  end;
end;

procedure TForm1.sLabelFX1DblClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar('https://rse.com.ua/редактор-символів-fontcreater/'), nil, nil, SW_SHOW);
end;

procedure TForm1.sLBDblClick(Sender: TObject);
begin
  if sLB.ItemIndex = -1 then
    exit;
  drwChar(sLB.Items.Strings[sLB.ItemIndex]);
end;

procedure TForm1.U1Click(Sender: TObject);
begin
  if (sLB.ItemIndex = 0) or (sLB.ItemIndex = -1) then
    exit;
  sLB.Items.Exchange(sLB.ItemIndex, sLB.ItemIndex - 1);
end;

end.
