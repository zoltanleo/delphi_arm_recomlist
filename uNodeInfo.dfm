object frmNodeInfo: TfrmNodeInfo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'frmNodeInfo'
  ClientHeight = 322
  ClientWidth = 679
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
  object pnlGroup: TPanel
    Left = 0
    Top = 0
    Width = 679
    Height = 41
    Align = alTop
    Caption = 'pnlGroup'
    TabOrder = 0
    DesignSize = (
      679
      41)
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 96
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1075#1088#1091#1087#1087#1099
    end
    object cbbGroup: TComboBox
      Left = 110
      Top = 8
      Width = 384
      Height = 23
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 278
    Width = 679
    Height = 44
    Align = alBottom
    Caption = 'pnlButtons'
    TabOrder = 2
    DesignSize = (
      679
      44)
    object btnCancel: TButton
      Left = 593
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
    end
    object btnSave: TButton
      Left = 512
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
    end
    object btnHelp: TButton
      Left = 8
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1055#1086#1084#1086#1097#1100
      TabOrder = 2
    end
  end
  object pnlCommon: TPanel
    Left = 0
    Top = 41
    Width = 679
    Height = 237
    Align = alClient
    Caption = 'pnlCommon'
    TabOrder = 1
    object pnlNodeInfo: TPanel
      Left = 1
      Top = 1
      Width = 487
      Height = 235
      Align = alClient
      Caption = 'pnlNodeInfo'
      TabOrder = 0
      object pnlItemName: TPanel
        Left = 1
        Top = 1
        Width = 485
        Height = 52
        Align = alTop
        Caption = 'pnlItemName'
        TabOrder = 0
        DesignSize = (
          485
          52)
        object lblItemName: TLabel
          Left = 7
          Top = 5
          Width = 69
          Height = 15
          Caption = 'lblItemName'
        end
        object edtItemName: TEdit
          Left = 7
          Top = 26
          Width = 470
          Height = 23
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'edtItemName'
        end
      end
      object pnlRichEdit: TPanel
        Left = 1
        Top = 53
        Width = 485
        Height = 181
        Align = alClient
        Caption = 'pnlRichEdit'
        TabOrder = 1
        DesignSize = (
          485
          181)
        object Label3: TLabel
          Left = 204
          Top = 157
          Width = 106
          Height = 15
          Anchors = [akRight, akBottom]
          Caption = #1055#1086#1083#1086#1089#1099' '#1087#1088#1086#1082#1088#1091#1090#1082#1080
          ExplicitLeft = 208
          ExplicitTop = 158
        end
        object REdt: TRichEdit
          Left = 7
          Top = 2
          Width = 470
          Height = 146
          Anchors = [akLeft, akTop, akRight, akBottom]
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          Lines.Strings = (
            'RichEdit1')
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 0
        end
        object chbWordWrap: TCheckBox
          Left = 7
          Top = 155
          Width = 166
          Height = 17
          Anchors = [akLeft, akBottom]
          Caption = #1056#1072#1079#1088#1077#1096#1080#1090#1100' '#1087#1077#1088#1077#1085#1086#1089' '#1089#1083#1086#1074
          TabOrder = 1
          OnClick = chbWordWrapClick
        end
        object cbbScrollbar: TComboBox
          Left = 316
          Top = 154
          Width = 161
          Height = 23
          Style = csDropDownList
          Anchors = [akRight, akBottom]
          TabOrder = 2
          OnChange = cbbScrollbarChange
        end
      end
    end
    object pnlSelectBtn: TPanel
      Left = 488
      Top = 1
      Width = 190
      Height = 235
      Align = alRight
      Caption = 'pnlSelectBtn'
      TabOrder = 1
      DesignSize = (
        190
        235)
      object Label2: TLabel
        Left = 6
        Top = 186
        Width = 160
        Height = 15
        Anchors = [akLeft, akBottom]
        Caption = #1050#1086#1076#1080#1088#1086#1074#1082#1072' '#1090#1077#1082#1089#1090#1086#1074#1086#1075#1086' '#1092#1072#1081#1083#1072
        ExplicitTop = 189
      end
      object btnODlg: TButton
        Left = 5
        Top = 24
        Width = 178
        Height = 25
        Anchors = [akLeft, akTop, akRight]
        Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
        TabOrder = 0
      end
      object cbbFileEncode: TComboBox
        Left = 5
        Top = 207
        Width = 178
        Height = 23
        Style = csDropDownList
        Anchors = [akLeft, akRight, akBottom]
        TabOrder = 1
      end
    end
  end
  object actList: TActionList
    Left = 448
    Top = 8
    object actOpenFile: TAction
      Caption = 'actOpenFile'
      OnExecute = actOpenFileExecute
    end
    object actSave: TAction
      Caption = 'actSave'
      OnExecute = actSaveExecute
    end
    object actCancel: TAction
      Caption = 'actCancel'
      OnExecute = actCancelExecute
    end
    object actHelp: TAction
      Caption = 'actHelp'
      OnExecute = actHelpExecute
    end
  end
  object oDlg: TOpenDialog
    Filter = #1092#1086#1088#1084#1072#1090#1099' '#1089' '#1090#1077#1082#1089#1090#1086#1084'|*.txt;*.doc;*.docx;*.rtf;*.odt'
    Left = 496
    Top = 8
  end
end
