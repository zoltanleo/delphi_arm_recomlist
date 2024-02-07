unit VarAndrUnit;

interface

uses
   Winapi.Windows
  , Graphics
  , ComCtrls
  , SysUtils
  , StrUtils
  , DBCtrlsEh
  , Classes
  , StdCtrls
  , CtlPanel
  , IBBlobFilter
  , Dialogs
  , Forms
  , Controls
//  , HtmlHelp
  , Registry
  , ShellApi
  ;

type
  TReportType = (
                 rt_full_A4  //полный общий осмотр А4 + анализы
                 , rt_long_A4  //полный общий осмотр А4 (без анализов)
                 , rt_short_A4 //короткий общий осмотр А4
                 , rt_full_A5  //полный общий осмотр А5 + анализы
                 , rt_long_A5 //полный общий осмотр А5 (без анализов)
                 , rt_short_A5 //короткий общий осмотр А5
                 , rt_recipe_107 //форма №107-1/у
                 , rt_recipe_148_88_small //форма №148-1/у-88 (A6)
                 , rt_recipe_148_88_large //форма №148-1/у-88 (A5)
                 , rt_recipe_148_04 //форма №148-1/у-04 (л)
                 );

const
  mailStr = 'leybabronstain@yandex.ru';
  DownloadsLinkStr = 'https://github.com/zoltanleo/ARM_doc_v4/releases';
  HomeLinkStr = 'https://github.com/zoltanleo/ARM_doc_v4/tree/master';
  HelpLinkStr = 'https://github.com/zoltanleo/ARM_doc_v4/wiki';

  EmptyDocTable = 'В БД отсутствуют сведения о работающих врачах!';
  EmptyClinicTable = 'В базе данных отсутствуют сведения об ЛПУ!';
  ShedulHint = 'Для %s в базе имеются актуальные заметки. Щелкните по сообщению, чтобы посмотреть их.';
  EmptyTownTable = 'В базе нет данных о населенных пунктах';
  PromptDataDrag = 'Перетащите сюда записи из соседней таблицы';
  ReportFileNotFound = 'Файл отчета "%s" не найден. Хотите поискать его самостоятельно?';

  CurrencyRu = 'руб.';

{$REGION 'FastReport reports names'}
  TitulList_A4 = 'TitulList_A4.fr3';
  TitulList_A5 = 'TitulList_A5.fr3';
  ResearchList_A4 = 'ResearchList_A4.fr3';
  ResearchList_A5 = 'ResearchList_A5.fr3';
  drag_annot_a4 = 'drag_annot_a4.fr3';
  drag_annot_a5 = 'drag_annot_a5.fr3';
  rt_recipe_107_A5 = 'recipe_107_A5.fr3';
  rt_recipe_148_88_small_A5 = 'recipe_148_88_A5_S.fr3';
  rt_recipe_148_88_large_A5 = 'recipe_148_88_A5_L.fr3';
  rt_recipe_148_04_A5 = 'recipe_148_04_A5.fr3';
  rt_recipe_107_A4 = 'recipe_107_A4.fr3';
  rt_recipe_148_88_small_A4 = 'recipe_148_88_A4_S.fr3';
  rt_recipe_148_88_large_A4 = 'recipe_148_88_A4_L.fr3';
  rt_recipe_148_04_A4 = 'recipe_148_04_A4.fr3';
  rt_inspection_common_A5 = 'inspection_common_A5.fr3';
  rt_inspection_common_A4 = 'inspection_common_A4.fr3';
  rt_lues_A5 = 'LuesList_A5.fr3';
  rt_lues_A4 = 'LuesList_A4.fr3';
  rt_consult_A4 = 'DocConsult_A4.fr3';
  rt_consult_A5 = 'DocConsult_A5.fr3';


