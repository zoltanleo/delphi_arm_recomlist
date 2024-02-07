program Project1;

uses
  Vcl.Forms,
  uRecomList in 'uRecomList.pas' {frmRecomList},
  uNodeInfo in 'uNodeInfo.pas' {frmNodeInfo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmRecomList, frmRecomList);
  Application.Run;
end.
