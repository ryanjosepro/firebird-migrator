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
  Migration, Config, MyUtils, MyFileDialogs;

type
  TWindowMain = class(TForm)
    Page: TPageControl;
    TabMigration: TTabSheet;
    Images: TImageList;
    Actions: TActionList;
    ActEsc: TAction;
    ActRestore: TAction;
    FBRestore: TFDIBRestore;
    ActMigrate: TAction;
    TabAdmin: TTabSheet;
    TxtDbAdmin: TNsEditBtn;
    LblDbAdmin: TLabel;
    LblUserAdmin: TLabel;
    TxtUserAdmin: TEdit;
    LblPasswordAdmin: TLabel;
    TxtPasswordAdmin: TEdit;
    LblProtocolAdmin: TLabel;
    BoxProtocolAdmin: TComboBox;
    TxtHostAdmin: TEdit;
    LblHostAdmin: TLabel;
    LblPortAdmin: TLabel;
    TxtPortAdmin: TEdit;
    CheckVerboseAdmin: TCheckBox;
    LblBackupFileAdmin: TLabel;
    FBBackup: TFDIBBackup;
    ActBackup: TAction;
    RadioGroupMethodAdmin: TRadioGroup;
    CheckListOptionsAdmin: TCheckListBox;
    BtnStartAdmin: TButton;
    LblDllAdmin: TLabel;
    TxtDllAdmin: TNsEditBtn;
    RadioGroupConnMethodAdmin: TRadioGroup;
    TxtBackupFileAdmin: TNsEditBtn;
    MemoLogAdmin: TMemo;
    LblLogAdmin: TLabel;
    BoxVersionAdmin: TComboBox;
    LblVersionAdmin: TLabel;
    PageMigration: TPageControl;
    TabStart: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    BtnStart: TSpeedButton;
    ActStart: TAction;
    procedure ActEscExecute(Sender: TObject);
    procedure ActRestoreExecute(Sender: TObject);
    procedure FBError(ASender, AInitiator: TObject; var AException: Exception);
    procedure FBProgress(ASender: TFDPhysDriverService; const AMessage: string);
    procedure ActMigrateExecute(Sender: TObject);
    procedure BtnTestConnClick(Sender: TObject);
    procedure ActBackupExecute(Sender: TObject);
    procedure BtnStartAdminClick(Sender: TObject);
    procedure TxtDbAdminBtnClick(Sender: TObject);
    procedure Dll(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RadioGroupConnMethodAdminClick(Sender: TObject);
    procedure TxtBackupFileAdminBtnClick(Sender: TObject);

    procedure RadioGroupMethodAdminClick(Sender: TObject);
    procedure ActStartExecute(Sender: TObject);
  private
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

//INIT

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
  RadioGroupMethodAdminClick(Self);
  RadioGroupConnMethodAdminClick(Self);
end;

procedure TWindowMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveConfigs;
  SaveAdminConfigs;
end;

/////////////
//MIGRATION//
/////////////

procedure TWindowMain.LoadConfigs;
begin
//  var Config := TMigrationConfig.Create;
//
//  TConfig.GetGeral(Config);
//
//  with Config.Source do
//  begin
//    TxtUserSource.Text := User;
//    TxtPasswordSource.Text := Password;
//    TxtDbSource.Text := Database;
//    BoxVersionSource.ItemIndex := Integer(Version);
//  end;
//
//  with Config.Dest do
//  begin
//    TxtDbDest.Text := Database;
//    BoxVersionDest.ItemIndex := Integer(Version);
//  end;
end;

procedure TWindowMain.SaveConfigs;
begin
//  var Config := TMigrationConfig.Create;
//
//  with Config.Source do
//  begin
//    User := TxtUserSource.Text;
//    Password := TxtPasswordSource.Text;
//    Database := TxtDbSource.Text;
//    Version := TVersion(BoxVersionSource.ItemIndex);
//  end;
//
//  with Config.Dest do
//  begin
//    Database := TxtDbDest.Text;
//    Version := TVersion(BoxVersionDest.ItemIndex);
//  end;
//
//  TConfig.SetGeral(Config);
//
//  Config.Free;
end;

procedure TWindowMain.ActStartExecute(Sender: TObject);
begin
  TabAdmin.TabVisible := false;

  Page.Height := Page.Height + 27;
  Page.Top := -27;
end;

procedure TWindowMain.BtnTestConnClick(Sender: TObject);
var
  FBDriverLink: TFDPhysFBDriverLink;
  ConnTest: TFDConnection;
begin
//  BtnTestConn.Enabled := false;
//
//  with MigrationConfig.Source do
//  begin
//    User := TxtUserSource.Text;
//    Password := TxtPasswordSource.Text;
//    Version := TVersion(BoxVersionSource.ItemIndex);
//    Database := TxtDbSource.Text;
//  end;
//
//  FBDriverLink := TFDPhysFBDriverLink.Create(self);
//
//  ConnTest := TFDConnection.Create(self);
//
//  try
//    FBDriverLink.Embedded := true;
//    FBDriverLink.VendorLib := MigrationConfig.GetPathSourceDll;
//    FBDriverLink.DriverID := 'FB';
//
//    ConnTest.DriverName := 'FB';
//
//    with TFDPhysFBConnectionDefParams(ConnTest.Params) do
//    begin
//      UserName := TxtUserSource.Text;
//      Password := TxtPasswordSource.Text;
//      Database := TxtDbSource.Text;
//      Protocol := ipLocal;
//    end;
//
//    try
//      ConnTest.Open;
//
//      ShowMessage('Conexão Ok!');
//    Except on E: Exception do
//    begin
//      ShowMessage('Erro: ' + E.Message);
//    end;
//    end;
//  finally
//    ConnTest.Close;
//    FreeAndNil(ConnTest);
//    FBDriverLink.Release;
//    FreeAndNil(FBDriverLink);
//    BtnTestConn.Enabled := true;
//  end;
end;

procedure TWindowMain.ActMigrateExecute(Sender: TObject);
var
  Migration: TMigration;
begin
//  SaveConfigs;
//
//  MemoLog.Clear;
//  MemoErrors.Clear;
//
//  try
//    with MigrationConfig.Source do
//    begin
//      User := TxtUserSource.Text;
//      Password := TxtPasswordSource.Text;
//      Version := TVersion(BoxVersionSource.ItemIndex);
//      Database := TxtDbSource.Text;
//    end;
//
//    with MigrationConfig.Dest do
//    begin
//      Version := TVersion(BoxVersionDest.ItemIndex);
//      Database := TxtDbDest.Text;
//    end;
//
//    Migration := TMigration.Create(MigrationConfig);
//
//    Migration.Migrate(MemoLog, MemoErrors);
//  finally
//    Migration.Free;
//  end;
end;

/////////////
////ADMIN////
/////////////

procedure TWindowMain.LoadAdminConfigs;
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(TUtils.AppPath + 'Config.ini');

  try
    TxtDbAdmin.Text := Arq.ReadString('GENERAL', 'Database', '');
    TxtUserAdmin.Text := Arq.ReadString('GENERAL', 'User', 'SYSDBA');
    TxtPasswordAdmin.Text := Arq.ReadString('GENERAL', 'Password', 'masterkey');
    RadioGroupConnMethodAdmin.ItemIndex := Arq.ReadString('GENERAL', 'ConnMethod', '0').ToInteger;
    BoxProtocolAdmin.ItemIndex := Arq.ReadString('GENERAL', 'Protocol', '1').ToInteger;
    TxtHostAdmin.Text := Arq.ReadString('GENERAL', 'Host', 'localhost');
    TxtPortAdmin.Text := Arq.ReadString('GENERAL', 'Port', '3050');
    TxtDllAdmin.Text := Arq.ReadString('GENERAL', 'Dll', '');
    TxtBackupFileAdmin.Text := Arq.ReadString('GENERAL', 'BackupFile', '');
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
    Arq.WriteString('GENERAL', 'Database', TxtDbAdmin.Text);
    Arq.WriteString('GENERAL', 'User', TxtUserAdmin.Text);
    Arq.WriteString('GENERAL', 'Password', TxtPasswordAdmin.Text);
    Arq.WriteString('GENERAL', 'ConnMethod', RadioGroupConnMethodAdmin.ItemIndex.ToString);
    Arq.WriteString('GENERAL', 'Protocol', BoxProtocolAdmin.ItemIndex.ToString);
    Arq.WriteString('GENERAL', 'Host', TxtHostAdmin.Text);
    Arq.WriteString('GENERAL', 'Port', TxtPortAdmin.Text);
    Arq.WriteString('GENERAL', 'Dll', TxtDllAdmin.Text);
    Arq.WriteString('GENERAL', 'BackupFile', TxtBackupFileAdmin.Text);
  finally
    Arq.Free;
  end;
end;

procedure TWindowMain.CopyFirebirdMsg;
begin
  var Arq := ExtractFilePath(TxtDllAdmin.Text) + '\Firebird.msg';

  if FileExists(Arq) then
    CopyFile(PWideChar(Arq), PWideChar(ExtractFilePath(Application.ExeName) + '\Firebird.msg'), false);
end;

procedure TWindowMain.RadioGroupConnMethodAdminClick(Sender: TObject);
begin
  case RadioGroupConnMethodAdmin.ItemIndex of
  0:
  begin
    BoxProtocolAdmin.Enabled := true;
    TxtHostAdmin.Enabled := true;
    TxtPortAdmin.Enabled := true;
  end;

  1:
  begin
    BoxProtocolAdmin.Enabled := false;
    TxtHostAdmin.Enabled := false;
    TxtPortAdmin.Enabled := false;
    TxtDllAdmin.Enabled := true;
  end;

  end;
end;

procedure TWindowMain.RadioGroupMethodAdminClick(Sender: TObject);
begin
  case RadioGroupMethodAdmin.ItemIndex of
  0:
  begin
    with CheckListOptionsAdmin.Items do
    begin
      Clear;

      Add('boIgnoreChecksum');
      Add('boIgnoreLimbo');
      Add('boMetadataOnly');
      Add('boNoGarbageCollect');
      Add('boOldDescriptions');
      Add('boNonTransportable');
      Add('boConvert');
      Add('boExpand');
    end;
  end;

  1:
  begin
    with CheckListOptionsAdmin.Items do
    begin
      Clear;

      Add('roDeactivateIdx');
      Add('roNoShadow');
      Add('roNoValidity');
      Add('roOneAtATime');
      Add('roReplace');
      Add('roUseAllSpace');
      Add('roValidate');
      Add('roFixFSSData');
      Add('roFixFSSMetaData');
      Add('roMetaDataOnly');
    end;
  end;

  end;
end;

procedure TWindowMain.TxtDbAdminBtnClick(Sender: TObject);
begin
  case RadioGroupMethodAdmin.ItemIndex of
  0:
    TFileDialogs.OpenFileFB(Sender);
  1:
    TFileDialogs.SaveFileFB(Sender);
  end;
end;

procedure TWindowMain.TxtBackupFileAdminBtnClick(Sender: TObject);
begin
  case RadioGroupMethodAdmin.ItemIndex of
  0:
    TFileDialogs.SaveFileFBK(Sender);
  1:
    TFileDialogs.OpenFileFBK(Sender);
  end;
end;

procedure TWindowMain.Dll(Sender: TObject);
begin
  TFileDialogs.OpenFileDLL(Sender);
end;

procedure TWindowMain.BtnStartAdminClick(Sender: TObject);
begin
  case RadioGroupMethodAdmin.ItemIndex of
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

  MemoLogAdmin.Clear;

  Application.ProcessMessages;

  FBDriverLink := TFDPhysFBDriverLink.Create(nil);

  try
    FBBackup.Database := TxtDbAdmin.Text;
    FBBackup.UserName := TxtUserAdmin.Text;
    FBBackup.Password := TxtPasswordAdmin.Text;

    FBBackup.BackupFiles.Clear;
    FBBackup.BackupFiles.Text := TxtBackupFileAdmin.Text;

    //TCPIP
    case RadioGroupConnMethodAdmin.ItemIndex of
    0:
    begin
      FBDriverLink.Embedded := false;

      FBDriverLink.VendorLib := TxtDllAdmin.Text;

      FBBackup.Protocol := TIBProtocol(BoxProtocolAdmin.ItemIndex);
      FBBackup.Host := TxtHostAdmin.Text;
      FBBackup.Port := StrToInt(TxtPortAdmin.Text);
    end;
    //EMBEDDED
    1:
    begin
      FBDriverLink.Embedded := true;

      FBDriverLink.VendorLib := TxtDllAdmin.Text;

      FBBackup.Protocol := ipLocal;

      CopyFirebirdMsg;
    end;

    end;

    FBBackup.DriverLink := FBDriverLink;

    FBBackup.Verbose := CheckVerboseAdmin.Checked;
    FBBackup.Options := [];

    for I := 0 to CheckListOptionsAdmin.Count - 1 do
    begin
      if CheckListOptionsAdmin.Checked[I] then
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

  MemoLogAdmin.Clear;

  Application.ProcessMessages;

  FBDriverLink := TFDPhysFBDriverLink.Create(nil);

  try
    FBRestore.Database := TxtDbAdmin.Text;
    FBRestore.UserName := TxtUserAdmin.Text;
    FBRestore.Password := TxtPasswordAdmin.Text;

    FBRestore.BackupFiles.Clear;
    FBRestore.BackupFiles.Text := TxtBackupFileAdmin.Text;

    case RadioGroupConnMethodAdmin.ItemIndex of
    0:
    begin
      FBDriverLink.Embedded := false;

      FBRestore.Protocol := TIBProtocol(BoxProtocolAdmin.ItemIndex);
      FBRestore.Host := TxtHostAdmin.Text;
      FBRestore.Port := StrToInt(TxtPortAdmin.Text);
    end;

    1:
    begin
      FBDriverLink.Embedded := true;

      FBDriverLink.VendorLib := TxtDllAdmin.Text;

      FBRestore.Protocol := ipLocal;

//      CopyFirebirdMsg;
    end;

    end;

    FBRestore.DriverLink := FBDriverLink;

    FBRestore.Verbose := CheckVerboseAdmin.Checked;
    FBRestore.Options := [];

    for I := 0 to CheckListOptionsAdmin.Count - 1 do
    begin
      if CheckListOptionsAdmin.Checked[I] then
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
  WindowMain.MemoLogAdmin.Lines.Add(AMessage);
end;

procedure TWindowMain.FBError(ASender, AInitiator: TObject; var AException: Exception);
begin
  WindowMain.MemoLogAdmin.Lines.Add(AException.Message);
end;

//OTHERS

procedure TWindowMain.ActEscExecute(Sender: TObject);
begin
  Close;
end;

end.