{$ENDREGION}
{$REGION 'shortcut block'}
  ShortCutSave = 'Ctrl+Enter';
  ShortCutCancel = 'Esc';
  ShortCutSpace = 'Space';
  ShortCutEnter = 'Enter';
  ShortCutFind = 'Ctrl+F';
  ShortCutPrint = 'Ctrl+P';
  ShortCutHome = 'Shift+Ctrl+H';
  ShortCutMail = 'Shift+Ctrl+M';
  ShortCutDownload = 'Shift+Ctrl+D';
  ShortCutOpen = 'Ctrl+O';

  PgShortCutPrev = 'Shift+Ctrl+Left';
  PgShortCutNext = 'Shift+Ctrl+Right';
  SubPgShortCutPrev = 'Shift+Ctrl+Alt+Left';
  SubPgShortCutNext = 'Shift+Ctrl+Alt+Right';
  ShortCutEmpty = '';
  ShortCutImgBtn_1 = 'Shift+Ctrl+1';
  ShortCutImgBtn_2 = 'Shift+Ctrl+2';
  ShortCutImgBtn_3 = 'Shift+Ctrl+3';
  ShortCutImgBtn_4 = 'Shift+Ctrl+4';
  ShortCutImgBtn_5 = 'Shift+Ctrl+5';
  ShortCutImgBtn_6 = 'Shift+Ctrl+6';
  ShortCutAdd = 'Ctrl+N';
  ShortCutAddMore = 'Shift+Ctrl+N';
  ShortCutEdit = 'Ctrl+E';
  ShortCutDel = 'Ctrl+D';
  ShortCutEdtEx = 'Shift+Ctrl+E';
  ShortCutEdtEx2 = 'Shift+Alt+E';
  ShortCutInfo = 'Ctrl+I';
  ShortCutToggleGrid = 'Ctrl+Alt+Z';

  ShortCutHelp = 'Ctrl+F1';
  ImgAdd_1_ShortCut = 'Shift+1';
  ImgDel_1_ShortCut = 'Ctrl+1';
  ImgAdd_2_ShortCut = 'Shift+2';
  ImgDel_2_ShortCut = 'Ctrl+2';
  ImgAdd_3_ShortCut = 'Shift+3';
  ImgDel_3_ShortCut = 'Ctrl+3';
  ImgAdd_4_ShortCut = 'Shift+4';
  ImgDel_4_ShortCut = 'Ctrl+4';
  ImgAdd_5_ShortCut = 'Shift+5';
  ImgDel_5_ShortCut = 'Ctrl+5';
  ImgAdd_6_ShortCut = 'Shift+6';
  ImgDel_6_ShortCut = 'Ctrl+6';

  ShortCutRepCommon_A5 = 'Shift+Ctrl+F';
  ShortCutRepFull_A5 = 'Shift+Ctrl+E';
  ShortCutRepShort_A5 = 'Shift+Ctrl+W';

  ShortCutRepCommon_A4 = 'Ctrl+Alt+F';
  ShortCutRepFull_A4 = 'Ctrl+Alt+E';
  ShortCutRepShort_A4 = 'Ctrl+Alt+W';

  ShortCutNewDB = 'F2';
  ShortCutOpenDb = 'F3';
  ShortCutCloseDB = 'F11';
  ShortCutExitProgram = 'F12';
  ShortCutDataRefresh = 'F5';
  ShortCutViewPat = 'F6';
  ShortCutViewTotal = 'F7';
  ShortCutPatPayment = 'Ctrl+M';
  ShortCutShedul = 'Ctrl+L';
  ShortCutFindPat = 'Ctrl+F';
  ShortCutCallHlpGeneral = 'F1';
  ShortCutAbout = 'Ctrl+F1';

  ShortCutReportResearch = 'Shift+Ctrl+Y';
  ShortCutTitulList = 'Shift+Ctrl+U';
  ShortCutReportInspectPict_A5 = 'Shift+Ctrl+G';
  ShortCutReportInspectPict_A4 = 'Ctrl+Alt+G';
  ShortCutReportLuesList = 'Shift+Ctrl+H';

  ShortCutDocSchedule = 'Shift+Ctrl+I';
{$ENDREGION}
{$REGION 'SQL text block'}
  {$REGION 'TblCLinic'}
    SQLTextClinicSelect =
        'SELECT ' +
          'ID_CLINIC, CLIN_NAME, CLIN_ADRESS, CLIN_ADRESSBOOL, ' +
          'CLIN_PHONE, CLIN_REKVIZIT, CLIN_LOGOS, CLIN_LOGOS_EXT, ' +
          'CLIN_LOGOSBOOL, CLIN_INTERNET, CLIN_LICENSE, CLIN_LICENSEBOOL, CLIN_NALOG ' +
        'FROM TBL_CLINIC ' +
        'ORDER BY 1';

    SQLTextClinicInsert =
        'INSERT INTO TBL_CLINIC (' +
          'CLIN_NAME, CLIN_ADRESS, CLIN_ADRESSBOOL, CLIN_PHONE, ' +
          'CLIN_REKVIZIT, CLIN_LOGOS, CLIN_LOGOS_EXT, CLIN_LOGOSBOOL, ' +
          'CLIN_INTERNET, CLIN_LICENSE, CLIN_LICENSEBOOL, CLIN_NALOG) ' +
        'VALUES (' +
          ':CLIN_NAME, :CLIN_ADRESS, :CLIN_ADRESSBOOL, :CLIN_PHONE, ' +
          ':CLIN_REKVIZIT, :CLIN_LOGOS, :CLIN_LOGOS_EXT, :CLIN_LOGOSBOOL, ' +
          ':CLIN_INTERNET, :CLIN_LICENSE, :CLIN_LICENSEBOOL, :CLIN_NALOG) ' +
        'RETURNING ID_CLINIC';

    SQLTextClinicUpdate =
        'UPDATE TBL_CLINIC ' +
        'SET CLIN_NAME = :CLIN_NAME, ' +
            'CLIN_ADRESS = :CLIN_ADRESS, ' +
            'CLIN_ADRESSBOOL = :CLIN_ADRESSBOOL, ' +
            'CLIN_PHONE = :CLIN_PHONE, ' +
            'CLIN_REKVIZIT = :CLIN_REKVIZIT, ' +
            'CLIN_LOGOS = :CLIN_LOGOS, ' +
            'CLIN_LOGOS_EXT = :CLIN_LOGOS_EXT, ' +
            'CLIN_LOGOSBOOL = :CLIN_LOGOSBOOL, ' +
            'CLIN_INTERNET = :CLIN_INTERNET, ' +
            'CLIN_LICENSE = :CLIN_LICENSE, ' +
            'CLIN_LICENSEBOOL = :CLIN_LICENSEBOOL, ' +
            'CLIN_NALOG = :CLIN_NALOG ' +
        'WHERE (ID_CLINIC = :ID_CLINIC)';

    SQLTextClinicDelete =
        'DELETE FROM TBL_CLINIC ' +
        'WHERE (ID_CLINIC = :ID_CLINIC)';
  {$ENDREGION}
  {$REGION 'Doctor'}
      SQLTextTblDocSelect =
          'SELECT ' +
            'ID_DOCTOR, ' +
            'DOC_STUFFSTATUS, ' +
            'TRIM(' +
            'TRIM(CASE DOC_STEPEN ' +
                   'WHEN 0 THEN '''' ' +
                   'WHEN 1 THEN ''к.м.н.,'' ' +
                   'WHEN 2 THEN ''д.м.н.,'' ' +
                 'END)||'' ''||' +
            'TRIM(CASE DOC_CATEGORY ' +
                   'WHEN 0 THEN ''врач'' ' +
                   'WHEN 1 THEN ''врач 2-й кат.'' ' +
                   'WHEN 2 THEN ''врач 1-й кат.'' ' +
                   'WHEN 3 THEN ''врач высш.кат.'' ' +
                 'END)||'' ''||' +
            'DOC_PROFIL||'' ''||' +
            'DOC_LASTNAME||'' ''||' +
            'UPPER(LEFT(DOC_FIRSTNAME, 1))||''.''||' +
            'UPPER(LEFT(DOC_THIRDNAME, 1))||''.''' +
            ') AS FULL_INFO ' +
          'FROM TBL_DOCTOR ' +
          'ORDER BY 1';
  {$ENDREGION}
{$ENDREGION}
{$REGION 'HelpContext Constants'}
//здесь перечислены некоторые константы
//для имитации HelpContext контроллов,
//вызывающих справку

