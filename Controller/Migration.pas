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
  private
    WorkFolder: string;
  public
    Source: TMigrationConnection;
    Dest: TMigrationConnection;
    function GetWorkFolder: string;

    constructor Create;
    destructor Destroy;
  end;

  TMigration = class
  private
    Config: TMigrationConfig;

  public
    constructor Create(Config: TMigrationConfig);
    procedure Migrate(Log: TMemo = nil; LogError: TMemo = nil);
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
end;

destructor TMigrationConfig.Destroy;
begin
  Source.Free;
  Dest.Free;
end;

function TMigrationConfig.GetWorkFolder: string;
begin
  Result := WorkFolder;
end;

{ TMigration }

constructor TMigration.Create(Config: TMigrationConfig);
begin
  Self.Config := Config;
end;

procedure TMigration.Migrate(Log: TMemo = nil; LogError: TMemo = nil);
var
  Backup: TBackup;
begin
  Backup := TBackup.Create(Config);

  Backup.Execute;
end;

end.
