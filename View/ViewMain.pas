unit ViewMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.ImageList, Vcl.ImgList,
  System.Actions, Vcl.ActnList, FireDAC.Stan.Def, FireDAC.VCLUI.Wait, FireDAC.Phys.IBWrapper,
  FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.IBBase, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.CheckLst,
  ACBrBase,
  MyUtils, FireDAC.Phys.FBDef, FireDAC.Phys.FB;

type
  TWindowMain = class(TForm)
    MemoLog: TMemo;
    MemoErrors: TMemo;
    LblLog: TLabel;
    LblErrors: TLabel;
    BtnRestore: TSpeedButton;
    Page: TPageControl;
    TabRestore: TTabSheet;
    TabConfigs: TTabSheet;
    Restore: TFDIBRestore;
    LblBackupFiles: TLabel;
    ListBackupFiles: TListBox;
    LblHost: TLabel;
    TxtHost: TEdit;
    TxtPort: TEdit;
    LblPort: TLabel;
    LblDestFile: TLabel;
    TxtUser: TEdit;
    LblUser: TLabel;
    BoxProtocol: TComboBox;
    LblProtocol: TLabel;
    LblPassword: TLabel;
    TxtPassword: TEdit;
    TxtDestFile: TEdit;
    CheckListOptions: TCheckListBox;
    LblOptions: TLabel;
    Images: TImageList;
    Actions: TActionList;
    ActAddBackup: TAction;
    ActRmvBackup: TAction;
    ActEsc: TAction;
    BtnRemove: TSpeedButton;
    BtnAdd: TSpeedButton;
    BtnDbFile: TSpeedButton;
    ActDbFile: TAction;
    OpenBackupFile: TFileOpenDialog;
    CheckVerbose: TCheckBox;
    ActRestore: TAction;
    SaveDbFile: TFileSaveDialog;
    FBDriverLink: TFDPhysFBDriverLink;
    procedure ActEscExecute(Sender: TObject);
    procedure ActDbFileExecute(Sender: TObject);
    procedure ActRmvBackupExecute(Sender: TObject);
    procedure ActAddBackupExecute(Sender: TObject);
    procedure ActRestoreExecute(Sender: TObject);
    procedure RestoreError(ASender, AInitiator: TObject; var AException: Exception);
    procedure RestoreProgress(ASender: TFDPhysDriverService; const AMessage: string);
  end;

  TRestoreThread = class(TThread)
  protected
    procedure Execute; override;
  public
    constructor Create;
  end;

var
  WindowMain: TWindowMain;

implementation

{$R *.dfm}

procedure TWindowMain.ActRestoreExecute(Sender: TObject);
var
  RestoreThread: TRestoreThread;
begin
  Page.ActivePageIndex := 0;

  TabConfigs.Enabled := false;

  MemoLog.Clear;
  MemoErrors.Clear;

  try
    RestoreThread := TRestoreThread.Create;

    RestoreThread.Execute;
  finally
    TabConfigs.Enabled := true;
  end;
end;

procedure TWindowMain.ActDbFileExecute(Sender: TObject);
begin
  if SaveDbFile.Execute then
  begin
    TxtDestFile.Text := SaveDbFile.FileName;
  end;
end;

procedure TWindowMain.ActAddBackupExecute(Sender: TObject);
begin
  if OpenBackupFile.Execute then
  begin
    ListBackupFiles.Items.Add(OpenBackupFile.FileName);
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

procedure TWindowMain.RestoreError(ASender, AInitiator: TObject; var AException: Exception);
begin
  WindowMain.MemoErrors.Lines.Add(AException.Message);
end;

procedure TWindowMain.RestoreProgress(ASender: TFDPhysDriverService; const AMessage: string);
begin
  WindowMain.MemoLog.Lines.Add(AMessage);
end;

procedure TWindowMain.ActEscExecute(Sender: TObject);
begin
  Close;
end;

{ TRestoreThread }

constructor TRestoreThread.Create;
begin
  inherited Create(true);
end;

procedure TRestoreThread.Execute;
var
  BackupFile: string;
  I: integer;
begin
  inherited;

  with WindowMain do
  begin
    Restore.Database := TxtDestFile.Text;
    Restore.UserName := TxtUser.Text;
    Restore.Password := TxtPassword.Text;

    Restore.BackupFiles.Clear;

    for BackupFile in ListBackupFiles.Items do
    begin
      Restore.BackupFiles.Add(BackupFile);
    end;

    Restore.Protocol := TIBProtocol(BoxProtocol.ItemIndex);

    Restore.Host := TxtHost.Text;

    Restore.Port := StrToInt(TxtPort.Text);

    Restore.Options := [];

    for I := 0 to CheckListOptions.Count - 1 do
    begin
      if CheckListOptions.Checked[I] then
      begin
        case I of
        0: Restore.Options := Restore.Options + [roDeactivateIdx];
        1: Restore.Options := Restore.Options + [roNoShadow];
        2: Restore.Options := Restore.Options + [roNoValidity];
        3: Restore.Options := Restore.Options + [roOneAtATime];
        4: Restore.Options := Restore.Options + [roReplace];
        5: Restore.Options := Restore.Options + [roUseAllSpace];
        6: Restore.Options := Restore.Options + [roValidate];
        7: Restore.Options := Restore.Options + [roFixFSSData];
        8: Restore.Options := Restore.Options + [roFixFSSMetaData];
        9: Restore.Options := Restore.Options + [roMetaDataOnly];
        end;
      end;
    end;

    Restore.Verbose := CheckVerbose.Checked;

    Restore.Restore;
  end;
end;

end.