//  HlpCtxBasePrice: Integer = 3235;
//  HlpCtxConnect: Integer = 3212;
//  HlpCtxIFA: Integer = 32254;
//  HlpCtxBloodHorm: Integer = 32254;
//  HlpCtxShedul: Integer = 32210;
//  HlpCtxStatusPat_0: Integer = 32251;
//  HlpCtxStatusPat_1: Integer = 32252;
//  HlpCtxStatusPat_2: Integer = 32253;
//  HlpCtxStatusPat_3: Integer = 32254;
//  HlpCtxStatusPat_4: Integer = 32255;
//  HlpCtxStatusPat_5: Integer = 32256;
//  HlpCtxAnketa: Integer = 3221;
//  HlpCtxClinic: Integer = 3233;
//  HlpCtxDoctor: Integer = 3232;
//  HlpCtxDrugs: Integer = 3237;
//  HlpCtxDs: Integer = 3238;
//  HlpCtxManip: Integer = 3239;
//  HlpCtxPayment: Integer = 3229;
//  HlpCtxPrice: Integer = 3235;
//  HlpCtxRecom: Integer = 32310;
//  HlpCtxTown: Integer = 3231;
//  HlpCtxConsultation: Integer = 3234;
//  HlpCtxReportResearch: Integer = 324;

{$ENDREGION}

{$REGION 'Functions & procedures declaration section'}
    //блок объявления процедур
    function PrmIsDigit(const APrm: string): Boolean;
    function PrmIsDigitSymb(const PrmKey: Char): Boolean;
    function PrmIsLatinSymb(var PrmKey: Char): Boolean;
    function PrmIsCyrillicSymb(var PrmKey: Char): Boolean;

    function WriteSymbolToEndString(const TmpString, TmpSymbol: String): String;
    function GetRTFText(ARichEdit: TRichedit): AnsiString;
    function UpFirstChar(Sender: TEdit): String;
    function UpFirstCharEhEdt(Sender: TDBEditEh): String;
    function BoolConvertInt(const ChkStatus: Boolean): Integer;
    function IntConvertBool(const VarInt: Integer): Boolean;
    function RemoveTmpDir(sDir: String): Boolean;
    function GetFileSize(const FileName: string): longint;
    function FormatStrListToBulkText(ARichEdt: TRichEdit; ExcludStr: String;
                                                                      ShrtVar: Boolean): AnsiString;
    function CutStrFromBulkText(ARichEdt: TRichEdit; ExcludStr: String): AnsiString;
    function PADC(Src:string; Lg:Integer): string;
    function PADR(Src:string; Lg:Integer): string;
    function PADL(Src:string; Lg:Integer): string;

    function DeleteBlank(S: String): String;
    function GetFBDefaultInstance: string;//получение полного пути к каталогу FB из реестра
    function InvertStr(const AStr: string): string;//инверсия строки
    function GetLastUsedKeyLayout: Integer;
    procedure SetLastUsedKeyLayout(aKeybrdLayoutNum: Integer);
    procedure OutputStrToFile(aStr: string; const aFileName: string);


{$ENDREGION}

implementation

//----------------------------------------------------------------------------
//функция проверяет, содержит ли строка целое число без пробелов(в т.ч. и отрицательное)
function PrmIsDigit(const APrm: string): Boolean;
const TmpTxt: string = '-0123456789';
var i,counter: Integer;
begin
  Result:= False;
  if Length(Trim(APrm)) = 0  then Exit;//выйдем, если строка пустая

  counter:= 0;//обнулим счетчик

  //каждый символ строки сравниваем с эталоном
  //если хоть один символ не присутствует в строке, то наращиваем счетчик
  for i:= 1 to Length(APrm) do
    if (Pos(APrm[i],TmpTxt) = 0) then Inc(counter);

  Result:= (counter = 0);
end;

//----------------------------------------------------------------------------
//функция проверяет, является ли переданный символ целым числом
function PrmIsDigitSymb(const PrmKey: Char): Boolean;
const TmpStr: string = '0123456789';
begin
  Result:= (Pos(PrmKey,TmpStr) > 0);
end;

//----------------------------------------------------------------------------
//функция проверяет, является ли переданный символ частью массива кириллических знаков
function PrmIsCyrillicSymb(var PrmKey: Char): Boolean;
//const TmpStr: array[0..66] of Char = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя';
//var i, counter: Integer;
const TmpStr: string = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя';
begin
Result:= (Pos(PrmKey,TmpStr) > 0);

//counter:= 0;
//for i:= 0 to High(TmpStr) - 1 do
//    if ord(TmpStr[i]) = ord(PrmKey) then Inc(counter);
//
//Result:= (counter > 0);
end;

