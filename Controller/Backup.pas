unit Backup;

interface

uses
  System.SysUtils, System.Variants, System.Classes, FireDAC.Phys.FB, FireDAC.Phys.IBBase,
  FireDAC.Phys.IBWrapper, Vcl.StdCtrls, FireDAC.Phys,
  Migration;

type
  TBackup = class
    procedure BackupProgress(ASender: TFDPhysDriverService; const AMessage: string);
    procedure BackupError(ASender, AInitiator: TObject; var AException: Exception);
  private
    FBDriverLink: TFDPhysFBDriverLink;
    Backup: TFDIBBackup;
    Log: TMemo;
    LogErrors: TMemo;
  public
    constructor Create(Config: TMigrationConfig);

    procedure Execute(Log: TMemo = nil; LogErrors: TMemo = nil);

    destructor Destroy;
  end;

implementation

{ TBackup }

constructor TBackup.Create(Config: TMigrationConfig);
begin
  FBDriverLink := TFDPhysFBDriverLink.Create(nil);

  Backup := TFDIBBackup.Create(nil);
  Backup.DriverLink := FBDriverLink;

  Backup.Protocol := ipTCPIP;

  Backup.Statistics := [bsTime, bsDelta, bsReads, bsWrites];

  Backup.Verbose := true;

  with Config.Source do
  begin
    Backup.Host := Host;
    Backup.Port := Port;
    Backup.UserName := User;
    Backup.Password := Password;
    Backup.Database := Database;
  end;

  Backup.BackupFiles.Clear;

  Backup.BackupFiles.Add(Config.GetBackupFile);

  Backup.OnProgress := BackupProgress;
  Backup.OnError := BackupError;
end;

procedure TBackup.BackupProgress(ASender: TFDPhysDriverService; const AMessage: string);
begin
  if Log <> nil then
  begin
    Log.Lines.Add(AMessage);
  end;
end;

procedure TBackup.BackupError(ASender, AInitiator: TObject; var AException: Exception);
begin
  if LogErrors <> nil then
  begin
    LogErrors.Lines.Add(AException.Message);
  end;
end;

procedure TBackup.Execute(Log: TMemo = nil; LogErrors: TMemo = nil);
begin
  self.Log := Log;
  self.LogErrors := LogErrors;

  if Self.Log <> nil then
  begin
    Self.Log.Lines.Add('');
    Self.Log.Lines.Add('************* BACKUP *************');
    Self.Log.Lines.Add('');
  end;

  Backup.Backup;
end;

destructor TBackup.Destroy;
begin
  FBDriverLink.Free;
  Backup.Free;
end;

end.
