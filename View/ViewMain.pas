unit ViewMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.ImageList, Vcl.ImgList,
  System.Actions, Vcl.ActnList, FireDAC.Stan.Def, FireDAC.VCLUI.Wait, FireDAC.Phys.IBWrapper,
  FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.IBBase, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.CheckLst,
  ACBrBase, FireDAC.Phys.FBDef, FireDAC.Phys.FB, NsEditBtn, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, Data.DB, FireDAC.Comp.Client, System.IniFiles,
  Migration, Config, MyUtils;

type
  TWindowMain = class(TForm)
    Page: TPageControl;
    TabMigration: TTabSheet;
    Images: TImageList;
    Actions: TActionList;
    ActAddBackup: TAction;
    ActRmvBackup: TAction;
    ActEsc: TAction;
    ActDbFile: TAction;
    OpenFile: TFileOpenDialog;
    ActRestore: TAction;
    SaveFile: TFileSaveDialog;
    FBRestore: TFDIBRestore;
    ActMigrate: TAction;
    GroupBoxSource: TGroupBox;
    GroupBoxDest: TGroupBox;
    LblUserSource: TLabel;
    TxtUserSource: TEdit;
    LblPasswordSource: TLabel;
    TxtPasswordSource: TEdit;
    LblDbSource: TLabel;
    LblDbDest: TLabel;
    TxtDbDest: TNsEditBtn;
    TabAdmin: TTabSheet;
    TxtDb: TNsEditBtn;
    LblDb: TLabel;
    LblUser: TLabel;
    TxtUser: TEdit;
    LblPassword: TLabel;
    TxtPassword: TEdit;
    LblProtocol: TLabel;
    BoxProtocol: TComboBox;
    TxtHost: TEdit;
    LblHost: TLabel;
    LblPort: TLabel;
    TxtPort: TEdit;
    CheckVerbose: TCheckBox;
    LblBackupFile: TLabel;
    TxtDbSource: TNsEditBtn;
    FBBackup: TFDIBBackup;
    ActBackup: TAction;
    LblOptions: TLabel;
    RadioGroupMethod: TRadioGroup;
    MemoErrors: TMemo;
    MemoLog: TMemo;
    LblErrors: TLabel;
    LblLog: TLabel;
    CheckListOptions: TCheckListBox;
    BtnMigrate: TButton;
    BtnStart: TButton;
    LblDll: TLabel;
    TxtDll: TNsEditBtn;
    BoxVersionSource: TComboBox;
    BoxVersionDest: TComboBox;
    LblVersionSource: TLabel;
    LblVersionDest: TLabel;
    RadioGroupConnMethod: TRadioGroup;
    BtnTestConn: TButton;
    TxtBackupFile: TNsEditBtn;
    procedure ActEscExecute(Sender: TObject);
    procedure ActRestoreExecute(Sender: TObject);
    procedure FBError(ASender, AInitiator: TObject; var AException: Exception);
    procedure FBProgress(ASender: TFDPhysDriverService; const AMessage: string);
    procedure ActMigrateExecute(Sender: TObject);
    procedure BtnTestConnClick(Sender: TObject);
    procedure ActBackupExecute(Sender: TObject);
    procedure BtnStartClick(Sender: TObject);
    procedure TxtDbBtnClick(Sender: TObject);
    procedure TxtDbSourceBtnClick(Sender: TObject);
    procedure TxtDbDestBtnClick(Sender: TObject);
    procedure RadioGroupMethodClick(Sender: TObject);
    procedure TxtDllBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RadioGroupConnMethodClick(Sender: TObject);
    procedure TxtBackupFileBtnClick(Sender: TObject);

  private
    procedure CarregarArquivo(Sender: TObject; DisplayName, FileMask: string);
    procedure SalvarArquivo(Sender: TObject; DisplayName, FileMask: string);
    procedure CarregarPasta(Sender: TObject);
    procedure SalvarPasta(Sender: TObject);

    procedure LoadConfigs;
    procedure SaveConfigs;

    procedure LoadAdminConfigs;
    procedure SaveAdminConfigs;

    procedure CopyFirebirdMsg;
  end;

var
  WindowMain: TWindowMain;
  MigrationConfig: TMigrationConfig;

implementation

{$R *.dfm}