//----------------------------------------------------------------------------
//функция проверяет, является ли переданный символ частью массива латинских знаков
function PrmIsLatinSymb(var PrmKey: Char): Boolean;
//const TmpStr: array[0..52] of Char = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
//var i, counter: Integer;
const TmpStr: string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
begin
//counter:= 0;
//for i:= 0 to High(TmpStr) - 1 do
//    if ord(TmpStr[i]) = ord(PrmKey) then Inc(counter);
//
//Result:= (counter > 0);
Result:= (Pos(PrmKey,TmpStr) > 0); 
end;

//----------------------------------------------------------------------------
// функция проверяет, не является ли последний знак в строке TmpString запятой, точкой
// или точкой с запятой. Если таковые имеются, то обрезает любую из них, а затем
// вставляет в конец строки строку TmpSymbol.
// Полученная строка возращается в Result функции

function WriteSymbolToEndString(const TmpString, TmpSymbol: String): String;
begin
Result:= Trim(TmpString);
if (RightStr(Result,1) = ',') or (RightStr(Result,1) = '.') or (RightStr(Result,1) = ';')
  then
    Result:= LeftStr(Result,Length(Result)-1) + TmpSymbol
  else
    Result:= Result + TmpSymbol;
end;

//----------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////
/////  Функция, возвращающая строку RTF. Нужна, например, для передачи     /////
/////  форматированного текста из RichEdit в строковую переменную типа     /////
/////  AnsiString.                                                         /////
////////////////////////////////////////////////////////////////////////////////

function GetRTFText(ARichEdit: TRichedit): AnsiString;
var ss: TStringStream;
begin
ss := TStringStream.Create(EmptyStr);
   try
     ARichEdit.PlainText := False;
     ARichEdit.Lines.SaveToStream(ss);
     Result := ss.DataString;
   finally
     ss.Free
   end;
end;

//----------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////
/////  Функция, делает заглавной первую букву в первом слове текста Edit'а /////
////////////////////////////////////////////////////////////////////////////////

function UpFirstChar(Sender: TEdit): String;
begin
if Length(Trim(Sender.Text)) = 1 then
  begin
    Sender.Text:= AnsiUpperCase(Sender.Text);
    Sender.SelStart:= 1;
  end;
end;

//----------------------------------------------------------------------------
//аналогично предыдущей функции, только для TDBEditEh
function UpFirstCharEhEdt(Sender: TDBEditEh): String;
begin
if Length(Trim(Sender.Text)) = 1 then
  begin
    Sender.Text:= AnsiUpperCase(Sender.Text);
    Sender.SelStart:= 1;
  end;
end;

//----------------------------------------------------------------------------
//переводим check/uncheck радиокнопок в цифру
function BoolConvertInt(const ChkStatus: Boolean): Integer;
begin
if ChkStatus
  then Result:= 1
  else Result:= 0;
end;

//----------------------------------------------------------------------------
//переводим цифру в check/uncheck радиокнопок
function IntConvertBool(const VarInt: Integer): Boolean;
begin
if VarInt = 1
  then Result:= True
  else Result:= False;
end;

//----------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////////////
/////      Процедура добавления в текст RichEdit подчеркнутой строки     /////
//////////////////////////////////////////////////////////////////////////////

procedure AddFormatStrInRichEdit(Sender: TRichEdit; const Txt: String);
begin
with TRichEdit(Sender) do
  begin
      Lines.Add(Txt);
      SelStart:= Length(Text) - Length(Txt) - 2;
      SelLength:= Length(Txt);//выделяем "нужную" часть строки
      SelAttributes.Style:= [fsUnderline];//почеркиваем выделенный текст
      SelStart:= Length(Text);//курсор в конец текста
      SelLength:= 0;//уберем выделение
      SelAttributes.Assign(DefAttributes);//дефолтовые атрибуты
  end;{with TRichEdit(Sender) do}
end;

//----------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////////////
/////  Процедура форматирует текст в данном RichEdit в соответствии с    /////
///// переданными параметрами:                                           /////
///// ARichEdit - переданный рич-эдит                                    /////
///// CurStart - начальная позиция курсора для выделения                 /////
///// Index - "номер" цвета форматируемой строки                         /////
///// TxtStr - форматируемая строка                                      /////
//////////////////////////////////////////////////////////////////////////////

procedure FormatTextInTempRichEdit(ARichEdit: TRichEdit;
  const CurStart, Index: Integer; TxtStr: String);
begin
with ARichEdit do
      begin
        PlainText:= False;
        Lines.Add(TxtStr);//добавляем строку
        SelStart:= Length(Text) - CurStart - 2;//откатываемся назад
        SelLength:= CurStart - 1;//выделяем "нужное" кол-во символов
        with SelAttributes do //красим выделенную строку
          begin
            case Index of
              0: Color:= clNavy;
              1: Color:= clTeal;
              2: Color:= clMaroon;
              //3: Color:= clRed;
            3,4: begin
                  Color:= clRed;
                  Style:= [fsBold];
                 end;
            end;{case}
          end;{with SelAttributes do}
        SelStart:= Length(Text);//курсор в конец текста
        SelAttributes.Assign(DefAttributes);//возвращаем дефолтовые аттрибуты
      end;{with TRichEdit(Sender) do}
end;

//----------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////////////
///// Процедура переключает вкладку PgCtrlSender с номером SheetNum,     /////
///// и передает фокус в EdtSender                                       /////
//////////////////////////////////////////////////////////////////////////////

procedure SetFocusToEmptyEdit(EdtSender: TEdit; PgCtrlSender: TPageControl;
                                                                 const SheetNum: Integer);
