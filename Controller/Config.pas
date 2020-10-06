unit Config;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.Variants, Vcl.Forms, IniFiles,
  System.Rtti,
  MyUtils, Migration;

type
  TConfig = class
  private
    class procedure CreateFile(Path: string);
    class function Source: string;
  public
    class function GetConfig(const Section, Name: string; Default: string = ''): string;
    class procedure SetConfig(const Section, Name: string; Value: string = '');

    class procedure SetGeral(Config: TMigrationConfig);
    class procedure GetGeral(var Config: TMigrationConfig);
  end;

implementation

{ TConfigs }

class procedure TConfig.CreateFile(Path: string);
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Path);
  try
    Arq.WriteString('SOURCE', 'Host', 'localhost');
    Arq.WriteString('SOURCE', 'Port', '3050');
    Arq.WriteString('SOURCE', 'User', 'SYSDBA');
    Arq.WriteString('SOURCE', 'Password', 'masterkey');
    Arq.WriteString('SOURCE', 'Database', '');
    Arq.WriteString('SOURCE', 'Version', '0');

    Arq.WriteString('DEST', 'Host', 'localhost');
    Arq.WriteString('DEST', 'Port', '3050');
    Arq.WriteString('DEST', 'User', 'SYSDBA');
    Arq.WriteString('DEST', 'Password', 'masterkey');
    Arq.WriteString('DEST', 'Database', '');
    Arq.WriteString('DEST', 'Version', '0');
  finally
    FreeAndNil(Arq);
  end;
end;

//Caminho das configurações
class function TConfig.Source: string;
begin
  Result := TUtils.Temp + 'FirebirdMigrator\' + 'Config.ini';

  if not FileExists(Result) then
  begin
    if not DirectoryExists(ExtractFileDir(Result)) then
    begin
      CreateDir(ExtractFileDir(Result));
    end;

    CreateFile(Result);
  end;
end;

//Busca uma configuração específica
class function TConfig.GetConfig(const Section, Name: string; Default: string = ''): string;
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Source);

  try
    Result := Arq.ReadString(Section, Name, Default);
  finally
    FreeAndNil(Arq);
  end;
end;

//Define uma configuração específica
class procedure TConfig.SetConfig(const Section, Name: string; Value: string = '');
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Source);
  try
    Arq.WriteString(Section, Name, Value);
  finally
    FreeAndNil(Arq);
  end;
end;

class procedure TConfig.SetGeral(Config: TMigrationConfig);
begin
  with Config.Source do
  begin
    SetConfig('SOURCE', 'Host', Host);
    SetConfig('SOURCE', 'Port', IntToStr(Port));
    SetConfig('SOURCE', 'User', User);
    SetConfig('SOURCE', 'Password', Password);
    SetConfig('SOURCE', 'Database', Database);
    SetConfig('SOURCE', 'Version', Integer(Version).ToString);
  end;

  with Config.Dest do
  begin
    SetConfig('DEST', 'Host', Host);
    SetConfig('DEST', 'Port', IntToStr(Port));
    SetConfig('DEST', 'User', User);
    SetConfig('DEST', 'Password', Password);
    SetConfig('DEST', 'Database', Database);
    SetConfig('DEST', 'Version', Integer(Version).ToString);
  end;
end;

class procedure TConfig.GetGeral(var Config: TMigrationConfig);
begin
  with Config.Source do
  begin
    Host := GetConfig('SOURCE', 'Host', 'localhost');
    Port := GetConfig('SOURCE', 'Port', '3050').ToInteger;
    User := GetConfig('SOURCE', 'User', 'SYSDBA');
    Password := GetConfig('SOURCE', 'Password', 'masterkey');
    Database := GetConfig('SOURCE', 'Database', '');
    Version := TVersion(GetConfig('SOURCE', 'Version', '0').ToInteger);
  end;

  with Config.Dest do
  begin
    Host := GetConfig('DEST', 'Host', 'localhost');
    Port := GetConfig('DEST', 'Port', '3050').ToInteger;
    User := GetConfig('DEST', 'User', 'SYSDBA');
    Password := GetConfig('DEST', 'Password', 'masterkey');
    Database := GetConfig('DEST', 'Database', '');
    Version := TVersion(GetConfig('DEST', 'Version', '0').ToInteger);
  end;
end;

end.
