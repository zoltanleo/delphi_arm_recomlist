object frmNodeInfo: TfrmNodeInfo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'frmNodeInfo'
  ClientHeight = 323
  ClientWidth = 583
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
    Width = 583
    Height = 41
    Align = alTop
    Caption = 'pnlGroup'
    TabOrder = 0
    DesignSize = (
      583
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
      Width = 292
      Height = 23
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 279
    Width = 583
    Height = 44
    Align = alBottom
    Caption = 'pnlButtons'
    TabOrder = 1
    DesignSize = (
      583
      44)
    object btnCancel: TButton
      Left = 501
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 0
    end
    object btnSave: TButton
      Left = 420
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 1
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
    Width = 583
    Height = 238
    Align = alClient
    Caption = 'pnlCommon'
    TabOrder = 2
    object pnlNodeInfo: TPanel
      Left = 1
      Top = 1
      Width = 391
      Height = 236
      Align = alClient
      Caption = 'pnlNodeInfo'
      TabOrder = 0
      object pnlItemName: TPanel
        Left = 1
        Top = 1
        Width = 389
        Height = 52
        Align = alTop
        Caption = 'pnlItemName'
        TabOrder = 0
        DesignSize = (
          389
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
          Width = 378
          Height = 23
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'edtItemName'
        end
      end
      object pnlRichEdit: TPanel
        Left = 1
        Top = 53
        Width = 389
        Height = 182
        Align = alClient
        Caption = 'pnlRichEdit'
        TabOrder = 1
        DesignSize = (
          389
          182)
        object REdt: TRichEdit
          Left = 7
          Top = 2
          Width = 378
          Height = 176
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
      end
    end
    object pnlSelectBtn: TPanel
      Left = 392
      Top = 1
      Width = 190
      Height = 236
      Align = alRight
      Caption = 'pnlSelectBtn'
      TabOrder = 1
      DesignSize = (
        190
        236)
      object Label2: TLabel
        Left = 6
        Top = 187
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
        Top = 208
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
