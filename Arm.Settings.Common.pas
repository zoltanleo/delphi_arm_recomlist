unit Arm.Settings.Common;

interface
uses
    Arm.Singleton
  , Vcl.Forms
  , Vcl.Dialogs
  , System.IniFiles
  , System.SysUtils
  , System.Types
  , System.IOUtils
  , Winapi.Windows
  ;

const
  KeybrdLayoutDefault = 67699721;
  ArmHomeDir = 'Leybasoft';
  ReportExpDir = 'Reports';
  ReportDefaultDir = 'Reports';
  CommonSectName = 'Common';

type
  TSenderObject = (
                  soNil
                  , soFrmMainProg
                  , soFrmStatusPat
                  , soFrmTblDoctor
                  , soFrmConsultation
                  , sofrmFindPat
                  , soFrmRichTxtShow
                  , soFrmTblDrugsSingle
                  , soFrmTblDrugsDual
                  , soFrmReportResearch
                  , soFrmTitulPrint
                  , soFrmBasePrice
                  , sofrmTblPrice
                  , soFrmTblLaborIssue
                  , soFrmBloodHorm
                  , soFrmIFA
                  , soFrmMazProst
                  , soFrmMazUrethraM
                  , soFrmMazUrethraF
                  , soFrmMKB
                  , soFrmOAM
                  , soFrmPCR
                  , soFrmResearchLues
                  , soFrmShedul
                  , soFrmSpermGr
                  , soFrmStLocalisTempl
                  , soFrmStPraesensTempl
                  , soFrmStProstataTempl
                  , soFrmTblAnketa
                  , soFrmTblClinic
                  , soFrmTblDsSingle
                  , soFrmTblDsDual
                  , soFrmTblManipSingle
                  , soFrmTblManipDual
                  , soFrmTblRecomSingle
                  , soFrmTblRecomDual
                  , soFrmTblTown
                  , soFrmAbout
                  , soFrmAIDS
                  , soFrmAllergyChoice
                  , soFrmAnthrDes
                  , soFrmChildDes
                  , soFrmMicUrBactInoc
                  , soFrmProstBactInoc
                  , soFrmUrethBactInoc
                  , soFrmUrinBactInoc
                  , soFrmZPPP
                  , soFrmImgTemplateFour
                  , soFrmImgTemplateSingle
                  , soFrmImgTemplateSix
                  , sofrmItem
                  , soFrmUrScopiaDry
                  , soFrmUrScopiaIrrig
                  , sofrmTblPriceTree
                  , soFrmUZIGenit
                  , soFrmUZIRen
                  );

  {from here https://www.gunsmoker.ru/2011/04/blog-post.html}
  TSettings = class(TSingleton)
  protected
    constructor Create; override;
  public
    destructor Destroy; override;
  private
    FSettingsFile: TCustomIniFile;
    FSenderObject: TSenderObject;
    FKeybrdLayoutNum: Integer;
    FfrxExp_ExportPath: string;
    FfrxExp_OverwritePrompt: Boolean;
    FfrxExp_OpenAfterExport: Boolean;
    FClinicID: Integer;
    FDoctorID: Integer;
    FcbbPrintFmt_ItemIndex: Integer;
    Frb_SexFind: Integer;
    Fchb_ThirdNameFind: Boolean;
    Fchb_LastNameFind: Boolean;
    Fchb_DateExactFind: Boolean;
    Fchb_DateExpirFind: Boolean;
    Fchb_SexFind: Boolean;
    Fchb_FirstNameFind: Boolean;
    FReportTemplDir: string;
    FcbbReportType_ItemIndex: Integer;
    FPriceName: string;
    FDepartID: Integer;
    FActivePageIdx: Integer;
    Fchb_HighLightNodePriceTree: Boolean;
    Fchb_HideDelNodePriceTree: Boolean;
    FIsTreeExpanded_PriceTree: Boolean;
  public
    property SettingsFile: TCustomIniFile read FSettingsFile;
    property ReportTemplDir: string read FReportTemplDir write FReportTemplDir;//путь к папке с отчетами
    property SenderObject: TSenderObject read FSenderObject write FSenderObject;
    property KeybrdLayoutNum: Integer read FKeybrdLayoutNum write FKeybrdLayoutNum;//номер текущей раскладки
    property frxExp_ExportPath: string read FfrxExp_ExportPath write FfrxExp_ExportPath;//папка по умолчанию для экспорта отчетов
    property frxExp_OpenAfterExport: Boolean read FfrxExp_OpenAfterExport write FfrxExp_OpenAfterExport;// опция открыть после экспорта"
    property frxExp_OverwritePrompt: Boolean read FfrxExp_OverwritePrompt write FfrxExp_OverwritePrompt;//опция "спрашивать при перезаписи"
    property ClinicID: Integer read FClinicID write FClinicID;//ID текущей клиники, с которой работает текущий доктор
    property DoctorID: Integer read FDoctorID write FDoctorID;//ID текущего доктора, который работает с программой
    property DepartID: Integer read FDepartID write FDepartID;//ID раздела прайса, выбранный в последний раз
    property PriceName: string read FPriceName write FPriceName;//имя прайс-листа
    property ActivePageIdx: Integer read FActivePageIdx write FActivePageIdx;//активная вкладка какой-нибудь формы

    property cbbPrintFmt_ItemIndex: Integer read FcbbPrintFmt_ItemIndex
                                                    write FcbbPrintFmt_ItemIndex;//формат печати отчетов в некоторых формах

    property cbbReportType_ItemIndex: Integer read FcbbReportType_ItemIndex
                                              write FcbbReportType_ItemIndex;//порядковый номер экземпляра TReportType в коьбе

    property chb_LastNameFind: Boolean read Fchb_LastNameFind
                                       write Fchb_LastNameFind;//чекбокс фамилии
    property chb_FirstNameFind: Boolean read Fchb_FirstNameFind
                                       write Fchb_FirstNameFind;//чекбокс имени
    property chb_ThirdNameFind: Boolean read Fchb_ThirdNameFind
                                       write Fchb_ThirdNameFind;//чекбокс отчества
    property chb_SexFind: Boolean read Fchb_SexFind
                                  write Fchb_SexFind;//"половой" чекбокс
    property rb_SexFind: Integer read Frb_SexFind
                                 write Frb_SexFind;//"половой" радиобутон
    property chb_DateExactFind: Boolean read Fchb_DateExactFind
                                       write Fchb_DateExactFind;//"точная" дата поиска
    property chb_DateExpirFind: Boolean read Fchb_DateExpirFind
                                       write Fchb_DateExpirFind;//"крайняя" дата поиска
    property chb_HighLightNodePriceTree: Boolean read Fchb_HighLightNodePriceTree
                                       write Fchb_HighLightNodePriceTree;//подсветка измененных узлов в frmTblPriceTree
    property chb_HideDelNodePriceTree: Boolean read Fchb_HideDelNodePriceTree
                                       write Fchb_HideDelNodePriceTree;//скрытие удаленных узлов в frmTblPriceTree
    property IsTreeExpanded_PriceTree: Boolean read FIsTreeExpanded_PriceTree
                                               write FIsTreeExpanded_PriceTree;//состояние дерева(развернуто/скрыто) в frmTblPriceTree


    procedure Save(Sender: TObject);
    procedure Load(Sender: TObject);
  end;

  function Settings: TSettings;

implementation

var SettingsDirPath: string;

  {TSettings}
function Settings: TSettings;
begin
  Result := TSettings.GetInstance;
end;

constructor TSettings.Create;
begin
  inherited Create;

  {$IFDEF DEBUG}
  SettingsDirPath:= '';
  FReportTemplDir:= 'c:\proj\armdoc_4\Reports\';

  {$ELSE}
  FReportTemplDir:= Format('%s%s\',[ExtractFilePath(Application.ExeName), ReportDefaultDir]);
  SettingsDirPath:= Format('%s\%s\',[TPath.GetHomePath,ArmHomeDir]);

  if not TDirectory.Exists(SettingsDirPath) then
    if not ForceDirectories(SettingsDirPath) then FfrxExp_ExportPath:= '';

  {$ENDIF}

  FSettingsFile:= TMemIniFile.Create((SettingsDirPath + ChangeFileExt(ExtractFileName(Application.ExeName),'.INI')),
                                                                                                      TEncoding.UTF8);
  SenderObject:= soNil;
  FKeybrdLayoutNum:= KeybrdLayoutDefault;
  FClinicID:= -1;
  FDoctorID:= -1;
  FDepartID:= -1;
  frxExp_OpenAfterExport:= True;
  frxExp_OverwritePrompt:= True;
  FcbbPrintFmt_ItemIndex:= 0;
  FcbbReportType_ItemIndex:= 0;

  Fchb_LastNameFind:= False;
  Fchb_FirstNameFind:= False;
  Fchb_ThirdNameFind:= False;
  Fchb_SexFind:= False;
  Frb_SexFind:= 1;
  Fchb_DateExactFind:= False;
  Fchb_DateExpirFind:= False;
  FPriceName:= '';
  FActivePageIdx:= 0;

  Fchb_HighLightNodePriceTree:= False;
  Fchb_HideDelNodePriceTree:= False;
  FIsTreeExpanded_PriceTree:= False;


  FfrxExp_ExportPath:= Format('%s\%s\%s\',[TPath.GetHomePath,ArmHomeDir,ReportExpDir]);

  if not TDirectory.Exists(frxExp_ExportPath) then
    if not ForceDirectories(frxExp_ExportPath) then FfrxExp_ExportPath:= '';
end;

destructor TSettings.Destroy;
begin
  FSettingsFile.Free;
  inherited Destroy;
end;

procedure TSettings.Load(Sender: TObject);
var
  SectName: string;
begin
  if not TObject(Sender).InheritsFrom(TCustomForm) then Exit;

  if not Assigned(SettingsFile) then Exit;

  SectName:= TCustomForm(Sender).Name;

  with TCustomForm(Sender) do
  begin
    case SenderObject of
      soFrmTblDrugsSingle
      , soFrmIFA
      , soFrmMazProst
      , soFrmOAM
      , soFrmPCR
      , soFrmResearchLues
      , soFrmSpermGr
      , soFrmStLocalisTempl
      , soFrmStPraesensTempl
      , soFrmStProstataTempl
      , soFrmTblAnketa
      , soFrmTblDsSingle
      , soFrmTblManipSingle
      , soFrmTblRecomSingle
      , soFrmAbout
      , soFrmAIDS
      , soFrmAllergyChoice
      , soFrmAnthrDes
      , soFrmChildDes
      , soFrmMicUrBactInoc
      , soFrmProstBactInoc
      , soFrmUrethBactInoc
      , soFrmUrinBactInoc
      , soFrmZPPP
      , soFrmUrScopiaDry
      , soFrmUrScopiaIrrig
      , soFrmUZIGenit
      , soFrmUZIRen:
        begin
          Top     := SettingsFile.ReadInteger(SectName, 'Top_Single', Top);
          Left    := SettingsFile.ReadInteger(SectName, 'Left_Single', Left);
        end;
      soFrmMazUrethraM:
        begin
          Top     := SettingsFile.ReadInteger(SectName, 'Top_Male', Top);
          Left    := SettingsFile.ReadInteger(SectName, 'Left_Male', Left);
        end;
      soFrmMazUrethraF:
        begin
          Top     := SettingsFile.ReadInteger(SectName, 'Top_Female', Top);
          Left    := SettingsFile.ReadInteger(SectName, 'Left_Female', Left);
        end;
      else
        begin
          case SettingsFile.ReadBool(SectName, 'InitMax', WindowState = wsMaximized) of
            True : WindowState := wsMaximized;
            False:
              begin
                WindowState := wsNormal;
                Top     := SettingsFile.ReadInteger(SectName, 'Top', Top);
                Left    := SettingsFile.ReadInteger(SectName, 'Left', Left);
                Width   := SettingsFile.ReadInteger(SectName, 'Width', Width);
                Height  := SettingsFile.ReadInteger(SectName, 'Height', Height);
              end;
          end;
        end;
    end;
    FKeybrdLayoutNum:= SettingsFile.ReadInteger(SectName, 'KeybrdLayoutNum', KeybrdLayoutNum);
  end;

  case SenderObject of
    soNil: Exit;
    soFrmMainProg:
      begin
        FfrxExp_ExportPath:= SettingsFile.ReadString(CommonSectName,'frxExp_ExportPath', frxExp_ExportPath);
        FfrxExp_OpenAfterExport:= SettingsFile.ReadBool(CommonSectName, 'frxExp_OpenAfterExport', frxExp_OpenAfterExport);
        FfrxExp_OverwritePrompt:= SettingsFile.ReadBool(CommonSectName, 'frxExp_OverwritePrompt', frxExp_OverwritePrompt);
        FClinicID:= SettingsFile.ReadInteger(CommonSectName,'ClinicID',ClinicID);
        FDoctorID:= SettingsFile.ReadInteger(CommonSectName,'DoctorID',DoctorID);
        FReportTemplDir:= SettingsFile.ReadString(SectName, 'ReportTemplDir', ReportTemplDir);
      end;
    soFrmStatusPat: ;
    soFrmTblDoctor: ;
    soFrmConsultation:
      begin
        FcbbPrintFmt_ItemIndex:= SettingsFile.ReadInteger(SectName, 'cbbPrintFmt_ItemIndex', cbbPrintFmt_ItemIndex);
        FReportTemplDir:= SettingsFile.ReadString(SectName, 'ReportTemplDir', ReportTemplDir);
      end;
    sofrmFindPat:
      begin
        Fchb_LastNameFind:= SettingsFile.ReadBool(SectName, 'chb_LastNameFind', chb_LastNameFind);
        Fchb_FirstNameFind:= SettingsFile.ReadBool(SectName, 'chb_FirstNameFind', chb_FirstNameFind);
        Fchb_ThirdNameFind:= SettingsFile.ReadBool(SectName, 'chb_ThirdNameFind', chb_ThirdNameFind);
        Fchb_SexFind:= SettingsFile.ReadBool(SectName, 'chb_SexFind', chb_SexFind);
        Frb_SexFind:= SettingsFile.ReadInteger(SectName, 'rb_SexFind', rb_SexFind);
        Fchb_DateExactFind:= SettingsFile.ReadBool(SectName, 'chb_DateExactFind', chb_DateExactFind);
        Fchb_DateExpirFind:= SettingsFile.ReadBool(SectName, 'chb_DateExpirFind', chb_DateExpirFind);
      end;
    soFrmRichTxtShow:
      begin
        FcbbPrintFmt_ItemIndex:= SettingsFile.ReadInteger(SectName, 'cbbPrintFmt_ItemIndex', cbbPrintFmt_ItemIndex);
        FReportTemplDir:= SettingsFile.ReadString(SectName, 'ReportTemplDir', ReportTemplDir);
      end;
    soFrmTblDrugsSingle,
    soFrmTblDrugsDual:
      begin
        FcbbPrintFmt_ItemIndex:= SettingsFile.ReadInteger(SectName, 'cbbPrintFmt_ItemIndex', cbbPrintFmt_ItemIndex);
        FcbbReportType_ItemIndex:= SettingsFile.ReadInteger(SectName, 'cbbReportType_ItemIndex', cbbReportType_ItemIndex);
        FReportTemplDir:= SettingsFile.ReadString(SectName, 'ReportTemplDir', ReportTemplDir);
      end;
    soFrmReportResearch:
      begin
        FPriceName:= SettingsFile.ReadString(SectName, 'PriceName', PriceName);
        FReportTemplDir:= SettingsFile.ReadString(SectName, 'ReportTemplDir', ReportTemplDir);
        FcbbPrintFmt_ItemIndex:= SettingsFile.ReadInteger(SectName, 'cbbPrintFmt_ItemIndex', cbbPrintFmt_ItemIndex);
        FDepartID:= SettingsFile.ReadInteger(SectName, 'DepartID', DepartID);
        FClinicID:= SettingsFile.ReadInteger(SectName,'ClinicID',ClinicID);
        FDoctorID:= SettingsFile.ReadInteger(SectName,'DoctorID',DoctorID);
      end;
    soFrmTitulPrint:
      begin
        FClinicID:= SettingsFile.ReadInteger(SectName,'ClinicID',ClinicID);
        FcbbPrintFmt_ItemIndex:= SettingsFile.ReadInteger(SectName, 'cbbPrintFmt_ItemIndex', cbbPrintFmt_ItemIndex);
      end;
    soFrmSpermGr:
      begin
        FActivePageIdx:= SettingsFile.ReadInteger(SectName, 'ActivePageIdx', ActivePageIdx);
      end;
    sofrmTblPriceTree:
      begin
        chb_HighLightNodePriceTree:= SettingsFile.ReadBool(SectName, 'chb_HighLightNodePriceTree', chb_HighLightNodePriceTree);
        chb_HideDelNodePriceTree:= SettingsFile.ReadBool(SectName, 'chb_HideDelNodePriceTree', chb_HideDelNodePriceTree);
        IsTreeExpanded_PriceTree:= SettingsFile.ReadBool(SectName, 'IsTreeExpanded_PriceTree', IsTreeExpanded_PriceTree);
      end;
    soFrmResearchLues:
      begin
        cbbPrintFmt_ItemIndex:= SettingsFile.ReadInteger(SectName, 'cbbPrintFmt_ItemIndex', cbbPrintFmt_ItemIndex);
        FReportTemplDir:= SettingsFile.ReadString(SectName, 'ReportTemplDir', ReportTemplDir);
      end;
  end;
end;

procedure TSettings.Save(Sender: TObject);
var
  SectName: string;
begin
  if not TObject(Sender).InheritsFrom(TCustomForm) then Exit;
  if not Assigned(SettingsFile) then Exit;

  SectName:= TCustomForm(Sender).Name;

  try
    with TCustomForm(Sender) do
    begin
      case SenderObject of
        soFrmTblDrugsSingle
        , soFrmIFA
        , soFrmMazProst
        , soFrmOAM
        , soFrmPCR
        , soFrmResearchLues
        , soFrmSpermGr
        , soFrmStLocalisTempl
        , soFrmStPraesensTempl
        , soFrmStProstataTempl
        , soFrmTblAnketa
        , soFrmTblDsSingle
        , soFrmTblManipSingle
        , soFrmTblRecomSingle
        , soFrmAbout
        , soFrmAIDS
        , soFrmAllergyChoice
        , soFrmAnthrDes
        , soFrmChildDes
        , soFrmMicUrBactInoc
        , soFrmProstBactInoc
        , soFrmUrethBactInoc
        , soFrmUrinBactInoc
        , soFrmZPPP
        , soFrmUrScopiaDry
        , soFrmUrScopiaIrrig
        , soFrmUZIGenit
        , soFrmUZIRen:
          begin
            SettingsFile.WriteInteger (Name, 'Top_Single', Top);
            SettingsFile.WriteInteger (Name, 'Left_Single', Left);
          end;
      soFrmMazUrethraM:
        begin
          SettingsFile.WriteInteger(SectName, 'Top_Male', Top);
          SettingsFile.WriteInteger(SectName, 'Left_Male', Left);
        end;
      soFrmMazUrethraF:
        begin
          SettingsFile.WriteInteger(SectName, 'Top_Female', Top);
          SettingsFile.WriteInteger(SectName, 'Left_Female', Left);
        end;

        else
          begin
            SettingsFile.WriteBool    (Name, 'InitMax', WindowState = wsMaximized);
            if (WindowState <> wsMaximized) then
            begin
              SettingsFile.WriteInteger (Name, 'Top', Top);
              SettingsFile.WriteInteger (Name, 'Left', Left);
              SettingsFile.WriteInteger (Name, 'Width', Width);
              SettingsFile.WriteInteger (Name, 'Height', Height);
            end;
          end;
        SettingsFile.WriteInteger (Name, 'KeybrdLayoutNum', KeybrdLayoutNum);
      end;

      case SenderObject of
        soNil: Exit;
        soFrmMainProg:
          begin
            SettingsFile.WriteString(CommonSectName,'frxExp_ExportPath', frxExp_ExportPath);
            SettingsFile.WriteBool(CommonSectName, 'frxExp_OpenAfterExport', frxExp_OpenAfterExport);
            SettingsFile.WriteBool(CommonSectName, 'frxExp_OverwritePrompt', frxExp_OverwritePrompt);
            SettingsFile.WriteInteger(CommonSectName, 'ClinicID', ClinicID);
            SettingsFile.WriteInteger(CommonSectName, 'DoctorID', DoctorID);
            SettingsFile.WriteString(SectName, 'ReportTemplDir', ReportTemplDir);
            SettingsFile.WriteString(CommonSectName, 'LastModified', FormatDateTime('dd.mm.yyyy hh:nn:ss', Now));
          end;
        soFrmStatusPat: ;
        soFrmTblDoctor: ;
        soFrmConsultation:
          begin
            SettingsFile.WriteInteger(SectName, 'cbbPrintFmt_ItemIndex', cbbPrintFmt_ItemIndex);
            SettingsFile.WriteString(SectName, 'ReportTemplDir', ReportTemplDir);
          end;
        sofrmFindPat:
          begin
            SettingsFile.WriteBool(SectName, 'chb_LastNameFind', chb_LastNameFind);
            SettingsFile.WriteBool(SectName, 'chb_FirstNameFind', chb_FirstNameFind);
            SettingsFile.WriteBool(SectName, 'chb_ThirdNameFind', chb_ThirdNameFind);
            SettingsFile.WriteBool(SectName, 'chb_SexFind', chb_SexFind);
            SettingsFile.WriteInteger(SectName, 'rb_SexFind', rb_SexFind);
            SettingsFile.WriteBool(SectName, 'chb_DateExactFind', chb_DateExactFind);
            SettingsFile.WriteBool(SectName, 'chb_DateExpirFind', chb_DateExpirFind);
          end;
        soFrmRichTxtShow:
          begin
            SettingsFile.WriteInteger(SectName, 'cbbPrintFmt_ItemIndex', cbbPrintFmt_ItemIndex);
            SettingsFile.WriteString(SectName, 'ReportTemplDir', ReportTemplDir);
          end;
        soFrmTblDrugsSingle,
        soFrmTblDrugsDual:
          begin
            SettingsFile.WriteInteger(SectName, 'cbbPrintFmt_ItemIndex', cbbPrintFmt_ItemIndex);
            SettingsFile.WriteInteger(SectName, 'cbbReportType_ItemIndex', cbbReportType_ItemIndex);
            SettingsFile.WriteString(SectName, 'ReportTemplDir', ReportTemplDir);
          end;
        soFrmReportResearch:
          begin
            SettingsFile.WriteString(SectName, 'PriceName', PriceName);
            SettingsFile.WriteString(SectName, 'ReportTemplDir', ReportTemplDir);
            SettingsFile.WriteInteger(SectName, 'cbbPrintFmt_ItemIndex', cbbPrintFmt_ItemIndex);
            SettingsFile.WriteInteger(SectName, 'DepartID', DepartID);
            SettingsFile.WriteInteger(SectName, 'ClinicID', ClinicID);
            SettingsFile.WriteInteger(SectName, 'DoctorID', DoctorID);
          end;
        soFrmTitulPrint:
          begin
            SettingsFile.WriteInteger(SectName, 'ClinicID', ClinicID);
            SettingsFile.WriteInteger(SectName, 'cbbPrintFmt_ItemIndex', cbbPrintFmt_ItemIndex);
          end;
        soFrmSpermGr:
          begin
            SettingsFile.WriteInteger(SectName, 'ActivePageIdx', ActivePageIdx);
          end;
        sofrmTblPriceTree:
          begin
            SettingsFile.WriteBool(SectName, 'chb_HighLightNodePriceTree', chb_HighLightNodePriceTree);
            SettingsFile.WriteBool(SectName, 'chb_HideDelNodePriceTree', chb_HideDelNodePriceTree);
            SettingsFile.WriteBool(SectName, 'IsTreeExpanded_PriceTree', IsTreeExpanded_PriceTree);
          end;
        soFrmResearchLues:
          begin
            SettingsFile.WriteInteger(SectName, 'cbbPrintFmt_ItemIndex', cbbPrintFmt_ItemIndex);
            SettingsFile.WriteString(SectName, 'ReportTemplDir', ReportTemplDir);
          end;
      end;
    end;
  finally
    SettingsFile.UpdateFile;
  end;
end;

end.
