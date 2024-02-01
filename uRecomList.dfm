object frmRecomList: TfrmRecomList
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'frmRecomList'
  ClientHeight = 411
  ClientWidth = 992
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 15
  object Spl: TSplitter
    AlignWithMargins = True
    Left = 524
    Top = 3
    Height = 405
    Beveled = True
    ResizeStyle = rsUpdate
    OnMoved = SplMoved
    ExplicitLeft = 632
    ExplicitTop = 160
    ExplicitHeight = 100
  end
  object pnlLeftCmn: TPanel
    Left = 0
    Top = 0
    Width = 521
    Height = 411
    Align = alLeft
    Caption = 'pnlLeftCmn'
    TabOrder = 0
    ExplicitHeight = 410
    object pnlLeftTop: TPanel
      Left = 1
      Top = 1
      Width = 519
      Height = 367
      Align = alClient
      Caption = 'pnlLeftTop'
      ParentColor = True
      TabOrder = 0
      ExplicitHeight = 366
      DesignSize = (
        519
        367)
      object vst: TVirtualStringTree
        Left = 8
        Top = 8
        Width = 343
        Height = 355
        Anchors = [akLeft, akTop, akRight, akBottom]
        Header.AutoSizeIndex = 0
        Header.MainColumn = -1
        TabOrder = 0
        OnFreeNode = vstFreeNode
        OnGetText = vstGetText
        OnPaintText = vstPaintText
        OnGetNodeDataSize = vstGetNodeDataSize
        OnHeaderDraw = vstHeaderDraw
        OnResize = vstResize
        Touch.InteractiveGestures = [igPan, igPressAndTap]
        Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
        Columns = <>
      end
      object btnGroupAdd: TButton
        Left = 357
        Top = 8
        Width = 155
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
        TabOrder = 1
      end
      object btnItemAdd: TButton
        Left = 357
        Top = 39
        Width = 155
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1088#1077#1082#1086#1084#1077#1085#1076#1072#1094#1080#1102
        TabOrder = 2
      end
      object btnItemEdit: TButton
        Left = 357
        Top = 70
        Width = 155
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        TabOrder = 3
      end
      object btnItemDelete: TButton
        Left = 357
        Top = 101
        Width = 155
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #1059#1076#1072#1083#1080#1090#1100
        TabOrder = 4
      end
      object chbPreview: TCheckBox
        Left = 357
        Top = 346
        Width = 155
        Height = 17
        Anchors = [akRight, akBottom]
        Caption = #1055#1088#1077#1076#1086#1089#1084#1086#1090#1088' '#1092#1072#1081#1083#1086#1074
        TabOrder = 5
        OnClick = chbPreviewClick
        ExplicitTop = 345
      end
    end
    object pnlLeftBottom: TPanel
      Left = 1
      Top = 368
      Width = 519
      Height = 42
      Align = alBottom
      Caption = 'pnlLeftBottom'
      TabOrder = 1
      ExplicitTop = 367
      DesignSize = (
        519
        42)
      object btnHelp: TButton
        Left = 8
        Top = 9
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = #1055#1086#1084#1086#1097#1100
        TabOrder = 0
      end
      object cbbFmtPrint: TComboBox
        Left = 357
        Top = 10
        Width = 155
        Height = 23
        Style = csDropDownList
        Anchors = [akRight, akBottom]
        TabOrder = 1
      end
      object btnPrint: TButton
        Left = 276
        Top = 9
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #1055#1077#1095#1072#1090#1100
        TabOrder = 2
      end
    end
  end
  object pnlPreview: TPanel
    Left = 530
    Top = 0
    Width = 462
    Height = 411
    Align = alClient
    Caption = 'pnlPreview'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      462
      411)
    object Label1: TLabel
      Left = 177
      Top = 382
      Width = 106
      Height = 15
      Anchors = [akRight, akBottom]
      Caption = #1055#1086#1083#1086#1089#1099' '#1087#1088#1086#1082#1088#1091#1090#1082#1080
      ExplicitLeft = 179
    end
    object REdt: TRichEdit
      Left = 3
      Top = 9
      Width = 447
      Height = 355
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      Lines.Strings = (
        're1')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
      ExplicitWidth = 443
      ExplicitHeight = 354
    end
    object chbWordWrap: TCheckBox
      Left = 3
      Top = 381
      Width = 166
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = #1056#1072#1079#1088#1077#1096#1080#1090#1100' '#1087#1077#1088#1077#1085#1086#1089' '#1089#1083#1086#1074
      TabOrder = 1
      OnClick = chbWordWrapClick
      ExplicitTop = 380
    end
    object cbbScrollbar: TComboBox
      Left = 289
      Top = 379
      Width = 161
      Height = 23
      Style = csDropDownList
      Anchors = [akRight, akBottom]
      TabOrder = 2
      OnChange = cbbScrollbarChange
      ExplicitLeft = 285
      ExplicitTop = 378
    end
  end
  object oDlg: TOpenDialog
    Filter = #1092#1086#1088#1084#1072#1090#1099' '#1089' '#1090#1077#1082#1089#1090#1086#1084'|*.txt;*.doc;*.docx;*.rtf;*.odt'
    Left = 16
    Top = 8
  end
  object actList: TActionList
    Left = 58
    Top = 8
    object actGroupAdd: TAction
      Category = 'Nodes'
      Caption = 'actGroupAdd'
    end
    object actItemAdd: TAction
      Category = 'Nodes'
      Caption = 'actItemAdd'
    end
    object actNodeEdt: TAction
      Category = 'Nodes'
      Caption = 'actNodeEdt'
    end
    object actNodeDel: TAction
      Category = 'Nodes'
      Caption = 'actNodeDel'
    end
    object ActPrint: TAction
      Category = 'Execute'
      Caption = 'ActPrint'
    end
    object ActHelp: TAction
      Category = 'Execute'
      Caption = 'ActHelp'
    end
    object actClose: TAction
      Category = 'Execute'
      Caption = 'actClose'
    end
  end
  object imgList: TImageList
    ColorDepth = cd32Bit
    Left = 104
    Top = 8
    Bitmap = {
      494C010102000800040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00040000001E0000002300000000000000000000000000000000000000000000
      00000000001E0000002100000006000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000001A0000
      00390000003F0000003F00000014000000000000000000000000000000000000
      00180000003F0000003F0000003B0000001E0000000200000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000012000000350000003F0000
      003F0000003F0000003F00000020000000000000000000000000000000000000
      00200000003F0000003F0000003F0000003F0000003900000016000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000A0000002D0000003F0000003F0000003F0000
      003F0000003F0000003F00000020000000000000000000000000000000000000
      00200000003F0000003F0000003F0000003F0000003F0000003F000000330000
      0010000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000006000000250000003F0000003F0000003F0000003F0000003B0000
      002F0000003F0000003F00000020000000000000000000000000000000000000
      00200000003F0000003F00000031000000390000003F0000003F0000003F0000
      003F0000002D0000000C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00080000003B0000003F0000003F0000003F0000003F00000023000000060000
      00180000003F0000003F00000020000000000000000000000000000000000000
      00200000003F0000003F0000002000000004000000200000003D0000003F0000
      003F0000003F0000003D00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00180000003F0000003F0000003F0000003F0000002300000002000000000000
      00180000003F0000003F00000020000000000000000000000000000000000000
      00200000003F0000003F0000002000000000000000000000001E0000003F0000
      003F0000003F0000003F0000001E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0004000000310000003F0000003F0000003F0000003F00000037000000140000
      00180000003F0000003F00000020000000000000000000000000000000000000
      00200000003F0000003F0000002000000010000000330000003F0000003F0000
      003F0000003F0000003700000008000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000018000000390000003F0000003F0000003F0000003F0000
      003B0000003F0000003F00000020000000000000000000000000000000000000
      00200000003F0000003F0000003B0000003F0000003F0000003F0000003F0000
      003B0000001E0000000200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000020000001E0000003B0000003F0000003F0000
      003F0000003F0000003F00000020000000000000000000000000000000000000
      00200000003F0000003F0000003F0000003F0000003F0000003D000000230000
      0004000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000006000000230000003F0000
      003F0000003F0000003F00000020000000000000000000000000000000000000
      00200000003F0000003F0000003F0000003F0000002900000008000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000080000
      002B0000003F0000003F0000000C000000000000000000000000000000000000
      00100000003F0000003F0000002F0000000C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000A0000000E00000000000000000000000000000000000000000000
      00000000000C0000000C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
end
