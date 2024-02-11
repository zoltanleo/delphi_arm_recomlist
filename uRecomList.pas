﻿unit uRecomList;

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
  , vcl.Menus
  ;

type
  { TODO : убрать тут объявление и подключить MainAndrUnit }
  TEditMode = (emAdd, emEdit);

  TNodeInfoMode = (nimGroup, nimItem); //что добавляем название группы/название пункта списка

  PItemsRec = ^TItemsRec;
  TItemsRec = record
    NodeUID: string;//GUID
    ParentUID: string;//GUID родителя (для узлов в корне пустая строка)
    IsGroupName: Integer;//заголовок группы (True = 1)
    PathIsExists: Integer;//корректность пути к файлу (для несущестующих 0, для заголовков групп -1)
    ItemName: string;//название исследования/заголовка группы
    ItemPath: string;//путь к файлу (для заголовков пусто)
    ItemEncod: Integer;//последняя использованная при открытии кодировка файла
  end;

  TfrmRecomList = class(TForm)
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
    btnNodeEdt: TButton;
    btnNodeDel: TButton;
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
    actCallNodeInfo: TAction;
    actChkStatusBtn: TAction;
    btnClose: TButton;
    oDlg: TOpenDialog;
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
    procedure actCallNodeInfoExecute(Sender: TObject);
    procedure actGroupAddExecute(Sender: TObject);
    procedure actItemAddExecute(Sender: TObject);
    procedure actNodeEdtExecute(Sender: TObject);
    procedure actNodeDelExecute(Sender: TObject);
    procedure ActPrintExecute(Sender: TObject);
    procedure ActHelpExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actChkStatusBtnExecute(Sender: TObject);
    procedure vstAddToSelection(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstRemoveFromSelection(Sender: TBaseVirtualTree; Node: PVirtualNode);
  private
    FKeybrdLayoutNum: Integer;
    FNodeInfoMode: TNodeInfoMode;
    FEditMode: TEditMode;
    function GetUID: string;
  public
    { Public declarations }
    property KeybrdLayoutNum: Integer read FKeybrdLayoutNum;//номер текущей раскладки
    property NodeInfoMode: TNodeInfoMode read FNodeInfoMode;//вид добавляемого узла
    property EditMode: TEditMode read FEditMode;//режим редактирования узла
  end;


var
  frmRecomList: TfrmRecomList;

implementation

{$R *.dfm}

uses uNodeInfo;

procedure TfrmRecomList.actCallNodeInfoExecute(Sender: TObject);
var
  tmpFrm: TfrmNodeInfo;
  Node, ParNode: PVirtualNode;
  Data, ParData: PItemsRec;
begin
  tmpFrm:= TfrmNodeInfo.Create(Self);
  Node:= nil;
  Data:= nil;
  ParNode:= nil;
  ParData:= nil;

  try
    with tmpFrm do
    begin
      NodeInfoMode:= Self.NodeInfoMode;
      EditMode:= Self.EditMode;

      if (NodeInfoMode = nimItem) then
      begin
        cbbGroup.Items.Clear;
        if (vst.RootNodeCount > 0) then
        begin
          Node:= vst.GetFirst;
          while not Assigned(Node) do
          begin
            Data:= vst.GetNodeData(Node);
            if (Data^.IsGroupName = 1) then
            cbbGroup.Items.Add(Data^.ItemName);
          end;
        end;
      end;

      case FEditMode of
        emAdd:
          begin
            edtItemName.Clear;
            if (NodeInfoMode = nimItem) then REdt.Clear;

            if (vst.RootNodeCount = 0)
              then ParNode:= nil
              else
                begin
                  if (vst.SelectedCount = 0)
                    then Node:= vst.GetFirst
                    else Node:= vst.GetFirstSelected;

                  ParNode:= nil;
                  if Assigned(Node) then
                    if (vst.GetNodeLevel(Node) = 1) then
                      ParNode:= Node^.Parent;
                end;
          end;
        emEdit:
          begin
            Node:= vst.GetFirstSelected;
            if not Assigned(Node) then Exit;

            Data:= vst.GetNodeData(Node);
            if Assigned(Data) then
            begin
              edtItemName.Text:= Data^.ItemName;

              if (NodeInfoMode = nimItem) then
              begin
                if FileExists(Data^.ItemPath) then
                begin
                  case Data^.ItemEncod of
                    0: REdt.Lines.LoadFromFile(oDlg.FileName);
                    1: REdt.Lines.LoadFromFile(oDlg.FileName,TEncoding.ANSI);
                    2: REdt.Lines.LoadFromFile(oDlg.FileName,TEncoding.UTF8);
                    3: REdt.Lines.LoadFromFile(oDlg.FileName,TEncoding.Unicode);
                    4: REdt.Lines.LoadFromFile(oDlg.FileName,TEncoding.BigEndianUnicode);
                  end;

                  cbbFileEncode.ItemIndex:= Data^.ItemEncod;
                end;
              end;
            end;
          end;
      end;

      ShowModal;
      if (ModalResult = mrOk) then
      begin
        case EditMode of
          emAdd:
            begin
              Node:= vst.AddChild(ParNode);
              Data:= vst.GetNodeData(Node);
              Data^.ItemName:= Trim(edtItemName.Text);

              case NodeInfoMode of
                nimGroup:
                  begin
                    Data^.NodeUID:= GetUID;
                    Data^.ParentUID:= '';
                    Data^.IsGroupName:= 1;
                    Data^.ItemPath:= '';
                    Data^.ItemEncod:= 0;
                    !
                  end;
                nimItem: ;
              end;
            end;
          emEdit:
            begin
              Data:= vst.GetNodeData(Node);
              if Assigned(Data) then
              begin
                Data^.ItemName:= Trim(edtItemName.Text);

                if (NodeInfoMode = nimItem) then
                begin
                  Data^.ItemPath:= NodeFilePath;
                  Data^.ItemEncod:= cbbFileEncode.ItemIndex;
                end;
              end;
            end;
        end;
      end;
    end;
  finally
    vst.Refresh;
    actChkStatusBtnExecute(Sender);
    FreeAndNil(tmpFrm);
  end;
//    NodeUID: string;//GUID
//    ParentUID: string;//GUID родителя (для узлов в корне пустая строка)
//    IsGroupName: Integer;//заголовок группы (True = 1)
//    PathIsExists: Integer;//корректность пути к файлу (для несущестующих 0, для заголовков групп -1)
//    ItemName: string;//название исследования/заголовка группы
//    ItemPath: string;//путь к файлу (для заголовков пусто)
//    ItemEncod: Integer;//последняя использованная при открытии кодировка файла
end;

procedure TfrmRecomList.actChkStatusBtnExecute(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PItemsRec;
begin
  Data:= nil;
  Node:= nil;

  if (csDestroying in ComponentState) then Exit;

  actItemAdd.Enabled:= (vst.SelectedCount <= 1);
  actNodeEdt.Enabled:= ((vst.RootNodeCount > 0) and (vst.SelectedCount = 1));
  actNodeDel.Enabled:= ((vst.RootNodeCount > 0) and (vst.SelectedCount > 0));
  btnItemAdd.Enabled:= actItemAdd.Enabled;
  btnNodeEdt.Enabled:= actNodeEdt.Enabled;
  btnNodeDel.Enabled:= actNodeDel.Enabled;

  ActPrint.Enabled:= False;

  if (vst.RootNodeCount > 0) then
  begin
    if (vst.SelectedCount = 0) then Node:= vst.GetFirst;
    if (vst.SelectedCount > 1) then Node:= vst.GetFirstSelected;

    Data:= vst.GetNodeData(Node);
    if Assigned(Data) then
      ActPrint.Enabled:= ((vst.SelectedCount = 1)
                          and (Data^.IsGroupName = 0)
                            and FileExists(Data^.ItemPath));
    if (FileExists(Data^.ItemPath) and chbPreview.Checked) then
    begin
      case Data^.ItemEncod of
        1: REdt.Lines.LoadFromFile(oDlg.FileName,TEncoding.ANSI);
        2: REdt.Lines.LoadFromFile(oDlg.FileName,TEncoding.UTF8);
        3: REdt.Lines.LoadFromFile(oDlg.FileName,TEncoding.Unicode);
        4: REdt.Lines.LoadFromFile(oDlg.FileName,TEncoding.BigEndianUnicode);
        else
          REdt.Lines.LoadFromFile(oDlg.FileName);
      end;
    end;
  end;

  btnPrint.Enabled:= ActPrint.Enabled;
  cbbFmtPrint.Enabled:= ActPrint.Enabled;
end;

procedure TfrmRecomList.actCloseExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmRecomList.actGroupAddExecute(Sender: TObject);
begin
  FNodeInfoMode:= nimGroup;
  FEditMode:= emAdd;
  actCallNodeInfoExecute(Sender);
end;

procedure TfrmRecomList.ActHelpExecute(Sender: TObject);
begin
//
end;

procedure TfrmRecomList.actItemAddExecute(Sender: TObject);
begin
  FNodeInfoMode:= nimItem;
  FEditMode:= emAdd;
  actCallNodeInfoExecute(Sender);
end;

procedure TfrmRecomList.actNodeDelExecute(Sender: TObject);
begin
//
end;

procedure TfrmRecomList.actNodeEdtExecute(Sender: TObject);
var
  NodeLvl: Integer;
  Node: PVirtualNode;
begin
  if (vst.RootNodeCount = 0) then Exit;

  if (vst.SelectedCount = 0) then
  begin
//    Node:= vst.GetFirst;
//    vst.Selected[Node]:= True;
    Application.MessageBox('Вы должны выделить редактируемый узел!',
                          'Недостаточно данных', MB_ICONINFORMATION);
    Exit;
  end;

  case vst.GetNodeLevel(Node) of
    0: FNodeInfoMode:= nimGroup;
    1: FNodeInfoMode:= nimItem;
  end;

  FEditMode:= emEdit;
  actCallNodeInfoExecute(Sender);
end;

procedure TfrmRecomList.ActPrintExecute(Sender: TObject);
begin
//
end;

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
  REdt.ScrollBars:= sbValue;
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
  oDlg.Filter:= 'файлы с текстом(*.txt;*.rtf)|*.txt;*.rtf';

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
  pnlLeftCmn.Constraints.MinWidth:= 520;
  pnlLeftCmn.Constraints.MinHeight:= 400;
  pnlPreview.Constraints.MinWidth:= 460;


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

  Self.ShowHint:= True;

  actGroupAdd.ShortCut:= TextToShortCut(ShortCutAdd);
  btnGroupAdd.OnClick:= actGroupAddExecute;
  btnGroupAdd.Hint:= ShortCutAdd;

  actItemAdd.ShortCut:= TextToShortCut(ShortCutAddMore);
  btnItemAdd.OnClick:= actItemAddExecute;
  btnItemAdd.Hint:= ShortCutAddMore;

  actNodeEdt.ShortCut:= TextToShortCut(ShortCutEdit);
  btnNodeEdt.OnClick:= actNodeEdtExecute;
  btnNodeEdt.Hint:= ShortCutEdit;

  actNodeDel.ShortCut:= TextToShortCut(ShortCutDel);
  btnNodeDel.OnClick:= actNodeDelExecute;
  btnNodeDel.Hint:= ShortCutDel;

  ActPrint.ShortCut:= TextToShortCut(ShortCutPrint);
  btnPrint.OnClick:= ActPrintExecute;
  btnPrint.Hint:= ShortCutPrint;

  ActHelp.ShortCut:= TextToShortCut(ShortCutHelp);
  btnHelp.OnClick:= ActHelpExecute;
  btnHelp.Hint:= ShortCutHelp;

  actClose.ShortCut:= TextToShortCut(ShortCutCancel);
  btnClose.OnClick:= actCloseExecute;
  btnClose.Hint:= ShortCutCancel;
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
  cbbScrollbarChange(Sender);
  actChkStatusBtnExecute(Sender);
end;

function TfrmRecomList.GetUID: string;
var
  tmpGUID: TGUID;
begin
  Result:= '';
  if (CreateGUID(tmpGUID) = 0)
    then Result:= GUIDToString(tmpGUID)
    else Result:= FormatDateTime('yyyy.mm.dd_hh:nn:ss.zzz', Now);
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

procedure TfrmRecomList.vstAddToSelection(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  ActChkStatusBtnExecute(Sender);
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

procedure TfrmRecomList.vstRemoveFromSelection(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  ActChkStatusBtnExecute(Sender);
end;

procedure TfrmRecomList.vstResize(Sender: TObject);
begin
  vst.Header.Columns.Items[1].Width:= vst.ClientWidth div 3 * 2;
end;

end.
