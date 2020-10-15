unit Migration;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Vcl.StdCtrls, Winapi.Windows, Vcl.Forms,
  MyUtils;

type
  TVersion = (vrFb21 = 0, vrFb25 = 1, vrFb30 = 2, vrFb40 = 3);

  TMigrationConnection = class
  public
    User: string;
    Password: string;
    Version: TVersion;
    Database: string;
  end;

  TMigrationConfig = class
  strict private
    function GetVersionName(Version: TVersion): string;
    function GetResourceName(Version: TVersion): string;
    function GetPathDll(Version: TVersion): string;
  public
    Source: TMigrationConnection;
    Dest: TMigrationConnection;
    function GetPathTemp: string;
    function GetSourcePathDll: string;
    function GetDestPathDll: string;
    function GetPathBackupFile: string;
    function GetSourceVersionName: string;
    function GetDestVersionName: string;

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
end;

destructor TMigrationConfig.Destroy;
begin
  Source.Free;
  Dest.Free;
end;

function TMigrationConfig.GetVersionName(Version: TVersion): string;
begin
  case Version of
  vrFb21:
    Result := 'Firebird 2.1.7.18553';
  vrFb25:
    Result := 'Firebird 2.5.8.27089';
  vrFb30:
    Result := 'Firebird 3.0.4.33054';
  vrFb40:
    Result := 'Firebird 4.0.0.19630';
  end;
end;

function TMigrationConfig.GetResourceName(Version: TVersion): string;
begin
  case Version of
  vrFb21:
    Result := 'Firebird_2_1';
  vrFb25:
    Result := 'Firebird_2_5';
  vrFb30:
    Result := 'Firebird_3_0';
  vrFb40:
    Result := 'Firebird_4_0';
  end;
end;

function TMigrationConfig.GetPathTemp: string;
begin
  Result := TUtils.Temp + 'FirebirdMigrator\';
end;

function TMigrationConfig.GetPathDll(Version: TVersion): string;
var
  Folder: string;
begin
  //Pasta destino
  Folder := GetPathTemp + GetResourceName(Version) + '\';

  TUtils.DeleteIfExistsDir(Folder);

  Application.ProcessMessages;

  //Extrai resource para a pasta temp
  TUtils.ExtractResourceZip(GetResourceName(Version), GetPathTemp);

  Application.ProcessMessages;

  //Copia o firebird.msg para a pasta do executável
  CopyFile(PWideChar(Folder + 'Firebird.msg'), PWideChar(TUtils.AppPath + 'Firebird.msg'), false);

  Application.ProcessMessages;

  Result := Folder + 'fbclient.dll';
end;

function TMigrationConfig.GetSourcePathDll: string;
begin
  Result := GetPathDll(Source.Version);
end;

function TMigrationConfig.GetDestPathDll: string;
begin
  Result := GetPathDll(Dest.Version);
end;

function TMigrationConfig.GetPathBackupFile: string;
begin
  Result := GetPathTemp + 'BackupFile.fbk';
end;

function TMigrationConfig.GetSourceVersionName: string;
begin
  Result := GetVersionName(Source.Version);
end;

function TMigrationConfig.GetDestVersionName: string;
begin
  Result := GetVersionName(Dest.Version);
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
  Config.Dest.User := Config.Source.User;
  Config.Dest.Password := Config.Source.Password;

  CreateDir(Config.GetPathTemp);

  Backup := TBackup.Create(Config);
  Restore := TRestore.Create(Config);

  try
    if Log <> nil then
    begin
      with Log.Lines do
      begin
        Add('************* MIGRAÇÃO ************');
        Add(DateTimeToStr(now));
        Add('*Fonte*');
        Add('Path: ' + Config.Source.Database);
        Add('Versão: ' + Config.GetSourceVersionName);
        Add('***********************************');
        Add('*Destino*');
        Add('Path: ' + Config.Dest.Database);
        Add('Versão: ' + Config.GetDestVersionName);
        Add('***********************************');
        Add('');
      end;
    end;

    Backup.Execute(Log, LogErrors);

    Restore.Execute(Log, LogErrors);

    if Log <> nil then
    begin
      with Log.Lines do
      begin
        Add('');
        Add('******** MIGRAÇÃO FINALIZADA ******');
        Add(DateTimeToStr(now));
        Add('');
      end;
    end;

    Log.Lines.SaveToFile(Config.GetPathTemp + 'Log.txt');
    LogErrors.Lines.SaveToFile(Config.GetPathTemp + 'Errors.txt');
  finally
    Backup.Free;
    Restore.Free;
  end;
end;

end.
