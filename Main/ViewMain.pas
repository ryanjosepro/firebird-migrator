unit ViewMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList, FireDAC.Stan.Def,
  FireDAC.VCLUI.Wait, FireDAC.Phys.IBWrapper, FireDAC.Stan.Intf, FireDAC.Phys,
  FireDAC.Phys.IBBase, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.CheckLst;

type
  TWindowMain = class(TForm)
    MemoLog: TMemo;
    MemoErrors: TMemo;
    LblLog: TLabel;
    LblErrors: TLabel;
    BtnRestore: TSpeedButton;
    Actions: TActionList;
    Images: TImageList;
    ActOpenFile: TAction;
    ActRestore: TAction;
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
    TxtProtocol: TComboBox;
    LblProtocol: TLabel;
    LblPassword: TLabel;
    TxtPassword: TEdit;
    TxtDestFile: TEdit;
    SpeedButton1: TSpeedButton;
    CheckListOptions: TCheckListBox;
    LblOptions: TLabel;
  end;

var
  WindowMain: TWindowMain;

implementation

{$R *.dfm}

end.
