unit ViewMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.ImageList, Vcl.ImgList,
  System.Actions, Vcl.ActnList, FireDAC.Stan.Def, FireDAC.VCLUI.Wait, FireDAC.Phys.IBWrapper,
  FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.IBBase, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.CheckLst,
  ACBrBase, FireDAC.Phys.FBDef, FireDAC.Phys.FB, NsEditBtn, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, Data.DB, FireDAC.Comp.Client;

type
  TWindowMain = class(TForm)
    MemoLog: TMemo;
    MemoErrors: TMemo;
    LblLog: TLabel;
    LblErrors: TLabel;
    Page: TPageControl;
    TabMigration: TTabSheet;
    TabConfigs: TTabSheet;
    Images: TImageList;
    Actions: TActionList;
    ActAddBackup: TAction;
    ActRmvBackup: TAction;
    ActEsc: TAction;
    ActDbFile: TAction;
    OpenFile: TFileOpenDialog;
    ActRestore: TAction;
    SaveFile: TFileSaveDialog;
    FBDriverLink: TFDPhysFBDriverLink;
    FBRestore: TFDIBRestore;
    BtnMigrate: TSpeedButton;
    ActMigrate: TAction;
    GroupBoxSource: TGroupBox;
    GroupBoxDest: TGroupBox;
    TxtHostSource: TEdit;
    LblHostSource: TLabel;
    LblPortSource: TLabel;
    TxtPortSource: TEdit;
    LblUserSource: TLabel;
    TxtUserSource: TEdit;
    LblPasswordSource: TLabel;
    TxtPasswordSource: TEdit;
    LblDbSource: TLabel;
    LblHostDest: TLabel;
    LblPortDest: TLabel;
    LblUserDest: TLabel;
    LblPasswordDest: TLabel;
    LblDbDest: TLabel;
    TxtDbDest: TNsEditBtn;
    TabTemp: TTabSheet;
    TxtDestFile: TNsEditBtn;
    LblDestFile: TLabel;
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
    LblBackupFiles: TLabel;
    ListBackupFiles: TListBox;
    BtnAdd: TSpeedButton;
    BtnRemove: TSpeedButton;
    LblRestoreOptions: TLabel;
    CheckListRestore: TCheckListBox;
    BtnStart: TSpeedButton;
    TxtHostDest: TEdit;
    TxtPortDest: TEdit;
    TxtUserDest: TEdit;
    TxtPasswordDest: TEdit;
    TxtDbSource: TNsEditBtn;
    BtnTestSourceConn: TButton;
    ConnTest: TFDConnection;
    FBBackup: TFDIBBackup;
    ActBackup: TAction;
    CheckListBackup: TCheckListBox;
    LblBackupOptions: TLabel;
    RadioGroupMethod: TRadioGroup;
    procedure ActEscExecute(Sender: TObject);
    procedure ActAddBackupExecute(Sender: TObject);
    procedure ActRmvBackupExecute(Sender: TObject);
    procedure ActRestoreExecute(Sender: TObject);
    procedure FBRestoreError(ASender, AInitiator: TObject; var AException: Exception);
    procedure FBRestoreProgress(ASender: TFDPhysDriverService; const AMessage: string);
    procedure ActMigrateExecute(Sender: TObject);
    procedure BtnTestSourceConnClick(Sender: TObject);
    procedure ActBackupExecute(Sender: TObject);
    procedure BtnStartClick(Sender: TObject);
    procedure TxtDestFileBtnClick(Sender: TObject);

  private
    procedure CarregarArquivo(Sender: TObject; DisplayName, FileMask: string);
    procedure SalvarArquivo(Sender: TObject; DisplayName, FileMask: string);
    procedure CarregarPasta(Sender: TObject);
    procedure SalvarPasta(Sender: TObject);
    procedure Backup;
    procedure Restore;

  end;

var
  WindowMain: TWindowMain;

implementation

uses
  Migration;

{$R *.dfm}

procedure TWindowMain.ActMigrateExecute(Sender: TObject);
var
  MigrationConfig: TMigrationConfig;
  Migration: TMigration;
begin
  MigrationConfig := TMigrationConfig.Create;

  try
    with MigrationConfig.Source do
    begin
      Host := TxtHostSource.Text;
      Port := StrToInt(TxtPortSource.Text);
      User := TxtUserSource.Text;
      Password := TxtPasswordSource.Text;
      Database := TxtDbSource.Text;
    end;

    with MigrationConfig.Dest do
    begin
      Host := TxtHostDest.Text;
      Port := StrToInt(TxtPortDest.Text);
      User := TxtUserDest.Text;
      Password := TxtPasswordDest.Text;
      Database := TxtDbDest.Text;
    end;

    Migration := TMigration.Create(MigrationConfig);

    Migration.Migrate(MemoLog, MemoErrors);
  finally
    MigrationConfig.Free;
    Migration.Free;
  end;
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

procedure TWindowMain.TxtDestFileBtnClick(Sender: TObject);
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

procedure TWindowMain.ActAddBackupExecute(Sender: TObject);
var
  DisplayName, FileMask: string;
