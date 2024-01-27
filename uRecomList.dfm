object frmRecomList: TfrmRecomList
  Left = 0
  Top = 0
  Caption = 'frmRecomList'
  ClientHeight = 411
  ClientWidth = 843
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnResize = FormResize
  TextHeight = 15
  object Spl: TSplitter
    AlignWithMargins = True
    Left = 532
    Top = 3
    Height = 405
    Beveled = True
    ResizeStyle = rsUpdate
    ExplicitLeft = 632
    ExplicitTop = 160
    ExplicitHeight = 100
  end
  object pnlRight: TPanel
    Left = 538
    Top = 0
    Width = 305
    Height = 411
    Align = alClient
    Caption = 'pnlRight'
    TabOrder = 0
    ExplicitLeft = 532
    ExplicitWidth = 307
    ExplicitHeight = 410
    DesignSize = (
      305
      411)
    object REdt: TRichEdit
      Left = 16
      Top = 8
      Width = 270
      Height = 395
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
      ExplicitWidth = 272
      ExplicitHeight = 394
    end
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 529
    Height = 411
    Align = alLeft
    Caption = 'pnlLeft'
    ParentColor = True
    TabOrder = 1
    ExplicitHeight = 410
    DesignSize = (
      529
      411)
    object vst: TVirtualStringTree
      Left = 8
      Top = 8
      Width = 363
      Height = 393
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
      Left = 377
      Top = 7
      Width = 145
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'btnGroupAdd'
      TabOrder = 1
    end
    object btnItemAdd: TButton
      Left = 377
      Top = 38
      Width = 145
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'btnItemAdd'
      TabOrder = 2
    end
    object btnItemEdit: TButton
      Left = 377
      Top = 69
      Width = 145
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'btnItemEdit'
      TabOrder = 3
    end
    object btnItemDelete: TButton
      Left = 377
      Top = 100
      Width = 145
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'btnItemDelete'
      TabOrder = 4
    end
    object cbbFmtPrint: TComboBox
      Left = 377
      Top = 378
      Width = 145
      Height = 23
      Anchors = [akRight, akBottom]
      TabOrder = 5
      Text = 'cbbFmtPrint'
      ExplicitTop = 377
    end
    object btnPrint: TButton
      Left = 377
      Top = 347
      Width = 146
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'btnPrint'
      TabOrder = 6
      ExplicitTop = 346
    end
  end
  object oDlg: TOpenDialog
    Filter = #1092#1086#1088#1084#1072#1090#1099' '#1089' '#1090#1077#1082#1089#1090#1086#1084'|*.txt;*.doc;*.docx;*.rtf;*.odt'
    Left = 16
    Top = 8
  end
end
