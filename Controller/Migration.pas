unit Migration;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Vcl.StdCtrls,
  MyUtils;

type
  TVersion = (vrFb21 = 0, vrFb25 = 1, vrFb30 = 2, vrFb40 = 3);

  TMigrationConnection = class
  public
    Host: string;
    Port: integer;
    User: string;
    Password: string;
    Version: TVersion;
    Database: string;
  end;

  TMigrationConfig = class
  strict private
    PathTemp: string;
    function GetPathDll(Version: TVersion): string;
  public
    Source: TMigrationConnection;
    Dest: TMigrationConnection;
    function GetPathTemp: string;
    function GetPathBackupFile: string;
    function GetPathSourceDll: string;
    function GetPathDestDll: string;

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
  PathTemp := TUtils.AppPath + 'Temp\';
end;

destructor TMigrationConfig.Destroy;
begin
  Source.Free;
  Dest.Free;
end;

function TMigrationConfig.GetPathTemp: string;
begin
  Result := Self.PathTemp;
end;

function TMigrationConfig.GetPathBackupFile: string;
begin
  Result := GetPathTemp + 'BackupFile.fbk';
end;

function TMigrationConfig.GetPathDll(Version: TVersion): string;
begin
  case Version of
  vrFb21:
    Result := GetPathTemp + 'Dlls\fbclient21.dll';
  vrFb25:
    Result := GetPathTemp + 'Dlls\fbclient25.dll';
  vrFb30:
    Result := GetPathTemp + 'Dlls\fbclient30.dll';
  vrFb40:
    Result := GetPathTemp + 'Dlls\fbclient40.dll';
  end;
end;

function TMigrationConfig.GetPathSourceDll: string;
begin
  Result := GetPathDll(Source.Version);
end;

function TMigrationConfig.GetPathDestDll: string;
begin
  Result := GetPathDll(Dest.Version);
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
  CreateDir(Config.GetPathTemp);

  Backup := TBackup.Create(Config);
  Restore := TRestore.Create(Config);

  try
    Backup.Execute(Log, LogErrors);

    Restore.Execute(Log, LogErrors);

    Log.Lines.SaveToFile(Config.GetPathTemp + 'Log.txt');
    LogErrors.Lines.SaveToFile(Config.GetPathTemp + 'Errors.txt');
  finally
    Backup.Free;
    Restore.Free;
  end;
end;

end.