procedure TWindowMain.FormCreate(Sender: TObject);
begin
  MigrationConfig := TMigrationConfig.Create;
end;

procedure TWindowMain.FormDestroy(Sender: TObject);
begin
  MigrationConfig.Free;
end;

procedure TWindowMain.FormActivate(Sender: TObject);
begin
  LoadConfigs;
  LoadAdminConfigs;
  RadioGroupConnMethodClick(self);
end;

procedure TWindowMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveConfigs;
  SaveAdminConfigs;
end;

procedure TWindowMain.LoadConfigs;
var
  Config: TMigrationConfig;
begin
  Config := TMigrationConfig.Create;

  TConfig.GetGeral(Config);

  with Config.Source do
  begin
    TxtUserSource.Text := User;
    TxtPasswordSource.Text := Password;
    TxtDbSource.Text := Database;
    BoxVersionSource.ItemIndex := Integer(Version);
  end;

  with Config.Dest do
  begin
    TxtDbDest.Text := Database;
    BoxVersionDest.ItemIndex := Integer(Version);
  end;
end;

procedure TWindowMain.SaveConfigs;
var
  Config: TMigrationConfig;
begin
  Config := TMigrationConfig.Create;

  with Config.Source do
  begin
    User := TxtUserSource.Text;
    Password := TxtPasswordSource.Text;
    Database := TxtDbSource.Text;
    Version := TVersion(BoxVersionSource.ItemIndex);
  end;

  with Config.Dest do
  begin
    Database := TxtDbDest.Text;
    Version := TVersion(BoxVersionDest.ItemIndex);
  end;

  TConfig.SetGeral(Config);

  Config.Free;
end;

procedure TWindowMain.TxtDbSourceBtnClick(Sender: TObject);
var
  DisplayName, FileMask: string;
begin
  DisplayName := 'Firebird Database (*.FDB)';
  FileMask := '*.fdb';

  CarregarArquivo(sender, DisplayName, FileMask);
end;

procedure TWindowMain.TxtDbDestBtnClick(Sender: TObject);
var
  DisplayName, FileMask: string;
begin
  DisplayName := 'Firebird Database (*.FDB)';
  FileMask := '*.FDB';

  SalvarArquivo(sender, DisplayName, FileMask);
end;

procedure TWindowMain.BtnTestConnClick(Sender: TObject);
var
  FBDriverLink: TFDPhysFBDriverLink;
  ConnTest: TFDConnection;
begin
  BtnTestConn.Enabled := false;

  with MigrationConfig.Source do
  begin
    User := TxtUserSource.Text;
    Password := TxtPasswordSource.Text;
    Version := TVersion(BoxVersionSource.ItemIndex);
    Database := TxtDbSource.Text;
  end;

  FBDriverLink := TFDPhysFBDriverLink.Create(self);

  ConnTest := TFDConnection.Create(self);

  try
    FBDriverLink.Embedded := true;
    FBDriverLink.VendorLib := MigrationConfig.GetPathSourceDll;
    FBDriverLink.DriverID := 'FB';

    ConnTest.DriverName := 'FB';

    with TFDPhysFBConnectionDefParams(ConnTest.Params) do
    begin
      UserName := TxtUserSource.Text;
      Password := TxtPasswordSource.Text;
      Database := TxtDbSource.Text;
      Protocol := ipLocal;
    end;

    try
      ConnTest.Open;

      ShowMessage('Conexão Ok!');
    Except on E: Exception do
    begin
      ShowMessage('Erro: ' + E.Message);
    end;
    end;
  finally
    ConnTest.Close;
    FreeAndNil(ConnTest);
    FBDriverLink.Release;
    FreeAndNil(FBDriverLink);
    BtnTestConn.Enabled := true;
  end;
end;

procedure TWindowMain.ActMigrateExecute(Sender: TObject);
var
  Migration: TMigration;
begin
  SaveConfigs;

  MemoLog.Clear;
  MemoErrors.Clear;

  try
    with MigrationConfig.Source do
    begin
      User := TxtUserSource.Text;
      Password := TxtPasswordSource.Text;
      Version := TVersion(BoxVersionSource.ItemIndex);
      Database := TxtDbSource.Text;
    end;

    with MigrationConfig.Dest do
    begin
      Version := TVersion(BoxVersionDest.ItemIndex);
      Database := TxtDbDest.Text;
    end;

    Migration := TMigration.Create(MigrationConfig);

    Migration.Migrate(MemoLog, MemoErrors);
  finally
    Migration.Free;
  end;