begin
PgCtrlSender.ActivePageIndex:= SheetNum;
if EdtSender.CanFocus then EdtSender.SetFocus;
end;

///////////////////////////////////////////////////////////////////////////////
//////             Функции упаковки-распаковки блоб-полей               ///////
///////////////////////////////////////////////////////////////////////////////

//---------------------------------------------------------------

procedure PackBuffer(var Buffer: PChar; var BufSize: Integer);
//var srcStream, dstStream: TStream;
begin
//srcStream := TMemoryStream.Create;
//dstStream := TMemoryStream.Create;
//  try
//    srcStream.WriteBuffer(Buffer^, BufSize);
//    srcStream.Position := 0;
//    UclCompressStream(srcStream, dstStream);
//    //GZipStream(srcStream, dstStream, 6);
//    srcStream.Free;
//    srcStream := nil;
//    BufSize := dstStream.Size;
//    dstStream.Position := 0;
//    ReallocMem(Buffer, BufSize);
//    dstStream.ReadBuffer(Buffer^, BufSize);
//  finally
//    if Assigned(srcStream) then srcStream.Free;
//    dstStream.Free;
//  end;
end;

//---------------------------------------------------------------

procedure UnpackBuffer(var Buffer: PChar; var BufSize: Integer);
//var srcStream,dstStream: TStream;
begin
//srcStream := TMemoryStream.Create;
//dstStream := TMemoryStream.Create;
//  try
//    srcStream.WriteBuffer(Buffer^, BufSize);
//    srcStream.Position := 0;
//    UclDeCompressStream(srcStream, dstStream);
//    //GunZipStream(srcStream, dstStream);
//    srcStream.Free;
//    srcStream:=nil;
//    BufSize := dstStream.Size;
//    dstStream.Position := 0;
//    ReallocMem(Buffer, BufSize);
//    dstStream.ReadBuffer(Buffer^, BufSize);
//  finally
//    if assigned(srcStream) then srcStream.Free;
//    dstStream.Free;
//  end;
end;

//---------------------------------------------------------------
//удаление каталога с подкаталогами
function RemoveTmpDir(sDir: String): Boolean;
var iIndex : Integer;
    SearchRec : TSearchRec;
    sFileName : String;
begin
  Result := False;
  sDir := sDir + '\*.*';
  iIndex := FindFirst(sDir, faAnyFile, SearchRec);
  while iIndex = 0 do
    begin
      sFileName := ExtractFileDir(sDir)+'\'+SearchRec.Name;
      if SearchRec.Attr = faDirectory
        then
          begin
            if (SearchRec.Name <> '' ) and (SearchRec.Name <> '.') and (SearchRec.Name <> '..')
              then
                RemoveTmpDir(sFileName);
          end
        else
          begin
            if SearchRec.Attr <> faArchive
              then FileSetAttr(sFileName, faArchive);
            if not DeleteFile(sFileName)
              then ShowMessage('Невозможно удалить папку ' + sFileName);
          end;
      iIndex := FindNext(SearchRec);
    end;
  FindClose(SearchRec);
  RemoveDir(ExtractFileDir(sDir));
  Result := True;
end;

//---------------------------------------------------------------
//вычисляем размер файла
function GetFileSize(const FileName: string): longint;
var
SearchRec : TSearchRec;
begin
if FindFirst(ExpandFileName(FileName),faAnyFile,SearchRec)=0
then Result:=SearchRec.Size
else Result:=-1;
FindClose(SearchRec);
end;

//----------------------------------------------------------
//копируем файл с одного места в другой методом потока
procedure FileCopy(const SourceFileName, TargetFileName: String);
var S,T: TFileStream;
Begin
 S:= TFileStream.Create(sourcefilename, fmOpenRead );
 try
  T:= TFileStream.Create(targetfilename, fmOpenWrite or fmCreate);
  try
    T.CopyFrom(S, S.Size ) ;
    FileSetDate(T.Handle, FileGetDate(S.Handle));
  finally
   T.Free;
  end;
 finally
  S.Free;
 end;
end;

//---------------------------------------------------------------
//функция возвращает строку, состоящую из последовательно "склеенных" строк ARichEdt, отделенных
//друг от друга запятыми.
//Параметр ExcludStr позволяет удалить первую строчку рич-эдита, если она имеет содержащиеся
//в нем символы (без учета) регистра - для "обрезания" заголовка.
//Параметр ShrtVar позволяет возвращать от каждой строчки рич-эдита только одно слово в нижнем
//регистре.
//
// ВНИМАНИЕ!
// Каждая строка рич-эдита будет отделена запятой от соседней, если только она начинается с
// символов "-", "+" или "*"

function FormatStrListToBulkText(ARichEdt: TRichEdit; ExcludStr: String; ShrtVar: Boolean): AnsiString;
var i: Integer;
    TmpBool: Boolean;
    tmpstr, tstr: AnsiString;//внутренние переменные
    TmpRE: TRichEdit;
