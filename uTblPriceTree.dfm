object frmTblPriceTree: TfrmTblPriceTree
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'frmTblPriceTree'
  ClientHeight = 437
  ClientWidth = 608
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pnlBtn: TPanel
    Left = 0
    Top = 399
    Width = 608
    Height = 38
    Align = alBottom
    Caption = 'pnlBtn'
    TabOrder = 2
    DesignSize = (
      608
      38)
    object btnCancel: TButton
      Left = 521
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
    end
    object btnSave: TButton
      Left = 440
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
    end
    object btnHelp: TButton
      Left = 7
      Top = 6
      Width = 75
      Height = 25
      Caption = #1055#1086#1084#1086#1097#1100
      TabOrder = 2
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 65
    Width = 608
    Height = 334
    Align = alClient
    Caption = 'pnlMain'
    TabOrder = 0
    object pnlOptions: TPanel
      Left = 1
      Top = 1
      Width = 606
      Height = 80
      Align = alTop
      Caption = 'pnlOptions'
      ShowCaption = False
      TabOrder = 2
      object chbSetZeroCost: TCheckBox
        Left = 8
        Top = 5
        Width = 233
        Height = 17
        Caption = '"'#1054#1073#1085#1091#1083#1080#1090#1100'" '#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1074#1089#1077#1093' '#1091#1089#1083#1091#1075
        TabOrder = 0
        OnClick = chbSetZeroCostClick
      end
      object chbShowUpdatedPrice: TCheckBox
        Left = 8
        Top = 28
        Width = 297
        Height = 17
        Caption = #1055#1086#1076#1089#1074#1077#1095#1080#1074#1072#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1085#1099#1077' '#1088#1072#1079#1076#1077#1083#1099' '#1080' '#1091#1089#1083#1091#1075#1080
        TabOrder = 1
        OnClick = chbShowUpdatedPriceClick
      end
      object chbHideDelNode: TCheckBox
        Left = 8
        Top = 51
        Width = 297
        Height = 17
        Caption = #1057#1082#1088#1099#1074#1072#1090#1100' '#1091#1076#1072#1083#1077#1085#1085#1099#1077' '#1088#1072#1079#1076#1077#1083#1099' '#1080' '#1091#1089#1083#1091#1075#1080
        TabOrder = 2
        OnClick = chbHideDelNodeClick
      end
    end
    object pnlSetPriceName: TPanel
      Left = 1
      Top = 81
      Width = 606
      Height = 60
      Align = alTop
      Caption = 'pnlSetPriceName'
      TabOrder = 1
      DesignSize = (
        606
        60)
      object Label4: TLabel
        Left = 8
        Top = 6
        Width = 166
        Height = 15
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1085#1086#1074#1086#1075#1086' '#1087#1088#1072#1081#1089'-'#1083#1080#1089#1090#1072
      end
      object edtSetPriceName: TEdit
        Left = 8
        Top = 27
        Width = 587
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 'edtSetPriceName'
      end
    end
    object pnlTree: TPanel
      Left = 1
      Top = 141
      Width = 606
      Height = 192
      Align = alClient
      Caption = 'pnlTree'
      TabOrder = 0
      object pnlTreeTree: TPanel
        Left = 1
        Top = 1
        Width = 419
        Height = 190
        Align = alClient
        Caption = 'pnlTreeTree'
        TabOrder = 1
        DesignSize = (
          419
          190)
        object vst: TVirtualStringTree
          Left = 7
          Top = 5
          Width = 402
          Height = 165
          Anchors = [akLeft, akTop, akRight, akBottom]
          Header.AutoSizeIndex = 0
          Header.MainColumn = -1
          TabOrder = 0
          Touch.InteractiveGestures = [igPan, igPressAndTap]
          Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
          Columns = <>
        end
      end
      object pnlTreeBtn: TPanel
        Left = 420
        Top = 1
        Width = 185
        Height = 190
        Align = alRight
        Caption = 'pnlTreeBtn'
        ShowCaption = False
        TabOrder = 0
        DesignSize = (
          185
          190)
        object btnRootAdd: TButton
          Left = 6
          Top = 5
          Width = 173
          Height = 25
          Anchors = [akTop, akRight]
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1088#1072#1079#1076#1077#1083
          TabOrder = 0
        end
        object btnChildAdd: TButton
          Left = 6
          Top = 36
          Width = 173
          Height = 25
          Anchors = [akTop, akRight]
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1091#1089#1083#1091#1075#1091
          TabOrder = 1
        end
        object btnNodeEdt: TButton
          Left = 6
          Top = 67
          Width = 173
          Height = 25
          Anchors = [akTop, akRight]
          Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1088#1072#1079#1076#1077#1083'/'#1091#1089#1083#1091#1075#1091
          TabOrder = 2
        end
        object btnNodeDel: TButton
          Left = 6
          Top = 98
          Width = 173
          Height = 25
          Anchors = [akTop, akRight]
          Caption = #1059#1076#1072#1083#1080#1090#1100' '#1088#1072#1079#1076#1077#1083'/'#1091#1089#1083#1091#1075#1091
          TabOrder = 3
        end
        object btnNodeRestore: TButton
          Left = 6
          Top = 129
          Width = 173
          Height = 25
          Anchors = [akTop, akRight]
          Caption = #1042#1077#1088#1085#1091#1090#1100' '#1088#1072#1079#1076#1077#1083'/'#1091#1089#1083#1091#1075#1091
          TabOrder = 4
        end
      end
    end
  end
  object pnlNodesEdit: TPanel
    Left = 0
    Top = 0
    Width = 608
    Height = 65
    Align = alTop
    Caption = 'pnlNodesEdit'
    ShowCaption = False
    TabOrder = 1
    object pnlPriceNameEdt: TPanel
      Left = 1
      Top = 1
      Width = 347
      Height = 63
      Align = alClient
      Caption = 'pnlPriceNameEdt'
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        347
        63)
      object Label1: TLabel
        Left = 8
        Top = 10
        Width = 52
        Height = 15
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      end
      object edtPriceName: TEdit
        Left = 8
        Top = 31
        Width = 329
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 'edtPriceName'
      end
    end
    object pnlItemSelect: TPanel
      Left = 571
      Top = 1
      Width = 36
      Height = 63
      Align = alRight
      Caption = 'pnlItemSelect'
      ShowCaption = False
      TabOrder = 3
      object btnItemSelect: TButton
        Left = 3
        Top = 31
        Width = 23
        Height = 23
        Caption = '...'
        TabOrder = 0
      end
    end
    object pnlEdtCost: TPanel
      Left = 428
      Top = 1
      Width = 143
      Height = 63
      Align = alRight
      Caption = 'pnlEdtCost'
      ShowCaption = False
      TabOrder = 1
      object Label3: TLabel
        Left = 6
        Top = 10
        Width = 60
        Height = 15
        Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
      end
      object edtPriceCost: TEdit
        Left = 6
        Top = 31
        Width = 121
        Height = 23
        TabOrder = 0
        Text = '0'
        OnKeyPress = edtPriceCostKeyPress
      end
      object udPriceCost: TUpDown
        Left = 127
        Top = 31
        Width = 16
        Height = 23
        Associate = edtPriceCost
        DoubleBuffered = True
        Max = 100000000
        Increment = 50
        ParentDoubleBuffered = False
        TabOrder = 1
        Thousands = False
      end
    end
    object pnlEdtCodeLiter: TPanel
      Left = 348
      Top = 1
      Width = 80
      Height = 63
      Align = alRight
      Caption = 'pnlEdtCodeLiter'
      ShowCaption = False
      TabOrder = 2
      DesignSize = (
        80
        63)
      object Label2: TLabel
        Left = 6
        Top = 10
        Width = 64
        Height = 15
        Caption = #1050#1086#1076' '#1083#1080#1090#1077#1088#1099
      end
      object edtCodeLiter: TEdit
        Left = 6
        Top = 31
        Width = 68
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 'edtCodeLiter'
        OnKeyPress = edtCodeLiterKeyPress
      end
    end
  end
  object actList: TActionList
    Left = 18
    Top = 213
    object ActRootAdd: TAction
      Category = 'node'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1088#1072#1079#1076#1077#1083
      OnExecute = ActRootAddExecute
    end
    object ActChildAdd: TAction
      Category = 'node'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1091#1089#1083#1091#1075#1091
      OnExecute = ActChildAddExecute
    end
    object ActNodeEdt: TAction
      Category = 'node'
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1088#1072#1079#1076#1077#1083'/'#1091#1089#1083#1091#1075#1091
      OnExecute = ActNodeEdtExecute
    end
    object ActNodeDel: TAction
      Category = 'node'
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1088#1072#1079#1076#1077#1083'/'#1091#1089#1083#1091#1075#1091
      OnExecute = ActNodeDelExecute
    end
    object ActNodeDataSave: TAction
      Category = 'node'
      Caption = 'ActNodeDataSave'
      OnExecute = ActNodeDataSaveExecute
    end
    object ActNodeDataCancel: TAction
      Category = 'node'
      Caption = 'ActNodeDataCancel'
      OnExecute = ActNodeDataCancelExecute
    end
    object ActNodeRestore: TAction
      Category = 'node'
      Caption = #1042#1077#1088#1085#1091#1090#1100' '#1088#1072#1079#1076#1077#1083'/'#1091#1089#1083#1091#1075#1091
      OnExecute = ActNodeRestoreExecute
    end
    object ActItemSelect: TAction
      Category = 'node'
      Caption = 'ActItemSelect'
      OnExecute = ActItemSelectExecute
      OnUpdate = ActItemSelectUpdate
    end
    object actAllExpand: TAction
      Category = 'ppmVST'
      Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077' '#1088#1072#1079#1076#1077#1083#1099
      OnExecute = actAllExpandExecute
    end
    object actAllCollaps: TAction
      Category = 'ppmVST'
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077' '#1088#1072#1079#1076#1077#1083#1099
      OnExecute = actAllCollapsExecute
    end
    object actNodeCollaps: TAction
      Category = 'ppmVST'
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1088#1072#1079#1076#1077#1083
      OnExecute = actNodeCollapsExecute
    end
    object actNodeExpand: TAction
      Category = 'ppmVST'
      Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1088#1072#1079#1076#1077#1083
      OnExecute = actNodeExpandExecute
    end
    object ActChkStatusMnuVST: TAction
      Category = 'ppmVST'
      Caption = 'ActChkStatusMnuVST'
      OnExecute = ActChkStatusMnuVSTExecute
    end
    object actChkStatusBtn: TAction
      Category = 'common'
      Caption = 'actChkStatusBtn'
      OnExecute = actChkStatusBtnExecute
    end
    object actEdtNodeDataOn: TAction
      Category = 'common'
      Caption = 'actEdtNodeDataOn'
      OnExecute = actEdtNodeDataOnExecute
    end
    object actEdtNodeDataOff: TAction
      Category = 'common'
      Caption = 'actEdtNodeDataOff'
      OnExecute = actEdtNodeDataOffExecute
    end
    object actPriceSave: TAction
      Category = 'common'
      Caption = 'actPriceSave'
      OnExecute = actPriceSaveExecute
    end
    object actPriceCancel: TAction
      Category = 'common'
      Caption = 'actPriceCancel'
      OnExecute = actPriceCancelExecute
    end
    object actHlp: TAction
      Category = 'common'
      Caption = 'actHlp'
      OnExecute = actHlpExecute
    end
    object ActGetPriceOnly: TAction
      Category = 'GetData'
      Caption = 'ActGetPriceOnly'
      OnExecute = ActGetPriceOnlyExecute
    end
    object ActGetPriceCommon: TAction
      Category = 'GetData'
      Caption = 'ActGetPriceCommon'
      OnExecute = ActGetPriceCommonExecute
    end
    object ActGetLaborIssue: TAction
      Category = 'GetData'
      Caption = 'ActGetLaborIssue'
      OnExecute = ActGetLaborIssueExecute
    end
    object ActGetBasePrice: TAction
      Category = 'GetData'
      Caption = 'ActGetBasePrice'
      OnExecute = ActGetBasePriceExecute
    end
    object actPriceFill: TAction
      Category = 'common'
      Caption = 'actPriceFill'
      OnExecute = actPriceFillExecute
    end
  end
  object ppmVST: TPopupMenu
    Left = 18
    Top = 274
    object N1: TMenuItem
      Action = actAllExpand
    end
    object N2: TMenuItem
      Action = actAllCollaps
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Action = actNodeExpand
    end
    object N5: TMenuItem
      Action = actNodeCollaps
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object N7: TMenuItem
      Action = ActRootAdd
    end
    object N8: TMenuItem
      Action = ActChildAdd
    end
    object N9: TMenuItem
      Action = ActNodeEdt
    end
    object N10: TMenuItem
      Action = ActNodeDel
    end
    object N11: TMenuItem
      Action = ActNodeRestore
    end
  end
  object mds_price_common: TMemTableEh
    Params = <>
    Left = 96
    Top = 216
  end
  object mds_baseprice: TMemTableEh
    Params = <>
    Left = 96
    Top = 272
  end
  object mds_laborissue: TMemTableEh
    Params = <>
    Left = 96
    Top = 328
  end
  object qryBaseprice: TpFIBQuery
    Transaction = tmpTrans
    Left = 194
    Top = 219
  end
  object qryLaborissue: TpFIBQuery
    Transaction = tmpTrans
    Left = 194
    Top = 275
  end
  object qryPriceItemInsert: TpFIBQuery
    Transaction = tmpTrans
    Left = 292
    Top = 219
  end
  object qryPriceItemUpdate: TpFIBQuery
    Transaction = tmpTrans
    Left = 292
    Top = 275
  end
  object qryPriceItemDelete: TpFIBQuery
    Transaction = tmpTrans
    Left = 292
    Top = 331
  end
  object tmpTrans: TpFIBTransaction
    TRParams.Strings = (
      'write'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 194
    Top = 330
  end
  object mds_price_only: TMemTableEh
    Params = <>
    Left = 98
    Top = 386
  end
  object tmpQry: TpFIBQuery
    Transaction = tmpTrans
    Left = 200
    Top = 387
  end
end
