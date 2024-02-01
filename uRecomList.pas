unit uRecomList;

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
  , Vcl.StdCtrls
  , Vcl.ComCtrls
  , VarAndrUnit
  , Arm.Settings.Common
  , VirtualTrees
  , Vcl.ExtCtrls
  , System.Actions
  , Vcl.ActnList
  , Vcl.Buttons
  , System.ImageList
  , Vcl.ImgList
  , System.UITypes
  ;

type
  PItemsRec = ^TItemsRec;
  TItemsRec = record
    NodeID: Integer;//счетчик
    ParentID: Integer;//ID родителя (для узлов в корне дерева = 0)
    IsGroupName: Integer;//заголовок группы (True = 1)
    PathIsExists: Integer;//корректность пути к файлу (для несущестующих 0, для заголовков групп -1)
    ItemName: string;//название исследования/заголовка группы
    ItemPath: string;//путь к файлу (для заголовков пусто)
    ItemEncod: string;//последняя использованная при открытии кодировка файла
  end;

  TfrmRecomList = class(TForm)
    oDlg: TOpenDialog;
    Spl: TSplitter;
    actList: TActionList;
    actGroupAdd: TAction;
    actItemAdd: TAction;
    actNodeEdt: TAction;
    actNodeDel: TAction;
    ActPrint: TAction;
    ActHelp: TAction;
    actClose: TAction;
    imgList: TImageList;
    pnlLeftCmn: TPanel;
    pnlLeftTop: TPanel;
    vst: TVirtualStringTree;
    btnGroupAdd: TButton;
    btnItemAdd: TButton;
    btnItemEdit: TButton;
    btnItemDelete: TButton;
    pnlLeftBottom: TPanel;
    btnHelp: TButton;
    cbbFmtPrint: TComboBox;
    btnPrint: TButton;
    pnlPreview: TPanel;
    REdt: TRichEdit;
    chbPreview: TCheckBox;
    chbWordWrap: TCheckBox;
    Label1: TLabel;
    cbbScrollbar: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure vstGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure vstFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstHeaderDraw(Sender: TVTHeader; HeaderCanvas: TCanvas; Column: TVirtualTreeColumn; R: TRect; Hover,
      Pressed: Boolean; DropMark: TVTDropMarkMode);
    procedure vstPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vstGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure vstResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure chbPreviewClick(Sender: TObject);
    procedure SplMoved(Sender: TObject);
    procedure chbWordWrapClick(Sender: TObject);
    procedure cbbScrollbarChange(Sender: TObject);
  private
    FKeybrdLayoutNum: Integer;
    FNodeCounter: Integer;
//    FpnlPreviewPrevWidth: Integer;
//    FpnlLeftCnmPrevWidth: Integer;
//    FIsAllowResizepnlPreview: Boolean;
  public
    { Public declarations }
    property KeybrdLayoutNum: Integer read FKeybrdLayoutNum;//номер текущей раскладки
    property NodeCounter: Integer read FNodeCounter;//счетчик для Node ID
//    property pnlLeftCnmPrevWidth: Integer read FpnlLeftCnmPrevWidth;//ширина pnlLeftCnm до ресайза
//    property pnlPreviewPrevWidth: Integer read FpnlPreviewPrevWidth;//ширина pnlPreview до ресайза
//    property IsAllowResizepnlPreview: Boolean read FIsAllowResizepnlPreview;//разрешение запоминать ширину pnlPreview
  end;

const
  InitDir = 'c:\proj\test_delphi\delphi_recomlist\recom';
var
  frmRecomList: TfrmRecomList;

implementation

{$R *.dfm}

procedure TfrmRecomList.cbbScrollbarChange(Sender: TObject);
var
  sbValue: TScrollStyle;
begin
  case cbbScrollbar.ItemIndex of
    0: sbValue:= TScrollStyle.ssBoth; //обе
    1: sbValue:= TScrollStyle.ssVertical; // вертикальная
    2: sbValue:= TScrollStyle.ssHorizontal; // горизонтальная
    3: sbValue:= TScrollStyle.ssNone; // отсутствуют
  end;
end;

procedure TfrmRecomList.chbPreviewClick(Sender: TObject);
var
  tmpWidth: Integer;
begin
  tmpWidth:= pnlLeftCmn.Width;
  Self.LockDrawing;
  try
    Spl.Visible:= chbPreview.Checked;
    pnlPreview.Visible:= chbPreview.Checked;

    if chbPreview.Checked
      then
        begin
          pnlLeftCmn.Align:= alLeft;
          Spl.Align:= alLeft;

          if (Self.WindowState = TWindowState.wsMaximized)
            then pnlLeftCmn.Width:= Self.ClientWidth div 3 * 2
            else Self.ClientWidth:= tmpWidth + Spl.Width + pnlPreview.Width;
        end
      else
        begin
          Spl.Align:= alNone;

          if (Self.WindowState <> TWindowState.wsMaximized) then
          Self.ClientWidth:= tmpWidth;
          pnlLeftCmn.Align:= alClient;

        end;
  finally
    Self.UnlockDrawing;
  end;
