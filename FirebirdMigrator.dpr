program FirebirdMigrator;





{$R *.dres}

uses
  Vcl.Forms,
  ViewMain in 'View\ViewMain.pas' {WindowMain},
  MyDialogs in 'Code\MyDialogs.pas',
  MyUtils in 'Code\MyUtils.pas',
  Backup in 'Controller\Backup.pas',
  Restore in 'Controller\Restore.pas',
  Migration in 'Controller\Migration.pas',
  Config in 'Controller\Config.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TWindowMain, WindowMain);
  Application.Run;
end.