begin
  DisplayName := 'Firebird Backup (*.FBK)';
  FileMask := '*.fbk';

  case RadioGroupMethod.ItemIndex of

  0:
  begin
    SaveFile.FileTypes[0].DisplayName := DisplayName;
    SaveFile.FileTypes[0].FileMask := FileMask;

    if SaveFile.Execute then
    begin
      ListBackupFiles.Items.Add(SaveFile.FileName);
    end;
  end;

  1:
  begin
    OpenFile.FileTypes[0].DisplayName := DisplayName;
    OpenFile.FileTypes[0].FileMask := FileMask;

    if OpenFile.Execute then
    begin
      ListBackupFiles.Items.Add(OpenFile.FileName);
    end;
  end;

  end;
end;

procedure TWindowMain.ActRmvBackupExecute(Sender: TObject);
var
  Index: integer;
begin
  Index := ListBackupFiles.ItemIndex;
  ListBackupFiles.DeleteSelected;
  if Index = 0 then
  begin
    ListBackupFiles.ItemIndex := 0;
  end
  else
  begin
    ListBackupFiles.ItemIndex := Index - 1;
  end;
end;

procedure TWindowMain.BtnTestSourceConnClick(Sender: TObject);
begin
  ConnTest.Close;

  TFDPhysFBConnectionDefParams(ConnTest.Params).Server := TxtHostSource.Text;
  TFDPhysFBConnectionDefParams(ConnTest.Params).Port := StrToInt(TxtPortSource.Text);

  with ConnTest.Params do
  begin
    UserName := TxtUserSource.Text;
    Password := TxtPasswordSource.Text;
    Database := TxtDbSource.Text;
  end;

  try
    try
      ConnTest.Open;

      ShowMessage('Conexão Ok!');
    Except on E: Exception do
      ShowMessage('Erro: ' + E.Message);
    end;
  finally
    ConnTest.Close;
  end;
end;

procedure TWindowMain.ActEscExecute(Sender: TObject);
begin
  Close;
end;

//

procedure TWindowMain.FBRestoreProgress(ASender: TFDPhysDriverService; const AMessage: string);
begin
  WindowMain.MemoLog.Lines.Add(AMessage);
end;

procedure TWindowMain.FBRestoreError(ASender, AInitiator: TObject; var AException: Exception);
begin
  WindowMain.MemoErrors.Lines.Add(AException.Message);
end;

//

procedure TWindowMain.CarregarArquivo(Sender: TObject; DisplayName, FileMask: string);
begin
  OpenFile.Options := OpenFile.Options - [fdoPickFolders];

  OpenFile.FileTypes[0].DisplayName := DisplayName;
  OpenFile.FileTypes[0].FileMask := FileMask;

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

//

procedure TWindowMain.ActBackupExecute(Sender: TObject);
begin
  Page.ActivePageIndex := 0;

  TabConfigs.Enabled := false;
  TabTemp.Enabled := false;

  MemoLog.Clear;
  MemoErrors.Clear;

  try
    Backup;
  finally
    TabConfigs.Enabled := true;
    TabTemp.Enabled := true;
  end;
end;

procedure TWindowMain.ActRestoreExecute(Sender: TObject);
begin
  Page.ActivePageIndex := 0;

  TabConfigs.Enabled := false;
  TabTemp.Enabled := false;

  MemoLog.Clear;
  MemoErrors.Clear;

  try
    Restore;
  finally
    TabConfigs.Enabled := true;
    TabTemp.Enabled := true;
  end;
end;

procedure TWindowMain.Backup;
var
  I: integer;
begin
  inherited;

  FBBackup.Database := TxtDestFile.Text;
  FBBackup.UserName := TxtUser.Text;
  FBBackup.Password := TxtPassword.Text;

  FBBackup.BackupFiles.Clear;
  FBBackup.BackupFiles := ListBackupFiles.Items;
  FBBackup.Protocol := TIBProtocol(BoxProtocol.ItemIndex);
  FBBackup.Host := TxtHost.Text;
  FBBackup.Port := StrToInt(TxtPort.Text);
  FBBackup.Verbose := CheckVerbose.Checked;
  FBBackup.Options := [];

  for I := 0 to CheckListBackup.Count - 1 do
  begin
    if CheckListBackup.Checked[I] then
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
end;

procedure TWindowMain.Restore;
var
  BackupFile: string;
  I: integer;
begin
  inherited;

  FBRestore.Database := TxtDestFile.Text;
  FBRestore.UserName := TxtUser.Text;
  FBRestore.Password := TxtPassword.Text;

  FBRestore.BackupFiles.Clear;
  FBRestore.BackupFiles := ListBackupFiles.Items;
  FBRestore.Protocol := TIBProtocol(BoxProtocol.ItemIndex);
  FBRestore.Host := TxtHost.Text;
  FBRestore.Port := StrToInt(TxtPort.Text);
  FBRestore.Verbose := CheckVerbose.Checked;
  FBRestore.Options := [];

  for I := 0 to CheckListRestore.Count - 1 do
  begin
    if CheckListRestore.Checked[I] then
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
end;

end.
