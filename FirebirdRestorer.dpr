program FirebirdRestorer;

uses
  Vcl.Forms,
  ViewMain in 'Main\ViewMain.pas' {WindowMain},
  MyArrays in 'Code\MyArrays.pas',
  MyDialogs in 'Code\MyDialogs.pas',
  MyUtils in 'Code\MyUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TWindowMain, WindowMain);
  Application.Run;
end.
