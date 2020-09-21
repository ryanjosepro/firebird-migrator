unit Migration;

interface

uses
  System.SysUtils, System.Variants, System.Classes, MyUtils;

type

  TMigrationSource = class
  public
    HostSource: string;
    PortSource: string;
    UserSource: string;
    PasswordSource: string;
    DbSource: string;
  end;

  TMigrationDest = class
  public
    HostDest: string;
    PortDest: string;
    UserDest: string;
    PasswordDest: string;
    DbDest: string;
  end;

  TMigrationConfig = class
  private
    WorkFolder: string;
  public
    Source: TMigrationSource;
    Dest: TMigrationDest;

    constructor Create;
    destructor Destroy;
  end;

  TMigration = class
  private
    Config: TMigrationConfig;

  public
    constructor Create(Config: TMigrationConfig);
    procedure Migrate;
  end;

implementation

{ TMigrationConfig }

constructor TMigrationConfig.Create;
begin
  Source := TMigrationSource.Create;
  Dest := TMigrationDest.Create;
  WorkFolder := TUtils.AppPath + 'Temp';
end;

destructor TMigrationConfig.Destroy;
begin
  Source.Free;
  Dest.Free;
end;

{ TMigration }

constructor TMigration.Create(Config: TMigrationConfig);
begin
  Self.Config := Config;
end;

procedure TMigration.Migrate;
begin
  //
end;

end.
