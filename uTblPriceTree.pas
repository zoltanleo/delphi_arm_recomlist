unit uTblPriceTree;

interface

uses
  Winapi.Windows
  , Winapi.Messages
  , Winapi.ActiveX
  , System.SysUtils
  , System.Variants
  , System.Classes
  , Vcl.Graphics
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs
  , DMFIBUnit
  , MainAndrUnit
  , VarAndrUnit
  , Arm.Settings.Common
  , Vcl.ExtCtrls
  , VirtualTrees
  , Vcl.StdCtrls
  , System.Actions
  , Vcl.ActnList
  , Vcl.ComCtrls
  , Vcl.Menus
  , MemTableDataEh
  , Data.DB
  , FIB
  , FIBQuery
  , pFIBQuery
  , MemTableEh
  , FIBDatabase
  , pFIBDatabase
  ;

type
  TTreeChangeType = (tctExisting, tctDeleted, tctInserted, tctUpdated, tctNew);
  TActionNodeSender = (ansNodeRoot, ansNodeChild, ansNodeEdit);

  PMyRec = ^TMyRec;
  TMyRec = record
    PriceID: Integer;
    DepartID: Integer;
    CurrentChangeType: TTreeChangeType;
    LastChangeType: TTreeChangeType;
    ItemName: string;
    CurrentCost: Currency;
    InitCost: Currency;
    CodeLiter: string;
    ExistStatus: TTreeChangeType;
  end;

  TfrmTblPriceTree = class(TForm)
    pnlBtn: TPanel;
    pnlMain: TPanel;
    pnlNodesEdit: TPanel;
    pnlOptions: TPanel;
    pnlSetPriceName: TPanel;
    pnlTree: TPanel;
    btnCancel: TButton;
    btnSave: TButton;
    btnHelp: TButton;
    pnlTreeTree: TPanel;
    pnlTreeBtn: TPanel;
    btnRootAdd: TButton;
    btnChildAdd: TButton;
    btnNodeEdt: TButton;
    btnNodeDel: TButton;
    btnNodeRestore: TButton;
    vst: TVirtualStringTree;
    actList: TActionList;
    ActRootAdd: TAction;
    ActChildAdd: TAction;
    ActNodeEdt: TAction;
    ActNodeDel: TAction;
    ActNodeDataSave: TAction;
    ActNodeDataCancel: TAction;
    ActNodeRestore: TAction;
    ActItemSelect: TAction;
    actAllExpand: TAction;
    actAllCollaps: TAction;
    actNodeCollaps: TAction;
    actNodeExpand: TAction;
    ActChkStatusMnuVST: TAction;
    actChkStatusBtn: TAction;
    actEdtNodeDataOn: TAction;
    actEdtNodeDataOff: TAction;
    actPriceSave: TAction;
    actPriceCancel: TAction;
    pnlPriceNameEdt: TPanel;
    pnlItemSelect: TPanel;
    pnlEdtCost: TPanel;
    pnlEdtCodeLiter: TPanel;
    edtPriceName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtCodeLiter: TEdit;
    Label3: TLabel;
    edtPriceCost: TEdit;
    udPriceCost: TUpDown;
    btnItemSelect: TButton;
    Label4: TLabel;
    edtSetPriceName: TEdit;
    chbSetZeroCost: TCheckBox;
    chbShowUpdatedPrice: TCheckBox;
    chbHideDelNode: TCheckBox;
    ppmVST: TPopupMenu;
    mds_price_common: TMemTableEh;
    mds_baseprice: TMemTableEh;
    mds_laborissue: TMemTableEh;
    qryBaseprice: TpFIBQuery;
    qryLaborissue: TpFIBQuery;
    qryPriceItemInsert: TpFIBQuery;
    qryPriceItemUpdate: TpFIBQuery;
    qryPriceItemDelete: TpFIBQuery;
    tmpTrans: TpFIBTransaction;
    actHlp: TAction;
    mds_price_only: TMemTableEh;
    ActGetPriceOnly: TAction;
    tmpQry: TpFIBQuery;
    ActGetPriceCommon: TAction;
    ActGetLaborIssue: TAction;
    ActGetBasePrice: TAction;
    actPriceFill: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actPriceSaveExecute(Sender: TObject);
    procedure actPriceCancelExecute(Sender: TObject);
    procedure actHlpExecute(Sender: TObject);
    procedure actChkStatusBtnExecute(Sender: TObject);
    procedure actEdtNodeDataOnExecute(Sender: TObject);
    procedure actEdtNodeDataOffExecute(Sender: TObject);
    procedure ActRootAddExecute(Sender: TObject);
    procedure ActChildAddExecute(Sender: TObject);
    procedure ActNodeEdtExecute(Sender: TObject);
    procedure ActNodeDelExecute(Sender: TObject);
    procedure ActNodeDataSaveExecute(Sender: TObject);
    procedure ActNodeDataCancelExecute(Sender: TObject);
    procedure ActNodeRestoreExecute(Sender: TObject);
    procedure ActItemSelectExecute(Sender: TObject);
    procedure actAllExpandExecute(Sender: TObject);
    procedure actAllCollapsExecute(Sender: TObject);
    procedure actNodeCollapsExecute(Sender: TObject);
    procedure actNodeExpandExecute(Sender: TObject);
    procedure ActChkStatusMnuVSTExecute(Sender: TObject);
    procedure ActGetPriceOnlyExecute(Sender: TObject);
    procedure ActGetPriceCommonExecute(Sender: TObject);
    procedure ActGetLaborIssueExecute(Sender: TObject);
    procedure ActGetBasePriceExecute(Sender: TObject);
    procedure actPriceFillExecute(Sender: TObject);
    procedure vstAddToSelection(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
      Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure vstDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
      Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure vstEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure vstExpanded(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure vstGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure vstHeaderDraw(Sender: TVTHeader; HeaderCanvas: TCanvas; Column: TVirtualTreeColumn; R: TRect; Hover,
      Pressed: Boolean; DropMark: TVTDropMarkMode);
    procedure vstPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vstRemoveFromSelection(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure chbSetZeroCostClick(Sender: TObject);
    procedure chbShowUpdatedPriceClick(Sender: TObject);
    procedure chbHideDelNodeClick(Sender: TObject);
    procedure ActItemSelectUpdate(Sender: TObject);
    procedure edtPriceCostKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodeLiterKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FFilterStr: string;
    FPriceName: string;
    FInitPriceItemValue: string;
    FActionNodeSender: TActionNodeSender;
    FTreeChangeType: TTreeChangeType;
    FIsPickedNode: Boolean;
    FNodeSender: PVirtualNode;
    FEditMode: TEditMode;
    FKeybrdLayoutNum: Integer;
    FIsTreeExpanded: Boolean;
    { Private declarations }
  public
    property PriceName: string read FPriceName write FPriceName;
    property FilterStr: string read FFilterStr;
    property TreeChangeType: TTreeChangeType read FTreeChangeType;
    property NodeSender: PVirtualNode read FNodeSender;
    property ActionNodeSender: TActionNodeSender read FActionNodeSender;
    property EditMode: TEditMode read FEditMode write FEditMode;
    property InitPriceItemValue: string read FInitPriceItemValue;
    property IsPickedNode: Boolean read FIsPickedNode;
    property KeybrdLayoutNum: Integer read FKeybrdLayoutNum;//номер текущей раскладки
    property IsTreeExpanded: Boolean read FIsTreeExpanded;//состояние раскрытости дерева
  end;

var
  frmTblPriceTree: TfrmTblPriceTree;

implementation

uses uItem;

const
  msgAllowMovingNonExistNode = 'Можно перемещать только те добавленные данные, которых еще нет на текущий момент в базе данных.';

  //=== Price ===
  SQLTextPriceOnlySelect =
    'SELECT ' +
      'MAX(ID_PRICE) AS ID_PRICE, ' +
      'NAME_PRICE ' +
    'FROM TBL_PRICE ' +
    'GROUP BY NAME_PRICE ' +
    'ORDER BY 1 DESC';

  SQLTextPriceCommonSelect =
      'SELECT ' +
          'BP.BASEPRICE_ID, ' +
          'BP.BASEPRICE_PROC_NAME, ' +
          'P.COST_PROC_PRICE, ' +
          'LI.LABORISSUE_ID, ' +
          'LI.LABORISSUE_NAME, ' +
          'LI.LABORISSUE_CODELITER, ' +
          'P.NAME_PRICE ' +
      'FROM TBL_LABORISSUE LI ' +
         'JOIN TBL_BASEPRICE BP ON (LI.LABORISSUE_ID = BP.BASEPRICE_PROC_ISSUE_FK) ' +
         'JOIN TBL_PRICE P ON (BP.BASEPRICE_ID = P.FK_BASEPRICE) ' +
      'ORDER BY 1';

  //=== PriceItem ===
  SQLTextPriceItemInsert =
    'INSERT INTO TBL_PRICE (' +
      'FK_BASEPRICE,' +
      'NAME_PRICE,' +
      'COST_PROC_PRICE) ' +
    'VALUES (' +
      ':FK_BASEPRICE,' +
      ':NAME_PRICE,' +
      ':COST_PROC_PRICE)';

  SQLTextPriceItemUpdate =
    'UPDATE TBL_PRICE ' +
    'SET COST_PROC_PRICE = :COST_PROC_PRICE ' +
    'WHERE (FK_BASEPRICE = :FK_BASEPRICE) AND (NAME_PRICE = :NAME_PRICE)';

  SQLTextPriceItemDelete =
    'DELETE FROM TBL_PRICE ' +
    'WHERE (FK_BASEPRICE = :FK_BASEPRICE) AND (NAME_PRICE = :NAME_PRICE)';

  //=== LaborIssue ===
  SQLTextLaborIssueSelect =
    'SELECT ' +
        'LABORISSUE_ID, ' +
        'LABORISSUE_NAME, ' +
        'LABORISSUE_CODELITER ' +
    'FROM TBL_LABORISSUE ' +
    'ORDER BY 1';

  SQLTextLaborIssueInsert =
    'INSERT INTO TBL_LABORISSUE (' +
      'LABORISSUE_NAME, ' +
      'LABORISSUE_CODELITER) ' +
    'VALUES (' +
      ':LABORISSUE_NAME, ' +
      ':LABORISSUE_CODELITER) ' +
    'RETURNING LABORISSUE_ID';

    //=== ItemsSelect ===
  SQLTextItemsSelect =
    'SELECT ' +
        'LI.LABORISSUE_ID, ' +
        'LI.LABORISSUE_NAME, ' +
        'LI.LABORISSUE_CODELITER, ' +
        'BP.BASEPRICE_ID, ' +
        'BP.BASEPRICE_PROC_NAME ' +
    'FROM TBL_BASEPRICE BP ' +
       'INNER JOIN TBL_LABORISSUE LI ' +
       'ON (BP.BASEPRICE_PROC_ISSUE_FK = LI.LABORISSUE_ID) ' +
    'WHERE LI.LABORISSUE_NAME = :LABORISSUE_NAME';

    //=== BasePrice ===
     SQLTextBasepriceSelect =
      'SELECT ' +
        'BASEPRICE_ID, ' +
        'BASEPRICE_PROC_CODE, ' +
        'BASEPRICE_PROC_NAME, ' +
        'BASEPRICE_PROC_ISSUE_FK ' +
      'FROM TBL_BASEPRICE ' +
      'ORDER BY 1';

     SQLTextBasepriceInsert =
      'INSERT INTO TBL_BASEPRICE (' +
        'BASEPRICE_PROC_NAME, ' +
        'BASEPRICE_PROC_ISSUE_FK) ' +
      'VALUES (' +
        ':BASEPRICE_PROC_NAME, ' +
        ':BASEPRICE_PROC_ISSUE_FK) ' +
      'RETURNING BASEPRICE_ID';

{$R *.dfm}

procedure TfrmTblPriceTree.actAllCollapsExecute(Sender: TObject);
begin
  FIsTreeExpanded:= False;
  vst.FullCollapse(nil);
end;

procedure TfrmTblPriceTree.actAllExpandExecute(Sender: TObject);
begin
  FIsTreeExpanded:= True;
  vst.FullExpand(nil);
end;

procedure TfrmTblPriceTree.ActGetBasePriceExecute(Sender: TObject);
begin
  try
    tmpTrans.StartTransaction;
    tmpQry.Close;
    tmpQry.SQL.Text:= SQLTextBasepriceSelect;
    tmpQry.ExecQuery;

    if mds_baseprice.Active
      then mds_baseprice.EmptyTable
      else mds_baseprice.Active:= True;

    while not tmpQry.Eof do
    begin
      mds_baseprice.AppendRecord([
          tmpQry.FieldByName('BASEPRICE_ID').AsInteger,
          tmpQry.FieldByName('BASEPRICE_PROC_CODE').AsString,
          tmpQry.FieldByName('BASEPRICE_PROC_NAME').AsString,
          tmpQry.FieldByName('BASEPRICE_PROC_ISSUE_FK').AsInteger
                              ]);
      tmpQry.Next;
    end;

    tmpTrans.Commit;
  except
    on E: EFIBError do
    begin
      tmpTrans.Rollback;
      Application.MessageBox(PChar(DMFIB.GetFIBExceptStr(E)), 'Ошибка доступа к данным', MB_ICONERROR);
    end;
  end;
end;

procedure TfrmTblPriceTree.ActChildAddExecute(Sender: TObject);
var
  tmpCurr: Currency;
  fs: TFormatSettings;
  NodeLvl: Integer;
begin
  if (vst.SelectedCount = 0) then
  begin
    Application.MessageBox('Должен выделен хотя бы один узел!','Недостаточно данных', MB_ICONINFORMATION);
    Exit;
  end;

  fs:= TFormatSettings.Create;

  pnlEdtCost.Visible:= True;
  pnlEdtCodeLiter.Visible:= not pnlEdtCost.Visible;

  FNodeSender:= vst.GetFirstSelected;
  FActionNodeSender:= ansNodeChild;
  actEdtNodeDataOnExecute(Sender);

  edtPriceName.Clear;
  edtCodeLiter.Clear;
  edtPriceCost.Text:= '0';

  if TryStrToCurr(edtPriceCost.Text, tmpCurr,fs)
    then edtPriceCost.Text:= Format('%2.2f',[tmpCurr])
    else edtPriceCost.Clear;

  if edtPriceName.CanFocus then edtPriceName.SetFocus;
end;

procedure TfrmTblPriceTree.actChkStatusBtnExecute(Sender: TObject);
var
  NodeLvl: Integer;
  Node: PVirtualNode;
  Nodes: TNodeArray;
  Data: PMyRec;
  I: Integer;
begin
  if (csDestroying in ComponentState) then Exit;

  ActNodeEdt.Enabled:= False;
  ActChildAdd.Enabled:= False;

  case vst.SelectedCount of
    0:
      begin
        ActNodeDel.Enabled:= False;
        ActNodeRestore.Enabled:= False;
      end;
    1:
      begin
        Node:= vst.GetFirstSelected;
        Data:= vst.GetNodeData(Node);
        NodeLvl:= vst.GetNodeLevel(Node);

        if Assigned(Data) then
        begin
          ActNodeDel.Enabled:= (Data^.CurrentChangeType <> tctDeleted);
          ActNodeRestore.Enabled:= (Data^.CurrentChangeType = tctDeleted);

          if (Data^.CurrentChangeType <> tctExisting)
            then ActNodeEdt.Enabled:= (Data^.CurrentChangeType <> tctDeleted)
            else ActNodeEdt.Enabled:= ((Data^.CurrentChangeType <> tctDeleted) and (NodeLvl > 0));



          if (NodeLvl = 1) then Data:= vst.GetNodeData(Node.Parent);
          ActChildAdd.Enabled:= ((vst.RootNodeCount > 0) and (Data^.CurrentChangeType <> tctDeleted));
        end;
      end;
    else
      begin
        ActNodeDel.Enabled:= True;
        ActNodeRestore.Enabled:= True;

        Nodes:= vst.GetSortedSelection(True);

        for i := 0 to Pred(System.Length(Nodes)) do
        begin
          Data:= vst.GetNodeData(Nodes[i]);
          if Assigned(Data) then
            if (Data^.CurrentChangeType = tctDeleted) then
            begin
              ActNodeDel.Enabled:= False;
              Break;
            end;
        end;

        for i := 0 to Pred(System.Length(Nodes)) do
        begin
          Data:= vst.GetNodeData(Nodes[i]);
          if Assigned(Data) then
            if (Data^.CurrentChangeType <> tctDeleted) then
            begin
              ActNodeRestore.Enabled:= False;
              Break;
            end;
        end;
      end;
  end;

  btnChildAdd.Enabled:= ActChildAdd.Enabled;
  btnNodeEdt.Enabled:= ActNodeEdt.Enabled;
  btnNodeDel.Enabled:= ActNodeDel.Enabled;
  btnNodeRestore.Enabled:= ActNodeRestore.Enabled;
//  btnPriceSave.Enabled:= actPriceSave.Enabled;
//  btnPriceCancel.Enabled:= actPriceCancel.Enabled;
end;

procedure TfrmTblPriceTree.ActChkStatusMnuVSTExecute(Sender: TObject);
var
  Node: PVirtualNode;
  NodeLvl: Integer;
begin
  Node:= vst.GetFirstSelected(True);

  if not Assigned(node) then Exit;
  NodeLvl:= vst.GetNodeLevel(Node);

  if (NodeLvl > 0) then Node:= Node.Parent;

  actNodeCollaps.Enabled:= ((vst.SelectedCount = 1) and (vsExpanded in Node^.States));
  actNodeExpand.Enabled:= ((vst.SelectedCount = 1) and not (vsExpanded in Node^.States));
end;

procedure TfrmTblPriceTree.actEdtNodeDataOffExecute(Sender: TObject);
var
  i: Integer;
  IsEdit: Boolean;
begin
  vst.Refresh;
  IsEdit:= False;

  for i := 0 to  Pred(pnlTreeBtn.ControlCount) do
  begin
    if TObject(pnlTreeBtn.Controls[i]).InheritsFrom(TButton) then
      TButton(pnlTreeBtn.Controls[i]).Enabled:= not IsEdit;
  end;

  pnlOptions.Visible:= not IsEdit;
  vst.Enabled:= not IsEdit;

  pnlNodesEdit.Visible:= IsEdit;
  pnlSetPriceName.Visible:= (not IsEdit and (EditMode = emAdd));

  ActRootAdd.Enabled:= not IsEdit;
  ActChildAdd.Enabled:= not IsEdit;
  ActNodeEdt.Enabled:= not IsEdit;
  ActNodeDel.Enabled:= not IsEdit;
  ActNodeRestore.Enabled:= not IsEdit;

  pnlEdtCost.Align:= alNone;
  pnlEdtCodeLiter.Align:= alNone;
  pnlItemSelect.Align:= alNone;

  ActNodeDataSave.ShortCut:= TextToShortCut(ShortCutEmpty);
  ActNodeDataCancel.ShortCut:= TextToShortCut(ShortCutEmpty);

  actPriceSave.ShortCut:= TextToShortCut(ShortCutSave);
  actPriceCancel.ShortCut:= TextToShortCut(ShortCutCancel);
  btnSave.OnClick:= actPriceSaveExecute;
  btnCancel.OnClick:= actPriceCancelExecute;

  ActChkStatusBtnExecute(Sender);
end;

procedure TfrmTblPriceTree.actEdtNodeDataOnExecute(Sender: TObject);
var
  i, NodeLvl: Integer;
  IsEdit: Boolean;
begin
  IsEdit:= True;

  for i := 0 to  Pred(pnlTreeBtn.ControlCount) do
  begin
    if TObject(pnlTreeBtn.Controls[i]).InheritsFrom(TButton) then
      TButton(pnlTreeBtn.Controls[i]).Enabled:= not IsEdit;
  end;

  pnlOptions.Visible:= not IsEdit;
  pnlSetPriceName.Visible:= (not IsEdit and (EditMode = emAdd));

  vst.Enabled:= not IsEdit;
  pnlNodesEdit.Visible:= IsEdit;

  ActRootAdd.Enabled:= not IsEdit;
  ActChildAdd.Enabled:= not IsEdit;
  ActNodeEdt.Enabled:= not IsEdit;
  ActNodeDel.Enabled:= not IsEdit;
  ActNodeRestore.Enabled:= not IsEdit;

  ActItemSelect.Enabled:= (ActionNodeSender <> ansNodeEdit);

  case ActionNodeSender of
    ansNodeRoot:
      begin
        pnlEdtCost.Visible:= False;
        pnlEdtCodeLiter.Visible:= not pnlEdtCost.Visible;
      end;
    ansNodeChild:
      begin
        pnlEdtCost.Visible:= True;
        pnlEdtCodeLiter.Visible:= not pnlEdtCost.Visible;
      end;
    ansNodeEdit:
      begin
        NodeLvl:= vst.GetNodeLevel(NodeSender);
        pnlEdtCost.Visible:= (NodeLvl = 1);
        pnlEdtCodeLiter.Visible:= (NodeLvl <> 1);
      end;
  end;

  pnlItemSelect.Align:= alRight;
  if pnlEdtCodeLiter.Visible then pnlEdtCodeLiter.Align:= alRight;
  if pnlEdtCost.Visible then pnlEdtCost.Align:= alRight;

  actPriceSave.ShortCut:= TextToShortCut(ShortCutEmpty);
  actPriceCancel.ShortCut:= TextToShortCut(ShortCutEmpty);

  ActNodeDataSave.ShortCut:= TextToShortCut(ShortCutSave);
  ActNodeDataCancel.ShortCut:= TextToShortCut(ShortCutCancel);
  btnSave.OnClick:= ActNodeDataSaveExecute;
  btnCancel.OnClick:= ActNodeDataCancelExecute;
end;

procedure TfrmTblPriceTree.ActGetLaborIssueExecute(Sender: TObject);
begin
  try
    tmpTrans.StartTransaction;
    tmpQry.Close;
    tmpQry.SQL.Text:= SQLTextLaborIssueSelect;
    tmpQry.ExecQuery;

    if mds_laborissue.Active
      then mds_laborissue.EmptyTable
      else mds_laborissue.Active:= True;

    while not tmpQry.Eof do
    begin
      mds_laborissue.AppendRecord([
                  tmpQry.FieldByName('LABORISSUE_ID').AsInteger,
                  tmpQry.FieldByName('LABORISSUE_NAME').AsString,
                  tmpQry.FieldByName('LABORISSUE_CODELITER').AsString
                              ]);
      tmpQry.Next;
    end;

    tmpTrans.Commit;
  except
    on E: EFIBError do
    begin
      tmpTrans.Rollback;
      Application.MessageBox(PChar(DMFIB.GetFIBExceptStr(E)), 'Ошибка доступа к данным', MB_ICONERROR);
    end;
  end;
end;

procedure TfrmTblPriceTree.ActGetPriceCommonExecute(Sender: TObject);
begin
  try
    tmpTrans.StartTransaction;
    tmpQry.Close;
    tmpQry.SQL.Text:= SQLTextPriceCommonSelect;
    tmpQry.ExecQuery;

    if mds_price_common.Active
      then mds_price_common.EmptyTable
      else mds_price_common.Active:= True;

    while not tmpQry.Eof do
    begin
      mds_price_common.AppendRecord([
                  tmpQry.FieldByName('BASEPRICE_ID').AsInteger,
                  tmpQry.FieldByName('BASEPRICE_PROC_NAME').AsString,
                  tmpQry.FieldByName('COST_PROC_PRICE').AsCurrency,
                  tmpQry.FieldByName('LABORISSUE_ID').AsInteger,
                  tmpQry.FieldByName('LABORISSUE_NAME').AsString,
                  tmpQry.FieldByName('LABORISSUE_CODELITER').AsString,
                  tmpQry.FieldByName('NAME_PRICE').AsString
                              ]);
      tmpQry.Next;
    end;

    tmpTrans.Commit;
  except
    on E: EFIBError do
    begin
      tmpTrans.Rollback;
      Application.MessageBox(PChar(DMFIB.GetFIBExceptStr(E)), 'Ошибка доступа к данным', MB_ICONERROR);
    end;
  end;
end;

procedure TfrmTblPriceTree.ActGetPriceOnlyExecute(Sender: TObject);
begin
  try
    tmpTrans.StartTransaction;
    tmpQry.Close;
    tmpQry.SQL.Text:= SQLTextPriceOnlySelect;
    tmpQry.ExecQuery;

    if mds_price_only.Active
      then mds_price_only.EmptyTable
      else mds_price_only.Active:= True;

    while not tmpQry.Eof do
    begin
      mds_price_only.AppendRecord([
                tmpQry.FieldByName('ID_PRICE').AsInteger,
                tmpQry.FieldByName('NAME_PRICE').AsString
                              ]);
      tmpQry.Next;
    end;

    tmpTrans.Commit;
  except
    on E: EFIBError do
    begin
      tmpTrans.Rollback;
      Application.MessageBox(PChar(DMFIB.GetFIBExceptStr(E)), 'Ошибка доступа к данным', MB_ICONERROR);
    end;
  end;
end;

procedure TfrmTblPriceTree.actHlpExecute(Sender: TObject);
begin
//
end;

procedure TfrmTblPriceTree.ActItemSelectExecute(Sender: TObject);
var
  tmpFrm: TfrmItem;
  srcNode, destNode: PVirtualNode;
  destData: PTreeItem;
  srcData: PMyRec;
  NodeLvl: Integer;
  fs: TFormatSettings;

  procedure FillIssue;
  begin
    with tmpFrm do
    begin
      try
        if mds_issue.Active
          then mds_issue.EmptyTable
          else mds_issue.Active:= True;

        mds_laborissue.First;

        while not mds_laborissue.Eof do
        begin
          mds_issue.AppendRecord([
              mds_laborissue.FieldByName('LABORISSUE_ID').AsInteger,
              mds_laborissue.FieldByName('LABORISSUE_NAME').AsString,
              mds_laborissue.FieldByName('LABORISSUE_CODELITER').AsString
                                 ]);
          mds_laborissue.Next;
        end;

        if (vst.RootNodeCount > 0) then
        begin
          srcNode:= vst.GetFirst;

          while Assigned(srcNode) do
          begin
            srcData:= vst.GetNodeData(srcNode);

            if Assigned(srcData) then
              if mds_issue.Locate('LABORISSUE_NAME',srcData^.ItemName,[loCaseInsensitive])
                then mds_issue.Delete;

            srcNode:= srcNode.NextSibling;
          end;
        end;

        try
          PriceTree.BeginUpdate;
          PriceTree.Clear;

          if mds_issue.IsEmpty then Exit;

          mds_issue.First;

          while not mds_issue.Eof do
          begin
            destNode:= PriceTree.AddChild(nil);
            destData:= PriceTree.GetNodeData(destNode);
            if Assigned(destData) then
            begin
              destData^.ItemID:= mds_issue.FieldByName('LABORISSUE_ID').AsInteger;
              destData^.ItemName:= mds_issue.FieldByName('LABORISSUE_NAME').AsString;
              destData^.ItemLiter:= mds_issue.FieldByName('LABORISSUE_CODELITER').AsString;
            end;
            mds_issue.Next;
          end;
        finally
          PriceTree.EndUpdate;
        end;
      except
        on E: EFIBError do
        begin
          tmpTrans.Rollback;
          Application.MessageBox(PChar(DMFIB.GetFIBExceptStr(E)), 'Ошибка доступа к данным', MB_ICONERROR);
        end;
      end;
    end;
  end;

  procedure FillItems;
  begin
    if not Assigned(NodeSender) then Exit;
    NodeLvl:= vst.GetNodeLevel(NodeSender);

    case NodeLvl of
      0: srcNode:= NodeSender;
      1: srcNode:= NodeSender.Parent;
    end;

    with tmpFrm do
    begin
      try
        if mds_items.Active
          then mds_items.EmptyTable
          else mds_items.Active:= True;

        srcData:= vst.GetNodeData(srcNode);

        if Assigned(srcData) then
        begin
          mds_baseprice.First;

          while not mds_baseprice.Eof do
          begin
            mds_items.AppendRecord([
              mds_baseprice.FieldByName('BASEPRICE_ID').AsInteger,
              mds_baseprice.FieldByName('BASEPRICE_PROC_CODE').AsString,
              mds_baseprice.FieldByName('BASEPRICE_PROC_NAME').AsString,
              mds_baseprice.FieldByName('BASEPRICE_PROC_ISSUE_FK').AsInteger
                                    ]);
            mds_baseprice.Next;
          end;

          if mds_laborissue.Locate('LABORISSUE_NAME',srcData^.ItemName,[loCaseInsensitive]) then
          begin
            mds_items.Filtered:= False;
            mds_items.Filter:= Format('(BASEPRICE_PROC_ISSUE_FK=%d)',[mds_laborissue.FieldByName('LABORISSUE_ID').AsInteger]);
            mds_items.Filtered:= True;

            if mds_items.IsEmpty then Exit;

            if (srcNode^.ChildCount > 0) then
            begin
              srcNode:= srcNode.FirstChild;

              while Assigned(srcNode) do
              begin
                srcData:= vst.GetNodeData(srcNode);
                if Assigned(srcData) then
                  if mds_items.Locate('BASEPRICE_PROC_NAME',srcData^.ItemName,[loCaseInsensitive])
                    then mds_items.Delete;

                srcNode:= srcNode.NextSibling;
              end;
            end;

          end;

          try
            PriceTree.BeginUpdate;
            PriceTree.Clear;

            if mds_items.IsEmpty then Exit;

            mds_items.First;

            while not mds_items.Eof do
            begin
              destNode:= PriceTree.AddChild(nil);
              destData:= PriceTree.GetNodeData(destNode);

              if Assigned(destData) then
              begin
                destData.ItemID:= mds_items.FieldByName('BASEPRICE_ID').AsInteger;
                destData.ItemName:= mds_items.FieldByName('BASEPRICE_PROC_NAME').AsString;
                destData.ItemLiter:= '';
              end;

              mds_items.Next;
            end;
          finally
            PriceTree.EndUpdate;
          end;
        end;
      except
        on E: EFIBError do
        begin
          tmpTrans.Rollback;
          Application.MessageBox(PChar(DMFIB.GetFIBExceptStr(E)), 'Ошибка доступа к данным', MB_ICONERROR);
        end;
      end;
    end;
  end;
begin
  srcNode:= nil;
  destNode:= nil;
  srcData:= nil;
  destData:= nil;

  tmpFrm:= TfrmItem.Create(Self);
  try
    with tmpFrm do
    begin
      case ActionNodeSender of
        ansNodeRoot:
                begin
                  FillIssue;
                  Caption:= 'Выбор раздела';
                end;
        ansNodeChild:
                begin
                  FillItems;
                  Caption:= 'Выбор услуги';
                end;
        ansNodeEdit: Exit;
      end;

      lblEmptyWarninig.Visible:= (PriceTree.RootNodeCount = 0);
      FInitPriceItemValue:= '';
      FIsPickedNode:= False;

      ShowModal;

      if (ModalResult = mrOk) then
      begin
        destNode:= PriceTree.GetFirstSelected;
        if not Assigned(destNode) then Exit;

        destData:= PriceTree.GetNodeData(destNode);
        if Assigned(destData) then
        begin
          edtPriceName.Text:= destData^.ItemName;

          case ActionNodeSender of
            ansNodeRoot:
              begin
                 edtCodeLiter.Text:= UpperCase(destData^.ItemLiter,loUserLocale);
                 edtPriceCost.Clear;
                 udPriceCost.Position:= 0;
                 FInitPriceItemValue:= UpperCase(Format('%s~%s',[edtPriceName.Text, edtCodeLiter.Text]), loUserLocale);
              end;
            ansNodeChild:
              begin
                FInitPriceItemValue:= edtPriceName.Text;
                edtCodeLiter.Clear;
                fs:= TFormatSettings.Create;
                edtPriceCost.Text:= Format('0%s00',[fs.DecimalSeparator]);
                udPriceCost.Position:= 0;
//                edtPriceCostChange(Sender);
              end;
            ansNodeEdit: Exit;
          end;
        end;
      end;
      FIsPickedNode:= (ModalResult = mrOk);
    end;
  finally
    FreeAndNil(tmpFrm);
  end;
end;

procedure TfrmTblPriceTree.ActItemSelectUpdate(Sender: TObject);
begin
  pnlItemSelect.Visible:= ActItemSelect.Enabled;
end;

procedure TfrmTblPriceTree.actNodeCollapsExecute(Sender: TObject);
var
  NodeLvl: Integer;
  Node: PVirtualNode;
begin
  if (vst.SelectedCount <> 1) then Exit;

  Node:= vst.GetFirstSelected;
  if not Assigned(Node) then Exit;
  NodeLvl:= vst.GetNodeLevel(Node);

  if (NodeLvl <> 0) then Node:= Node.Parent;
  vst.Expanded[Node]:= False;

  FIsTreeExpanded:= False;
end;

procedure TfrmTblPriceTree.ActNodeDataCancelExecute(Sender: TObject);
begin
  actEdtNodeDataOffExecute(Sender);
end;

procedure TfrmTblPriceTree.ActNodeDataSaveExecute(Sender: TObject);
const
  RootPriceItemListExixst =  'Раздел с таким названием в текущем списке уже существует! ' +
                          'Возможно он просто скрыт в настройках и не отображается.';
  ChildPriceItemListExixst =  'Услуга с таким названием в текущем списке уже существует! ' +
                          'Возможно она просто скрыт в настройках и не отображается.';

  RootPriceItemBaseExixst = 'Раздел с таким названием в базе данных уже существует!';
  ChildPriceItemBaseExixst = 'Услуга с таким названием в базе данных уже существует!';
var
  NodeLvl: Integer;
  Node: PVirtualNode;
  rData, Data: PMyRec;
  tmpCurr: Currency;
  fs: TFormatSettings;

  function RootTreeExists(PriceNameText: string): Boolean;
  var
    aNode: PVirtualNode;
    aData: PMyRec;
  begin
    aNode:= nil;
    aData:= nil;

    Result:= False;
    if (vst.RootNodeCount = 0) then Exit;

    aNode:= vst.GetFirst;

    while Assigned(aNode) do
    begin
      aData:= vst.GetNodeData(aNode);

      if Assigned(aData) then
        Result:= (CompareText(aData^.ItemName, Trim(PriceNameText),loUserLocale) = 0);

      if Result then Exit;

      aNode:= aNode.NextSibling;
    end;

  end;

  function ChildTreeExists(PriceNameText: string): Boolean;
  var
    aNode, bNode: PVirtualNode;
    aData: PMyRec;
  begin
    aNode:= nil;
    bNode:= nil;
    aData:= nil;

    Result:= False;
    if (vst.RootNodeCount = 0) then Exit;

    aNode:= vst.GetFirst;

    while Assigned(aNode) do
    begin
      if (vsHasChildren in aNode.States) then
      begin
        bNode:= aNode^.FirstChild;

        while Assigned(bNode) do
        begin
          aData:= vst.GetNodeData(bNode);
          if Assigned(aData) then
            Result:= (CompareStr(aData^.ItemName, Trim(PriceNameText), loUserLocale) = 0);

          if Result then Exit;

          bNode:= bNode.NextSibling;
        end;
      end;

      aNode:= aNode.NextSibling;
    end;
  end;
begin
  Node:= nil;

  if (Trim(edtPriceName.Text) = '') then
  begin
    Application.MessageBox('Поле не может быть пустым!','Некорректные данные',MB_ICONINFORMATION);
    if edtPriceName.CanFocus then edtPriceName.SetFocus;
    Exit;
  end;

  if ((Trim(edtCodeLiter.Text) = '') and (ActionNodeSender = ansNodeRoot)) then
  begin
    Application.MessageBox('Поле не может быть пустым!','Некорректные данные',MB_ICONINFORMATION);
    if edtCodeLiter.CanFocus then edtCodeLiter.SetFocus;
    Exit;
  end;

  case ActionNodeSender of
    ansNodeRoot:
              begin
                if RootTreeExists(edtPriceName.Text)
                then
                  begin
                    Application.MessageBox(PChar(RootPriceItemListExixst),'Некорректные данные',MB_ICONINFORMATION);
                    if edtPriceName.CanFocus then edtPriceName.SetFocus;
                    Exit;
                  end
                else
                  begin
                    if IsPickedNode
                    then
                      begin
                        if (InitPriceItemValue <> UpperCase(Trim(edtPriceName.Text) + '~' + Trim(edtCodeLiter.Text),loUserLocale)) then
                        begin
                          if mds_laborissue.Locate('LABORISSUE_NAME',Trim(edtPriceName.Text),[loCaseInsensitive]) then
                          begin
                            Application.MessageBox(PChar(RootPriceItemBaseExixst),
                                                    'Некорректные данные',MB_ICONINFORMATION);
                            if edtPriceName.CanFocus then edtPriceName.SetFocus;
                            Exit;
                          end;

                          if mds_laborissue.Locate('LABORISSUE_CODELITER',Trim(edtCodeLiter.Text),[loCaseInsensitive]) then
                          begin
                            Application.MessageBox('Раздел с таким значением литеры кода базе данных уже существует!',
                                                    'Некорректные данные',MB_ICONINFORMATION);
                            if edtCodeLiter.CanFocus then edtCodeLiter.SetFocus;
                            Exit;
                          end;
                        end;
                      end
                    else
                      begin
                        if mds_laborissue.Locate('LABORISSUE_NAME',Trim(edtPriceName.Text),[loCaseInsensitive]) then
                        begin
                          Application.MessageBox(PChar(RootPriceItemBaseExixst),
                                                  'Некорректные данные',MB_ICONINFORMATION);
                          if edtPriceName.CanFocus then edtPriceName.SetFocus;
                          Exit;
                        end;

                        if mds_laborissue.Locate('LABORISSUE_CODELITER',Trim(edtCodeLiter.Text),[loCaseInsensitive]) then
                        begin
                          Application.MessageBox('Раздел с таким значением литеры кода базе данных уже существует!',
                                                  'Некорректные данные',MB_ICONINFORMATION);
                          if edtCodeLiter.CanFocus then edtCodeLiter.SetFocus;
                          Exit;
                        end;
                      end;
                  end;

                if not Assigned(NodeSender)
                  then Node:= vst.AddChild(NodeSender)
                  else
                    begin
                      NodeLvl:= vst.GetNodeLevel(NodeSender);
                      if (NodeLvl = 1) then FNodeSender:= NodeSender.Parent;
                      Node:= vst.InsertNode(NodeSender, amInsertAfter);
                    end;
              end;
    ansNodeChild:
              begin
                if ChildTreeExists(edtPriceName.Text)
                then
                  begin
                    Application.MessageBox(PChar(ChildPriceItemListExixst),'Некорректные данные',MB_ICONINFORMATION);
                    if edtPriceName.CanFocus then edtPriceName.SetFocus;
                    Exit;
                  end
                else
                  begin
                    if IsPickedNode
                    then
                      begin
                        if (CompareText(InitPriceItemValue,Trim(edtPriceName.Text), loUserLocale) <> 0) then
                          if mds_baseprice.Locate('BASEPRICE_PROC_NAME',Trim(edtPriceName.Text),[loCaseInsensitive]) then
                          begin
                            Application.MessageBox(PChar(ChildPriceItemBaseExixst),'Некорректные данные',MB_ICONINFORMATION);
                            if edtPriceName.CanFocus then edtPriceName.SetFocus;
                            Exit;
                          end;
                      end
                    else
                      if mds_baseprice.Locate('BASEPRICE_PROC_NAME',Trim(edtPriceName.Text),[loCaseInsensitive]) then
                      begin
                        Application.MessageBox(PChar(ChildPriceItemBaseExixst),'Некорректные данные',MB_ICONINFORMATION);
                        if edtPriceName.CanFocus then edtPriceName.SetFocus;
                        Exit;
                      end;
                  end;

                if not Assigned(NodeSender) then Exit;
                NodeLvl:= vst.GetNodeLevel(NodeSender);

                case NodeLvl of
                  0: Node:= vst.InsertNode(NodeSender, amAddChildFirst);
                  1: Node:= vst.InsertNode(NodeSender, amInsertAfter);
                end;
              end;
    ansNodeEdit:
              begin
                NodeLvl:= vst.GetNodeLevel(NodeSender);
                Data:= vst.GetNodeData(NodeSender);

                case NodeLvl of
                  0:
                    begin
                      if (CompareText(InitPriceItemValue, Format('%s~%s',
                                      [Trim(edtPriceName.Text),Trim(edtCodeLiter.Text)]),loUserLocale) <> 0) then
                        if RootTreeExists(edtPriceName.Text)
                        then
                          begin
                            Application.MessageBox(PChar(RootPriceItemListExixst),'Некорректные данные',MB_ICONINFORMATION);
                            if edtPriceName.CanFocus then edtPriceName.SetFocus;
                            Exit;
                          end
                        else
                          begin
                            if mds_laborissue.Locate('LABORISSUE_NAME',Trim(edtPriceName.Text),[loCaseInsensitive]) then
                            begin
                              Application.MessageBox(PChar(RootPriceItemBaseExixst),
                                                      'Некорректные данные',MB_ICONINFORMATION);
                              if edtPriceName.CanFocus then edtPriceName.SetFocus;
                              Exit;
                            end;

                            if mds_laborissue.Locate('LABORISSUE_CODELITER',Trim(edtCodeLiter.Text),[loCaseInsensitive]) then
                            begin
                              Application.MessageBox('Раздел с таким значением литеры кода базе данных уже существует!',
                                                      'Некорректные данные',MB_ICONINFORMATION);
                              if edtCodeLiter.CanFocus then edtCodeLiter.SetFocus;
                              Exit;
                            end;
                          end;
                    end;
                  1:
                    begin
                      if (CompareText(InitPriceItemValue, Trim(edtPriceName.Text),loUserLocale) <> 0) then
                        if ChildTreeExists(edtPriceName.Text)
                        then
                          begin
                            Application.MessageBox(PChar(ChildPriceItemListExixst),'Некорректные данные',MB_ICONINFORMATION);
                            if edtPriceName.CanFocus then edtPriceName.SetFocus;
                            Exit;
                          end
                        else
                          begin
                            if mds_baseprice.Locate('BASEPRICE_PROC_NAME',Trim(edtPriceName.Text),[loCaseInsensitive]) then
                            begin
                              Application.MessageBox(PChar(ChildPriceItemBaseExixst),'Некорректные данные',MB_ICONINFORMATION);
                              if edtPriceName.CanFocus then edtPriceName.SetFocus;
                              Exit;
                            end;
                          end;

                    end;
                end;

                Node:= NodeSender;
              end;

  end;

  Data:= vst.GetNodeData(Node);

  if Assigned(Data) then
  begin
    NodeLvl:= vst.GetNodeLevel(Node);

    case ActionNodeSender of
      ansNodeRoot:
        begin
          Data^.PriceID:= 0;
          Data^.DepartID:= 0;
          Data^.ItemName:= Trim(edtPriceName.Text);
          Data^.CurrentChangeType:= tctInserted;
          Data^.LastChangeType:= Data^.CurrentChangeType;

          if mds_laborissue.Locate('LABORISSUE_NAME',Trim(edtPriceName.Text),[loCaseInsensitive])
            then Data^.ExistStatus:= tctExisting
            else Data^.ExistStatus:= tctNew;
        end;
      ansNodeChild:
        begin
          Data^.PriceID:= 0;
          Data^.DepartID:= 0;
          Data^.ItemName:= Trim(edtPriceName.Text);
          Data^.CurrentChangeType:= tctInserted;
          Data^.LastChangeType:= Data^.CurrentChangeType;

          if mds_baseprice.Locate('BASEPRICE_PROC_NAME',Trim(edtPriceName.Text),[loCaseInsensitive])
            then Data^.ExistStatus:= tctExisting
            else Data^.ExistStatus:= tctNew;
        end;
      ansNodeEdit:
        begin
          Data^.CurrentChangeType:= tctUpdated;
          Data^.LastChangeType:= Data^.CurrentChangeType;
          Data^.ItemName:= Trim(edtPriceName.Text);
        end;
    end;

    case NodeLvl of
    0:
      begin
        Data^.CurrentCost:= 0;
        Data^.InitCost:= 0;
        Data^.CodeLiter:= UpperCase(Trim(edtCodeLiter.Text),loUserLocale);
      end;
    1:
      begin
        fs:= TFormatSettings.Create;
        if TryStrToCurr(edtPriceCost.Text, tmpCurr,fs) then Data^.CurrentCost:= tmpCurr;
        Data^.CodeLiter:= '';
      end;
    end;
  end;

  vst.Refresh;
  actEdtNodeDataOffExecute(Sender);
  vst.ClearSelection;
  vst.ScrollIntoView(Node,True,False);
  vst.Selected[Node]:= True;
  if vst.CanFocus then vst.SetFocus;

  ActChkStatusBtnExecute(Sender);
end;

procedure TfrmTblPriceTree.ActNodeDelExecute(Sender: TObject);
var
  Nodes: TNodeArray;
  Data: PMyRec;
  i: Integer;
  chNode: PVirtualNode;
  Nodelvl: Integer;
begin
  if (vst.SelectedCount = 0) then Exit;

  Nodes:= vst.GetSortedSelection(True);

  for i := 0 to Pred(System.Length(Nodes)) do
  begin
    if (vst.GetNodeLevel(Nodes[i]) = 0)
    then
      begin
        Data:= vst.GetNodeData(Nodes[i]);

        if Assigned(Data) then
        begin
          Data^.LastChangeType:= Data^.CurrentChangeType;
          Data^.CurrentChangeType:= tctDeleted;

          if (vsHasChildren in Nodes[i]^.States) then
          begin
            chNode:=  Nodes[i]^.FirstChild;

            while Assigned(chNode) do
            begin
              Data:= vst.GetNodeData(chNode);

              if Assigned(Data) then
              begin
                Data^.LastChangeType:= Data^.CurrentChangeType;
                Data^.CurrentChangeType:= tctDeleted;
                chNode:= chNode.NextSibling;
              end;
            end;
          end;
        end;
      end
    else
      begin
        Data:= vst.GetNodeData(Nodes[i]);
        if Assigned(Data) then
        begin
          Data^.LastChangeType:= Data^.CurrentChangeType;
          Data^.CurrentChangeType:= tctDeleted;
        end;
      end;
  end;

  vst.Refresh;

  chbHideDelNodeClick(Sender);
  ActChkStatusBtnExecute(Sender);
end;

procedure TfrmTblPriceTree.ActNodeEdtExecute(Sender: TObject);
var
  tmpCurr: Currency;
  fs: TFormatSettings;
  Data: PMyRec;
  NodeLvl: Integer;
begin
  if (vst.SelectedCount <> 1) then Exit;
  FNodeSender:= vst.GetFirstSelected;

  FActionNodeSender:= ansNodeEdit;

  Data:= vst.GetNodeData(NodeSender);
  if not Assigned(Data) then Exit;


  edtPriceName.Text:= Data^.ItemName;
  NodeLvl:= vst.GetNodeLevel(NodeSender);

  case NodeLvl of
    0:
      begin
        if (Data^.CurrentChangeType <> tctExisting)
          then edtCodeLiter.Text:= UpperCase(Data^.CodeLiter, loUserLocale);

        FInitPriceItemValue:= UpperCase(Format('%s~%s',[Data^.ItemName,Data^.CodeLiter]),loUserLocale);
      end;
    1:
      begin
        fs:= TFormatSettings.Create;
        edtPriceCost.Text:= Format('%2.2f',[Data^.CurrentCost]);
        FInitPriceItemValue:= UpperCase(Data^.ItemName, loUserLocale);
      end;
  end;

  actEdtNodeDataOnExecute(Sender);
end;

procedure TfrmTblPriceTree.actNodeExpandExecute(Sender: TObject);
var
  NodeLvl: Integer;
  Node: PVirtualNode;
begin
  if (vst.SelectedCount <> 1) then Exit;

  Node:= vst.GetFirstSelected;
  if not Assigned(Node) then Exit;
  NodeLvl:= vst.GetNodeLevel(Node);

  if (NodeLvl <> 0) then Node:= Node.Parent;
  vst.Expanded[Node]:= True;

  FIsTreeExpanded:= False;
end;

procedure TfrmTblPriceTree.ActNodeRestoreExecute(Sender: TObject);
var
  Nodes: TNodeArray;
  Data: PMyRec;
  i: Integer;
  chNode: PVirtualNode;
begin
  if (vst.SelectedCount = 0) then Exit;

  Nodes:= vst.GetSortedSelection(True);

  for i := 0 to Pred(System.Length(Nodes)) do
  begin
    if (vst.GetNodeLevel(Nodes[i]) = 0)
    then
      begin
        Data:= vst.GetNodeData(Nodes[i]);

        if Assigned(Data) then
        begin
          Data^.CurrentChangeType:= Data^.LastChangeType;

          if (vsHasChildren in Nodes[i]^.States) then
          begin
            chNode:=  Nodes[i]^.FirstChild;

            while Assigned(chNode) do
            begin
              Data:= vst.GetNodeData(chNode);

              if Assigned(Data) then
              begin
                Data^.CurrentChangeType:= Data^.LastChangeType;
                chNode:= chNode.NextSibling;
              end;
            end;
          end;
        end;
      end
    else
      begin
        //проверяем, не является ли узел root'ом
        if Assigned(Nodes[i].Parent) then
        begin
          Data:= vst.GetNodeData(Nodes[i].Parent);
          if Assigned(Data) then
            if (Data^.CurrentChangeType = tctDeleted)
              then Data^.CurrentChangeType:= Data^.LastChangeType;
        end;

        Data:= vst.GetNodeData(Nodes[i]);
        if Assigned(Data) then Data^.CurrentChangeType:= Data^.LastChangeType;
      end;
  end;

  vst.Refresh;
  chbHideDelNodeClick(Sender);

  if vst.CanFocus then vst.SetFocus;
  ActChkStatusBtnExecute(Sender);
end;

procedure TfrmTblPriceTree.actPriceCancelExecute(Sender: TObject);
begin
  Self.ModalResult:= mrCancel;
end;

procedure TfrmTblPriceTree.actPriceFillExecute(Sender: TObject);
var
  Node, ChdNode: PVirtualNode;
  Data: PMyRec;
begin
  if not mds_price_common.Active then Exit;
  if mds_price_common.IsEmpty then Exit;
  if not mds_laborissue.Active  then Exit;
  if not mds_baseprice.Active  then Exit;
  if (Trim(PriceName) = '') then Exit;

  try
    vst.BeginUpdate;
    vst.Clear;

    mds_laborissue.First;

    while not mds_laborissue.Eof do
    begin
      mds_price_common.Filtered:= False;
      mds_price_common.Filter:= Format('(UPPER(NAME_PRICE) LIKE UPPER(''%%%s%%'')) AND (LABORISSUE_ID=%d)',
                                    [PriceName,mds_laborissue.FieldByName('LABORISSUE_ID').AsInteger]);
      mds_price_common.Filtered:= True;

      if not mds_price_common.IsEmpty then
      begin
        mds_price_common.First;

        Node:= vst.AddChild(nil);
        Data:= vst.GetNodeData(Node);
        FTreeChangeType:= tctExisting;

        if Assigned(Data) then
        begin
          Data^.PriceID:= 0;
          Data^.DepartID:= 0;
          Data^.CurrentChangeType:= TreeChangeType;
          Data^.LastChangeType:= TreeChangeType;
          Data^.ExistStatus:= TreeChangeType;
          Data^.ItemName:= mds_price_common.FieldByName('LABORISSUE_NAME').AsString;
          Data^.CurrentCost:= 0;
          Data^.InitCost:= 0;
          Data^.CodeLiter:= mds_price_common.FieldByName('LABORISSUE_CODELITER').AsString;

          while not mds_price_common.Eof do
          begin
            ChdNode:= vst.AddChild(Node);
            Data:= vst.GetNodeData(ChdNode);

            if Assigned(Data) then
            begin
              Data^.PriceID:= 0;
              Data^.DepartID:= 0;
              Data^.CurrentChangeType:= TreeChangeType;
              Data^.LastChangeType:= TreeChangeType;
              Data^.ExistStatus:= TreeChangeType;
              Data^.ItemName:= mds_price_common.FieldByName('BASEPRICE_PROC_NAME').AsString;
              Data^.CurrentCost:= mds_price_common.FieldByName('COST_PROC_PRICE').AsCurrency;
              Data^.InitCost:= mds_price_common.FieldByName('COST_PROC_PRICE').AsCurrency;
              Data^.CodeLiter:= '';
            end;

            mds_price_common.Next;
          end;
        end;
      end;

      mds_laborissue.Next;
    end;
  finally
    mds_price_common.Filtered:= False;
    vst.EndUpdate;
  end;
end;

procedure TfrmTblPriceTree.actPriceSaveExecute(Sender: TObject);
var
  rNode, chNode: PVirtualNode;
  Data: PMyRec;
  laborissue_id, baseprice_id: Integer;
begin
  if (vst.RootNodeCount = 0) then Exit;

  rNode:= nil;
  chNode:= nil;
  laborissue_id:= -1;
  baseprice_id:= -1;

  if (EditMode = emAdd) then
    if (Trim(edtSetPriceName.Text) = '') then
    begin
      Application.MessageBox('Задайте имя прайс-листа!','Некорректные данные',MB_ICONINFORMATION);
      if edtSetPriceName.CanFocus then edtSetPriceName.SetFocus;
      Exit;
    end;

  if (EditMode = emAdd) then
  begin
    if mds_price_only.Locate('NAME_PRICE', Trim(edtSetPriceName.Text),[loCaseInsensitive]) then
    begin
      Application.MessageBox('Такое имя прайс-листа уже есть в базе данных. Задайте другое!','Некорректные данные',MB_ICONINFORMATION);
      if edtSetPriceName.CanFocus then edtSetPriceName.SetFocus;
      Exit;
    end;

    PriceName:= Trim(edtSetPriceName.Text);
  end;

  //добалвяем вновь внесенные записи в таблички laborissue и baseprice
  try
    tmpTrans.StartTransaction;
    qryLaborissue.Close;
    qryLaborissue.SQL.Text:= SQLTextLaborIssueInsert;
    qryLaborissue.Prepare;

    qryBaseprice.Close;
    qryBaseprice.SQL.Text:= SQLTextBasepriceInsert;
    qryBaseprice.Prepare;

    rNode:= vst.GetFirst;

    while Assigned(rNode) do
    begin
      Data:= vst.GetNodeData(rNode);
      if Assigned(Data) then
      begin
        if mds_laborissue.Locate('LABORISSUE_NAME', Data^.ItemName,[loCaseInsensitive])
        then
          laborissue_id:= mds_laborissue.FieldByName('LABORISSUE_ID').AsInteger
        else
          begin
            qryLaborissue.ParamByName('LABORISSUE_NAME').Value:= Data^.ItemName;
            qryLaborissue.ParamByName('LABORISSUE_CODELITER').Value:= Data^.CodeLiter;
            qryLaborissue.ExecQuery;
            laborissue_id:= qryLaborissue.FieldByName('LABORISSUE_ID').AsInteger;
          end;

        Data^.PriceID:= laborissue_id;
        Data^.DepartID:= 0;
      end;

      if (vsHasChildren in rNode.States) then
      begin
        chNode:= rNode^.FirstChild;

        while Assigned(chNode) do
        begin
          Data:= vst.GetNodeData(chNode);

          if Assigned(Data) then
          begin
            if mds_baseprice.Locate('BASEPRICE_PROC_NAME',Data^.ItemName,[loCaseInsensitive])
            then
              baseprice_id:= mds_baseprice.FieldByName('BASEPRICE_ID').AsInteger
            else
              begin
                qryBaseprice.ParamByName('BASEPRICE_PROC_NAME').Value:= Data^.ItemName;
                qryBaseprice.ParamByName('BASEPRICE_PROC_ISSUE_FK').Value:= laborissue_id;
                qryBaseprice.ExecQuery;
                baseprice_id:= qryBaseprice.FieldByName('BASEPRICE_ID').AsInteger;
              end;
            Data^.PriceID:= baseprice_id;
            Data^.DepartID:= laborissue_id;
          end;

          chNode:= chNode.NextSibling;
        end;
      end;

      rNode:= rNode.NextSibling;
    end;

    //создаем новые/обновляем имеющиеся записи в tbl_price
    qryPriceItemInsert.Close;
    qryPriceItemInsert.SQL.Text:= SQLTextPriceItemInsert;
    qryPriceItemInsert.Prepare;

    qryPriceItemUpdate.Close;
    qryPriceItemUpdate.SQL.Text:= SQLTextPriceItemUpdate;
    qryPriceItemUpdate.Prepare;

    qryPriceItemDelete.Close;
    qryPriceItemDelete.SQL.Text:= SQLTextPriceItemDelete;
    qryPriceItemDelete.Prepare;

    rNode:= vst.GetFirst;

    case EditMode of
      emAdd:
        begin
          while Assigned(rNode) do
          begin
            Data:= vst.GetNodeData(rNode);
            if Assigned(Data) then
              if (Data^.CurrentChangeType <> tctDeleted) then
                if (vsHasChildren in rNode.States) then
                begin
                  chNode:= rNode^.FirstChild;

                  while Assigned(chNode) do
                  begin
                    Data:= vst.GetNodeData(chNode);

                    if Assigned(Data) then
                      if (Data^.CurrentChangeType <> tctDeleted) then
                      begin
                        qryPriceItemInsert.ParamByName('FK_BASEPRICE').Value:= Data^.PriceID;
                        qryPriceItemInsert.ParamByName('NAME_PRICE').Value:= PriceName;
                        qryPriceItemInsert.ParamByName('COST_PROC_PRICE').Value:= Data^.CurrentCost;
                        qryPriceItemInsert.ExecQuery;
                      end;

                    chNode:= chNode.NextSibling;
                  end;
                end;
            rNode:= rNode.NextSibling;
          end;
        end;
      emEdit:
        begin
          while Assigned(rNode) do
          begin
            if (vsHasChildren in rNode.States) then
            begin
              chNode:= rNode^.FirstChild;

              while Assigned(chNode) do
              begin
                Data:= vst.GetNodeData(chNode);

                if Assigned(Data) then
                  case Data^.CurrentChangeType of
                    tctInserted:
                          begin
                            qryPriceItemInsert.ParamByName('FK_BASEPRICE').Value:= Data^.PriceID;
                            qryPriceItemInsert.ParamByName('NAME_PRICE').Value:= PriceName;
                            qryPriceItemInsert.ParamByName('COST_PROC_PRICE').Value:= Data^.CurrentCost;
                            qryPriceItemInsert.ExecQuery;
                          end;
                     tctUpdated:
                          case Data^.ExistStatus of
                                 tctNew:
                                    begin
                                      qryPriceItemInsert.ParamByName('FK_BASEPRICE').Value:= Data^.PriceID;
                                      qryPriceItemInsert.ParamByName('NAME_PRICE').Value:= PriceName;
                                      qryPriceItemInsert.ParamByName('COST_PROC_PRICE').Value:= Data^.CurrentCost;
                                      qryPriceItemInsert.ExecQuery;
                                    end;
                            tctExisting:
                                    begin
                                      qryPriceItemUpdate.ParamByName('COST_PROC_PRICE').Value:= Data^.CurrentCost;
                                      qryPriceItemUpdate.ParamByName('FK_BASEPRICE').Value:= Data^.PriceID;
                                      qryPriceItemUpdate.ParamByName('NAME_PRICE').Value:= PriceName;
                                      qryPriceItemUpdate.ExecQuery;
                                    end;
                          end;
                     tctDeleted:
                          begin
                            qryPriceItemDelete.ParamByName('FK_BASEPRICE').Value:= Data^.PriceID;
                            qryPriceItemDelete.ParamByName('NAME_PRICE').Value:= PriceName;
                            qryPriceItemDelete.ExecQuery;
                          end;
                  end;
                chNode:= chNode.NextSibling;
              end;
            end;
            rNode:= rNode.NextSibling;
          end;
        end;
    end;

    tmpTrans.Commit;
  except
    on E: EFIBError do
    begin
      tmpTrans.Rollback;
      Application.MessageBox(PChar(DMFIB.GetFIBExceptStr(E)), 'Ошибка модификации данных', MB_ICONERROR);
      Exit;
    end;
  end;

  Self.ModalResult:= mrOk;
end;

procedure TfrmTblPriceTree.ActRootAddExecute(Sender: TObject);
var
  NodeLvl: Integer;
begin
  edtPriceName.Clear;
  edtCodeLiter.Clear;
  edtPriceCost.Text:= '0';

  FActionNodeSender:= ansNodeRoot;

  if (vst.SelectedCount > 0)
    then FNodeSender:= vst.GetFirstSelected
    else FNodeSender:= nil;

  actEdtNodeDataOnExecute(Sender);

  if edtPriceName.CanFocus then edtPriceName.SetFocus;
end;

procedure TfrmTblPriceTree.chbHideDelNodeClick(Sender: TObject);
var
  rNode, chNode, lsNode: PVirtualNode;
  Data: PMyRec;
begin
  if (vst.RootNodeCount = 0) then Exit;

  try
    vst.BeginUpdate;

    if (vst.SelectedCount > 0)
      then lsNode:= vst.GetFirstSelected
      else lsNode:= vst.GetFirst;

    rNode:= vst.GetFirst;

    while Assigned(rNode) do
    begin
      Data:= vst.GetNodeData(rNode);
      if Assigned(Data) then
      begin
        if (Data^.CurrentChangeType = tctDeleted)
        then
          vst.IsVisible[rNode]:= not chbHideDelNode.Checked
        else
          begin
            if (rNode^.ChildCount > 0) then
            begin
              chNode:= rNode^.FirstChild;

              while Assigned(chNode) do
              begin
                Data:= vst.GetNodeData(chNode);

                if Assigned(Data) then
                  if (Data^.CurrentChangeType = tctDeleted) then vst.IsVisible[chNode]:= not chbHideDelNode.Checked;
                chNode:= chNode.NextSibling;
              end;
            end;
          end;
      end;

      rNode:= rNode.NextSibling;
    end;
    vst.Refresh;
    if vst.CanFocus then vst.SetFocus;

    if Assigned(vst.TopNode) then //visible node count > 0
      if (chbHideDelNode.Checked and not (vsVisible in lsNode.States)) then
      begin
        vst.ClearSelection;

        if (vsHasChildren in lsNode.States)
          then lsNode:= vst.GetFirstVisible(nil,True,False)
          else lsNode:= vst.GetFirstVisible(lsNode.Parent,True,False);

        vst.Selected[lsNode]:= True;
      end;

   ActChkStatusBtnExecute(Sender);
  finally
    vst.EndUpdate;
  end;
end;

procedure TfrmTblPriceTree.chbSetZeroCostClick(Sender: TObject);
var
  rNode, chNode: PVirtualNode;
  Data: PMyRec;
begin
  if (vst.TotalCount = 0) then Exit;
  if (EditMode = emEdit) then Exit;

  rNode:= vst.GetFirst;

  while Assigned(rNode) do
  begin
    if (vsHasChildren in rNode^.States) then
    begin
      chNode:= vst.GetFirstChild(rNode);

      while Assigned(chNode) do
      begin
        Data:= vst.GetNodeData(chNode);

        if Assigned(Data) then
        begin
          if chbSetZeroCost.Checked
            then Data^.CurrentCost:= 0
            else Data^.CurrentCost:= Data^.InitCost;
        end;
        chNode:= chNode.NextSibling;
      end;
    end;
    rNode:= rNode.NextSibling;
  end;

  vst.Refresh;
end;

procedure TfrmTblPriceTree.chbShowUpdatedPriceClick(Sender: TObject);
begin
  vst.Refresh;
end;

procedure TfrmTblPriceTree.edtCodeLiterKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key,['A'..'Z','a'..'z']) then Key:= #0;
end;

procedure TfrmTblPriceTree.edtPriceCostKeyPress(Sender: TObject; var Key: Char);
var
  fs: TFormatSettings;
begin
  fs:= TFormatSettings.Create;
  if not CharInSet(Key,['0'..'9','-',fs.DecimalSeparator]) then Key:= #0;
end;

procedure TfrmTblPriceTree.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Settings.SenderObject:= sofrmTblPriceTree;
  FKeybrdLayoutNum:= GetLastUsedKeyLayout;
  Settings.KeybrdLayoutNum:= Self.KeybrdLayoutNum;
  Settings.chb_HighLightNodePriceTree:= chbShowUpdatedPrice.Checked;
  Settings.chb_HideDelNodePriceTree:= chbHideDelNode.Checked;
  Settings.IsTreeExpanded_PriceTree:= Self.IsTreeExpanded;
  Settings.Save(Self);
end;

procedure TfrmTblPriceTree.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  with Self do
  begin
    ModalResult:= mrCancel;
    ShowHint:= True;
    EditMode:= emAdd;
  end;

  edtSetPriceName.MaxLength:= 40;
  edtCodeLiter.MaxLength:= 5;
  edtPriceName.MaxLength:= 100;

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

    OnAddToSelection:= vstAddToSelection;
    OnCollapsed:= vstCollapsed;
    OnDragDrop:= vstDragDrop;
    OnDragOver:= vstDragOver;
    OnEditing:= vstEditing;
    OnExpanded:= vstExpanded;
    OnFreeNode:= vstFreeNode;
    OnGetNodeDataSize:= vstGetNodeDataSize;
    OnGetText:= vstGetText;
    OnHeaderDraw:= vstHeaderDraw;
    OnPaintText:= vstPaintText;
    OnRemoveFromSelection:= vstRemoveFromSelection;

    PopupMenu:= ppmVST;


    //header properties
    with Header do
    begin
      Columns.Clear;
      Columns.Add;
      Columns[0].Text:= 'Название';

      Columns.Add;
      Columns[1].Text:= 'Стоимость';

      AutoSizeIndex:= 0;
      Height:= 30;
      Options:= Options + [hoAutoResize, hoOwnerDraw, hoShowHint
                          , hoShowImages,hoVisible, hoAutoSpring];

      for i := 0 to Pred(Columns.Count) do
      begin
        Columns.Items[i].Style:= vsOwnerDraw;
        Columns.Items[i].CaptionAlignment:= taCenter;
        if (Columns.Items[i].Position = 1) then Columns.Items[i].Width:= 100;
      end;
    end;
  end;

  btnSave.Hint:= ShortCutSave;
  btnCancel.Hint:= ShortCutCancel;

  actHlp.ShortCut:= TextToShortCut(ShortCutHelp);
  btnHelp.OnClick:= actHlpExecute;
  btnHelp.Hint:= ShortCutHelp;

  ActRootAdd.ShortCut:= TextToShortCut(ShortCutImgBtn_1);
  btnRootAdd.OnClick:= ActRootAddExecute;
  btnRootAdd.Hint:= ShortCutImgBtn_1;

  ActChildAdd.ShortCut:= TextToShortCut(ShortCutImgBtn_2);
  btnChildAdd.OnClick:= ActChildAddExecute;
  btnChildAdd.Hint:= ShortCutImgBtn_2;

  ActNodeEdt.ShortCut:= TextToShortCut(ShortCutImgBtn_3);
  btnNodeEdt.OnClick:= ActNodeEdtExecute;
  btnNodeEdt.Hint:= ShortCutImgBtn_3;

  ActNodeDel.ShortCut:= TextToShortCut(ShortCutImgBtn_4);
  btnNodeDel.OnClick:= ActNodeDelExecute;
  btnNodeDel.Hint:= ShortCutImgBtn_4;

  ActNodeRestore.ShortCut:= TextToShortCut(ShortCutImgBtn_5);
  btnNodeRestore.OnClick:= ActNodeRestoreExecute;
  btnNodeRestore.Hint:= ShortCutImgBtn_5;

  ActItemSelect.ShortCut:= TextToShortCut(ShortCutImgBtn_6);
  btnItemSelect.OnClick:= ActItemSelectExecute;
  btnItemSelect.Hint:= ShortCutImgBtn_6;

  with mds_baseprice do
  begin
    FieldDefs.Add('BASEPRICE_ID', ftInteger);
    FieldDefs.Add('BASEPRICE_PROC_CODE', ftString, 20);
    FieldDefs.Add('BASEPRICE_PROC_NAME', ftString, 100);
    FieldDefs.Add('BASEPRICE_PROC_ISSUE_FK', ftInteger);

    CreateDataSet;
    Filtered:= False;
    Active := False;
  end;

  with mds_price_only do
  begin
    FieldDefs.Add('ID_PRICE', ftInteger);
    FieldDefs.Add('NAME_PRICE', ftString, 40);

    CreateDataSet;
    Filtered:= False;
    Active := False;
  end;

  with mds_price_common do
  begin
    FieldDefs.Add('BASEPRICE_ID', ftInteger);
    FieldDefs.Add('BASEPRICE_PROC_NAME', ftString, 100);
    FieldDefs.Add('COST_PROC_PRICE', ftCurrency);
    FieldDefs.Add('LABORISSUE_ID', ftInteger);
    FieldDefs.Add('LABORISSUE_NAME', ftString, 100);
    FieldDefs.Add('LABORISSUE_CODELITER', ftString, 5);
    FieldDefs.Add('NAME_PRICE', ftString,40);

    CreateDataSet;
    Filtered:= False;
    Active := False;
  end;

  with mds_laborissue do
  begin
    FieldDefs.Add('LABORISSUE_ID', ftInteger);
    FieldDefs.Add('LABORISSUE_NAME', ftString, 100);
    FieldDefs.Add('LABORISSUE_CODELITER', ftString, 5);

    CreateDataSet;
    Filtered:= False;
    Active := False;
  end;

  for i := 0 to Pred(Self.ControlCount) do
    if Self.Controls[i].InheritsFrom(TPanel) then
    begin
      TPanel(Self.Controls[i]).ShowCaption:= False;
      TPanel(Self.Controls[i]).BevelOuter:= bvNone;
    end;

  for i := 0 to Pred(pnlNodesEdit.ControlCount) do
    if pnlNodesEdit.Controls[i].InheritsFrom(TPanel) then
    begin
      TPanel(pnlNodesEdit.Controls[i]).ShowCaption:= False;
      TPanel(pnlNodesEdit.Controls[i]).BevelOuter:= bvNone;
    end;

  for i := 0 to Pred(pnlMain.ControlCount) do
    if pnlMain.Controls[i].InheritsFrom(TPanel) then
    begin
      TPanel(pnlMain.Controls[i]).ShowCaption:= False;
      TPanel(pnlMain.Controls[i]).BevelOuter:= bvNone;
    end;

  for i := 0 to Pred(pnlTree.ControlCount) do
    if pnlTree.Controls[i].InheritsFrom(TPanel) then
    begin
      TPanel(pnlTree.Controls[i]).ShowCaption:= False;
      TPanel(pnlTree.Controls[i]).BevelOuter:= bvNone;
    end;

  for i := 0 to Pred(pnlNodesEdit.ControlCount) do
    if pnlNodesEdit.Controls[i].InheritsFrom(TPanel) then
    begin
      TPanel(pnlNodesEdit.Controls[i]).ShowCaption:= False;
      TPanel(pnlNodesEdit.Controls[i]).BevelOuter:= bvNone;
    end;
end;

procedure TfrmTblPriceTree.FormShow(Sender: TObject);
begin
  Settings.SenderObject:= sofrmTblPriceTree;
  Settings.Load(Self);
  FKeybrdLayoutNum:= Settings.KeybrdLayoutNum;
  SetLastUsedKeyLayout(KeybrdLayoutNum);
  chbShowUpdatedPrice.Checked:= Settings.chb_HighLightNodePriceTree;
  chbHideDelNode.Checked:= Settings.chb_HideDelNodePriceTree;
  FIsTreeExpanded:= Settings.IsTreeExpanded_PriceTree;


  chbSetZeroCost.Enabled:= (EditMode = emAdd);
  pnlSetPriceName.Align:= alNone;
  pnlSetPriceName.Align:= alTop;
  pnlSetPriceName.Visible:= (EditMode = emAdd);
  edtSetPriceName.Clear;

  actEdtNodeDataOffExecute(Sender);

  if (vst.RootNodeCount > 0) then
    if IsTreeExpanded
      then vst.FullExpand(nil)
      else vst.FullCollapse(nil);
end;

procedure TfrmTblPriceTree.vstAddToSelection(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  ActChkStatusBtnExecute(Sender);
  ActChkStatusMnuVSTExecute(Sender);
end;

procedure TfrmTblPriceTree.vstCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  ActChkStatusMnuVSTExecute(Sender);
end;

procedure TfrmTblPriceTree.vstDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject;
  Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  NodeLvl: Integer;
  NodeTarget: PVirtualNode;//принимающий узел
  Nodes: TNodeArray;//перемещаемые узлы
  attMode: TVTNodeAttachMode;
  DataTarget: PMyRec;
  DataSource: PMyRec;
  i: Integer;
begin
  DataTarget:= nil;
  DataSource:= nil;
  attMode:= amNoWhere;

  NodeTarget := Sender.DropTargetNode;
  Nodes:= TVirtualStringTree(Source).GetSortedSelection(True);
  if (System.Length(Nodes) = 0) then Exit;

  //позволяем перемещать только свежедобавленные узлы
  for i := 0 to Pred(System.Length(Nodes)) do
  begin
    DataSource:= TVirtualStringTree(Source).GetNodeData(Nodes[i]);
    if Assigned(DataSource) then
      if (DataSource.ExistStatus = tctExisting) then
      begin
        Application.MessageBox(PChar(msgAllowMovingNonExistNode),'Ошибка работы с данными', MB_ICONINFORMATION);
        Exit;
      end;
  end;

  case Mode of
    dmNowhere: attMode := amNoWhere;
    dmAbove:
      begin
        DataTarget:=Sender.GetNodeData(NodeTarget);
        NodeLvl:= Sender.GetNodeLevel(NodeTarget);

        case NodeLvl of
          0: attMode := amAddChildFirst;
          1: attMode := amInsertBefore;
        end;
      end;
    dmOnNode:
      begin
        DataTarget:=Sender.GetNodeData(NodeTarget);
        NodeLvl:= Sender.GetNodeLevel(NodeTarget);

        case NodeLvl of
          0: attMode := amAddChildFirst;
          1: attMode := amInsertAfter;
        end;
      end;
     dmBelow:
     begin
        DataTarget:=Sender.GetNodeData(NodeTarget);
        NodeLvl:= Sender.GetNodeLevel(NodeTarget);

        case NodeLvl of
          0: attMode := amAddChildFirst;
          1: attMode := amInsertAfter;
        end;
     end;
  end;

  NodeLvl:= Sender.GetNodeLevel(NodeTarget);

  case NodeLvl of
    0: DataTarget:= Sender.GetNodeData(NodeTarget);
    1: DataTarget:= Sender.GetNodeData(NodeTarget.Parent);
  end;

  //меняем родителя вновь перемещенным узлам
  for i := 0 to Pred(System.Length(Nodes)) do
    begin
      Sender.MoveTo(Nodes[i], NodeTarget, attMode, False);
      DataSource:= TVirtualStringTree(Source).GetNodeData(Nodes[i]);
    end;
end;

procedure TfrmTblPriceTree.vstDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState;
  Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
var
  Nodes: TNodeArray;
  NodeLvl: Integer;
  i: Integer;
  Data: PMyRec;
  drgNode,tgtNode: PVirtualNode;
begin
  if (Sender <> Source) then Exit;//если бросаем в пределах того же родителя

  tgtNode:= Sender.DropTargetNode;//узел, над или около которого мы находимся
  drgNode:= TBaseVirtualTree(Source).GetFirstSelected;//первый выделенный перемещаемый узел

  if (Assigned(tgtNode) and Assigned(drgNode)) then
  begin
    if ((drgNode.Parent = tgtNode.Parent) or (drgNode.Parent = tgtNode)) then Exit;
  end;

  Nodes:= Sender.GetSortedSelection(True);
  Accept:= True;

  for i := 0 to Pred(System.Length(Nodes)) do
  begin
    NodeLvl:= Sender.GetNodeLevel(Nodes[i]);
    if (NodeLvl = 0) then //если пытаемся переместить root-узел
    begin
      Accept:= False;
      Exit;
    end;
  end;
end;

procedure TfrmTblPriceTree.vstEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  var Allowed: Boolean);
var
  Data: PMyRec;
  NodeLvl: Integer;
begin
  //запрещаем редактировать вручную 2-ю колонку root-узла
  Allowed:= False;
  NodeLvl:= Sender.GetNodeLevel(Node);
  Data:= Sender.GetNodeData(Node);

  if not Assigned(Data) then Exit;
  Allowed:= not ((Column = 1) and (NodeLvl = 0));
end;

procedure TfrmTblPriceTree.vstExpanded(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  ActChkStatusMnuVSTExecute(Sender);
end;

procedure TfrmTblPriceTree.vstFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PMyRec;
begin
  Data:= Sender.GetNodeData(Node);

  if Assigned(Data) then Finalize(Data^);
end;

procedure TfrmTblPriceTree.vstGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize:= SizeOf(TMyRec);
end;

procedure TfrmTblPriceTree.vstGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  NodeLvl: Integer;
  Data: PMyRec;
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
        1: CellText:= Format('%2.2f %s',[Data^.CurrentCost, fs.CurrencyString]);
      end;
  end;
end;

procedure TfrmTblPriceTree.vstHeaderDraw(Sender: TVTHeader; HeaderCanvas: TCanvas; Column: TVirtualTreeColumn; R: TRect;
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

procedure TfrmTblPriceTree.vstPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType);
var
  Data: PMyRec;
begin
  Data:= Sender.GetNodeData(Node);

  if Assigned(Data) then
  begin
    if (Data^.CurrentChangeType = tctDeleted) then
    begin
      TargetCanvas.Font.Style:= TargetCanvas.Font.Style + [TFontStyle.fsStrikeOut];
      TargetCanvas.Font.Color:= clGrayText;
    end;

    if chbShowUpdatedPrice.Checked then
      if (Data^.CurrentCost <> Data^.InitCost) then
        TargetCanvas.Font.Style:= TargetCanvas.Font.Style + [TFontStyle.fsBold];
  end;
end;

procedure TfrmTblPriceTree.vstRemoveFromSelection(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  ActChkStatusBtnExecute(Sender);
end;

end.
