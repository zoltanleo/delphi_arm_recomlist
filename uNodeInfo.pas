unit uNodeInfo;

interface

uses
  Winapi.Windows
  , Winapi.Messages
  , System.SysUtils
  , System.Variants
  , System.Classes
  , Vcl.Graphics
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs
  , Vcl.ExtCtrls
  , Arm.Settings.Common
  , VarAndrUnit
  , Vcl.StdCtrls
  , Vcl.ComCtrls
  , System.Actions
  , Vcl.ActnList
  , Vcl.Menus
  , uRecomList
  ;

type
  TfrmNodeInfo = class(TForm)
    pnlGroup: TPanel;
    pnlButtons: TPanel;
    pnlCommon: TPanel;
    pnlNodeInfo: TPanel;
    pnlSelectBtn: TPanel;
    Label1: TLabel;
    cbbGroup: TComboBox;
    actList: TActionList;
    btnODlg: TButton;
    cbbFileEncode: TComboBox;
    btnCancel: TButton;
    btnSave: TButton;
    btnHelp: TButton;
    Label2: TLabel;
    oDlg: TOpenDialog;
    pnlItemName: TPanel;
    lblItemName: TLabel;
    edtItemName: TEdit;
    pnlRichEdit: TPanel;
    REdt: TRichEdit;
    actOpenFile: TAction;
    actSave: TAction;
    actCancel: TAction;
    actHelp: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actOpenFileExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
  private
    FNodeInfoMode: TNodeInfoMode;
    FKeybrdLayoutNum: Integer;
    FEditMode: TEditMode;
    FNodeFilePath: string;
    { Private declarations }
  public
    { Public declarations }
    property NodeInfoMode: TNodeInfoMode read FNodeInfoMode write FNodeInfoMode;//вид добавляемого узла
    property KeybrdLayoutNum: Integer read FKeybrdLayoutNum;//номер текущей раскладки
    property EditMode: TEditMode read FEditMode write FEditMode;//режим редактирования узла
    property NodeFilePath: string read FNodeFilePath write FNodeFilePath;//путь к загружаемому файлу
  end;

const
  InitDir = 'c:\proj\test_delphi\delphi_recomlist\recom';
  EncodStrArr: array[0..4] of string = ('Автоопределение','ANSI','UTF8', 'UTF16 LE(Unicode)','UTF16 BE');

var
  frmNodeInfo: TfrmNodeInfo;

implementation

{$R *.dfm}

procedure TfrmNodeInfo.actCancelExecute(Sender: TObject);
begin
  Self.ModalResult:= mrCancel;
end;

procedure TfrmNodeInfo.actHelpExecute(Sender: TObject);
begin
//
end;

procedure TfrmNodeInfo.actOpenFileExecute(Sender: TObject);
const
  eTxt = '.txt';
  eRTF = '.rtf';
begin
  if not oDlg.Execute then Exit;

  FNodeFilePath:= oDlg.FileName;

  if (ExtractFileExt(oDlg.FileName) = eTxt) then
    case cbbFileEncode.ItemIndex of
      0: REdt.Lines.LoadFromFile(oDlg.FileName);
      1: REdt.Lines.LoadFromFile(oDlg.FileName,TEncoding.ANSI);
      2: REdt.Lines.LoadFromFile(oDlg.FileName,TEncoding.UTF8);
      3: REdt.Lines.LoadFromFile(oDlg.FileName,TEncoding.Unicode);
      4: REdt.Lines.LoadFromFile(oDlg.FileName,TEncoding.BigEndianUnicode);
    end;

  if (ExtractFileExt(oDlg.FileName) = eRTF) then REdt.Lines.LoadFromFile(oDlg.FileName);

end;

procedure TfrmNodeInfo.actSaveExecute(Sender: TObject);
const
  MsgText= 'Поле "%s" не может быть пустым!';
begin
  if (Trim(edtItemName.Text) = '') then
  begin
    Application.MessageBox(PChar(Format(MsgText,[lblItemName.Caption])),
                          'Недостаточно данных',
                          MB_ICONINFORMATION);
    if edtItemName.CanFocus then edtItemName.SetFocus;
    Exit;
  end;

  Self.ModalResult:= mrOk;
end;

procedure TfrmNodeInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  case NodeInfoMode of
    nimGroup: Settings.SenderObject:= sofrmNodeInfoGroup;
    nimItem: Settings.SenderObject:= sofrmNodeInfoItem;
  end;

  FKeybrdLayoutNum:= GetLastUsedKeyLayout;
  Settings.KeybrdLayoutNum:= Self.KeybrdLayoutNum;
  if (EditMode = emAdd) then
    Settings.SettingsFile.WriteInteger(Self.Name,'cbbFileEncode_ItemIndex', cbbFileEncode.ItemIndex);
  Settings.Save(Self);
