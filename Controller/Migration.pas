unit Migration;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Vcl.StdCtrls,
  MyUtils;

type

  TMigrationConnection = class
  public
    Host: string;
    Port: integer;
    User: string;
    Password: string;
    Database: string;
  end;

  TMigrationConfig = class
  strict private
    WorkFolder: string;
    BackupFile: string;
  public
    Source: TMigrationConnection;
    Dest: TMigrationConnection;
    function GetWorkFolder: string;
    function GetBackupFile: string;

    constructor Create;
    destructor Destroy;
  end;

  TMigration = class
  private
    Config: TMigrationConfig;

  public
    constructor Create(Config: TMigrationConfig);
    procedure Migrate(Log: TMemo = nil; LogErrors: TMemo = nil);
  end;

implementation

uses
  Backup, Restore;

{ TMigrationConfig }

constructor TMigrationConfig.Create;
begin
  Source := TMigrationConnection.Create;
  Dest := TMigrationConnection.Create;
  WorkFolder := TUtils.AppPath + 'Temp\';
  BackupFile := GetWorkFolder + 'BackupFile.fbk';
end;

destructor TMigrationConfig.Destroy;
begin
  Source.Free;
  Dest.Free;
end;

function TMigrationConfig.GetWorkFolder: string;
begin
  Result := Self.WorkFolder;
end;

function TMigrationConfig.GetBackupFile: string;
begin
  Result := Self.BackupFile;
end;

{ TMigration }

constructor TMigration.Create(Config: TMigrationConfig);
begin
  Self.Config := Config;
end;

procedure TMigration.Migrate(Log: TMemo = nil; LogErrors: TMemo = nil);
var
  Backup: TBackup;
  Restore: TRestore;
begin
  CreateDir(Config.GetWorkFolder);

  Backup := TBackup.Create(Config);
  Restore := TRestore.Create(Config);

  try
    Backup.Execute(Log, LogErrors);

    Restore.Execute(Log, LogErrors);

    Log.Lines.SaveToFile(Config.GetWorkFolder + 'Log.txt');
    LogErrors.Lines.SaveToFile(Config.GetWorkFolder + 'Errors.txt');
  finally
    Backup.Free;
    Restore.Free;
  end;
end;

end.