end;

procedure TWindowMain.ActEscExecute(Sender: TObject);
begin
  Close;
end;

procedure TWindowMain.RadioGroupMethodClick(Sender: TObject);
begin
  CheckListOptions.Items.Clear;

  case RadioGroupMethod.ItemIndex of
  0:
  begin
    CheckListOptions.Items.Add('IgnoreChecksum');
    CheckListOptions.Items.Add('IgnoreLim');
    CheckListOptions.Items.Add('MetadataOnly');
    CheckListOptions.Items.Add('NoGarbageCollect');
    CheckListOptions.Items.Add('OldDescriptions');
    CheckListOptions.Items.Add('NonTransportable');
    CheckListOptions.Items.Add('Convert');
    CheckListOptions.Items.Add('Expand');
  end;

  1:
  begin
    CheckListOptions.Items.Add('DeactivateIdx');
    CheckListOptions.Items.Add('NoShadow');
    CheckListOptions.Items.Add('NoValidity');
    CheckListOptions.Items.Add('OneAtATime');
    CheckListOptions.Items.Add('Replace');
    CheckListOptions.Items.Add('UseAllSpace');
    CheckListOptions.Items.Add('Validate');
    CheckListOptions.Items.Add('FixFSSData');
    CheckListOptions.Items.Add('FixFSSMetaData');
    CheckListOptions.Items.Add('MetaDataOnly');
  end;

  end;
end;

//FILES AND FOLDERS

procedure TWindowMain.CarregarArquivo(Sender: TObject; DisplayName, FileMask: string);
begin
  OpenFile.Options := OpenFile.Options - [fdoPickFolders];

  OpenFile.FileTypes[0].DisplayName := DisplayName;
  OpenFile.FileTypes[0].FileMask := FileMask;
  OpenFile.FileName := '';

  if OpenFile.Execute then
  begin
    (Sender as TNsEditBtn).Text := OpenFile.FileName;
  end;
end;

procedure TWindowMain.SalvarArquivo(Sender: TObject; DisplayName, FileMask: string);
begin
  SaveFile.Options := SaveFile.Options - [fdoPickFolders];

  SaveFile.FileTypes[0].DisplayName := DisplayName;
  SaveFile.FileTypes[0].FileMask := FileMask;
  SaveFile.FileName := '';

  if SaveFile.Execute then
  begin
    (Sender as TNsEditBtn).Text := SaveFile.FileName;
  end;
end;

procedure TWindowMain.CarregarPasta(Sender: TObject);
begin
  OpenFile.Options := OpenFile.Options + [fdoPickFolders];

  if OpenFile.Execute then
  begin
    (Sender as TNsEditBtn).Text := OpenFile.FileName;
  end;
end;

procedure TWindowMain.SalvarPasta(Sender: TObject);
begin
  SaveFile.Options := SaveFile.Options + [fdoPickFolders];

  if SaveFile.Execute then
  begin
    (Sender as TNsEditBtn).Text := SaveFile.FileName;
  end;
end;

//TEMP//

procedure TWindowMain.LoadAdminConfigs;
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(TUtils.AppPath + 'Config.ini');

  try
    TxtDb.Text := Arq.ReadString('GENERAL', 'Database', '');
    TxtUser.Text := Arq.ReadString('GENERAL', 'User', 'SYSDBA');
    TxtPassword.Text := Arq.ReadString('GENERAL', 'Password', 'masterkey');
    RadioGroupConnMethod.ItemIndex := Arq.ReadString('GENERAL', 'ConnMethod', '0').ToInteger;
    BoxProtocol.ItemIndex := Arq.ReadString('GENERAL', 'Protocol', '1').ToInteger;
    TxtHost.Text := Arq.ReadString('GENERAL', 'Host', 'localhost');
    TxtPort.Text := Arq.ReadString('GENERAL', 'Port', '3050');
    TxtDll.Text := Arq.ReadString('GENERAL', 'Dll', '');
    TxtBackupFile.Text := Arq.ReadString('GENERAL', 'BackupFile', '');
  finally
    Arq.Free;
  end;
