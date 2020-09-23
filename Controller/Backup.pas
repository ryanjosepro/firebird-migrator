unit Backup;

interface

uses
  System.SysUtils, System.Variants, System.Classes, FireDAC.Phys.FB, FireDAC.Phys.IBBase,
  FireDAC.Phys.IBWrapper, Vcl.StdCtrls, FireDAC.Phys,
  Migration;

type
  TBackup = class
  private
    FBDriverLink: TFDPhysFBDriverLink;
    Backup: TFDIBBackup;
    Log: TMemo;
    LogErrors: TMemo;
    procedure RestoreProgress(ASender: TFDPhysDriverService; const AMessage: string);
    procedure RestoreError(ASender, AInitiator: TObject; var AException: Exception);
  public
    constructor Create(Config: TMigrationConfig);
    destructor Destroy;

    procedure Execute(Log: TMemo = nil; LogError: TMemo = nil);
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

  Backup.BackupFiles.Add(Config.GetWorkFolder + 'BackupFile.fbk');

  Backup.OnProgress := RestoreProgress;
  Backup.OnError := RestoreError;
end;

procedure TBackup.RestoreProgress(ASender: TFDPhysDriverService; const AMessage: string);
begin
  if Log <> nil then
  begin
    Log.Lines.Add(AMessage);
  end;
end;

procedure TBackup.RestoreError(ASender, AInitiator: TObject; var AException: Exception);
begin
  if LogErrors <> nil then
  begin
    LogErrors.Lines.Add(AException.Message);
  end;
end;

procedure TBackup.Execute(Log: TMemo = nil; LogError: TMemo = nil);
begin
  self.Log := Log;
  self.LogErrors := LogError;

  Backup.Backup;
end;

destructor TBackup.Destroy;
begin
  FBDriverLink.Free;
  Backup.Free;
end;

end.
