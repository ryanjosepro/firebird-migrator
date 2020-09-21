unit ViewMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.ImageList, Vcl.ImgList,
  System.Actions, Vcl.ActnList, FireDAC.Stan.Def, FireDAC.VCLUI.Wait, FireDAC.Phys.IBWrapper,
  FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.IBBase, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.CheckLst,
  ACBrBase, MyUtils, FireDAC.Phys.FBDef, FireDAC.Phys.FB, NsEditBtn;

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
    FBBackup: TFDIBBackup;
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
    TxtDbSource: TNsEditBtn;
    LblDbSource: TLabel;
    LblHostDest: TLabel;
    LblPortDest: TLabel;
    LblUserDest: TLabel;
    LblPasswordDest: TLabel;
    LblDbDest: TLabel;
    TxtDbDest: TNsEditBtn;
    TabRestore: TTabSheet;
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
    LblOptions: TLabel;
    CheckListOptions: TCheckListBox;
    BtnRestore: TSpeedButton;
    TxtHostDest: TEdit;
    TxtPortDest: TEdit;
    TxtUserDest: TEdit;
    TxtPasswordDest: TEdit;
    procedure ActEscExecute(Sender: TObject);
    procedure ActAddBackupExecute(Sender: TObject);
    procedure ActRmvBackupExecute(Sender: TObject);
    procedure ActRestoreExecute(Sender: TObject);
    procedure FBRestoreError(ASender, AInitiator: TObject; var AException: Exception);
    procedure FBRestoreProgress(ASender: TFDPhysDriverService; const AMessage: string);
    procedure ActMigrateExecute(Sender: TObject);

  private
    procedure CarregarArquivo(Sender: TObject);
    procedure CarregarPasta(Sender: TObject);
    procedure SalvarArquivo(Sender: TObject);
    procedure SalvarPasta(Sender: TObject);
    procedure Backup;
    procedure Restore;

  end;

var
  WindowMain: TWindowMain;

implementation

{$R *.dfm}

procedure TWindowMain.ActMigrateExecute(Sender: TObject);
begin
  //
end;

procedure TWindowMain.ActRestoreExecute(Sender: TObject);
begin
  Page.ActivePageIndex := 0;

  TabConfigs.Enabled := false;

  MemoLog.Clear;
  MemoErrors.Clear;

  try
    Restore;
  finally
    TabConfigs.Enabled := true;
  end;
end;

procedure TWindowMain.ActAddBackupExecute(Sender: TObject);
begin
  OpenFile.Options := OpenFile.Options - [fdoPickFolders];

  if OpenFile.Execute then
  begin
    ListBackupFiles.Items.Add(OpenFile.FileName);
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

procedure TWindowMain.CarregarArquivo(Sender: TObject);
begin
  OpenFile.Options := OpenFile.Options - [fdoPickFolders];

  if OpenFile.Execute then
  begin
    (Sender as TNsEditBtn).Text := OpenFile.FileName;
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

procedure TWindowMain.SalvarArquivo(Sender: TObject);
begin
  SaveFile.Options := OpenFile.Options - [fdoPickFolders];

  if SaveFile.Execute then
  begin
    (Sender as TNsEditBtn).Text := SaveFile.FileName;
  end;
end;

procedure TWindowMain.SalvarPasta(Sender: TObject);
begin
  SaveFile.Options := OpenFile.Options + [fdoPickFolders];

  if SaveFile.Execute then
  begin
    (Sender as TNsEditBtn).Text := SaveFile.FileName;
  end;
end;

//

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
end;

procedure TWindowMain.Backup;
begin
  //
end;

end.