end;

procedure TWindowMain.SaveAdminConfigs;
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(TUtils.AppPath + 'Config.ini');

  try
    Arq.WriteString('GENERAL', 'Database', TxtDb.Text);
    Arq.WriteString('GENERAL', 'User', TxtUser.Text);
    Arq.WriteString('GENERAL', 'Password', TxtPassword.Text);
    Arq.WriteString('GENERAL', 'ConnMethod', RadioGroupConnMethod.ItemIndex.ToString);
    Arq.WriteString('GENERAL', 'Protocol', BoxProtocol.ItemIndex.ToString);
    Arq.WriteString('GENERAL', 'Host', TxtHost.Text);
    Arq.WriteString('GENERAL', 'Port', TxtPort.Text);
    Arq.WriteString('GENERAL', 'Dll', TxtDll.Text);
    Arq.WriteString('GENERAL', 'BackupFile', TxtBackupFile.Text);
  finally
    Arq.Free;
  end;
end;

procedure TWindowMain.CopyFirebirdMsg;
var
  Arq: string;
begin
  Arq := ExtractFilePath(TxtDll.Text) + 'Firebird.msg';

  if FileExists(Arq) then
  begin
    CopyFile(PWideChar(Arq), PWideChar(ExtractFilePath(Application.ExeName) + 'Firebird.msg'), false);
  end;
end;

procedure TWindowMain.RadioGroupConnMethodClick(Sender: TObject);
begin
  case RadioGroupConnMethod.ItemIndex of
  0:
  begin
    BoxProtocol.Enabled := true;
    TxtHost.Enabled := true;
    TxtPort.Enabled := true;
    TxtDll.Enabled := false;
  end;

  1:
  begin
    BoxProtocol.Enabled := false;
    TxtHost.Enabled := false;
    TxtPort.Enabled := false;
    TxtDll.Enabled := true;
  end;

  end;
end;

procedure TWindowMain.TxtDbBtnClick(Sender: TObject);
var
  DisplayName, FileMask: string;
begin
  DisplayName := 'Firebird Database (*.FDB)';
  FileMask := '*.fdb';

  case RadioGroupMethod.ItemIndex of
  0:
    CarregarArquivo(Sender, DisplayName, FileMask);
  1:
    SalvarArquivo(Sender, DisplayName, FileMask);
  end;
end;

procedure TWindowMain.TxtBackupFileBtnClick(Sender: TObject);
var
  DisplayName, FileMask: string;
begin
  DisplayName := 'Firebird Backup (*.FBK)';
  FileMask := '*.fbk';

  case RadioGroupMethod.ItemIndex of
  0:
    CarregarArquivo(Sender, DisplayName, FileMask);
  1:
    SalvarArquivo(Sender, DisplayName, FileMask);
  end;
end;

procedure TWindowMain.TxtDllBtnClick(Sender: TObject);
var
  DisplayName, FileMask: string;
begin
  DisplayName := 'Dinamic Link Library (*.DLL)';
  FileMask := '*.dll';

  CarregarArquivo(Sender, DisplayName, FileMask);
end;

procedure TWindowMain.BtnStartClick(Sender: TObject);
begin
  case RadioGroupMethod.ItemIndex of
  0:
    ActBackup.Execute;
  1:
    ActRestore.Execute;
  end;
end;

procedure TWindowMain.ActBackupExecute(Sender: TObject);
var
  I: integer;
  FBDriverLink: TFDPhysFBDriverLink;