begin
  tmpstr:= '';
  TmpRE:= TRichEdit.Create(ARichEdt.Parent);
  try
    with TmpRE do
      begin
        Parent:= ARichEdt.Parent;
        PlainText:= True;
        Visible:= False;

        Lines.Assign(ARichEdt.Lines);

        if Trim(Text) = '' then
          begin
            Result:= '';
            Exit;
          end;

        if Pos(AnsiUpperCase(ExcludStr),AnsiUpperCase(Lines.Strings[0])) > 0 then  Lines.Delete(0);

        if ShrtVar
          then //если в текст вписывается по 1 слову от строки
            begin
              //если нужно оставить только одно слово от каждой строки
              for i:= 0 to Lines.Count - 1 do
                begin
                  tstr:= Trim(Lines.Strings[i]);//обрезаем пробелы

                  if ((Pos('-',tstr) = 1) or (Pos('*',tstr) = 1) or (Pos('+',tstr) = 1))
                    then //если встречаются символы "+", "-", "*" в самом начале строки
                      begin
                        //перебираем строки, пока не кончились
                        while ((Pos('-',tstr) = 1) or (Pos('*',tstr) = 1) or (Pos('+',tstr) = 1)) do
                          begin
                            tstr:= Trim(RightStr(tstr,Length(tstr) - 1));//нещадно их обрезаем
                          end;

                        //"декапитализируем" слово
                        tstr:= AnsiLowerCase(tstr);

                        if i = 0
                          then
                            tmpstr:= LeftStr(tstr,pos(' ',tstr)-1)//если это самая первая строка
                          else
                            tmpstr:= tmpstr + ', ' + LeftStr(tstr,pos(' ',tstr)-1);//если не самая
                                                              //первая, то перед ней поставим запятую
                      end;
                end;
            end
          else //если строки вписываются в текст полностью
            begin
              for i:= 0 to Lines.Count - 1 do
                begin
                  tstr:= Trim(Lines.Strings[i]);//обрезаем пробелы

                  if ((Pos('-',tstr) = 1) or (Pos('*',tstr) = 1) or (Pos('+',tstr) = 1))
                    then //если встречаются символы "+", "-", "*"
                      begin
                        while ((Pos('-',tstr) = 1) or (Pos('*',tstr) = 1) or (Pos('+',tstr) = 1)) do
                          begin
                            tstr:= Trim(RightStr(tstr,Length(tstr) - 1));//нещадно их обрезаем
                          end;
                        TmpBool:= True; //флаг того, строку кромсали от указанных символов
                      end
                    else
                      TmpBool:= False;//флаг того, что строку не кромсали
                  if TmpBool
                    then //если строку кромсали
                      begin
                        if i = 0
                          then tmpstr:= tstr //если это самая первая строка
                          else tmpstr:= tmpstr + ', ' + tstr;//если не самая первая, то перед ней
                                                             //поставим запятую
                      end
                    else //если не кромсали, то просто присоединим через пробел
                      tmpstr:= tmpstr + ' ' + Trim(tstr);
                end;
            end;

        Result:= Trim(tmpstr) + '.';
      end;
  finally
    TmpRE.Free;
  end;
end;

//--------------------------------------------------------------------------
//функция вырезает из текста ARichEdt начальную построку ExcludStr (без учета регистра)
//и возвращает текст
function CutStrFromBulkText(ARichEdt: TRichEdit; ExcludStr: String): AnsiString;
var LenStr: Integer;
begin
LenStr:= Pos(AnsiUpperCase(Trim(ExcludStr)),AnsiUpperCase(Trim(ARichEdt.Text)));
if LenStr > 0
  then
    Result:= RightStr(Trim(ARichEdt.Text), Length(Trim(ARichEdt.Text)) - LenStr
                                                                      - length(Trim(ExcludStr)));
end;

//--------------------------------------------------------------------------
{ **** UBPFD *********** by ****
>> Дополнение строки пробелами с обоих сторон

Дополнение строки пробелами с обоих сторон до указанной длины

Зависимости: нет
Автор:       Anatoly Podgoretsky, anatoly@podgoretsky.com, Johvi
Copyright:
Дата:        26 апреля 2002 г.
пример использования:      S := PADC(S,32);

******************************* }

function PADC(Src:string; Lg:Integer) : string;
begin
  Result := Src;
  while Length(Result) < Lg do begin
    Result := Result + ' ';
    if Length(Result) < Lg then begin
      Result := ' ' + Result;
    end;
  end;
end;

//--------------------------------------------------------------------------
{ **** UBPFD *********** by ****
>> Дополнение строки пробелами справа

Дополняет строку пробелами справа до указанной длины.

Зависимости: нет
Автор:       Anatoly Podgoretsky, anatoly@podgoretsky.com, Johvi
Copyright:   Anatoly Podgoretsky
Дата:        26 апреля 2002 г.

пример использования:      S := PADR(S,32);
******************************* }

function PADR(Src:string; Lg:Integer) : string;
begin
  Result := Src;
  while Length(Result) < Lg do Result := Result + ' ';
end;

//--------------------------------------------------------------------------
{ **** UBPFD *********** by ****
>> Дополнение строки пробелами слева

Дополненяет строку слева пробелами до указанной длины

Зависимости: нет
Автор:       Anatoly Podgoretsky, anatoly@podgoretsky.com, Johvi
Copyright:  
Дата:        26 апреля 2002 г.

пример использования:      S := PADL(S,32);
******************************* }

function PADL(Src:string; Lg:Integer) : string;
begin
  Result := Src;
  while Length(Result) < Lg do Result := ' ' + Result;
end;


//--------------------------------------------------------------------------
{ **** UBPFD *********** by ****
>> Удаление лишних пробелов в строке (рекурсивное удаление)

Зависимости: SysUtils
Автор:       COOLer, COOLer_Master@mail.ru, ICQ:315733656, Омск
Copyright:   Interactive Incode - т.е. придумал сам.
Дата:        12 мая 2004 г.


******************************* }

function DeleteBlank(S : String) : String;
 var
  i : Integer;
begin
 for I := 2 to Length (S) + 1 do {делаем до длины строки}
  begin
   if (S[I-1] = ' ') and (S[I] = ' ') then {проверяем на пробелы}
    begin {да, есть лишние}
     Delete (S, I, 1); {удаляем их}
     S := DeleteBlank (S); {и снова проверяем}
    end; {рекурсия происходит до тех пор, пока строка не примет нормальный вид}
  end;
 Result := S; {результат}