end;

procedure TfrmRecomList.chbWordWrapClick(Sender: TObject);
begin
  REdt.WordWrap:= chbWordWrap.Checked;
end;

procedure TfrmRecomList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Settings.SenderObject:= sofrmRecomList;
  FKeybrdLayoutNum:= GetLastUsedKeyLayout;
  Settings.KeybrdLayoutNum:= Self.KeybrdLayoutNum;
  Settings.cbbPrintFmt_ItemIndex:= cbbFmtPrint.ItemIndex;
  Settings.SettingsFile.WriteInteger(Self.Name,'PnlLeftCmn_Width', pnlLeftCmn.Width);
  Settings.SettingsFile.WriteBool(Self.Name, 'chbPreview_chk',chbPreview.Checked);
  Settings.SettingsFile.WriteBool(Self.Name, 'chbWordWrap_chk',chbWordWrap.Checked);
  Settings.SettingsFile.WriteInteger(Self.Name,'cbbScrollbar_ItemIndex', cbbScrollbar.ItemIndex);

  Settings.Save(Self);
end;

procedure TfrmRecomList.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  oDlg.Filter:= 'файлы с текстом(*.txt;*.doc;*.docx;*.rtf;*.odt)|*.txt;*.doc;*.docx;*.rtf;*.odt';
  oDlg.InitialDir:= InitDir;

  for i := 0 to Pred(Self.ControlCount) do
    if TControl(Self.Controls[i]).InheritsFrom(TPanel) then
    begin
      TPanel(Self.Controls[i]).BevelOuter:= bvNone;
      TPanel(Self.Controls[i]).ShowCaption:= False;
    end;

  for i := 0 to Pred(pnlLeftCmn.ControlCount) do
    if TControl(pnlLeftCmn.Controls[i]).InheritsFrom(TPanel) then
    begin
      TPanel(pnlLeftCmn.Controls[i]).BevelOuter:= bvNone;
      TPanel(pnlLeftCmn.Controls[i]).ShowCaption:= False;
    end;

  REdt.Clear;
  with cbbFmtPrint do
  begin
    Clear;
    Items.Add('формат А5');
    Items.Add('формат А4');
    ItemIndex:= 0;
  end;

  with cbbScrollbar do
  begin
    Clear;
    Items.Add('обе');
    Items.Add('вертикальная');
    Items.Add('горизонтальная');
    Items.Add('отсутствуют');
    ItemIndex:= 0;
  end;

  Spl.Margins.Top:= vst.Top;
  Spl.Margins.Bottom:= vst.Top;
  pnlLeftCmn.Constraints.MinWidth:= 500;
  pnlLeftCmn.Constraints.MinHeight:= 400;
  pnlPreview.Constraints.MinWidth:= 460;

  FNodeCounter:= 0;

  with vst do
  begin
    //vst properties
    hintmode:= hmTooltip;
    ShowHint:= True;
    DragMode:= TDragMode.dmAutomatic;

    TreeOptions.AutoOptions:= TreeOptions.AutoOptions
              + []
              - [toAutoDeleteMovedNodes]
              ;

    TreeOptions.MiscOptions:= TreeOptions.MiscOptions
              + []
              - [toToggleOnDblClick, toEditOnClick]
              ;

    TreeOptions.SelectionOptions:= TreeOptions.SelectionOptions
              + [toExtendedFocus, toFullRowSelect, toLevelSelectConstraint, toMultiSelect,
                 toSiblingSelectConstraint, toAlwaysSelectNode]
              - []
              ;

//    OnAddToSelection:= vstAddToSelection;
//    OnCollapsed:= vstCollapsed;
//    OnDragDrop:= vstDragDrop;
//    OnDragOver:= vstDragOver;
//    OnEditing:= vstEditing;
//    OnExpanded:= vstExpanded;
//    OnFreeNode:= vstFreeNode;
//    OnGetNodeDataSize:= vstGetNodeDataSize;
//    OnGetText:= vstGetText;
//    OnHeaderDraw:= vstHeaderDraw;
//    OnPaintText:= vstPaintText;
//    OnRemoveFromSelection:= vstRemoveFromSelection;
//
//    PopupMenu:= ppmVST;


    //header properties
    with Header do
    begin
      Columns.Clear;
      Columns.Add;
      Columns[0].Text:= 'Название';

      Columns.Add;
      Columns[1].Text:= 'Путь к файлу';

      AutoSizeIndex:= 0;
      Height:= 30;
      Options:= Options + [hoAutoResize, hoOwnerDraw, hoShowHint
                          , hoShowImages,hoVisible, hoAutoSpring];

      for i := 0 to Pred(Columns.Count) do
      begin
        Columns.Items[i].Style:= vsOwnerDraw;
        Columns.Items[i].CaptionAlignment:= taCenter;
        if (Columns.Items[i].Position = 1) then Columns.Items[i].Width:= vst.ClientWidth div 3 * 2;
      end;
    end;
  end;
end;