begin
  Page.ActivePageIndex := 0;

  TabAdmin.Enabled := false;

  MemoLog.Clear;
  MemoErrors.Clear;

  Application.ProcessMessages;

  FBDriverLink := TFDPhysFBDriverLink.Create(nil);

  try
    FBBackup.Database := TxtDb.Text;
    FBBackup.UserName := TxtUser.Text;
    FBBackup.Password := TxtPassword.Text;

    FBBackup.BackupFiles.Clear;
    FBBackup.BackupFiles.Text := TxtBackupFile.Text;

    //By TCPIP
    case RadioGroupConnMethod.ItemIndex of
    0:
    begin
      FBDriverLink.Embedded := false;

      FBBackup.Protocol := TIBProtocol(BoxProtocol.ItemIndex);
      FBBackup.Host := TxtHost.Text;
      FBBackup.Port := StrToInt(TxtPort.Text);
    end;
    //By DLL
    1:
    begin
      FBDriverLink.Embedded := true;

      FBDriverLink.VendorLib := TxtDll.Text;

      FBBackup.Protocol := ipLocal;

      CopyFirebirdMsg;
    end;

    end;

    FBBackup.DriverLink := FBDriverLink;

    FBBackup.Verbose := CheckVerbose.Checked;
    FBBackup.Options := [];

    for I := 0 to CheckListOptions.Count - 1 do
    begin
      if CheckListOptions.Checked[I] then
      begin
        case I of
        0: FBBackup.Options := FBBackup.Options + [boIgnoreChecksum];
        1: FBBackup.Options := FBBackup.Options + [boIgnoreLimbo];
        2: FBBackup.Options := FBBackup.Options + [boMetadataOnly];
        3: FBBackup.Options := FBBackup.Options + [boNoGarbageCollect];
        4: FBBackup.Options := FBBackup.Options + [boOldDescriptions];
        5: FBBackup.Options := FBBackup.Options + [boNonTransportable];
        6: FBBackup.Options := FBBackup.Options + [boConvert];
        7: FBBackup.Options := FBBackup.Options + [boExpand];
        end;
      end;
    end;

    FBBackup.Backup;
  finally
    TabAdmin.Enabled := true;
    FBDriverLink.Free;
  end;
end;

procedure TWindowMain.ActRestoreExecute(Sender: TObject);
var
  I: integer;
  FBDriverLink: TFDPhysFBDriverLink;
begin
  Page.ActivePageIndex := 0;

  TabAdmin.Enabled := false;

  MemoLog.Clear;
  MemoErrors.Clear;

  Application.ProcessMessages;

  FBDriverLink := TFDPhysFBDriverLink.Create(nil);

  try
    FBRestore.Database := TxtDb.Text;
    FBRestore.UserName := TxtUser.Text;
    FBRestore.Password := TxtPassword.Text;

    FBRestore.BackupFiles.Clear;
    FBRestore.BackupFiles.Text := TxtBackupFile.Text;

    case RadioGroupConnMethod.ItemIndex of
    0:
    begin
      FBDriverLink.Embedded := false;

      FBRestore.Protocol := TIBProtocol(BoxProtocol.ItemIndex);
      FBRestore.Host := TxtHost.Text;
      FBRestore.Port := StrToInt(TxtPort.Text);
    end;

    1:
    begin
      FBDriverLink.Embedded := true;

      FBDriverLink.VendorLib := TxtDll.Text;

      FBRestore.Protocol := ipLocal;

      CopyFirebirdMsg;
    end;

    end;

    FBRestore.DriverLink := FBDriverLink;

    FBRestore.Verbose := CheckVerbose.Checked;
    FBRestore.Options := [];

    for I := 0 to CheckListOptions.Count - 1 do
    begin
      if CheckListOptions.Checked[I] then
      begin
        case I of
        0: FBRestore.Options := FBRestore.Options + [roDeactivateIdx];
        1: FBRestore.Options := FBRestore.Options + [roNoShadow];
        2: FBRestore.Options := FBRestore.Options + [roNoValidity];
        3: FBRestore.Options := FBRestore.Options + [roOneAtATime];
        4: FBRestore.Options := FBRestore.Options + [roReplace];
        5: FBRestore.Options := FBRestore.Options + [roUseAllSpace];
        6: FBRestore.Options := FBRestore.Options + [roValidate];
        7: FBRestore.Options := FBRestore.Options + [roFixFSSData];
        8: FBRestore.Options := FBRestore.Options + [roFixFSSMetaData];
        9: FBRestore.Options := FBRestore.Options + [roMetaDataOnly];
        end;
      end;
    end;

    FBRestore.Restore;
  finally
    TabAdmin.Enabled := true;
    FBDriverLink.Free;
  end;
end;

procedure TWindowMain.FBProgress(ASender: TFDPhysDriverService; const AMessage: string);
begin
  WindowMain.MemoLog.Lines.Add(AMessage);
end;

procedure TWindowMain.FBError(ASender, AInitiator: TObject; var AException: Exception);
begin
  WindowMain.MemoErrors.Lines.Add(AException.Message);
end;

end.
