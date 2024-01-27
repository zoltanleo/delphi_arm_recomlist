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
  , Arm.Settings.Common
  , VirtualTrees
  , Vcl.ExtCtrls
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
    pnlRight: TPanel;
    REdt: TRichEdit;
    pnlLeft: TPanel;
    vst: TVirtualStringTree;
    btnGroupAdd: TButton;
    btnItemAdd: TButton;
    btnItemEdit: TButton;
    btnItemDelete: TButton;
    cbbFmtPrint: TComboBox;
    Spl: TSplitter;
    btnPrint: TButton;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  InitDir = 'c:\proj\test_delphi\delphi_recomlist\recom';
var
  frmRecomList: TfrmRecomList;

implementation

{$R *.dfm}

procedure TfrmRecomList.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  oDlg.Filter:= 'файлы с текстом(*.txt;*.doc;*.docx;*.rtf;*.odt)|*.txt;*.doc;*.docx;*.rtf;*.odt';
  oDlg.InitialDir:= InitDir;

  for i := 0 to Pred(Self.ControlCount) do
    if TControl(Self.Controls[i]).InheritsFrom(TPanel) then
      TPanel(Self.Controls[i]).BevelOuter:= bvNone;

  REdt.Clear;


  Spl.Margins.Top:= vst.Top;
  Spl.Margins.Bottom:= pnlLeft.Height - vst.Top - vst.Height;



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
  if (Spl.Left > Self.Width) then  pnlLeft.Width:= Self.Width div 3 * 2;
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