end;

//----------------------------------------------------------------------------------
//----------------------------------------------------------------------------
//вызов справки по HelpContext сендера,
//если специальная переменная с ID топика (HlpCntx) имеет
//дефолтное значение и равна 0.
//Если и HelpContext у сендера имеет 0 значение, то вызывается
//раздел справки с ID=1
//ChmFileName - название файла справки (может включать абсолютный или относительный путь)
//procedure CallMyDocByHlpContext(Sender: TObject; HlpCntx: Integer);
//var IDindex: Integer;
//begin
//if not FileExists(ExtractFilePath(Application.ExeName) + ChmFileName) then
//  begin
//    Application.MessageBox('Файл справки отсутствует!','Ошибка доступа к файлу', MB_ICONINFORMATION);
//    Exit;
//  end;
//
//if HlpCntx = 0
//  then
//    begin
//      if (Sender as TControl).HelpContext = 0
//        then
//          begin
//            Application.MessageBox(PChar('Данному элементу не сопоставлен ни один из разделов справки. '
//                                   + 'Обратитесь разработчику или попробуйте поискать раздел самостоятельно.'),
//                                    'Ошибка доступа к справке', MB_ICONINFORMATION);
//            Exit;
//          end
//        else
//          IDindex:= (Sender as TControl).HelpContext;
//    end
//  else
//    IDindex:= HlpCntx;
//
//HH(Application.Handle, PChar(ChmFileName), HH_HELP_CONTEXT, IDindex);
//end;

////----------------------------------------------------------------------------
//
//function GetSystemPath(SystemPath: TSystemPath): string;
//var p:PChar;
//begin
//with TRegistry.Create do
//  try
//    RootKey := HKEY_CURRENT_USER;
//    OpenKeyReadOnly('\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders');
//      case SystemPath of
//        Desktop: result:=readstring('desktop');
//        StartMenu:result:=readstring('start menu');
//        Programs:result:=readstring('programs');
//        StartUp:result:=readstring('startup');
//        Personal:result:=readstring('personal');
//        Templates:result:=readstring('Templates');
//        Cache: result:=readstring('Cache');
//        MyPictures: result:=readstring('My Pictures');
//        MyVideo: result:=readstring('My Video');
//        AdministrativeTools: result:=readstring('Administrative Tools');
//        CD_Burning: result:=readstring('CD Burning');
//        WinRoot: begin
//                   GetMem(p,255);
//                   GetWindowsDirectory(p,254);
//                   Result:=StrPas(p);
//                   FreeMem(p);
//                 end;
//        WinSys:  begin
//                   GetMem(p,255);
//                   GetSystemDirectory(p,254);
//                   Result:=StrPas(p);
//                   FreeMem(p);
//                 end;
//      end;
//  finally
//    CloseKey;
//    Free;
//  end;
//
//  if (Result <> '') and (Result[Length(Result)]<>'') then Result:= Result + '';
//end;

//----------------------------------------------------------------------------
//получение полного пути к каталогу FB из реестра
function GetFBDefaultInstance: string;
begin
Result:= '';
with TRegistry.Create do
  begin
    try
      RootKey:= HKEY_LOCAL_MACHINE;
      if OpenKeyReadOnly('\SOFTWARE\Firebird Project\Firebird Server\Instances') then
        if ValueExists('DefaultInstance') then
          begin
            OpenKeyReadOnly('DefaultInstance');
            Result:= ReadString('DefaultInstance');
          end;
     finally
      CloseKey;
      Free;
    end;
  end;
end;

//----------------------------------------------------------------------------
//функция возвращает инвертированную строку (т.е. 'строка' возвращается как 'акортс')

//Зависимости: Windows, Classes, StdCtrls
//Автор:       Fenik, chook_nu@uraltc.ru, Новоуральск
//Copyright:   Автор: Федоровских Николай
//Дата:        26 июня 2002 г.

function InvertStr(const AStr: string): string;
var i, Len: Integer;
begin
Len := Length(AStr);
SetLength(Result, Len);
for i := 1 to Len do
  Result[i] := AStr[Len - i + 1];
end;

//----------------------------------------------------------------------------
///   This function reads the file resource of "FileName" and returns
///   the version number as formatted text.

///   Sto_GetFmtFileVersion() = '4.13.128.0'
///   Sto_GetFmtFileVersion('', '%.2d-%.2d-%.2d') = '04-13-128'

/// If "Fmt" is invalid, the function may raise an EConvertError exception.
/// <param name="FileName">Full path to exe or dll. If an empty
///   string is passed, the function uses the filename of the
///   running exe or dll.</param>
/// <param name="Fmt">Format string, you can use at most four integer
///   values.</param>
/// <returns>Formatted version number of file, '' if no version
///   resource found.</returns>

function Sto_GetFmtFileVersion(const FileName, Fmt: String): String;
var
  sFileName: String;
  iBufferSize: DWORD;
  iDummy: DWORD;
  pBuffer: Pointer;
  pFileInfo: Pointer;
  iVer: array[1..4] of Word;