procedure TfrmRecomList.FormResize(Sender: TObject);
begin
  if (Self.WindowState <> TWindowState.wsMaximized) then
    if (Spl.Left > Self.Width) then  pnlLeftCmn.Width:= Self.Width div 3 * 2;
end;

procedure TfrmRecomList.FormShow(Sender: TObject);
begin
  with Settings do
  begin
    SenderObject:= sofrmRecomList;
    Load(Self);
    cbbFmtPrint.ItemIndex:= cbbPrintFmt_ItemIndex;
    FKeybrdLayoutNum:= KeybrdLayoutNum;
    pnlLeftCmn.Width:= SettingsFile.ReadInteger(Self.Name,'PnlLeftCmn_Width', pnlLeftCmn.Constraints.MinWidth);
    chbPreview.Checked:= SettingsFile.ReadBool(Self.Name, 'chbPreview_chk',False);
    chbWordWrap.Checked:= Settings.SettingsFile.ReadBool(Self.Name, 'chbWordWrap_chk',False);
    cbbScrollbar.ItemIndex:= Settings.SettingsFile.ReadInteger(Self.Name,'cbbScrollbar_ItemIndex', 0);
  end;

  SetLastUsedKeyLayout(KeybrdLayoutNum);
  chbPreviewClick(Sender);
  chbWordWrapClick(Sender);
//  FpnlLeftCnmPrevWidth:= pnlLeftCmn.Width;
//  FpnlPreviewPrevWidth:= pnlPreview.Width;
end;

procedure TfrmRecomList.SplMoved(Sender: TObject);
begin
//  if (pnlLeftCnmPrevWidth > Spl.Left)
//    then Caption:= Format('сдвиг влево на: %d px',[pnlLeftCnmPrevWidth - Spl.left])
//    else
//      if (pnlLeftCnmPrevWidth < Spl.Left)
//        then Caption:= Format('сдвиг вправо на: %d px',[Spl.left - pnlLeftCnmPrevWidth])
//        else Caption:= 'стоим на месте';
end;

procedure TfrmRecomList.vstFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PItemsRec;
begin
  Data:= Sender.GetNodeData(Node);

  if Assigned(Data) then Finalize(Data^);
end;

procedure TfrmRecomList.vstGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize:= SizeOf(TItemsRec);
end;

procedure TfrmRecomList.vstGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  NodeLvl: Integer;
  Data: PItemsRec;
  fs: TFormatSettings;
begin
  Data:= Sender.GetNodeData(Node);

  if not Assigned(Data) then Exit;
  NodeLvl:= Sender.GetNodeLevel(Node);

  case NodeLvl of
    0:
      case Column of
        0: CellText:= Data^.ItemName;
        1: CellText:= '';
      end;
    1:
      case Column of
        0: CellText:= Data^.ItemName;
        1: CellText:= Data^.ItemPath;
      end;
  end;
end;

procedure TfrmRecomList.vstHeaderDraw(Sender: TVTHeader; HeaderCanvas: TCanvas; Column: TVirtualTreeColumn; R: TRect;
  Hover, Pressed: Boolean; DropMark: TVTDropMarkMode);
var
  i: integer;
  cp: TPoint;//центр текущего прямоугольника
  txt: string;//текст заголовка
  te: TSize;//ширина/высота канваса текста заголовка
begin
  for i := 0 to Pred(Sender.Columns.Count) do
  begin
    if (Column = Sender.Columns.Items[i]) then
    begin
      R.Inflate(1,1,0,0);
      HeaderCanvas.Brush.Color:= clBtnFace;
      HeaderCanvas.FillRect(R);
      HeaderCanvas.Brush.Color:= vst.Colors.TreeLineColor;
      HeaderCanvas.FrameRect(R);

      HeaderCanvas.Brush.Color:= clBtnFace;
      HeaderCanvas.Font.Color:= clHotLight;

      cp:= R.CenterPoint;
      txt:= Sender.Columns.Items[i].Text;
      te:= HeaderCanvas.TextExtent(txt);
      HeaderCanvas.TextOut(cp.X - te.cx div 2, cp.Y - te.cy div 2, txt);
    end;
  end;
end;

procedure TfrmRecomList.vstPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType);
var
  Data: PItemsRec;
begin
  Data:= Sender.GetNodeData(Node);

  if Assigned(Data) then
  begin
    if (Data^.PathIsExists = 0) then
      if (Column = 1) and (Data^.IsGroupName = 0) then //вторая колонка и не заголовок группы
      begin
        TargetCanvas.Font.Style:= TargetCanvas.Font.Style + [TFontStyle.fsStrikeOut];
        TargetCanvas.Font.Color:= clGrayText;
      end;
//
//    if chbShowUpdatedPrice.Checked then
//      if (Data^.CurrentCost <> Data^.InitCost) then
//        TargetCanvas.Font.Style:= TargetCanvas.Font.Style + [TFontStyle.fsBold];
  end;
end;

procedure TfrmRecomList.vstResize(Sender: TObject);
begin
  vst.Header.Columns.Items[1].Width:= vst.ClientWidth div 3 * 2;
end;

end.