end;

procedure TfrmNodeInfo.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  Self.ModalResult:= mrCancel;
  Self.ShowHint:= True;

//  oDlg.Filter:= 'файлы с текстом(*.txt;*.doc;*.docx;*.rtf;*.odt)|*.txt;*.doc;*.docx;*.rtf;*.odt';
  oDlg.Filter:= 'файлы с текстом(*.txt;*.rtf)|*.txt;*.rtf';
//  oDlg.InitialDir:= InitDir;

  for i:= 0 to Pred(Self.ControlCount) do
    if TControl(Self.Controls[i]).InheritsFrom(TPanel) then
    begin
      TPanel(Self.Controls[i]).BevelOuter:= bvNone;
      TPanel(Self.Controls[i]).ShowCaption:= False;
    end;

  for i:= 0 to Pred(pnlCommon.ControlCount) do
    if TControl(pnlCommon.Controls[i]).InheritsFrom(TPanel) then
    begin
      TPanel(pnlCommon.Controls[i]).BevelOuter:= bvNone;
      TPanel(pnlCommon.Controls[i]).ShowCaption:= False;
    end;

  for i:= 0 to Pred(pnlNodeInfo.ControlCount) do
    if TControl(pnlNodeInfo.Controls[i]).InheritsFrom(TPanel) then
    begin
      TPanel(pnlNodeInfo.Controls[i]).BevelOuter:= bvNone;
      TPanel(pnlNodeInfo.Controls[i]).ShowCaption:= False;
    end;

  with cbbFileEncode do
  begin
    Clear;
    for i := 0 to Pred(Length(EncodStrArr)) do
      Items.AddObject(EncodStrArr[i],TObject(i));
    ItemIndex:= 0;
  end;

  REdt.ReadOnly:= True;
  FNodeInfoMode:= nimItem;
  FNodeFilePath:= '';

  actOpenFile.ShortCut:= TextToShortCut(ShortCutOpen);
  btnODlg.OnClick:= actOpenFileExecute;
  btnODlg.Hint:= ShortCutOpen;

  actSave.ShortCut:= TextToShortCut(ShortCutSave);
  btnSave.OnClick:= actSaveExecute;
  btnSave.Hint:= ShortCutSave;

  actCancel.ShortCut:= TextToShortCut(ShortCutCancel);
  btnCancel.OnClick:= actCancelExecute;
  btnCancel.Hint:= ShortCutCancel;

  actHelp.ShortCut:= TextToShortCut(ShortCutHelp);
  btnHelp.OnClick:= actHelpExecute;
  btnHelp.Hint:= ShortCutHelp;
end;

procedure TfrmNodeInfo.FormShow(Sender: TObject);
begin
  pnlGroup.Visible:= ((NodeInfoMode = nimItem) and (cbbGroup.Items.Count > 1));
  pnlSelectBtn.Visible:= (NodeInfoMode = nimItem);
  pnlRichEdit.Visible:= (NodeInfoMode = nimItem);

  case NodeInfoMode of
    nimGroup: Settings.SenderObject:= sofrmNodeInfoGroup;
    nimItem: Settings.SenderObject:= sofrmNodeInfoItem;
  end;

  Settings.Load(Self);

  FKeybrdLayoutNum:= Settings.KeybrdLayoutNum;
  SetLastUsedKeyLayout(KeybrdLayoutNum);

  if (EditMode = emAdd) then
    cbbFileEncode.ItemIndex:= Settings.SettingsFile.ReadInteger(Self.Name,'cbbFileEncode_ItemIndex', 0);

  oDlg.InitialDir:= InitDir;

  case NodeInfoMode of
    nimGroup:
      begin
        lblItemName.Caption:= 'Название группы';
        Self.ClientHeight:= pnlItemName.Height + pnlButtons.Height;
        if pnlGroup.Visible then Self.ClientHeight:= Self.ClientHeight + pnlGroup.Height;
        Self.BorderStyle:= bsSingle;
        Self.BorderIcons:= Self.BorderIcons - [biMaximize];
      end;
    nimItem:
      begin
        lblItemName.Caption:= 'Название рекомендации';
        Self.BorderStyle:= bsSizeable;
        Self.BorderIcons:= Self.BorderIcons + [biMaximize];
        Self.ClientHeight:= pnlCommon.Height + pnlButtons.Height;
        if pnlGroup.Visible then Self.ClientHeight:= Self.ClientHeight + pnlGroup.Height;

      end;
  end;

  if edtItemName.CanFocus then edtItemName.SetFocus;
end;

end.