begin
  // set default value
  Result := '';
  // get filename of exe/dll if no filename is specified
  sFileName := FileName;
  if (sFileName = '') then
  begin
    // prepare buffer for path and terminating #0
    SetLength(sFileName, MAX_PATH + 1);
    SetLength(sFileName,
      GetModuleFileName(hInstance, PChar(sFileName), MAX_PATH + 1));
  end;
  // get size of version info (0 if no version info exists)
  iBufferSize := GetFileVersionInfoSize(PChar(sFileName), iDummy);
  if (iBufferSize > 0) then
  begin
    GetMem(pBuffer, iBufferSize);
    try
    // get fixed file info (language independent)
    GetFileVersionInfo(PChar(sFileName), 0, iBufferSize, pBuffer);
    VerQueryValue(pBuffer, '\', pFileInfo, iDummy);
    // read version blocks
    iVer[1] := HiWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionMS);
    iVer[2] := LoWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionMS);
    iVer[3] := HiWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionLS);
    iVer[4] := LoWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionLS);
    finally
      FreeMem(pBuffer);
    end;
    // format result string
    Result := Format(Fmt, [iVer[1], iVer[2], iVer[3], iVer[4]]);
  end;
end;

//----------------------------------------------------------------------------
    //функция проверяет корректность url или мыла и возвращает "правильную строку"
function Sto_UrlEncode(const Text: String): String;
var
  iPos: Integer;
  cCharacter: Char;
begin
  Result := Text;
  // search for not web save characters
  for iPos := Length(Result) downto 1 do
  begin
    cCharacter := Result[iPos];
    if (not (cCharacter in ['A'..'Z', 'a'..'z', '0'..'9'])) then
    begin
      Delete(Result, iPos, 1);
      Insert('%' + IntToHex(Ord(cCharacter), 2), Result, iPos);
    end;
  end;
end;

//----------------------------------------------------------------------------

procedure Sto_OpenMail(const Address: String; const Subject: String = '';
  const Body: String = ''; const Cc: String = ''; const Bcc: String = '');
var
  slParameters: TStrings;
  sMailCommand: String;
  iParameter: Integer;
begin
  slParameters := TStringList.Create;
  try
    if (Subject <> '') then slParameters.Add('subject=' + Sto_UrlEncode(Subject));
    if (Body <> '') then slParameters.Add('body=' + Sto_UrlEncode(Body));
    if (Cc <> '') then slParameters.Add('cc=' + Cc);
    if (Bcc <> '') then slParameters.Add('bcc=' + Bcc);

    // bring parameters into a form like:
    // mailto:<address>?subject=<subjectline>&body=<mailtext>&cc=<address>&bcc=<address>
    sMailCommand := 'mailto:' + Address;

    for iParameter := 0 to slParameters.Count - 1 do
      begin
        if (iParameter = 0) then
          sMailCommand := sMailCommand + '?'
        else
          sMailCommand := sMailCommand + '&';
        sMailCommand := sMailCommand + slParameters.Strings[iParameter];
      end;
    ShellExecute(0, 'open', PChar(sMailCommand), nil, nil, SW_SHOWNORMAL);
  finally
    slParameters.Free;
  end;
end;


//----------------------------------------------------------------------------
//открываем url
procedure Sto_OpenWebSite(const Site: String);
begin
  ShellExecute(0, 'open', PChar(Site), nil, nil, SW_SHOWNORMAL);
end;

//----------------------------------------------------------------------------
//процедура открывает CHM-файл не только на определенной странице, но и на определенной закладке (если она введена)
//ChmFN путь с CHM-файлу, начиная от корня с экзешником
//TopicFileName - имя страницы(*.htm) топика
//BookMark - имя закладки
procedure CallHelpTopic_With_Bookmark(const ChmFN: string = ''; const TopicFileName: string = ''; const BookMark: string = '');
begin
if (Trim(ChmFN) = '') or (Trim(TopicFileName) = '') then Exit;

if Length(Trim(BookMark)) <> 0
  then
    ShellExecute(Application.Handle,'open',PChar('hh.exe'),
      pchar(ExtractFileDir(Application.ExeName) + '\' +ChmFN + '::/' + Trim(TopicFileName) + '#' + Trim(BookMark)),nil,SW_SHOW)
  else
    ShellExecute(Application.Handle,'open',PChar('hh.exe'),
      pchar(ExtractFileDir(Application.ExeName) + '\' +ChmFN + '::/' + Trim(TopicFileName)),nil,SW_SHOW);
end;
//----------------------------------------------------------------------------

//получаем текущую раскладку
function GetLastUsedKeyLayout: Integer;
begin
  Result:= GetKeyboardLayout(GetWindowThreadProcessId(GetForegroundWindow, nil));
end;

//переключаемся на сохраненную раскладку
procedure SetLastUsedKeyLayout(aKeybrdLayoutNum: Integer);
begin
  {"волшебные" цифры 68748313(для русской клавы) и 67699721(для аглицкой) получены через }
  {функцию GetKeyboardLayout - см. метод OnClose этой формы}

  case aKeybrdLayoutNum of
    68748313: LoadKeyboardLayout('00000419', KLF_ACTIVATE); //переключаемся на кириллицу
    else
      LoadKeyboardLayout('00000409', KLF_ACTIVATE); //переключаемся на латиницу
  end;
end;

//вывод строки в файл (для отладки)
procedure OutputStrToFile(aStr: string; const aFileName: string);
var
  SL: TStringList;
begin
  SL:= TStringList.Create;
  try
    if FileExists(aFileName) then
      if not DeleteFile(aFileName) then
      begin
        Application.MessageBox(PChar(Format('Невозможно удалить файл "%s"',[aFileName])),
                                'Невыполнимая операция',
                                MB_ICONERROR);
        Exit;
      end;

    SL.Clear;
    SL.Text:= aStr;
    SL.Add('');
    SL.Add('=============');
    SL.Add(FormatDateTime('dd.mm.yyyy hh:nn:ss.zzzz',Now));
    SL.SaveToFile(aFileName, TEncoding.UTF8);
  finally
    SL.Free;
  end;
end;

end.
