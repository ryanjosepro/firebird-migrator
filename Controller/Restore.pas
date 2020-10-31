unit Restore;

interface

uses
  System.SysUtils, System.Variants, System.Classes, FireDAC.Phys.FB, FireDAC.Phys.IBBase,
  FireDAC.Phys.IBWrapper, Vcl.StdCtrls, FireDAC.Phys,
  Migration;

type
  TRestore = class
    procedure RestoreProgress(ASender: TFDPhysDriverService; const AMessage: string);
    procedure RestoreError(ASender, AInitiator: TObject; var AException: Exception);
  private
    FBDriverLink: TFDPhysFBDriverLink;
    Restore: TFDIBRestore;
    Log: TMemo;
    LogErrors: TMemo;
  public
    constructor Create(Config: TMigrationConfig);

    procedure Execute(Log, LogErrors: TMemo);

    destructor Destroy;
  end;

implementation

constructor TRestore.Create(Config: TMigrationConfig);
begin
  FBDriverLink := TFDPhysFBDriverLink.Create(nil);
  FBDriverLink.Release;
  FBDriverLink.Embedded := true;
  FBDriverLink.VendorLib := Config.GetDestPathDll;

  Restore := TFDIBRestore.Create(nil);
  Restore.DriverLink := FBDriverLink;

//  Restore.Protocol := ipTCPIP;

  Restore.Options := [roReplace];

  Restore.Statistics := [bsTime, bsDelta, bsReads, bsWrites];

  Restore.Verbose := true;

  with Config.Dest do
  begin
//    Restore.Host := Host;
//    Restore.Port := Port;
    Restore.UserName := User;
    Restore.Password := Password;
    Restore.Database := Database;
  end;

  Restore.BackupFiles.Clear;

  Restore.BackupFiles.Add(Config.GetPathBackupFile);

  Restore.OnProgress := RestoreProgress;
  Restore.OnError := RestoreError;
end;

procedure TRestore.RestoreProgress(ASender: TFDPhysDriverService; const AMessage: string);
begin
  if Log <> nil then
  begin
    Log.Lines.Add(AMessage);
  end;
end;

procedure TRestore.RestoreError(ASender, AInitiator: TObject; var AException: Exception);
begin
  if LogErrors <> nil then
  begin
    LogErrors.Lines.Add(AException.Message);
  end;
end;

procedure TRestore.Execute(Log, LogErrors: TMemo);
begin
  self.Log := Log;
  self.LogErrors := LogErrors;

  if Self.Log <> nil then
  begin
    with Self.Log.Lines do
    begin
      Add('');
      Add('************* RESTORE *************');
      Add('');
    end;
  end;

  Restore.Restore;
end;

destructor TRestore.Destroy;
begin
  FBDriverLink.Free;
  Restore.Free;
end;

end.
